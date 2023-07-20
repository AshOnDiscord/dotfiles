# Initial value
pactl get-sink-volume @DEFAULT_SINK@ | grep '%' | awk '{print$5}' | sed 's/.$//'

pactl subscribe | grep --line-buffered "sink" | while read -r _ ; do pactl get-sink-volume @DEFAULT_SINK@ | grep '%' | awk '{print$5}' | sed 's/.$//' ; done