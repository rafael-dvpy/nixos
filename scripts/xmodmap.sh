#!/bin/sh

# Remap Caps Lock to Escape
xmodmap -e 'keycode 66 = Escape'

# Disable Caps Lock completely (remove its functionality)
xmodmap -e 'clear Lock'

# Custom remap for Right Control (keycode 105)
xmodmap -e "keycode 105 = equal plus F12"

# Remap Caps Lock to Escape
xmodmap -e 'keycode 66 = Escape'

# Disable Caps Lock completely (remove its functionality)
xmodmap -e 'clear Lock'

# Custom remap for Right Control (keycode 105)
xmodmap -e "keycode 105 = equal plus F12"
