recurmove=$(echo $1 | cut -d\/ -f1 --complement)
dirmove=$(echo $1 | cut -d\/ -f1)
echo "moving to $dirmove"
echo "recurmove " $recurmove

#base="$(basename $(echo $1))"
#echo $base

directories=$(ls -l | grep -i "^d.*$dirmove" | cut -d: -f2- | cut -d\  -f2- )
echo "$(echo "$directories" | wc -l)"
if [ "$(echo "$directories" | wc -l)" -gt "1" ]; then 
	if ! timeout 1s xset q >&/dev/null; then
		echo "no x server found using cmenu"
		time echo $directories
sleep 10
		directories="$(echo "$directories" | cmenu -i)"
	else
		directories="$(echo "$directories" | dmenu -i)"
	fi
fi

cd "$directories" 

#[ "$(echo $recurmove | cut -d\/ -f1 --complement)" == "$(echo $recurmove | cut -d\/ -f1)" ] && exitflag="." && echo "exit flag"
[ "$(echo $1 | awk 'gsub(/\//, " ")' | wc -w)" -gt "1" ] && cdf $recurmove $exitflag

#echo "recurmove " $recurmove

#[ "$2" != "." ] && cdf $recurmove $exitflag

