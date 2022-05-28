[ $1 != "" ] && echo "posix detected" && export argv=$1 && export returnstring="cdf" || export returnstring=/home/main/.scripts/cdf

export recurmove=$(echo $argv | cut -d\/ -f1 --complement)
export dirmove=$(echo $argv | cut -d\/ -f1)
echo "moving to $dirmove"
echo "recurmove " $recurmove

export directories=$(ls -l | grep -i "^d.*$dirmove" | cut -d: -f2- | cut -d\  -f2- )
echo "$(echo "$directories" | wc -l)"

[ "$(echo "$directories" | wc -l)" -gt "1" ] && [! timeout 1s xset q >&/dev/null ] && echo "no x server found using cmenu" && time echo $directories && sleep 10 && export directories="$(echo "$directories" | cmenu -i)" || [ "$(echo "$directories" | wc -l)" -gt "1" ]  && export directories="$(echo "$directories" | dmenu -i)"

echo "cd $directories"
cd "$directories" 

[ "$(echo $argv | awk 'gsub(/\//, " ")' | wc -w)" -gt "1" ] && source $returnstring $recurmove $exitflag

