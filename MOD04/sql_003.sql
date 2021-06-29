


--CREATE TABLE BILLBOARD
create table public."Billboard" (
	"date" date NULL,
	"rank" int4 NULL,
	song varchar(300) NULL,
	artist varchar(300) NULL,
	"last-week" int4 NULL,
	"peak-rank" int4 NULL,
	"weeks-on-board" int4 NULL
);

SELECT t1."date"
	,t1."rank"
	,t1.song
	,t1.artist
	,t1."last-week"
	,t1."peak-rank"
	,t1."weeks-on-board"
FROM PUBLIC."Billboard" AS t1 limit 100;


SELECT 
	t1.artist
	,t1.song
FROM PUBLIC."Billboard" AS t1 
order by t1.artist
	,t1.song;
	
SELECT 
	t1.artist
	,count(*) as qtd_artist
FROM PUBLIC."Billboard" AS t1
group by t1.artist
order by t1.artist
;
SELECT 
	t1.song
	,count(*) as qtd_song
FROM PUBLIC."Billboard" AS t1
group by t1.song
order by t1.song
;

SELECT t1.artist
	,t2.qtd_artist
	,t1.song
	,t3.qtd_song
FROM PUBLIC."Billboard" AS t1
LEFT JOIN (
	SELECT t1.artist
		,count(*) AS qtd_artist
	FROM PUBLIC."Billboard" AS t1
	GROUP BY t1.artist
	ORDER BY t1.artist
	) AS t2 ON (t1.artist = t2.artist)
LEFT JOIN (
	SELECT t1.song
		,count(*) AS qtd_song
	FROM PUBLIC."Billboard" AS t1
	GROUP BY t1.song
	ORDER BY t1.song
	) AS t3 ON (t1.song = t3.song);

WITH cte_artist
AS (
	SELECT t1.artist
		,count(*) AS qtd_artist
	FROM PUBLIC."Billboard" AS t1
	GROUP BY t1.artist
	ORDER BY t1.artist
	)
	,cte_song
AS (
	SELECT t1.song
		,count(*) AS qtd_song
	FROM PUBLIC."Billboard" AS t1
	GROUP BY t1.song
	ORDER BY t1.song
	)
SELECT t1.artist
	,t2.qtd_artist
	,t1.song
	,t3.qtd_song
FROM PUBLIC."Billboard" AS t1
LEFT JOIN cte_artist AS t2 ON (t1.artist = t2.artist)
LEFT JOIN cte_song AS t3 ON (t1.song = t3.song);


with CTE_BILLBOARD as (
select distinct 
	t1.artist
	,t1.song
FROM PUBLIC."Billboard" AS t1
order by t1.artist
	,t1.song
)
select *
	,row_number() over(order by artist, song) as "row_number"
	,row_number() over(partition by artist order by artist, song) as "row_number_by_artist"
	,rank() over(partition by artist order by artist, song) as "rank_artist"
	,lag(song, 1) over(order by artist, song) as "lag_song"
	,lead(song, 1) over(order by artist, song) as "lead_song"
	,first_value(song) over(partition by artist order by artist, song) as "first_song"
	,last_value(song) over(partition by artist order by artist, song         RANGE BETWEEN 
            UNBOUNDED PRECEDING AND 
            UNBOUNDED FOLLOWING) as "last_song"
	,nth_value (song,2) over(partition by artist order by artist, song ) as "nth_song"
from CTE_BILLBOARD 
;


create table tb_web_site as (
with cte_dedup_artist as (
SELECT t1."date"
	,t1."rank"
	,t1.artist
	,row_number() over(partition by artist order by artist, "date") as dedup
FROM PUBLIC."Billboard" AS t1 
order by t1.artist, t1."date" 
)
select t1."date"
	,t1."rank"
	,t1.artist
from cte_dedup_artist as t1
where t1.dedup = 1
)
;


select * from tb_web_site;




create table tb_artist as (
SELECT t1."date"
	,t1."rank"
	,t1.artist
	,t1.song 
FROM PUBLIC."Billboard" AS t1 
where t1.artist = 'AC/DC'
order by t1.artist, t1.song , t1."date" 
);


drop table tb_artist;

select * from tb_artist;


create view vw_artist as (
with cte_dedup_artist as (
SELECT t1."date"
	,t1."rank"
	,t1.artist
	,row_number() over(partition by artist order by artist, "date") as dedup
FROM tb_artist AS t1 
order by t1.artist, t1."date" 
)
select t1."date"
	,t1."rank"
	,t1.artist
from cte_dedup_artist as t1
where t1.dedup = 1
)
;


--drop view vw_artisti;

select * from vw_artist;


insert into tb_artist (
SELECT t1."date"
	,t1."rank"
	,t1.artist
	,t1.song 
FROM PUBLIC."Billboard" AS t1 
where t1.artist like 'Elvis%'
order by t1.artist, t1.song , t1."date" 
);

select * from vw_artist;



create view vw_song as (
with cte_dedup_artist as (
SELECT t1."date"
	,t1."rank"
	,t1.artist
	,t1.song 
	,row_number() over(partition by artist, song order by artist, song , "date") as dedup
FROM tb_artist AS t1 
order by t1.artist, t1.song , t1."date" 
)
select t1."date"
	,t1."rank"
	,t1.artist
	,t1.song 
from cte_dedup_artist as t1
where t1.dedup = 1
)
;


select * from vw_song;


insert into tb_artist (
SELECT t1."date"
	,t1."rank"
	,t1.artist
	,t1.song 
FROM PUBLIC."Billboard" AS t1 
where t1.artist like 'Adele%'
order by t1.artist, t1.song , t1."date" 
);

select * from vw_artist;
select * from vw_song;




create or replace view vw_song as (
with cte_dedup_artist as (
SELECT t1."date"
	,t1."rank"
	,t1.song 
	,t1.artist 
	,row_number() over(partition by song order by song , "date") as dedup
FROM tb_artist AS t1 
order by  t1.song , t1."date" 
)
select t1."date"
	,t1."rank"
	,t1.artist
	,t1.song 
from cte_dedup_artist as t1
where t1.dedup = 1
)
;


drop view vw_song ;

create view vw_song as (
with cte_dedup_artist as (
SELECT t1."date"
	,t1."rank"
	,t1.song 
	,row_number() over(partition by song order by song , "date") as dedup
FROM tb_artist AS t1 
order by  t1.song , t1."date" 
)
select t1."date"
	,t1."rank"
	,t1.song 
from cte_dedup_artist as t1
where t1.dedup = 1
)



