
![OpenWines](https://raw.githubusercontent.com/OpenWines/Resources/master/elements/favicons/android-icon-96x96.png)

# Winemaker

This document is a collaborative terminology standard specification.
Its purpose is to help information systems designers to represent models and instances of the `winemaker` concept.

## Status of this document

This document is merely a public working draft of a potential specification. It has no official standing of any kind and does not represent the support or consensus of any standards organisation.

This document is an experimental work in progress. Use [Github (online editor)](https://help.github.com/articles/editing-files-in-another-user-s-repository/) to propose your changes as new pull request.

## Discussions

This is a collaborative draft, join the discussion on Slack:

- Already on Slack? [Sign in](https://openwines.slack.com/messages/semantics/)
- [Get an invitation](https://openwines-slackin.herokuapp.com/) first, then [join us](https://openwines.slack.com/messages/semantics/)

## Authors

- [Ronan Guilloux](https://github.com/ronanguilloux)

## Definition

`winemaker` (plural `winemakers`)

- a person or company that makes wine

(source: [wiktionary](https://en.wiktionary.org/wiki/winemaker))

## Full example (JSON-LD format)

```json
{
  "@context": [ 
      "http://schema.org/",
      { "ow": "https://github.com/OpenWines/Open-Data/tree/master/Ontologies/1.0/" }
  ],
  "@type": "Winemakerr",
  "ow:isLandowner": true,  
  "address": {
    "@type": "PostalAddress",
    "addressLocality": "Sainte Lumine de Clisson",
    "addressRegion": "Pays de la Loire",
    "postalCode": "44190",
    "streetAddress": "26 les Défois"
  },
  "memberOf": {
    "@type": "Organization",
    "name": "Syndicat Défense Des AOC Muscadet",
    "url" : "http://www.muscadet-grosplant.fr/",
    "telephone": "+33 2 40 80 14 90"
  },
  "businessRegistration": "RCS Nantes 514582691",
  "isicV4": "11.02",
  "name": "Durand Vigneron",
  "openingHours": [
    "Mo-Sa 11:00-14:30",
    "Mo-Th 17:00-21:30",
    "Fr-Sa 17:00-22:00"
  ],
  "telephone": "+33 2 40 54 70 03",
  "fax": "+33 2 40 54 70 03",
  "email": "mailto:durand.verteprairie@wanadoo.fr",
  "url": "http://www.durand-vigneron.com"
}
```

## The JSON-LD format choice

The JSON-LD format choice was [motivated in this article](http://openwines.eu/data-formats.html).

Proposing a JSON-LD format definition is compliant with both linked-data objectives, semantic web, and interoperability concerns, being a RDFa compatible format.

Learn more about [JSON-LD](http://www.w3.org/TR/json-ld/) (full spec on W3C)

[Schema.org](http://schema.org) already proposes a JSON-LD output for each entity it defines.

## Entity inheritance

This `Winemaker` entity described here is an overlay on top of the core Schema's [Winery](https://schema.org/Winery) definition. The [`Winery`](https://schema.org/Winery) parent type definition on [Schema.org](https://schema.org)

As of [JSON-LD spec](http://www.w3.org/TR/json-ld/), the `@vocab` property actually allows us to use such existing vocabulary in this new inherited entity definition.

[Schema.org](http://schema.org) in an ontologies namesspace that provides a core, basic vocabulary for describing the kind of entities the most common web applications need. There is often a need for more specialized and/or deeper vocabularies, that build upon the core. [Schema.org](http://schema.org) extension mechanisms facilitate the creation of such additional vocabularies.

[See how Extension Mechanism works](https://schema.org/docs/extension.html) on Schema.org website.

Example:

```
{
  "@context": [ 
      "http://schema.org/",
      { "ow": "https://github.com/OpenWines/Open-Data/tree/master/Ontologies/1.0/" }
  ],
  "@type": "Winemaker",             <-- this entity type, defined in this context
  "name" : "Durand Vigneron"        <-- name property inherited from Schema.org's Winery entity
}
```

This approach allows also to define french terms spelled sub-types: `vigneron`, `viticulteur`, `viniviticulteur`, `récoltant`, or the english `winegrower` / `vintner`.

## Inherited definitions

These properties are given only for information, the whole list can be found in the [`Winery`](https://schema.org/Winery) parent type definition on [Schema.org](https://schema.org), so this list is not intended to be exhaustive.

### `memberOf`

Inherited from [Schema.org](https://schema.org/memberOf)'s `memberOf`.

Property    | Expected Type               | Type origin                        | Description | Example
----------- | --------------------------- | ---------------------------------- | ----------- | -------
[`memberOf`](https://schema.org/memberOf) | [`Person`](https://schema.org/Person), [`Organization`](https://schema.org/Organization) | [`Winery`](https://schema.org/Winery)| memberships | see below

Example:

```json
{
  "memberOf": {
    "@type": "Organization",
    "name": "Vigneron Indépendant",
    "url": "http://www.vigneron-independant.com"
}
```

## New definitions

These properties are proposed in addition, from the [OpenWines.org](http://openwines.org) initiative.

__Disclaimers__

- Status: _Work In Progress_
- We're building a collaborative terminology standard recommandation: Each property newly proposed here always needs to be evaluated accurately first before being accepted. Expect to face some contradiction ;-) 


### `isLandowner`

Motivation: In both french and english vocabulary, many sub-types exists to define more precisely the person that make wine : (english) `winegrower`, `vintner`, (french) `vigneron`, `viticulteur`, `viniviticulteur`, `récoltant`. Each one is a variant of a global job family, but some of them have common the fact that they describe a person who owns the lands where the grapes are grown and harvested.

Property    | Expected Type               | Description | Example
----------- | --------------------------- | ----------- | -------
`ow:isLandowner` | [`Boolean`](https://schema.org/Boolean) | owns the lands where he produces his wines | `true`

Example :

```json
{
  "@context": [ 
      "http://schema.org/",
      { "ow": "https://github.com/OpenWines/Open-Data/tree/master/Ontologies/1.0/" }
  ],
  "@type": "Winemaker",
  "ow:isLandowner": true,
  "name" : "Durand Vigneron"
}
```

### `label`

Motivation: Winemaker's labels must not be confused with wine's labels ("_étiquette du vin_"). Such labels do not refer to a particular product (a wine, a _cuvée_) but is rather attached to the winemaker himself or his company. In concrete terms, a winemaker's label is an organization mark, and Winemaker's labels are usually represented as a logo of such labelling organization.

Property    | Expected Type               | Description | Example
----------- | --------------------------- | ----------- | -------
`ow:label` | [`Organization`](https://schema.org/Organization) | One or more labels owned by the winemaker | _see below_

Example :

```json
{
  "@context": [ 
      "http://schema.org/",
      { "ow": "https://github.com/OpenWines/Open-Data/tree/master/Ontologies/1.0/" }
  ],
  "@type": "Winemaker",
  "ow:label": [
      {
          "name": "Vignobles et Découvertes",
          "@type": "Organization",
          "url": "http://atout-france.fr/services/le-label-vignobles-decouvertes"
      },
      {
          "name": "Gîtes de France",
          "@type": "Organization",
          "url": "http://www.gites-de-france.com"
      }
  ],
  "name" : "Domaine du Moulin de l'Horizon"
}
```

### `service`

Motivation: Winemaker's services indicates all kind of services that differ from the main activity of the winemaker, as defined above. Services are not necessarily related to an organization or a label. Services may be free and immaterial. Be aware that winemakers that wouldn't produce any wine and who's essential activities are shifted into  providing _services_ should not then be represented using the actual `winemaker` ontology.

Property    | Expected Type               | Description | Example
----------- | --------------------------- | ----------- | -------
`ow:service` | [`Service`](https://schema.org/Service) | One or more services provided by the winemaker | _see below_

Example :

```json
{
  "@context": [ 
      "http://schema.org/",
      { "ow": "https://github.com/OpenWines/Open-Data/tree/master/Ontologies/1.0/" }
  ],
  "@type": "Winemaker",
  "ow:service": [
      {
          "name": "Handicap facilities",
          "@type": "Service"
      },
      {
          "name": "Payment by bankcard",
          "@type": "Service"
      }
  ],
  "name" : "Domaine du Moulin Blanc"
}
```
