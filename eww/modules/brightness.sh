rm ./logs/brightness.log;

./modules/brightness2.sh

tail -F -n 1 ./logs/brightness.log