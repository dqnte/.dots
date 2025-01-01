dirs=$(ls -p $1 | grep / | sed 's/\// /')
files=$(ls -p $1 | grep -v / )

longest_dir=$(echo $dirs | sed 's/ /\n/g' | sort | uniq | awk '{print length, $0}' | sort -nr | head -n 1 | cut -d " " -f 1)
longest_file=$(echo $files | sed 's/ /\n/g' | sort | uniq | awk '{print length, $0}' | sort -nr | head -n 1 | cut -d " " -f 1)

check=$( expr "$longest_dir" - "$longest_file" )
if (( $check > 0 )); then
    column_width=$longest_dir
else
    column_width=$longest_file
fi

column_width=$(expr $column_width + 3)
total_width=$(expr $(tput cols) - 2)
num_cols=$((total_width / column_width ))

echo
fmt=$( yes "%-${column_width}s" | head -$num_cols | xargs | sed 's/ //g' )
[ ! -z "$dirs" ] && printf "  $fmt\n" $dirs
echo "  ────"
[ ! -z "$files" ] && printf "  $fmt\n" $files
echo
