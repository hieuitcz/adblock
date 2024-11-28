#! /bin/sh


opkg install adblock
opkg install luci-app-adblock
opkg install luci-i18n-adblock-ja
opkg install tcpdump-mini

uci set adblock.global.adb_backupdir="/etc/adblock"

cp /etc/adblock/adblock.sources.gz /etc/adblock/adblock.sources.hieudz.gz
gunzip /etc/adblock/adblock.sources.hieudz.gz

sed -i -e '$d' /etc/adblock/adblock.sources.hieudz
sed -i -e '$d' /etc/adblock/adblock.sources.hieudz
cat <<"EOF" >> /etc/adblock/adblock.sources.hieudz
                },
        "hieudz": {
                "url": "https://raw.githubusercontent.com/bigdargon/hostsVN/master/option/hosts-VN",
                "rule": "/^0\\.0\\.0\\.0[[:space:]]+([[:alnum:]_-]{1,63}\\.)+[[:alpha:]]+([[:space:]]|$)/{print tolower($2)}",
                "size": "S",
                "focus": "hieudz",
                "descurl": "https://bigdargon.github.io/hostsVN"
                }
}
EOF

gzip /etc/adblock/adblock.sources.hieudz

uci set adblock.global.adb_srcarc="/etc/adblock/adblock.sources.hieudz.gz"
uci set adblock.global.adb_enabled="1"
uci set adblock.global.adb_backup="1"
uci set adblock.global.adb_backupdir="/etc/adblock"
uci set adblock.global.adb_backup_mode="1"
uci add_list adblock.global.adb_sources='hieudz'

uci commit adblock
service adblock enable
service adblock start
