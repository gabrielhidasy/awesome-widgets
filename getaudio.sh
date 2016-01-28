#!/usr/bin/zsh
a=$(amixer | tail -7 | head -1 |  cut -d "[" -f 2 | cut -d "%" -f 1)
b=$(amixer -c 0 get Master | tail -1 | cut -d "[" -f 4)
c=$(amixer -c 0 get Headphone | tail -1 | cut -d "[" -f 4)


if [[ "$b" == "off]" ]]
then
	echo "MUTE"
	exit
fi
if [[ "$c" == "on]" ]]
then
	echo -n "HP "
else
	echo -n "SP "
fi
pbar=$(echo $a/5 | bc)
echo -n "<span color=\"light green\">"
flag=0
if [ $pbar -lt 20 ]
	then
		for i in $(seq 1 $pbar)
		do
			echo -n "|"
		done
	else
		for i in $(seq 1 20)
		do
			echo -n "|"
		done
		echo -n "</span><span color=\"red\">"
		for i in $(seq 20 $pbar)
		do
			echo -n "|"
		done
fi
echo -n "</span>"
for i in $(seq 1 $(echo 36-$pbar | bc))
do
    echo -n "."
done
exit
