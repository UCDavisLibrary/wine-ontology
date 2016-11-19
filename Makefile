#! /usr/bin/make -f

# Protege link to wine.daml is broken, this is
wine.rdf:=www.w3.org/TR/owl-guide/wine.rdf
wine.daml:=www.movesinstitute.org/exi/data/DAML/wines.daml

# Rejected
lmco:=www.atl.lmco.com/projects/ontology/ontologies/wine/WineA.n3 www.atl.lmco.com/projects/ontology/ontologies/wine/WineB.n3

dbpedia:=downloads.dbpedia.org/2015-10/dbpedia_2015-10.nt downloads.dbpedia.org/2015-10/dbpedia_2015-10.owl

other:=linkedgeodata.org/ontology.rdf openwines.eu/Winemaker.md

cached:=$(patsubst %,ontologies/%,${other})

sources:=$(patsubst %,ontologies/%,${wine.rdf} ${wine.daml} ${lmco} ${dbpedia})

sources: ${sources} ${cached}


${sources}:ontologies/%:
	(cd ontologies; wget --mirror http://$*)

ontologies/linkedgeodata.org/ontology.rdf:ontologies/%:
	mkdir -p $(dir $@);
	wget -O $@ 'http://swoogle.umbc.edu/index.php?option=com_swoogle_service&service=cache&view=raw&url=http%3A%2F%2Flinkedgeodata.org%2Fontology%2F'

ontologies/openwines.eu/Winemaker.md:ontologies/%:
	mkdir -p $(dir $@)
	wget -O $@ https://raw.githubusercontent.com/OpenWines/Ontology/master/1.0/Winemaker.md


##
# Create JSON-LD using RDF translator
wine-example.json:tr:=http://rdf-translator.appspot.com/convert
wine-example.json:wine-example.owl
	curl --data-urlencode content@$< ${tr}/n3/json-ld/content > $@
