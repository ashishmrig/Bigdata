use ${hivevar:hive_db};

drop table if exists msa_station;

create table if not exists msa_station
(
wban                       string,
wmo                        string,
callSign                   string,
climatedivisioncode        string,
climatedivisionstatecode   string,
climatedivisionstationcode string,
city                       string,
state                      string,
location                   string,
latitude                   string,
longitude                  string,
groundheight               string,
stationheight              string,
barometer                  string,
timeZone                   string
)
row format delimited fields terminated by '|'
lines terminated by '\n'
tblproperties ("skip.header.line.count"="1")
;

load data local inpath '/home/amrig/data/ex/201505station.txt' into table msa_station;

   
