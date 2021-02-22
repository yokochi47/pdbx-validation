#!/bin/bash

end_point=https://ts.glytoucan.org/sparql
limit=500

glytoucan_lock=glytoucan.lock
wurcs_catalog_xml=wurcs_catalog.xml

function query() {
 offset=${1:-0}

 sparql=$(cat <<EOS | sed -e 's/^\s\+//' | tr '\n' ' '
PREFIX glycan: <http://purl.jp/bio/12/glyco/glycan#>
PREFIX glytoucan: <http://www.glytoucan.org/glyco/owl/glytoucan#>
SELECT DISTINCT str(?wurcs) str(?id)
FROM <http://rdf.glytoucan.org/core>
FROM <http://rdf.glytoucan.org/sequence/wurcs>
WHERE {
 ?Saccharide glytoucan:has_primary_id ?id .
 ?Saccharide glycan:has_glycosequence ?GlycoSequence .
 ?GlycoSequence glycan:has_sequence ?wurcs .
 ?GlycoSequence glycan:in_carbohydrate_format glycan:carbohydrate_format_wurcs .
}
LIMIT $limit
OFFSET $offset
EOS
)

 curl -XPOST -H 'Accept: text/tab-separated-values' --data-urlencode "query=${sparql}" $end_point 2> /dev/null | sed '1d'

 return $?
}

function query_recursive() {
 offset=${1:-0}

 result=$(query ${offset})

 status=$?
 if [ $status != 0 ]; then
  echo $0 aborted.
  exit $status
 fi

 if [ -n "${result}" ]; then
  i=0
  printf "\rRetrieved %s entries..." $((offset + $(echo -e "${result}" | wc -l))) >&2
  for line in ${result} ; do
   if [ $(($i % 2)) == 0 ] ; then
    echo -n '<wurcs id='$(echo $line | sed 's/</\&lt;/g; s/>/\&gt;/g')'>' >> $wurcs_catalog_xml
   else
    echo $(echo $line | xargs)'</wurcs>' >> $wurcs_catalog_xml
   fi
   let i++
  done
  query_recursive $((offset + limit))
 else
  printf "\n" >&2
 fi
}

if [ -e $glytoucan_lock ] ; then
 echo $glytoucan_lock exists.
 exit 1
fi

touch $glytoucan_lock

echo '<catalog>' > $wurcs_catalog_xml

query_recursive

echo '</catalog>' >> $wurcs_catalog_xml

rm -f $glytoucan_lock

echo $wurcs_catalog_xml is up-to-date.

