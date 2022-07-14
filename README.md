# Custom_Tools
Custom Bash Tools

When the tool is launched, it will present an option to select from any of 3 options. 
run the install.sh script, to 
    - install ansible on the control node.
    - add the relevant value to the $PATH variable.
    - create the neccessary folders and modify permissions appropriately.
run the command "auto_deploy" to start the automation process. the tools will dislay via lines to guide your actions

Select one of the tasks below to proceed: 
-------------------------------------------------
1) MASTER-REPLICAS	 3) GALERA_CLUSTER
2) STANDALONE_INSTANCES	 4) quit

1. MASTER-REPLICAS
This will run the automated task to deploy a master-replica replication topology. 

2. STANDALONE_INSTANCES
This will run the automated task to deploy MariaDB to standalones nodes.

3. GALERA_CLUSTER (available from next release)
This will run the automated task to deploy a Galera replication topology. 

When any of the above tasks is started, it will prompt for the following values to configure the target worker nodes:
 . alias - this will be alias that will be used for noting the server in the ansible inventory. for this setup, the value for the master instance should be entered as "master"
            and the value for the replica instance should be entered as "replica". [N/B: These values must be stated this way, as the configuration will be looking for these exact names]
 . host - This is the IP of the target worker node.
 . ssh_user - This is the user that will be used for the ssh connections, and also used during deployments. If connection will be done via SSH trust, this can be left blank by pressing the ENTER key
              Please ensure the user has sudo privilege.
 . ssh_password - This will be the password of the ssh_user above. if using a user with an existing SSH trust to target worker nodes, also leave this field blank.
 see sample output below: 
          alias(1): master
          host(1):  192.168.10.57
          ssh_user:  root
          ssh_password: ***********
selecting any of options 1-3, will move to the next installation step, and prompt you to enter a version. See snippet below:
      ** Enter Mariadb version(e.g. 10.4) [latest]: 10.6
If no value is entered,  and you press the ENTER key, it will assume this value as "latest", and deploy with the latest version of MariaDB available.
 Next, you'll be prompted for a distribution, either Enterprise or Community. enter the appropriate number to select a distribution. See sample Snippet Below:
     
      1) Enterprise
      2) Community
      3) quit
If you choose the Enterprise distribution by entering 1, and pressing ENTER key, this will prompt you for the customer token. enter the value of the customer token, and press ENTER
see sample snippet below: 
  Enter Customer key:fa******-****-****-****-048***********
Next, you'll be prompted for the number of Nodes to deploy to. [N/B: This will take any integer from 1 to n... for all install options, with the exception of MASTER-REPLICAS.
 as at this version, 1.0.2, MASTER-REPLICAS will only accept 2 nodes. subsequent versions will extend this].
        Enter Number of Nodes:2

        configure instance: 1
  Entering any number and pressing the ENTER key, will proceed to ask for configuration details (already listed above). When the number of Nodes up until the value entered for 
  Number of Nodes have been configured, Ansible will kick in the auto deployment steps, and take it from there, until finish.
See sample snippet below:
      configure instance: 1
      alias(1): master
      host(1):  192.168.10.57
      ssh_user:  root
      ssh_password: ***********
      configure instance: 2
      alias(2): replica
      host(2):  192.168.10.58
      ssh_user:  root
      ssh_password: ***********
      +      +          +                +           +               +
      | S/N  | ALIAS    | HOST           | SSH_USER  | SSH_PASSWORD  |
      +      +          +                +           +               +
      | 1    | master   | 192.168.10.57  | root      | xxxxxxxxxxx   |
      | 2    | replica  | 192.168.10.58  | root      | xxxxxxxxxxx   |
      +      +          +                +           +               +

 
