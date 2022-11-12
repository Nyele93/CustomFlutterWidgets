#/bin/bash
count=0
user=$(fgrep User connect.config 2>/dev/null| grep -v "^#" | sed -e "s/Username//g" | tr -d " \t" | head -1)
#get and set hosts from connect.config
IFS="
"
 for srv in $(fgrep -B1 Hostname connect.config | grep -v "^#" | tr -d "\n" | sed -e "s/--/\n/g" | tr -s " " "\t")
  do
        IFS=$(echo -e "\t") a=($srv)
        name=${a[1]}
        addr=${a[3]}
        count=$((count+1))
        echo "$count $addr $user using ssh keys"
done
   IFS="
"

