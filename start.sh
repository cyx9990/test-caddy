#!/bin/sh

# configs
mkdir -p /etc/caddy/ /usr/share/caddy && echo -e "User-agent: *\nDisallow: /" >/usr/share/caddy/robots.txt
wget https://raw.githubusercontent.com/cyx9990/test-caddy/main/etc/index-head.html -O /usr/share/caddy/index.html
#wget -qO- $ConfigCaddyfile | sed -e "1c :$PORT" > /etc/caddy/Caddyfile
#wget -qO- $CONFIGCADDY | sed -e "1c :$PORT" -e "s/\$AUUID/$AUUID/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $AUUID)/g" >/etc/caddy/Caddyfile
wget $ConfigCaddyfile -O /etc/caddy/caddy.txt
sed -e "1c :$PORT" -e "s/\$AUUID/$PWDX/g" -e "s/\$MYUUID-HASH/$(caddy hash-password --plaintext $PWDX)/g" /etc/caddy/caddy.txt > /etc/caddy/Caddyfile

echo "this is test3" >> /usr/share/caddy/index.html
sed -e "s/^/<p>&/g" /etc/caddy/Caddyfile >> /usr/share/caddy/index.html
echo "----------" >> /usr/share/caddy/index.html
echo $PWDX, $PORT >> /usr/share/caddy/index.html
echo "---end---" >> /usr/share/caddy/index.html

caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
