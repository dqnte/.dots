if [ $THEME = 'everforest' ]; then
  if [ $THEME_MODE = 'dark' ]; then
      COLOR_POP="#a7c080"
      COLOR_FG="#d3c6aa"
      COLOR_FG_SUBTLE="#859289"
      COLOR_BG_OVERLAY="#2f383f"
      COLOR_BG_HI="#3a464c"
  else
      COLOR_POP="#8da101"
      COLOR_FG="#5c6a72"
      COLOR_FG_SUBTLE="#939f91"
      COLOR_BG_OVERLAY="#f7eed7"
      COLOR_BG_HI="#eae4ca"
  fi

elif [ $THEME = 'rose-pine' ]; then
  if [ $THEME_MODE = 'dark' ]; then
      COLOR_POP="#ebbcba"
      COLOR_FG="#e0def4"
      COLOR_FG_SUBTLE="#6e6a86"
      COLOR_BG_OVERLAY="#151320"
      COLOR_BG_HI="#21202e"
  else
      COLOR_POP="#d7827e"
      COLOR_FG="#575279"
      COLOR_FG_SUBTLE="#9893a5"
      COLOR_BG_OVERLAY="#fef8f1"
      COLOR_BG_HI="#f4ede8"
  fi
fi

FZF_COLOR_OPTS="fg:$COLOR_FG,fg+:regular:$COLOR_FG,query:regular:$COLOR_FG"
FZF_COLOR_OPTS="$FZF_COLOR_OPTS,bg:$COLOR_BG_OVERLAY,gutter:$COLOR_BG_OVERLAY,border:$COLOR_BG_OVERLAY"
FZF_COLOR_OPTS="$FZF_COLOR_OPTS,bg+:$COLOR_BG_HI,info:$COLOR_FG_SUBTLE,separator:$COLOR_FG_SUBTLE"
FZF_COLOR_OPTS="$FZF_COLOR_OPTS,prompt:$COLOR_POP,hl+:$COLOR_POP,hl:bold:$COLOR_POP,header:bold:$COLOR_POP"

export FZF_DEFAULT_OPTS="--margin 20%,10% --prompt='  ' --pointer='  ' --color='$FZF_COLOR_OPTS' --border='double' --layout='reverse'"
