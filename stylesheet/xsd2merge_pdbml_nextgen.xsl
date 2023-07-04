<?xml version="1.0" encoding="UTF-8"?>
<xsl2:stylesheet
   version="2.0"
   xmlns:xsl2="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsd="http://www.w3.org/2001/XMLSchema">

  <xsl2:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl2:strip-space elements="*"/>

  <xsl2:template match="/">
    <xsl2:text disable-output-escaping="yes">
&lt;xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"&gt;
</xsl2:text>
    <xsl2:apply-templates/>
    <xsl2:text disable-output-escaping="yes">
&lt;/xsl:stylesheet&gt;</xsl2:text>
  </xsl2:template>

  <xsl2:variable name="merge_categories">pdbx_sifts_unp_segments pdbx_sifts_xref_db</xsl2:variable>

  <xsl2:template match="/xsd:schema">
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:param name="nextgen_file" required="yes"/&gt;
  &lt;xsl:param name="alt_datablock" select="document($nextgen_file)/PDBx:datablock"/&gt;

  &lt;xsl:output method="xml" encoding="UTF-8" indent="yes"/&gt;
  &lt;xsl:strip-space elements="*"/&gt;

  &lt;xsl:variable name="entry_id"&gt;&lt;xsl:value-of select="/PDBx:datablock/PDBx:entryCategory/PDBx:entry/@id"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="datablock_name"&gt;&lt;xsl:value-of select="concat($entry_id,'-noatom')"/&gt;&lt;/xsl:variable&gt;

  &lt;xsl:variable name="pdb_id"&gt;&lt;xsl:value-of select="$alt_datablock/PDBx:entryCategory/PDBx:entry/@id"/&gt;&lt;/xsl:variable&gt;

  &lt;xsl:template match="/"&gt;

    &lt;xsl:if test="$entry_id!=$pdb_id"&gt;
      &lt;xsl:call-template name="error_handler"&gt;
	&lt;xsl:with-param name="terminate"&gt;yes&lt;/xsl:with-param&gt;
	&lt;xsl:with-param name="error_message"&gt;
Unmatched entry ID in both documents (&lt;xsl:value-of select="$entry_id"/&gt; and &lt;xsl:value-of select="$pdb_id"/&gt;).
	&lt;/xsl:with-param&gt;
      &lt;/xsl:call-template&gt;
    &lt;/xsl:if&gt;

    &lt;PDBx:datablock datablockName="{$datablock_name}" xsi:schemaLocation="http://pdbml.pdb.org/schema/pdbx-v50.xsd pdbx-v50.xsd"&gt;
      &lt;xsl:apply-templates select="PDBx:datablock/*[not(</xsl2:text>

    <xsl2:for-each select="tokenize($merge_categories,' ')">
      <xsl2:text disable-output-escaping="yes">local-name()='</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">Category'</xsl2:text>
      <xsl2:if test="position()!=last()"><xsl2:text disable-output-escaping="yes"> or </xsl2:text></xsl2:if>
    </xsl2:for-each>

    <xsl2:text disable-output-escaping="yes">)]"/&gt;
      &lt;xsl:apply-templates select="$alt_datablock/*[</xsl2:text>

    <xsl2:for-each select="tokenize($merge_categories,' ')">
      <xsl2:text disable-output-escaping="yes">local-name()='</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">Category'</xsl2:text>
      <xsl2:if test="position()!=last()"><xsl2:text disable-output-escaping="yes"> or </xsl2:text></xsl2:if>
    </xsl2:for-each>

    <xsl2:text disable-output-escaping="yes">]"/&gt;
</xsl2:text>

    <xsl2:text disable-output-escaping="yes">
    &lt;/PDBx:datablock&gt;
  &lt;/xsl:template&gt;
</xsl2:text>
    <xsl2:call-template name="categories"/>
      <xsl2:text disable-output-escaping="yes">
  &lt;xsl:template match="PDBx:*" mode="category-element"&gt;
    &lt;xsl:element name="{name()}"&gt;
      &lt;xsl:apply-templates select="@*|node()" mode="data-item"/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="@*" mode="category-element"&gt;
    &lt;xsl:copy/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:*" mode="data-item"&gt;
    &lt;xsl:element name="{name()}"&gt;
      &lt;xsl:apply-templates select="@*|node()" mode="data-item"/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="node()" mode="data-item"&gt;
    &lt;xsl:copy/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="@*" mode="data-item"&gt;
    &lt;xsl:copy/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template name="error_handler"&gt;
    &lt;xsl:param name="error_message"/&gt;
    &lt;xsl:param name="terminate"&gt;no&lt;/xsl:param&gt;
    &lt;xsl:choose&gt;
      &lt;xsl:when test="$terminate='yes'"&gt;
	&lt;xsl:message terminate="yes"&gt;
	  &lt;xsl:text&gt;ERROR in merge_pdbml_info.xsl: &lt;/xsl:text&gt;
	  &lt;xsl:value-of select="$error_message"/&gt;
	&lt;/xsl:message&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:otherwise&gt;
	&lt;span style="font-weight: bold; color: red"&gt;
	  &lt;xsl:text&gt;ERROR: &lt;/xsl:text&gt;
	  &lt;xsl:value-of select="$error_message"/&gt;
	&lt;/span&gt;
      &lt;/xsl:otherwise&gt;
    &lt;/xsl:choose&gt;
  &lt;/xsl:template&gt;
</xsl2:text>

    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:template match="*[@xsi:nil='true']"/&gt;
  &lt;xsl:template match="*|text()|@*"/&gt;
</xsl2:text>
  </xsl2:template>

  <xsl2:template name="categories">
    <xsl2:for-each select="xsd:complexType[@name='datablockType']/xsd:all/xsd:element">
      <xsl2:call-template name="category">
	<xsl2:with-param name="name" select="@name"/>
      </xsl2:call-template>
    </xsl2:for-each>
  </xsl2:template>

  <xsl2:template name="category">
    <xsl2:param name="name"/>
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:template match="PDBx:</xsl2:text><xsl2:value-of select="$name"/><xsl2:text disable-output-escaping="yes">"&gt;
    &lt;xsl:element name="{name()}"&gt;
      &lt;xsl:apply-templates mode="category-element"/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;
</xsl2:text>
  </xsl2:template>

</xsl2:stylesheet>
