use ${hivevar:hive_db};

drop table if exists msa_population;

create table if not exists msa_population
(
   msa string,
   state string,
   population_2000 int,
   population_2010 int
)
row format delimited fields terminated by '|'
lines terminated by '\n'
tblproperties ("skip.header.line.count"="1")
;

load data local inpath '/home/amrig/data/ex/msa_population.csv' into table msa_population;


