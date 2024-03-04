
### Creating a local pyenv

```sh
pyenv install 3.8.5
pyenv virtualenv 3.8.5 some_dir
pyenv local some_dir
```

### Exporting poetry dependencies to pyenv

```sh
poetry export --output requirements.txt
pip install -r requirements.txt
```
