SELECT t1."date"
	,t1."rank"
	,t1.song
	,t1.artist
	,t1."last-week"
	,t1."peak-rank"
	,t1."weeks-on-board"
FROM PUBLIC."Billboard" AS t1 limit 100;

select distinct 
	t1.artist
	,t1.songSELECT t1."date"
	,t1."rank"
	,t1.song
	,t1.artist
	,t1."last-week"
	,t1."peak-rank"
	,t1."weeks-on-board"
FROM PUBLIC."Billboard" AS t1 limit 100;

select distinct 
	t1.artist
	,t1.song
FROM PUBLIC."Billboard" AS t1
order by t1.artist
	,t1.song;
	
select  
	t1.artist
	,count(*) as qtd_artist
FROM PUBLIC."Billboard" AS t1
group by t1.artist
order by t1.artist
;
	
select  
	t1.song
	,count(*) as qtd_song
FROM PUBLIC."Billboard" AS t1
group by t1.song
order by t1.song


SELECT DISTINCT t1.artist
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
	) AS t3 ON (t1.song = t3.song)
ORDER BY t1.artist
	,t1.song;

--------------------------------------------
with cte_artist as(
	SELECT t1.artist
		,count(*) AS qtd_artist
	FROM PUBLIC."Billboard" AS t1
	GROUP BY t1.artist
	ORDER BY t1.artist
),
cte_song as (
SELECT t1.song
		,count(*) AS qtd_song
	FROM PUBLIC."Billboard" AS t1
	GROUP BY t1.song
	ORDER BY t1.song
)
SELECT DISTINCT t1.artist
	,t2.qtd_artist
	,t1.song
	,t3.qtd_song
FROM PUBLIC."Billboard" AS t1
LEFT JOIN cte_artist AS t2 ON (t1.artist = t2.artist)
LEFT JOIN cte_song AS t3 ON (t1.song = t3.song)
ORDER BY t1.artist
	,t1.song;

--------------------------------------------------------

with cte_billboard as(
select distinct 
	t1.artist
	,t1.song
FROM PUBLIC."Billboard" AS t1
order by t1.artist
	,t1.song
)
select *
	--,row_number() over(order by artist, song) as "row_number"
	--,row_number() over(partition by artist order by artist, song) as "row_number_artist"
	,rank() over(partition by artist order by artist, song) as "rank"
	--,lag(song, 1) over(partition by artist order by artist, song) as "lag_song"
	--,lead(song, 1) over(partition by artist order by artist, song) as "lead_song"
	,first_value(song) over(partition by artist order by artist, song) as "first_song"	
	,last_value(song) over(partition by artist order by artist, song range between unbounded preceding and unbounded following) as "last_song"	
	from cte_billboard
;


WITH T(StyleID, ID, Nome)
     AS (SELECT 1,1, 'Rhuan' UNION ALL
         SELECT 1,1, 'Andre' UNION ALL
         SELECT 1,2, 'Ana' UNION ALL
         SELECT 1,2, 'Maria' UNION ALL
         SELECT 1,3, 'Letícia' UNION ALL
         SELECT 1,3, 'Lari' UNION ALL
         SELECT 1,4, 'Edson' UNION ALL
         SELECT 1,4, 'Marcos' UNION ALL
         SELECT 1,5, 'Rhuan' UNION ALL
         SELECT 1,5, 'Lari' UNION ALL
         SELECT 1,6, 'Daisy' UNION ALL
         SELECT 1,6, 'João'
         )
SELECT *,
	   ROW_NUMBER() OVER(PARTITION BY StyleID ORDER BY ID) AS "ROW_NUMBER",
       RANK() OVER(PARTITION BY StyleID ORDER BY ID)       AS "RANK",
       DENSE_RANK() OVER(PARTITION BY StyleID ORDER BY ID) AS "DENSE_RANK",
       PERCENT_RANK() OVER(PARTITION BY StyleID ORDER BY ID) AS "PERCENT_RANK",
       CUME_DIST() OVER(PARTITION BY StyleID ORDER BY ID) AS "CUME_DIST",
       CUME_DIST() OVER(PARTITION BY StyleID ORDER BY ID DESC) AS "CUME_DIST_DESC",
       FIRST_VALUE(Nome) OVER(PARTITION by StyleID ORDER BY ID) AS "FIRST_VALUE",
       LAST_VALUE(Nome) OVER(PARTITION by StyleID ORDER BY ID) AS "LAST_VALUE",
       NTH_VALUE(Nome,5) OVER(PARTITION by StyleID ORDER BY ID) AS "NTH_VALUE",
       NTILE (5) OVER (ORDER BY StyleID) as "NTILE_5",
       LAG(Nome, 1) over(order by ID) as "LAG_NOME",
       LEAD(Nome, 1) over(order by ID) as "LEAD_NOME"
