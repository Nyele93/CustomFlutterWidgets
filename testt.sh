#/bin/bash

user=$(fgrep User connect.config 2>/dev/null| grep -v "^#" | sed -e "s/Username//g" | tr -d " \t" | head -1)
#get and set hosts from connect.config
IFS="
"
 for srv in $(fgrep -B1 Hostname connect.config | grep -v "^#" | tr -d "\n" | sed -e "s/--/\n/g" | tr -s " " "\t")
  do
        IFS=$(echo -e "\t") a=($srv)
        name=${a[1]}
        addr=${a[3]}
    echo "$name ansible_ssh_host=$addr ansible_connection=ssh ansible_user=$user" >> custom_deployment_hosts
    #echo -n "ansible_$name "
done
   IFS="
"


