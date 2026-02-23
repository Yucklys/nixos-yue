# Mac-specific nushell environment

# Import homebrew env from bash
source scripts/import-my-brew-env.nu

use std/util "path add"

# Nix environment (equivalent of sourcing nix-daemon.sh)
let nix_link = if ($"($env.HOME)/.local/state/nix/profile" | path exists) {
  $"($env.HOME)/.local/state/nix/profile"
} else {
  $"($env.HOME)/.nix-profile"
}
$env.NIX_PROFILES = $"/nix/var/nix/profiles/default ($nix_link)"
$env.NIX_SSL_CERT_FILE = "/nix/var/nix/profiles/default/etc/ssl/certs/ca-bundle.crt"
path add $"($nix_link)/bin"
path add "/run/current-system/sw/bin"
path add "/nix/var/nix/profiles/default/bin"
path add $"/etc/profiles/per-user/($env.USER)/bin"

path add "/usr/local/bin"
path add "~/.toolbox/bin"
