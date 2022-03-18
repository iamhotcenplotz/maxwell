# Step1:Modify mysql config file
cd /etc
vim my.cnf

############################### my.cnf ###############################
[mysqld]
# Remove leading # and set to the amount of RAM for the most important data
# cache in MySQL. Start at 70% of total RAM for dedicated server, else 10%.
# innodb_buffer_pool_size = 128M
#
# Remove the leading "# " to disable binary logging
# Binary logging captures changes between backups and is enabled by
# default. It's default setting is log_bin=binlog
# disable_log_bin
#
# Remove leading # to set options mainly useful for reporting servers.
# The server defaults are faster for transactions and fast SELECTs.
# Adjust sizes as needed, experiment to find the optimal values.
# join_buffer_size = 128M
# sort_buffer_size = 2M
# read_rnd_buffer_size = 2M
#
# Remove leading # to revert to previous value for default_authentication_plugin,
# this will increase compatibility with older clients. For background, see:
# https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_default_authentication_plugin
default-authentication-plugin=mysql_native_password

datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock

log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid

server_id=1
log-bin=mysql-bin
#########################################
binlog_format=row
# binlog_format=statement/mixed/row
## statement: will record every sql statement ---> less storage space ---> bad;
## row: will record inset,update,delete ...DDL results ---> Good! ---> Kafka.
## mixed: combined statement and row. ---> Don't use a lot. I guess...
#########################################
## assign specific database to monitor;
## If not assign mysql will start binlog for all databases;
binlog-do-db=ods_news_db

### for more database:
## binlog-do-db=ods_news_db
## binlog_do-db=dwd_news_db
######################################### end my.cnf #########################################

systemctl restart mysqld
systemctl status mysqld

# Step2:create mysql user for maxwell
mysql -u root -p

create database maxwell;
create user 'maxwell' identified by 'Password'
grant all on maxwell.* to 'maxwell'
grant select, replication slave, replication client on *.* to maxwell@'%';
flush privileges;
quit;

