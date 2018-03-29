#!/bin/bash

if [ ! `which mvn` ] ; then

 echo "mvn: command not found..."
 echo "Please install Apache Maven (https://maven.apache.org)."

 exit 1

fi

if [ ! `which git` ] ; then

 echo "git: commnd not found..."
 echo "Please install Git (https://git-scm.com)."

 exit 1

fi

EXTLIBS=./extlibs

SAXON=Saxon-HE
SAXON_VER=9.8.0-10

XSD2PGSCHEMA=xsd2pgschema
XSD2PGSCHEMA_VER=2.[0-9].[0-9]

mkdir -p $EXTLIBS

mvn dependency:copy -Dartifact=net.sf.saxon:$SAXON:$SAXON_VER
mv \$\{project.basedir\}/target/dependency/$SAXON-$SAXON_VER.jar $EXTLIBS/saxon9he.jar
rm -rf \$\{project.basedir\}

cd $EXTLIBS

git clone git://git.code.sf.net/p/xsd2pgschema/code xsd2pgschema-code

cd xsd2pgschema-code

mvn package

mv target/$XSD2PGSCHEMA-$XSD2PGSCHEMA_VER-jar-with-dependencies.jar ../$XSD2PGSCHEMA.jar

rm -rf ../xsd2pgschema-code

