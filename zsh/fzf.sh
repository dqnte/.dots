if [ $THEME = 'everforest' ]; then
  if [ $THEME_MODE = 'dark' ]; then
      COLOR_POP_1="#a7c080"
      COLOR_POP_2="#e69875"
      COLOR_FG="#d3c6aa"
      COLOR_FG_SUBTLE="#859289"
      COLOR_BG_OVERLAY="#2f383f"
      COLOR_BG_HI="#3a464c"
  else
      COLOR_POP_1="#8da101"
      COLOR_POP_2="#f57d26"
      COLOR_FG="#5c6a72"
      COLOR_FG_SUBTLE="#939f91"
      COLOR_BG_OVERLAY="#f7eed7"
      COLOR_BG_HI="#eae4ca"
  fi

elif [ $THEME = 'rose-pine' ]; then
  if [ $THEME_MODE = 'dark' ]; then
      COLOR_POP_1="#ea9a97"
      COLOR_POP_2="#c4a7e7"
      COLOR_FG="#e0def4"
      COLOR_FG_SUBTLE="#6e6a86"
      COLOR_BG_OVERLAY="#1f1d32"
      COLOR_BG_HI="#2a283e"

      # these are rose-pine-main themes
      # COLOR_POP_1="#ebbcba"
      # COLOR_POP_2="#c4a7e7"
      # COLOR_FG="#e0def4"
      # COLOR_FG_SUBTLE="#6e6a86"
      # COLOR_BG_OVERLAY="#151320"
      # COLOR_BG_HI="#21202e"
  else
      COLOR_POP_1="#d7827e"
      COLOR_POP_2="#907aa9"
      COLOR_FG="#575279"
      COLOR_FG_SUBTLE="#9893a5"
      COLOR_BG_OVERLAY="#fef8f1"
      COLOR_BG_HI="#f4ede8"
  fi
elif [ $THEME = 'neon' ]; then
    if [ $THEME_MODE = 'dark' ]; then
      COLOR_POP_1="#6cb6eb"
      COLOR_POP_2="#907aa9"
      COLOR_FG="#bbc2cf"
      COLOR_FG_SUBTLE="#7e8294"
      COLOR_BG_OVERLAY="#242830"
      COLOR_BG_HI="#202328"
    else
      COLOR_POP_1="#2257a0" # TelescopePromptPrefix fg
      COLOR_POP_2="#ff6655" # Dealers choice
      COLOR_FG="#4c566a" # Normal fg
      COLOR_FG_SUBTLE="#7e8294" # TelescopePromptCounter
      COLOR_BG_OVERLAY="#d7d7d7" # TelescopeResultsNormal bg
      COLOR_BG_HI="#d0d0d0" # TelescopeSelection bg
    fi
elif [ $THEME = 'tokyonight' ]; then
    if [ $THEME_MODE = 'dark' ]; then
      COLOR_POP_1="#82aaff"
      COLOR_POP_2="#ff966c"
      COLOR_FG="#c8d3f5"
      COLOR_FG_SUBTLE="#26283a"
      COLOR_BG_OVERLAY="#1e2032"
      COLOR_BG_HI="#2f334d"
    else
      COLOR_POP_1="#2e7de9" # TelescopePromptPrefix fg
      COLOR_POP_2="#c64343" # Dealers choice
      COLOR_FG="#3760bf" # Normal fg
      COLOR_FG_SUBTLE="#848cb5" # TelescopePromptCounter fg
      COLOR_BG_OVERLAY="#e5e6eb" # TelescopeResultsNormal bg
      COLOR_BG_HI="#c4c8da" # TelescopeSelection bg
    fi
fi

FZF_COLOR_OPTS="fg:$COLOR_FG,fg+:regular:$COLOR_FG,query:regular:$COLOR_FG,header:$COLOR_FG"
FZF_COLOR_OPTS="$FZF_COLOR_OPTS,bg:$COLOR_BG_OVERLAY,gutter:$COLOR_BG_OVERLAY,border:$COLOR_BG_OVERLAY"
FZF_COLOR_OPTS="$FZF_COLOR_OPTS,bg+:$COLOR_BG_HI,info:$COLOR_FG_SUBTLE,separator:$COLOR_FG_SUBTLE"
FZF_COLOR_OPTS="$FZF_COLOR_OPTS,prompt:$COLOR_POP_1,hl+:$COLOR_POP_1,hl:bold:$COLOR_POP_1"
FZF_COLOR_OPTS="$FZF_COLOR_OPTS,marker:$COLOR_POP_2"

export FZF_DEFAULT_OPTS="--margin 5%,5% --prompt='  ' --pointer=' ' --color='$FZF_COLOR_OPTS' --border='double' --layout='reverse' --cycle --marker='• ' --info='right'"
