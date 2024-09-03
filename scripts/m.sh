if [ ! -f Makefile ]; then
    echo "Makefile not found"
    exit
fi

target=$(grep -E '^[a-zA-Z0-9._-]+:' Makefile | sed 's/:.*//' | awk '{print $1}' | fzf)

if [ -z "$target" ]; then
    exit
fi

make $target
