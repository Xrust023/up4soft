curl -fsSL https://get.docker.com -o get-docker.sh
sh ./get-docker.sh
sudo gpasswd -a $USER docker
newgrp docker
