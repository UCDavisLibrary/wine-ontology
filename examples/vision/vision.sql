CREATE TABLE labels (
    label text NOT NULL,
    vision jsonb
);


\COPY labels from Amerine_0.tsv with CSV DELIMITER e'\t' QUOTE e'\r' NULL '\N' ENCODING 'UTF-8'
\COPY labels from Amerine_1.tsv with CSV DELIMITER e'\t' QUOTE e'\r' NULL '\N' ENCODING 'UTF-8'
\COPY labels from Amerine_2.tsv with CSV DELIMITER e'\t' QUOTE e'\r' NULL '\N' ENCODING 'UTF-8'
\COPY labels from Amerine_3.tsv with CSV DELIMITER e'\t' QUOTE e'\r' NULL '\N' ENCODING 'UTF-8'
\COPY labels from Amerine_4.tsv with CSV DELIMITER e'\t' QUOTE e'\r' NULL '\N' ENCODING 'UTF-8'
\COPY labels from Amerine_5.tsv with CSV DELIMITER e'\t' QUOTE e'\r' NULL '\N' ENCODING 'UTF-8'


create view label_dates as
with f as (
 select label,vision->'text'->0->'desc' as t from labels
), c as (
 select distinct label,
  regexp_replace(unnest(regexp_matches(t::text,'((?:(?:1\s*[89])|2\s*0)\s*\d\s*\d)','g')),'\s','','g') as year
  from f
)
select label,array_agg(year order by year) as years from c
group by label;

create view common_phrases as
select lower(jsonb_array_elements(vision->'text')->>'desc') as phrase,
count(*)
from labels
group by 1 order by 2 desc;

create table label_textbox
as
with txt_guess as (
 select * from (
  VALUES  ('date','19\d\d'),
	        ('alcohol','\d\d%')
	) as v(type,re)
),
txt as (
 select label,jsonb_array_elements(vision-> 'text') as it
 from labels
)
select
 label,
 row_number() OVER (partition by label) as num,
 it->>'desc' as text ,
 coalesce(g.type,'other') as type,
 st_geomfromEwkt(
  FORMAT('SRID=0;POLYGON((%s %s, %s %s, %s %s,%s %s,%1$s %2$s))',
  it->'bounds'->0->>'x',-(it->'bounds'->0->>'y')::float,
	it->'bounds'->1->>'x',-(it->'bounds'->1->>'y')::float,
	it->'bounds'->2->>'x',-(it->'bounds'->2->>'y')::float,
	it->'bounds'->3->>'x',-(it->'bounds'->3->>'y')::float)) as bounds
from txt left join txt_guess g on (it->>'desc' ~ g.re);

create view label_geojson as
with f as (
 select
	label,
	'Feature'::text as type,
 	st_asgeojson(bounds)::json as geometry,
	row_to_json((select p from (select num,text,type) as p)
	) as properties
	from label_textbox
),
fc as (
  select
  label,
  'FeatureCollection'::text as type,
	array_to_json(array_agg(f)) as features
  from f group by label,type
)
select label,
row_to_json((select p from (select type,features) as p),true) as json
from fc;


-- Example to get one label as a table;
\set am 0250
drop table if exists amerine.a:am;
create table amerine.a:am
as select * from label_textbox
where label='Amerine-'||:'am';
