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
