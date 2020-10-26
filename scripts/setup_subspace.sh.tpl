#!/bin/bash

mkdir /opt/subspace

cat <<CONTENT >> /opt/subspace/app.sh
#/bin/bash

docker stop $(docker ps -a -q)

docker rm $(docker ps -a -q)

docker system prune -f

docker rmi $(docker images -a -q)

docker create \
    --name subspace \
    --restart always \
    --network host \
    --cap-add NET_ADMIN \
    --volume /opt/subspace:/data \
    --env SUBSPACE_HTTP_HOST="${subspace_http_host}" \
    --env SUBSPACE_NAMESERVER="1.1.1.1" \
    --env SUBSPACE_LISTENPORT="51820" \
    --env SUBSPACE_IPV4_POOL="${subspace_ipv4_network}" \
    --env SUBSPACE_IPV6_NAT_ENABLED=0 \
    --env SUBSPACE_ALLOWED_IPS="${subspace_allowed_ips}" \
    subspacecommunity/subspace:${subspace_version}

docker start subspace

lineNum=$(docker exec subspace sh -c "sed -n '/^# dnsmasq service/=' /usr/local/bin/entrypoint.sh")

lineEndNum=$(docker exec subspace sh -c "sed -n '/^# subspace service/=' /usr/local/bin/entrypoint.sh")

docker exec -it subspace sh -c "sed -i /usr/local/bin/entrypoint.sh -re '$((lineNum)),$((lineEndNum - 1))d'"

docker exec -it subspace sh -c "rm -rf /etc/service/dnsmasq"

docker stop subspace

docker commit subspace subspacecommunity/subspace:${subspace_version}

docker start subspace
CONTENT

chmod +x /opt/subspace/app.sh

echo "Initialize Subspace APP"
/bin/bash /opt/subspace/app.sh