# Nushell Script to Import Specific Homebrew Environment Variables
# from an Already Configured Bash Shell (Based on a Fixed List)

# This script assumes your .bashrc (or other relevant bash startup files)
# already includes a command like `eval "$(brew shellenv)"`. It will import
# a predefined list of Homebrew-related variables from your configured
# bash environment into Nushell.

# print "Preparing to import specific Homebrew environment variables from bash..."

# Step 1: Define the specific list of variables to import,
# as identified from your `brew shellenv bash` output.
let homebrew_vars_to_import = [
    "HOMEBREW_PREFIX",
    "HOMEBREW_CELLAR",
    "HOMEBREW_REPOSITORY",
    "PATH",
    # "MANPATH",
    "INFOPATH"
]

# print $"Target variables: [($homebrew_vars_to_import | str join ', ')]"
# print "Capturing environment from a configured interactive bash shell..."

# Step 2: Capture the full environment from an interactive bash shell.
# The `-i` flag makes bash behave as interactive, so it should source .bashrc.
# `env -0` prints environment variables separated by NUL characters for safe parsing.
# `set -e` ensures the bash script exits on error.
let bash_interactive_script = $"
set -e
env -0
"
let bash_env_capture_result = (^bash -ic $bash_interactive_script | complete)

# Check if the bash command itself failed
if $bash_env_capture_result.exit_code != 0 {
  eprint $"Error: Could not capture environment from 'bash -ic \"env -0\"'."
  eprint $"Exit Code: ($bash_env_capture_result.exit_code)"
  eprint $"Stderr: ($bash_env_capture_result.stderr)"
  return # Exit the Nushell script
}

# Helper function to parse a NUL-separated "KEY=value" string into a Nushell record.
def parse-env-zero-to-record [env_zero_str: string] {
  $env_zero_str
    | split row (char nul) # Split by NUL character
    | where {|key_value_pair| not ($key_value_pair | is-empty) } # Remove any empty strings
    | each {|key_value_pair|
        let parts = ($key_value_pair | split row "=" -n 2); # Split into KEY and value
        if ($parts | length) == 2 {
          { ($parts | get 0): ($parts | get 1) } # Create a single-entry record {KEY: value}
        } else {
            # This case should be rare with `env -0` from a standard shell.
            eprint $"Warning: Malformed key-value pair encountered during parsing: ($key_value_pair)"
            {} # Return an empty record for this malformed pair
        }
    }
    | reduce -f {} {|item_record, accumulator_record| # Combine all single-entry records
        $accumulator_record | merge $item_record
    }
}

# Step 3: Parse the captured bash environment string into a Nushell record.
let full_configured_bash_env = (parse-env-zero-to-record $bash_env_capture_result.stdout)

if ($full_configured_bash_env | is-empty) {
  # This could happen if parsing failed for all lines or stdout was effectively empty.
  eprint "Error: Failed to parse any environment variables from the bash session, or the session had no environment variables (unlikely)."
  eprint "Please check if 'bash -ic \"env -0\"' outputs your environment correctly."
  return # Exit the Nushell script
}

# Step 4: Extract the values for the target Homebrew variables from the captured bash environment.
let env_vars_for_nushell = ($homebrew_vars_to_import
    | reduce -f {} {|current_var_name, acc_env_record|
        let var_value_from_bash = ($full_configured_bash_env | get $current_var_name); # Case-sensitive get 
        if $var_value_from_bash != null {
          $acc_env_record | upsert $current_var_name $var_value_from_bash
        } else {
            # Variable was in our target list but not found in the bash environment.
            print $"Warning: Target variable '($current_var_name)' was not found or was null in the captured bash environment. It will not be imported."
            $acc_env_record # Continue without adding it
        }
    }
)

# Step 5: Load the extracted Homebrew environment variables into Nushell.
# Nushell's `load-env` will use ENV_CONVERSIONS for PATH, MANPATH, etc.,
# correctly turning colon-delimited strings into lists.
if not ($env_vars_for_nushell | is-empty) {
  load-env $env_vars_for_nushell
  let num_vars_loaded = ($env_vars_for_nushell | columns | length)
  # print $"Successfully imported ($num_vars_loaded) Homebrew environment variable\(s\) from your configured bash environment into Nushell."

  # Optional: For debugging or confirmation, you can print the variables that were loaded.
  # print "Imported variables and their values:"
  # $env_vars_for_nushell | transpose name val | sort-by name | each {|e| $"($e.name)"}
} else {
    print "No values for the target Homebrew variables were found in the bash environment to import. Ensure your .bashrc sets them and 'bash -ic' reflects this."
}
