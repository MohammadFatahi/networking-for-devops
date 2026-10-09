# File Transfer Comparison
|Method|Advantage|Limitation|Use case|
|---|---|---|---|
|FTP, usually control port 21|Legacy tool support|Basic FTP does not encrypt credentials or data|Legacy service or isolated lab|
|SFTP over SSH, usually port 22|Secure transfer and interactive file management|Requires an SSH service|Secure uploads and downloads|
|SCP over SSH, usually port 22|Copy with one command|Less suited to interactive directory management|Quick file and directory copies|

FTP and SFTP are different protocols. SFTP uses SSH.
In current OpenSSH versions, scp uses SFTP by default.

```bash
ftp 127.0.0.1
sftp mohammad@192.0.2.10
scp report.txt mohammad@192.0.2.10:/home/student/
```
SFTP or scp is more appropriate on a public network because the connection is encrypted.
Source: https://man.openbsd.org/scp
