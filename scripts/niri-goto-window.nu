#!usr/bin/env nu

def get_windows [] {
	let windows_json = (niri msg -j windows | from json)

	$windows_json | each {|window|
	  {
	    id: $window.id,
	    title: $window.title,
		  app_id: $window.app_id,
	    display: (if ($window.title | is-empty) {
	    	$"[($window.app_id)]"
	    } else if ($window.app_id | is-empty) {
	    	$window.title
	    } else {
				$"($window.title) [($window.app_id)]"
			})
	  }
	}
}

def main [] {
	let windows = get_windows

	if ($windows | length) == 0 {
		print "No windows found"
		return
	}

	let titles = $windows | each {|w| $w.display}
	let selected = ($titles | str join "\n" | wofi --dmenu --prompt "Switch to:" -i -M "fuzzy")

	if ($selected | is-empty) {
		return
	}

	let window_id = ($windows | where display == $selected | first).id
	print $window_id

	if not ($window_id | is-empty) {
		niri msg action focus-window --id $window_id
	}
}
