# pnpm
$env.PNPM_HOME = "/home/yucklys/.local/share/pnpm"

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
$env.PATH = ($env.PATH | split row (char esep) |
                prepend ['~/.cargo/bin',
                         '~/.local/bin',
			 '~/.emacs.d/bin',
			 '~/.npm-global/bin'
			 ])

# use emacs as editor
$env.EDITOR = 'emacsclient -nw';
$env.VISUAL = 'emacsclient -c';

# improve emacs lsp-mode performance
$env.LSP_USE_PLISTS = true

# Zellij
$env.ZELLIJ_AUTO_ATTACH = true
$env.ZELLIJ_AUTO_EXIT = true

# Flake
$env.FLAKE = $"/home/($env.user)/nixos-config";
