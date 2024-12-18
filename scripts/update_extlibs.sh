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
SAXON_VER=10.9

XSD2PGSCHEMA=xsd2pgschema
XSD2PGSCHEMA_VER=5.3.9

ROBOT_VER=1.9.6

mkdir -p $EXTLIBS

mvn dependency:copy -Dartifact=net.sf.saxon:$SAXON:$SAXON_VER
mv \$\{project.basedir\}/target/dependency/$SAXON-$SAXON_VER.jar $EXTLIBS/saxon-he.jar
rm -rf \$\{project.basedir\}

#wget https://repo1.maven.org/maven2/net/sf/xsd2pgschema/$XSD2PGSCHEMA/$XSD2PGSCHEMA_VER/$XSD2PGSCHEMA-$XSD2PGSCHEMA_VER-jar-with-dependencies.jar -O $EXTLIBS/xsd2pgschema.jar

<<REMARK
mvn dependency:copy -Dartifact=net.sf.xsd2pgschema:$XSD2PGSCHEMA:$XSD2PGSCHEMA_VER
mv \$\{project.basedir\}/target/dependency/$XSD2PGSCHEMA-$XSD2PGSCHEMA_VER.jar $EXTLIBS/xsd2pgschema.jar
rm -rf \$\{project.basedir\}
REMARK

( cd $EXTLIBS
  git clone git://git.code.sf.net/p/xsd2pgschema/code xsd2pgschema-code
  cd xsd2pgschema-code
  git checkout jdk14
  mvn package
  mv target/$XSD2PGSCHEMA-$XSD2PGSCHEMA_VER-jar-with-dependencies.jar ../$XSD2PGSCHEMA.jar
  rm -rf ../xsd2pgschema-code )

wget https://github.com/ontodev/robot/releases/download/v$ROBOT_VER/robot.jar
