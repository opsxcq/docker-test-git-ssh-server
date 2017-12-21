#!/bin/bash

if [ -z "$1" ]
then
    echo '[-] No ssh keys, you will have to use password to log in this system'
fi

for key in "$@"
do
    echo "[+] Adding $key to authorized list"
    echo "$key" >> /home/git/.ssh/authorized_keys
done

echo '[+] Setup done, starting SSH'
/usr/sbin/sshd -D
