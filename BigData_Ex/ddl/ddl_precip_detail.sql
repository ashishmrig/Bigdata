use ${hivevar:hive_db};

drop table if exists msa_precip_detail;

create table if not exists msa_precip_detail
(
wban                   string,
date_of_record         int,
hour                   int,
stationtype            string,
skycondition           string,
skyconditionflag       string,
visibility             string,
visibilityflag         string,
weathertype            string,
weathertypeflag        string,
drybulbfarenheit       string,
drybulbfarenheitflag   string,
drybulbcelsius         string,
drybulbcelsiusflag     string,
wetbulbfarenheit       string,
wetbulbfarenheitflag   string,
wetbulbcelsius         string,
wetbulbcelsiusflag     string,
dewpointfarenheit      string,
dewpointfarenheitflag  string,
dewpointcelsius        string,
dewpointcelsiusflag    string,
relativehumidity       string,
relativehumidityflag   string,
windspeed              string,
windspeedflag          string,
winddirection          string,
winddirectionflag      string,
valueforwindcharacter  string,
valueforwindcharflag   string,
stationpressure        string,
stationpressureflag    string,
pressuretendency       string,
pressuretendencyflag   string,
pressurechange         string,
pressurechangeflag     string,
sealevelpressure       string,
sealevelpressureflag   string,
recordtype             string,
recordtypeflag         string,
hourlyprecip           float,
hourlyprecipflag       string,
altimeter              string,
altimeterflag          string
)
row format delimited fields terminated by ','
lines terminated by '\n'
tblproperties ("skip.header.line.count"="1")
;

load data local inpath '/home/amrig/data/ex/201505hourly.txt' into table msa_precip_detail;

   
