# Custom on default configuration
$env.config = ($env.config | upsert show_banner false)

source ~/.cache/atuin/init.nu
