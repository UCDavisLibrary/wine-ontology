#! /usr/bin/make -f
PG:=psql service=wine

regions_in.geojson:item:=f00e59695c114bcc8b88dd3c93437c52
regions_in.geojson:base:=http://www.arcgis.com/sharing/rest/content/items
regions_in.geojson:
	curl ${base}/${item}/data?f=json | jq -f esri2geojson.jq > $@


vineyards:
	shp2pgsql -d -S -i -t 2D -g boundary -s 3035:4326 clc06_c221.shp france.vineyards | ${PG}
