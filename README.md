# flap-wifi
Bash script that periodically monitors a specified ethernet port (typically wifi). If it is down, it flaps the port to bring it back up.

Run it in a background window, when your wifi connection drops, it will attempt to reassociate.
You can force a connectivity check by pressing any key.
The polling time backs off geometrically.

Note: uses the Airport command to grab the SSID for display, so remove if you are not on Mac OSX
