#! /usr/bin/make -f
SHELL:=/bin/bash

PG:=psql service=wine

WINERY_PUBLIC.base:= gis.napa.ca.gov/data/society
WINERY_PUBLIC.zip:= winery_public.zip
WINERY_PUBLIC.pg:= wineries

ava_napa_valley.base:= gis.napa.ca.gov/data/farming
ava_napa_valley.zip:= ava_napa_valley.zip
ava_napa_valley.pg:=napa_valley

ava_Napa_County.base:= gis.napa.ca.gov/data/boundaries
ava_Napa_County.zip:= ava_Napa_County.zip
ava_Napa_County.pg:=avas


files:=WINERY_PUBLIC ava_napa_valley ava_Napa_County
base_files=$(foreach f,${files},${$f.base}/$f)

pg:=$(patsubst %,%.pg,${base_files})
shp:=$(patsubst %,%.shp,${base_files})

${shp}:%.shp:
	[[ -f $(dir $*)${$(notdir $*).zip} ]] || wget --mirror http://$(dir $*)${$(notdir $*).zip}
	(cd $(dir $*); unzip ${$(notdir $*).zip})

.PHONY: pg
pg: ${pg}

${pg}:%.pg:%.shp
	shp2pgsql -d -g boundary -s 2226 -t 2D -S $*.shp ${$(notdir $*).pg} | ${PG} > $@

ava.csv:
	${PG} -c '\COPY (select ava_name as ava,st_asKML(boundary) as boundary from ava_napa_county) to ava.csv with csv header'

ava.geojson:
	ogr2ogr -f "GeoJSON" ava.geojson -t_srs epsg:4269 -sql  'select ava_name as ava,boundary from ava_napa_county' PG:"service=wine"

wineries.csv:
	${PG} -c '\COPY (select name,status,prod_orig,prod_curr,estab_date,total_size,ava,st_asKML(boundary) as boundary from wineries) to wineries.csv with csv header'

wineries.geojson:
	ogr2ogr -f "GeoJSON" wineries.geojson -t_srs epsg:4269 -select name,status,prod_orig,prod_curr,estab_date,total_size,ava PG:"service=wine" "wineries"
