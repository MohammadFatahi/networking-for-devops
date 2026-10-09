#!/bin/bash
set -e
cd "$(dirname "$0")"
sudo apt install -y vsftpd
sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.network2-backup
sudo cp vsftpd.conf /etc/vsftpd.conf
if ! id network2student > /dev/null 2>&1; then
    sudo useradd -m -s /bin/bash network2student
fi
sudo passwd network2student
sudo mkdir -p /home/network2student/upload /srv/ftp
sudo chown root:root /home/network2student
sudo chmod 755 /home/network2student
sudo chown network2student:network2student /home/network2student/upload
sudo chmod 755 /home/network2student/upload
echo 'FTP sample file' | sudo tee /srv/ftp/sample.txt > /dev/null
sudo chmod 644 /srv/ftp/sample.txt
printf 'network2student\nanonymous\nftp\n' | sudo tee /etc/vsftpd.network2-users > /dev/null
sudo systemctl restart vsftpd
sudo systemctl is-active vsftpd
echo 'Stop: sudo systemctl stop vsftpd'
echo 'Start: sudo systemctl start vsftpd'
