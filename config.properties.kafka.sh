
log_level=info

producer=kafka
kafka.bootstrap.servers=server1:9092,server2:9092,server3:9092

# mysql login info
host=localhost
user=maxwell
password=Password


# name of the mysql database where maxwell keeps its own state
schema_database=maxwell

# kafka topic to write to
# this can be static, e.g. 'maxwell', or dynamic, e.g. namespace_%{database}_%{table}
# in the latter case 'database' and 'table' will be replaced with the values for the row being processed
kafka_topic=ods_%{database}_%{table}

# a few defaults.
# These are 0.11-specific. They may or may not work with other versions.
kafka.compression.type=snappy
kafka.retries=0
kafka.acks=-1
#kafka.batch.size=16384


#           *** partitioning ***

# What part of the data do we partition by?
#producer_partition_by=database # [database, table, primary_key, transaction_id, thread_id, column]

producer_partition_by=table



