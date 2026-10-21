#!/bin/sh
# Apply the macOS settings in macos.yaml, then log out/in.

file="${1:-$(dirname "$0")/macos.yaml}"

while IFS= read -r line; do
	case $line in
	'' | '#'* | *[[:space:]]'#'*) continue ;;
	[![:space:]]*:) domain=${line%:} ;;
	*)
		line=${line#"${line%%[![:space:]]*}"}
		key=${line%%:*}
		value=${line#*: }
		case $value in
		\"*\") type=-string value=${value#\"} value=${value%\"} ;;
		true | false) type=-bool ;;
		*)
			if echo "$value" | grep -Eq '^-?[0-9]+$'; then
				type=-int
			elif echo "$value" | grep -Eq '^-?[0-9]+\.[0-9]+$'; then
				type=-float
			else
				type=-string
			fi
			;;
		esac
		echo "$domain $key $type $value"
		defaults write "$domain" "$key" "$type" "$value"
		;;
	esac
done <"$file"

killall Dock Finder SystemUIServer 2>/dev/null
