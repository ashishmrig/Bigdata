use ${hivevar:hive_db};

drop table if exists msa_precip;

create table if not exists msa_precip
(
wban          string,
yearmonthday  int,
hour          int,
precipitation float,
remarks       string
)
row format delimited fields terminated by ','
lines terminated by '\n'
tblproperties ("skip.header.line.count"="1")
;

load data local inpath '/home/amrig/data/ex/201505precip.txt' into table msa_precip;

   
