import json
import os
from dataclasses import dataclass
from typing import Dict, List, Optional

import click
import requests
from authlib.jose import JsonWebToken, errors  # type: ignore
from dotenv import load_dotenv
from pygments import formatters, highlight, lexers  # type: ignore

AUTH_SERVER_CONFIG_URLS: Dict[str, Dict] = {
    "TEMPLATE": {
        "dev": "https://template-dev.us.auth0.com/.well-known/openid-configuration",
        "staging": "https://template-staging.us.auth0.com/.well-known/openid-configuration",
        "prod": "https://template-prod.us.auth0.com/.well-known/openid-configuration",
    },
}

ENV_CONFIGS = {
    "local": {
        "base_url": "http://localhost:5050",
        "env_file": "env/dev.env",
    },
    "dev": {
        "base_url": "https://template-dev.com",
        "env_file": "env/staging.env",
    },
    "feature": {
        "env_file": "env/staging.env",
    },
    "staging": {
        "base_url": "https://template-staging.com",
        "env_file": "env/staging.env",
    },
    "prod": {
        "base_url": "https://template.com",
        "env_file": "env/prod.env",
    },
}


@dataclass
class AuthServerConfig:
    client_id: str
    client_secret: str
    token_endpoint: str
    public_keys: List[Dict]
    claims_options: Dict


class Client:
    base_url: str
    auth_config: AuthServerConfig
    verbose: bool
    verify_audience: bool

    token: Optional[str] = None

    def __init__(
        self,
        base_url: str,
        auth_config_url: str,
        auth_client_id: str,
        auth_client_secret: str,
        verbose: bool = False,
        verify_audience: bool = True,
    ):
        self.base_url = base_url
        self.verbose = verbose
        self.verify_audience = verify_audience

        self.auth_config = self.build_auth_config(
            auth_config_url, auth_client_id, auth_client_secret
        )

        self.refresh_token()

    # AUTHENTICATION
    def build_auth_config(
        self,
        auth_config_url: str,
        client_id: str,
        client_secret: str,
    ):
        """General function that pulls together auth server configs from the base config objects"""

        openid_config = requests.get(
            auth_config_url,
        ).json()

        jwks = requests.get(openid_config["jwks_uri"]).json()

        claims_options = {
            "iss": {"essential": True, "value": openid_config["issuer"]},
        }

        if self.verify_audience:
            claims_options["aud"] = {
                # token audience should be the the environment url
                "aud": {"essential": True, "value": self.base_url},
            }

        return AuthServerConfig(
            client_id=client_id,
            client_secret=client_secret,
            token_endpoint=openid_config["token_endpoint"],
            claims_options=claims_options,
            public_keys=jwks["keys"],
        )

    def check_response(self, resp: requests.Response):
        if not resp.ok:
            print("Error in response from auth server")
            raise Exception(
                f"Unexpected response from Auth provider. Url: {self.auth_config.token_endpoint}, status: {resp.status_code}, text: {resp.text} "
            )

    def refresh_token(self):
        """Requests a new access token from auth server"""

        data = {
            "grant_type": "client_credentials",
            "client_id": self.auth_config.client_id,
            "client_secret": self.auth_config.client_secret,
            "audience": self.base_url,
        }

        if self.verbose:
            print("Freshing token...", end="\r")

        resp = requests.post(
            self.auth_config.token_endpoint,
            headers={"Content-Type": "application/x-www-form-urlencoded"},
            data=data,
        )
        self.check_response(resp)

        json = resp.json()
        self.token = json["access_token"]
        self.verify_token()

        if self.verbose:
            print("Freshing token...Now!")

    def verify_token(self):
        decoder = JsonWebToken(["RS256"])
        decoded = decoder.decode(
            self.token,
            self.auth_config.public_keys,
            claims_options=self.auth_config.claims_options,
        )

        try:
            decoded.validate()
        except errors.JoseError as error:
            print("There was an error while decoding the token:")
            print(error)

    def check_token_expiration(self):
        """Checks current token expiration date, and refreshes the token if expired"""
        decoder = JsonWebToken(["RS256"])
        decoded = decoder.decode(
            self.token,
            self.auth_config.public_keys,
        )

        try:
            decoded.validate()
        except errors.ExpiredTokenError:
            self.refresh_token()

    def get_request_headers(self, additional_headers: Dict = {}) -> Dict:
        self.check_token_expiration()
        return {"Authorization": f"Bearer {self.token}", **additional_headers}

    # REST
    def post(self, url: str, data: Optional[Dict] = None, headers: Dict = {}):
        if self.verbose:
            print(f"POST - {self.base_url}{url}")

        return requests.post(
            f"{self.base_url}{url}",
            headers=self.get_request_headers(
                {"Content-Type": "application/json", **headers}
            ),
            json=data,
        )

    def get(self, url: str, headers: Dict = {}):
        if self.verbose:
            print(f"GET - {self.base_url}{url}")

        return requests.get(
            f"{self.base_url}{url}", headers=self.get_request_headers(headers)
        )

    # ROUTES
    def health(self):
        return self.get("/health")


