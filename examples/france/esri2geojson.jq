#! /usr/bin/jq -f

# This conflates all the layers in the ESRI JSON file, and uses the
# titles in attributes.
def toGeoJSON:
{"type":"FeatureCollection",
 "crs": {"type":"name",
				 "properties": {"name":"urn:ogc:def:crs:EPSG::3857"}
				},
 "features":[.operationalLayers[]
						 | . as $layer
						 | $layer.featureCollection.layers[].featureSet.features[]
						 | {"type":"Feature",
								"properties":.attributes
								| {"grapes":.Grapes,
									 "name":.name,
									 "url1":.URL1,
									 "url2":.url2,
									 "region":$layer.title
									},
								"geometry":{
									"type":"Polygon",
									"coordinates":.geometry.rings
								}
							 }
						]
};

toGeoJSON
