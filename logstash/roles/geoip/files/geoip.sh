#!/bin/bash
cd /opt/geoip
wget http://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz
wait
tar xvf GeoLite2-City.tar.gz
wait
mv -f /opt/geoip/GeoLite2-City_*/GeoLite2-City.mmdb /opt/geoip/
rm -fr /opt/geoip/GeoLite2-City_*
rm -fr /opt/geoip/GeoLite2-City.tar.gz
