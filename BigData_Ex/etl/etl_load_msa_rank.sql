use ${hivevar:hive_db};

drop table if exists wettest_pop;

create table if not exists wettest_pop
row format delimited fields terminated by ','
lines terminated by '\n'
AS
WITH population AS
(
  SELECT *,
         (((population_2010 - population_2000) / 10)*5 + population_2010) AS population_2015
  FROM dev.msa_population
),
precip AS
(
  SELECT wban,
         SUBSTRING(yearmonthday,1,6) YYYYMM,
         SUM(precipitation) tot_precip
  FROM dev.msa_precip
  WHERE HOUR BETWEEN 7 AND 23
  GROUP BY 1,2
),
precip_detail AS
(
  SELECT wban,
         SUBSTRING(date_of_record,1,6) YYYYMM,
         SUM(hourlyprecip) tot_precip
  FROM dev.msa_precip_detail
  WHERE HOUR BETWEEN 701 AND 2359
  GROUP BY 1, 2
),
stg_tbl as
(SELECT ms.wban,
       mp.msa MSA,
       mp.state,
       NVL(mpr.YYYYMM,mprd.YYYYMM) YearMon,
       population_2015,
       (CASE WHEN mpr.tot_precip IS NULL and mprd.tot_precip IS NULL THEN 0 ELSE 1 END) precip_flag,
       population_2015*greatest(mpr.tot_precip,mprd.tot_precip) pop_precip
FROM population mp
  JOIN dev.msa_station ms
    ON trim (lower (mp.msa)) = trim (lower (ms.city))
   AND trim (lower (mp.state)) = trim (lower (ms.state))
  LEFT JOIN precip mpr ON mpr.wban = ms.wban
  LEFT JOIN precip_detail mprd ON mprd.wban = ms.wban)
 select wban, 
        MSA, 
        state, 
        pop_precip, 
        rank() over (order by pop_precip desc, population_2015 desc) wettest_msa_rank, 
        (case when precip_flag = 0 then 'No precipitation data available for this MSA' else '' end) remarks 
from stg_tbl
;
