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
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
  xmlns:VRPTx="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd"
  exclude-result-prefixes="PDBx"&gt;
</xsl2:text>
    <xsl2:apply-templates/>
    <xsl2:text disable-output-escaping="yes">
&lt;/xsl:stylesheet&gt;</xsl2:text>
  </xsl2:template>

  <xsl2:template match="/xsd:schema">
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:param name="info_file" required="yes"/&gt;
  &lt;xsl:param name="info_entry" select="document($info_file)/wwPDB-validation-information/Entry"/&gt;

  &lt;xsl:output method="xml" encoding="UTF-8" indent="yes"/&gt;
  &lt;xsl:strip-space elements="*"/&gt;

  &lt;xsl:variable name="entry_id"&gt;&lt;xsl:value-of select="/PDBx:datablock/PDBx:entryCategory/PDBx:entry/@id"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="datablock_name"&gt;&lt;xsl:value-of select="concat(/PDBx:datablock/@datablockName,'-ext')"/&gt;&lt;/xsl:variable&gt;

  &lt;xsl:variable name="pdb_id"&gt;&lt;xsl:value-of select="$info_entry/@pdbid"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="xml_creation_date"&gt;&lt;xsl:value-of select="$info_entry/@XMLcreationDate"/&gt;&lt;/xsl:variable&gt;

  &lt;xsl:variable name="validation_created_year"&gt;&lt;xsl:value-of select="substring($xml_creation_date,9,4)"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="validation_created_day"&gt;&lt;xsl:value-of select="translate(substring($xml_creation_date,5,2),' ','0')"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="validation_created_month"&gt;
    &lt;xsl:variable name="month_name"&gt;&lt;xsl:value-of select="translate(substring($xml_creation_date,1,3),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/&gt;&lt;/xsl:variable&gt;
    &lt;xsl:choose&gt;
      &lt;xsl:when test="$month_name='JAN'"&gt;01&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='FEB'"&gt;02&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='MAR'"&gt;03&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='APR'"&gt;04&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='MAY'"&gt;05&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='JUN'"&gt;06&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='JUL'"&gt;07&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='AUG'"&gt;08&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='SEP'"&gt;09&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='OCT'"&gt;10&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='NOV'"&gt;11&lt;/xsl:when&gt;
      &lt;xsl:when test="$month_name='DEC'"&gt;12&lt;/xsl:when&gt;
      &lt;xsl:otherwise&gt;
	&lt;xsl:call-template name="error_handler"&gt;
	  &lt;xsl:with-param name="terminate"&gt;yes&lt;/xsl:with-param&gt;
	  &lt;xsl:with-param name="error_message"&gt;
Month name, &lt;xsl:value-of select="$month_name"/&gt;, is not listed in XSLT code.
	  &lt;/xsl:with-param&gt;
	&lt;/xsl:call-template&gt;
      &lt;/xsl:otherwise&gt;
    &lt;/xsl:choose&gt;
  &lt;/xsl:variable&gt;

  &lt;xsl:variable name="validation_created_date"&gt;&lt;xsl:value-of select="concat($validation_created_year,'-',$validation_created_month,'-',$validation_created_day)"/&gt;&lt;/xsl:variable&gt;

  &lt;xsl:variable name="nmr_models_consistency_flag"&gt;&lt;xsl:value-of select="$info_entry/@nmr_models_consistency_flag"/&gt;&lt;/xsl:variable&gt;

  &lt;xsl:template match="/"&gt;

    &lt;xsl:if test="$entry_id!=$pdb_id"&gt;
      &lt;xsl:call-template name="error_handler"&gt;
	&lt;xsl:with-param name="terminate"&gt;yes&lt;/xsl:with-param&gt;
	&lt;xsl:with-param name="error_message"&gt;
Unmatched entry ID in both documents (&lt;xsl:value-of select="$entry_id"/&gt; and &lt;xsl:value-of select="$pdb_id"/&gt;).
	&lt;/xsl:with-param&gt;
      &lt;/xsl:call-template&gt;
    &lt;/xsl:if&gt;

    &lt;VRPTx:datablock datablockName="{$datablock_name}" xsi:schemaLocation="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd pdbx-validation-v4.xsd"&gt;
      &lt;xsl:apply-templates select="PDBx:datablock/*"/&gt;
    &lt;/VRPTx:datablock&gt;
  &lt;/xsl:template&gt;
</xsl2:text>
      <xsl2:call-template name="categories"/>
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:template match="PDBx:*" mode="category-element"&gt;
    &lt;xsl:element name="VRPTx:{local-name()}"&gt;
      &lt;xsl:apply-templates select="@*|node()" mode="data-item"/&gt;
      &lt;xsl:choose&gt;
	&lt;xsl:when test="local-name()='pdbx_database_status'"&gt;
	  &lt;xsl:element name="VRPTx:validation_created_date"&gt;&lt;xsl:value-of select="$validation_created_date"/&gt;&lt;/xsl:element&gt;
	&lt;/xsl:when&gt;
	&lt;xsl:when test="local-name()='pdbx_nmr_ensemble'"&gt;
	  &lt;xsl:element name="VRPTx:atom_consistency_flag"&gt;
	    &lt;xsl:choose&gt;
	      &lt;xsl:when test="$nmr_models_consistency_flag='True'"&gt;Y&lt;/xsl:when&gt;
	      &lt;xsl:otherwise&gt;N&lt;/xsl:otherwise&gt;
	    &lt;/xsl:choose&gt;
	  &lt;/xsl:element&gt;
	&lt;/xsl:when&gt;
      &lt;/xsl:choose&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="@*" mode="category-element"&gt;
    &lt;xsl:copy/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:*" mode="data-item"&gt;
    &lt;xsl:element name="VRPTx:{local-name()}"&gt;
      &lt;xsl:apply-templates select="@*|node()" mode="data-item"/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="node()" mode="data-item"&gt;
    &lt;xsl:copy/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="@*" mode="data-item"&gt;
    &lt;xsl:copy/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="*[@xsi:nil='true']"/&gt;
  &lt;xsl:template match="*|text()|@*"/&gt;

  &lt;xsl:template name="error_handler"&gt;
    &lt;xsl:param name="error_message"/&gt;
    &lt;xsl:param name="terminate"&gt;no&lt;/xsl:param&gt;
    &lt;xsl:choose&gt;
      &lt;xsl:when test="$terminate='yes'"&gt;
	&lt;xsl:message terminate="yes"&gt;
	  &lt;xsl:text&gt;ERROR in extract_pdbml.xsl: &lt;/xsl:text&gt;
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
    &lt;xsl:element name="VRPTx:{local-name()}"&gt;
      &lt;xsl:apply-templates mode="category-element"/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;
</xsl2:text>
  </xsl2:template>

</xsl2:stylesheet>
