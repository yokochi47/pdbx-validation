#!/bin/sh

source ../scripts/env.sh

DIC_FILE=mmcif_pdbx_validation.dic

DIC_PREFIX=pdbx-validation

if [ -e $DIC_FILE ] ; then

 arg=(`grep dictionary.version $DIC_FILE`)
 DIC_VER=${arg[1]}
 DIC_MAJOR_VER=${DIC_VER%%.*}

fi

SAXON=../$SAXON
ROBOT=../$ROBOT

if [ ! -e $SAXON ] || [ ! -e $ROBOT ] ; then
 ( cd ..; ./scripts/update_extlibs.sh )
fi

# Generate VRPT/OWL (premerge)

VRPTX2OWL_PREMERGE_XSL=../stylesheet/vrptx2owl_premerge.xsl
VRPTX_PREMERGE_OWL=$DIC_PREFIX-v$DIC_MAJOR_VER"_premerge.owl"
PDBX_PREMERGE_OWL=../resource/pdbx-v50_premerge.owl
PDBX_VRPTX_OWL=pdbx-with-vrptx-v50.owl

pdbx_owl_file=../resource/pdbx-v50.owl

tagmap_xml_file=../schema/tagmap.xml

java -jar $SAXON -s:$DIC_PREFIX-v$DIC_MAJOR_VER.xsd -xsl:$VRPTX2OWL_PREMERGE_XSL -o:$VRPTX_PREMERGE_OWL pdbx_owl_file=$pdbx_owl_file tagmap_xml_file=$tagmap_xml_file

echo Generated: $VRPTX_PREMERGE_OWL

# Generate combined ontology for PDB core archive and wwPDB validation reports

java -jar $ROBOT merge --input $PDBX_PREMERGE_OWL --input $VRPTX_PREMERGE_OWL --output $PDBX_VRPTX_OWL

echo Generated: $PDBX_VRPTX_OWL

( cd ../resource; ln -s ../schema/$PDBX_VRPTX_OWL . )

date

