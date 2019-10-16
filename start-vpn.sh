#!/bin/sh

SCRIPT_DIR="$( cd "$( dirname "$0" )" && pwd )"

cd $SCRIPT_DIR

docker run -d --name xvt --entrypoint /bin/start-vpn \
    --cap-add=NET_ADMIN --device /dev/net/tun \
    -v $(pwd):/work --workdir /work xvtsolutions/xvt-openvpn-client:0.1 -c xvt.json -exec

sleep 5
docker exec --workdir /work xvt /bin/start-vpn -c errcd-wa.json -m &
