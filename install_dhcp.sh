#!/bin/bash

net=$(ifconfig ens32 |awk '/inet\>/{print $2}'| awk -F. '{print $1"."$2"."$3}')
read -p "请输入地址池开始和结束$net(例如:10 20): " start end
read -p "请输入网关地址:" gw
read -p "请输入DNS地址: " DNS1 DNS2
read -p "请输入最小和最大租约时间: " time1 time2

[ -d /media/cdrom ] || mkdir /media/cdrom
[ -d /media/cdrom/Packages ] || mount /dev/cdrom /media/cdrom &> /dev/null

echo "正在安装dhcp软件包，请耐心等待..."
rpm -q dhcp &> /dev/null
[ $? -eq 0 ] || rpm -i /media/cdrom/Packages/dhcp-*.el7.centos.x86_64.rpm 

cat << EOF > /etc/dhcp/dhcpd.conf
option domain-name "crushlinux.com";
option domain-name-servers $DNS1, $DNS2;
default-lease-time $time1;
max-lease-time $time2;
subnet $net.0 netmask 255.255.255.0 {
  range $net.$start $net.$end;
  option routers $gw; 
}
EOF

systemctl start dhcpd
netstat -lnpu | grep :67
