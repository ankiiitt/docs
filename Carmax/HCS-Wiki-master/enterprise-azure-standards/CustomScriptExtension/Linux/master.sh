#!/bin/bash

#Runs script to domain join linux system to the kmx.local domain. 
curl "https://kmxnonprodinfrashared.blob.core.windows.net/linux-domain-join/azure_domain_join.sh?sp=r&st=2019-10-03T15:28:33Z&se=2025-10-03T23:28:33Z&spr=https&sv=2018-03-28&sig=uac1Dr3q%2FmlCZqMAhjf%2BcKFbSDIk7KB%2BIQTBs2LHfng%3D&sr=b" -o azure_domain_join.sh
chmod 755 azure_domain_join.sh
sed -i 's/\r$//' azure_domain_join.sh

sh azure_domain_join.sh
sleep 300

#Install Crowdstrike
curl "https://kmxnonprodinfrashared.blob.core.windows.net/linux-domain-join/falcon-sensor-4.18.0-6402.el7.x86_64.rpm?sp=r&st=2019-01-22T17:09:27Z&se=2039-01-23T01:09:27Z&spr=https&sv=2018-03-28&sig=baf8eQyM3UqhWBiiZ48HW45oPRrCqFEhey1IIl%2FY%2BpM%3D&sr=b" -o falcon-sensor-4.18.0-6402.el7.x86_64.rpm
rpm -ivh falcon-sensor-4.18.0-6402.el7.x86_64.rpm
sudo /opt/CrowdStrike/falconctl -s --cid=9E158345F3D546BBB3493737D31A510D-07
sudo /opt/CrowdStrike/falconctl -s --aph=pitbcproxy.carmax.org --app=8080
systemctl start falcon-sensor

curl "https://kmxnonprodinfrashared.blob.core.windows.net/linux-domain-join/agent_installer.sh?sp=r&st=2019-09-04T16:46:51Z&se=2025-09-05T00:46:51Z&spr=https&sv=2018-03-28&sig=xnw2HgKasR4HuUOcP12nF07ybVPPI7BXNonoloeJOKw%3D&sr=b" -o agent_installer.sh 
chmod 700 agent_installer.sh
sudo sh ./agent_installer.sh install_start --token us:b00928f4-7087-44ee-b3bf-a9bc9c66a586

cd /tmp/
curl "https://kmxnonprodinfrashared.blob.core.windows.net/jdk-installer/jre-8u171-linux-x64.rpm?sv=2017-07-29&ss=bfqt&srt=sco&sp=rwdlacup&se=2028-05-07T21:58:57Z&st=2018-05-07T13:58:57Z&spr=https&sig=A2tMb3lu64xBuFdviec%2B4SJl6zWyVsh%2F28QrPtg5CSo%3D" -o jre-8u171-linux-x64.rpm
