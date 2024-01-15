Docker compose for run pritunl server in docker.
"Click, click, finish" solution for run openvpn server in docker.
Makefile command `build` builds pritunl container.
On first run webgui will ask about key, Makefile command `key` will gen it for you
For generate initial admin pass run command Makefile `pass` command

Pritunl:
Pay attention exposed port in docker-compose file and use the same one during config pritunl server, by default it is 15414/udp
Internal ip bind to 172.172.172.1
For configure local dns via AdGuardHome: set DNS host(optional param) in vpn server config to 172.172.172.3

MongoDB:
During first configuration need use next mongoDB connection string: `mongodb://mongo:27017/pritunl`
On some proxmox virtual servers mongoDB wont start because of cpu virtualisation, for fix it use `image: mongo:3.2` in docker-compose.yaml
but on arm cpus old version cant start, use `image: mongo:7.0.4 `instead
Internal ip bind to 172.172.172.2

AdGuardHome:
Pay attention exposed port in docker-compose file with comment '# DASHBOARD' and use same during config on the first page
Internal ip bind to 172.172.172.3
For configuring leave default port config during configuration on 172.172.172.3:3000


