brightnessctl info -m | awk -F "," '{print $4;}' | sed 's/.$//' >> ./logs/brightness.log;

tail -n 1 ./logs/brightness.log