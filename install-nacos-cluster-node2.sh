#!/bin/bash

# Nacos version
NACOS_VERSION="2.3.2"
NACOS_HOME="/opt/nacos"
CLUSTER_CONF="$NACOS_HOME/conf/cluster.conf"

# Download and extract Nacos
if [ ! -d "$NACOS_HOME" ]; then
    sudo mkdir -p $NACOS_HOME
    sudo curl -L "https://github.com/alibaba/nacos/releases/download/${NACOS_VERSION}/nacos-server-${NACOS_VERSION}.tar.gz" -o /tmp/nacos-server.tar.gz
    sudo tar -xzf /tmp/nacos-server.tar.gz -C $NACOS_HOME --strip-components=1
fi

# Create cluster.conf
sudo tee $CLUSTER_CONF > /dev/null <<EOF
192.168.1.101:8848
192.168.1.102:8848
192.168.1.103:8848
EOF

# Set permissions
sudo chown -R $USER:$USER $NACOS_HOME

# Start Nacos (standalone=false for cluster mode)
cd $NACOS_HOME/bin
sh startup.sh -m cluster

echo "Nacos node2 installation and startup complete."