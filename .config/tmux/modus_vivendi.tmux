# Modus Themes for Tmux
# Auto generated with https://github.com/miikanissi/modus-themes.nvim/blob/master/lua/modus-themes/extras/tmux.lua

set-option -g status-position "bottom"
set-option -g status-style bg=#404040,fg=#f0f0f0
set-option -g window-status-format ' #I:#W '
set-option -g window-status-current-format '#[bg=#79a8ff,fg=#1e1e1e] #I:#W#{?window_zoomed_flag,  , }'
