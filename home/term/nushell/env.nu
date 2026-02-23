use std/util "path add"

# pnpm
$env.PNPM_HOME = $"($env.HOME)/.local/share/pnpm"

path add "~/.cargo/bin"
path add "~/.local/bin"
path add "~/.emacs.d/bin"
path add "~/.npm-global/bin"

# use emacs as editor
$env.EDITOR = 'hx';
$env.VISUAL = 'emacsclient -c';

# improve emacs lsp-mode performance
$env.LSP_USE_PLISTS = true

# Zellij
$env.ZELLIJ_AUTO_ATTACH = true
$env.ZELLIJ_AUTO_EXIT = true

# enable carapace
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"
