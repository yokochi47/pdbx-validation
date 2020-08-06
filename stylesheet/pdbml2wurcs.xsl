<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd">

  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <xsl:for-each select="//PDBx:pdbx_entity_branch_descriptor/PDBx:descriptor[../PDBx:type='WURCS']/text()">
      <xsl:value-of select="."/>
      <xsl:text>&#xa;</xsl:text>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

</xsl:stylesheet>
