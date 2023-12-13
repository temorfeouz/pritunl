Docker compose for run pritunl server in docker.
Makefile command `build` builds pritunl container.
On first run webgui will ask about key, Makefile command `key` will gen it for you
For generate initial admin pass run command Makefile `pass` command

MongoDB:
During first configuration need use next mongoDB connection string: `mongodb://mongo:27017/pritunl`
On some proxmox virtual servers mongoDB wont start because of cpu virtualisation, for fix it use `image: mongo:3.2` in docker-compose.yaml
but on arm cpus old version cant start, use `image: mongo:7.0.4 `instead