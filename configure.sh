#!/bin/sh
# 新增 V2Ray 配置文件
cat <<-EOF > /etc/v2ray/config.json
$CONFIG_JSON
EOF
# 运行 V2Ray
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
