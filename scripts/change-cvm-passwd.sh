#!/usr/bin/expect
eval spawn ssh -oStrictHostKeyChecking=no -oCheckHostIP=no admin@192.168.5.2

# Use the correct prompt
set prompt ": $"
interact -o -nobuffer -re $prompt return
send "Nutanix/4u\r"
interact -o -nobuffer -re $prompt return
send "Nutanix/4u\r"
# TODO : optionally make the new password templated
interact -o -nobuffer -re $prompt return
send "Nutanix.123\r"
interact -o -nobuffer -re $prompt return
send "Nutanix.123\r"
interact