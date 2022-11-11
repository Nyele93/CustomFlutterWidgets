#!/bin/bash
declare -a address_list
template_file=maxscale_cnf_template
select module_type in  "mariadbmon" "galeramon" "quit"
do
  	case $module_type in 
                mariadbmon) echo "Selected module_type: mariadbmon"; echo $module_type ;;
                galeramon) echo "Selected module_type: galeramon"; echo $module_type ;;
                quit) echo "Terminating Program... Bye..."; break;;
                *) echo "Invalid option";;
        esac
	break
done

read -p "Enter maxscale user:" maxscale_user
read -p "Enter maxscale password:" maxscale_pwd

read -p "Enter Number of Servers to monitor:" no_servers
if [[ $no_servers -gt 0 ]]; then 
   for ((i=1; i<=$no_servers; i++))
   do
         echo "configure server_$i"
        read -p "alias($i): " sAlias
        read -p "address($i): " sAddress
        read -p "port($i):  " sPort

 address_list+=($sAlias)
  #write entry to template file
cat >> $template_file <<-EOF

[$sAlias]
type=server
address=$sAddress
port=$sPort 
protocol=MariaDBBackend
EOF
done

  srv_list=$(for server in "${address_list[*]}"; do echo "$server"; done | awk '{ gsub (" ", ",", $0); print}')

cat >> $template_file <<-EOF

# Monitor for the servers
[MariaDB-Monitor]
type=monitor
module=mariadbmon
servers=$srv_list
user=$maxscale_user
password=$maxscale_pwd
monitor_interval=2s

# Service definitions
[Read-Only-Service]
type=service
router=readconnroute
servers=$srv_list
user=$maxscale_user
password=$maxscale_pwd
router_options=slave

[Read-Write-Service]
type=service
router=readwritesplit
servers=$srv_list
user=$maxscale_user
password=$maxscale_pwd

EOF
fi
