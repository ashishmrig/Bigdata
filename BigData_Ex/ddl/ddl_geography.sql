use ${hivevar:hive_db};

drop table if exists msa_geography;

create table if not exists msa_geography
(
   region            string,
   wban_id           string,
   station_name      string,
   state_province    string,
   county            string,
   country           string,
   extended_name     string,
   call_sign         string,
   station_type      string,
   date_assigned     string,
   begin_date        string,
   comments          string,
   location          string,
   elev_other        string,
   elev_ground       string,
   elev_runway       string,
   elev_barometric   string,
   elev_station      string,
   elev_upper_air    string
)
row format delimited fields terminated by '|'
lines terminated by '\n'
tblproperties ("skip.header.line.count"="1")
;

load data local inpath '/home/amrig/data/ex/wbanmasterlist.psv' into table msa_geography;

   