class CLICaller:
    """Caller class to hold all caller methods.

    To add a new one, write a new function in this class that is
    public. It will become a valid arg to the CLI in kebab-case.
    """

    @classmethod
    def _print(cls, json_as_dict: Dict):
        """Fancy printing function for Dicts with pretty colors!"""
        formatted_json = json.dumps(json_as_dict, indent=2)
        colorful_json = highlight(
            formatted_json, lexers.JsonLexer(), formatters.TerminalFormatter()
        )

        print(colorful_json.strip())

    @classmethod
    def _receive(cls, resp: requests.Response):
        if resp.headers.get("content-type") == "application/json":
            cls._print(resp.json())
        else:
            cls._print({"status_code": resp.status_code, "reason": resp.reason})

    @classmethod
    def _text_methods(cls):
        caller_methods = []

        for attribute in dir(cls):
            if callable(getattr(cls, attribute)) and not attribute.startswith("_"):
                caller_methods.append(attribute.replace("_", "-"))

        return caller_methods

    @classmethod
    def health(cls, client: Client, **kwargs):
        cls._receive(client.health())


# CLI
@click.command()
@click.option(
    "--env",
    "-e",
    default="staging",
    help="Environment to make the call",
    type=click.Choice(list(ENV_CONFIGS.keys())),
)
@click.option(
    "--route",
    "-r",
    help="Route to call",
    type=click.Choice(CLICaller._text_methods()),
)
@click.option("--verbose", "-v", default=False, is_flag=True)
@click.option(
    "--get-token",
    default=False,
    is_flag=True,
    help="Get an auth token for an environment",
)
@click.option("--root-dir", help="Custom root directory", default="")
def main(env, verbose, get_token, route, root_dir):
    config = ENV_CONFIGS[env]

    load_dotenv(dotenv_path=f"{root_dir}{config['env_file']}")

    auth_client_id = os.getenv("AUTH_CLIENT_ID")
    auth_client_secret = os.getenv("AUTH_CLIENT_SECRET")

    if auth_client_id is None or auth_client_secret is None:
        print(f"One of your auth secrets is not set in {config['env_file']}")
        return

    client = Client(
        base_url=config["base_url"],
        auth_config_url=AUTH_SERVER_CONFIG_URLS["TEMPLATE"][env],
        auth_client_id=auth_client_id,
        auth_client_secret=auth_client_secret,
        verbose=verbose,
    )

    if get_token:
        print(client.token)
        return

    # commands are kebab-case, but methods are snake_case
    caller = getattr(CLICaller, route.replace("-", "_"))
    if caller:
        caller(client)
    else:
        print("Not sure what route you're going for here... try using client.py --help")


if __name__ == "__main__":
    main()
