@ECHO OFF

echo "Synchronizing userbook..."

SCP -i <id> rhost.txt <user>@<host>:<userbook>

echo Done.

pause>nul