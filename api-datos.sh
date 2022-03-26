#!/usr/bin/env bash
function espacio_dispo {
        /usr/bin/df | /usr/bin/grep "/dev/sda1" | /usr/bin/awk '{print $4}'
}
espacio_en_disco=$(espacio_dispo)

function ram_usada {
        /usr/bin/vmstat -s | /usr/bin/grep "used memory" | /usr/bin/awk '{print $1}'
}
uso_ram=$(ram_usada)

function carga_1min {
        /usr/bin/uptime | /usr/bin/awk '{print $9}'
}
uno=$(carga_1min)

function carga_5min {
        /usr/bin/uptime | /usr/bin/awk '{print $10}'
}
cinco=$(carga_5min)

function carga_15min {
        /usr/bin/uptime | /usr/bin/awk '{print $9}'
}
quince=$(carga_15min)

function api {
curl "https://api.m3o.com/v1/weather/Now" \
-X POST \
-H "Content-Type: application/json" \
-H "Authorization: Bearer NWM5MDQ5NDEtMTVlMy00ZDY5LTgwOGYtZGYxMDkxY2U4MTI3" \
-d '{
  "location": "london"}'
}
grafi=$(echo $(api | jq| grep "temp_c" | awk '{print $NF-1+1}'))

/usr/bin/curl https://api.thingspeak.com/update?api_key=ZSQCOXZUP08ORAXJ\&field1=${grafi}\&field2=${espacio_en_disco}\&field3=${uso_ram}\&field4=${uno}\&field5=${cinco}\&field6=${quince}