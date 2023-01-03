if status is-interactive
    # Environment
    set -x EDITOR nvim
    set -x GOPATH "$HOME/src/go"
    set -x PNPM_HOME "$HOME/.local/share/pnpm"
    set -x PATH "$HOME/.local/bin:$HOME/.cargo/bin:$GOPATH/bin:$PNPM_HOME:$PATH"

    # No Greeting
    set fish_greeting

    # Theme
    # TokyoNight Color Palette
    set -l foreground c0caf5
    set -l selection 364A82
    set -l comment 565f89
    set -l red f7768e
    set -l orange ff9e64
    set -l yellow e0af68
    set -l green 9ece6a
    set -l purple 9d7cd8
    set -l cyan 7dcfff
    set -l pink bb9af7
    
    # Syntax Highlighting Colors
    set -g fish_color_normal $foreground
    set -g fish_color_command $cyan
    set -g fish_color_keyword $pink
    set -g fish_color_quote $yellow
    set -g fish_color_redirection $foreground
    set -g fish_color_end $orange
    set -g fish_color_error $red
    set -g fish_color_param $purple
    set -g fish_color_comment $comment
    set -g fish_color_selection --background=$selection
    set -g fish_color_search_match --background=$selection
    set -g fish_color_operator $green
    set -g fish_color_escape $pink
    set -g fish_color_autosuggestion $comment
    
    # Completion Pager Colors
    set -g fish_pager_color_progress $comment
    set -g fish_pager_color_prefix $cyan
    set -g fish_pager_color_completion $foreground
    set -g fish_pager_color_description $comment

    # SSH Setup
    keychain --quiet -Q --noask id_ed25519
    source $HOME/.keychain/(hostnamectl hostname)-fish

    # Aliases
    source $HOME/.config/shell/aliases

    # Prompt
    starship init fish | source
end