FROM   T  ;




FROM PUBLIC."Billboard" AS t1
order by t1.artist
	,t1.song;
	
select  
	t1.artist
	,count(*) as qtd_artist
FROM PUBLIC."Billboard" AS t1
group by t1.artist
order by t1.artist
;
	
select  
	t1.song
	,count(*) as qtd_song
FROM PUBLIC."Billboard" AS t1
group by t1.song
order by t1.song


SELECT DISTINCT t1.artist
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
	) AS t3 ON (t1.song = t3.song)
ORDER BY t1.artist
	,t1.song;

--------------------------------------------
with cte_artist as(
	SELECT t1.artist
		,count(*) AS qtd_artist
	FROM PUBLIC."Billboard" AS t1
	GROUP BY t1.artist
	ORDER BY t1.artist
),
cte_song as (
SELECT t1.song
		,count(*) AS qtd_song
	FROM PUBLIC."Billboard" AS t1
	GROUP BY t1.song
	ORDER BY t1.song
)
SELECT DISTINCT t1.artist
	,t2.qtd_artist
	,t1.song
	,t3.qtd_song
FROM PUBLIC."Billboard" AS t1
LEFT JOIN cte_artist AS t2 ON (t1.artist = t2.artist)
LEFT JOIN cte_song AS t3 ON (t1.song = t3.song)
ORDER BY t1.artist
	,t1.song;

--------------------------------------------------------

with cte_billboard as(
select distinct 
	t1.artist
	,t1.song
FROM PUBLIC."Billboard" AS t1
order by t1.artist
	,t1.song
)
select *
	--,row_number() over(order by artist, song) as "row_number"
	--,row_number() over(partition by artist order by artist, song) as "row_number_artist"
	,rank() over(partition by artist order by artist, song) as "rank"
	--,lag(song, 1) over(partition by artist order by artist, song) as "lag_song"
	--,lead(song, 1) over(partition by artist order by artist, song) as "lead_song"
	,first_value(song) over(partition by artist order by artist, song) as "first_song"	
	,last_value(song) over(partition by artist order by artist, song range between unbounded preceding and unbounded following) as "last_song"	
	from cte_billboard
;


WITH T(StyleID, ID, Nome)
     AS (SELECT 1,1, 'Rhuan' UNION ALL
         SELECT 1,1, 'Andre' UNION ALL
         SELECT 1,2, 'Ana' UNION ALL
         SELECT 1,2, 'Maria' UNION ALL
         SELECT 1,3, 'Letícia' UNION ALL
         SELECT 1,3, 'Lari' UNION ALL
         SELECT 1,4, 'Edson' UNION ALL
         SELECT 1,4, 'Marcos' UNION ALL
         SELECT 1,5, 'Rhuan' UNION ALL
         SELECT 1,5, 'Lari' UNION ALL
         SELECT 1,6, 'Daisy' UNION ALL
         SELECT 1,6, 'João'
         )
SELECT *,
	   ROW_NUMBER() OVER(PARTITION BY StyleID ORDER BY ID) AS "ROW_NUMBER",
       RANK() OVER(PARTITION BY StyleID ORDER BY ID)       AS "RANK",
       DENSE_RANK() OVER(PARTITION BY StyleID ORDER BY ID) AS "DENSE_RANK",
       PERCENT_RANK() OVER(PARTITION BY StyleID ORDER BY ID) AS "PERCENT_RANK",
       CUME_DIST() OVER(PARTITION BY StyleID ORDER BY ID) AS "CUME_DIST",
       CUME_DIST() OVER(PARTITION BY StyleID ORDER BY ID DESC) AS "CUME_DIST_DESC",
       FIRST_VALUE(Nome) OVER(PARTITION by StyleID ORDER BY ID) AS "FIRST_VALUE",
       LAST_VALUE(Nome) OVER(PARTITION by StyleID ORDER BY ID) AS "LAST_VALUE",
       NTH_VALUE(Nome,5) OVER(PARTITION by StyleID ORDER BY ID) AS "NTH_VALUE",
       NTILE (5) OVER (ORDER BY StyleID) as "NTILE_5",
       LAG(Nome, 1) over(order by ID) as "LAG_NOME",
       LEAD(Nome, 1) over(order by ID) as "LEAD_NOME"
FROM   T  ;



