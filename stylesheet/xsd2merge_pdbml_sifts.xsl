<?xml version="1.0" encoding="UTF-8"?>
<xsl2:stylesheet
   version="2.0"
   xmlns:xsl2="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsd="http://www.w3.org/2001/XMLSchema">

  <xsl2:output method="xml" indent="yes"/>
  <xsl2:strip-space elements="*"/>

  <xsl2:template match="/">
    <xsl2:text disable-output-escaping="yes">
&lt;xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:align="http://www.ebi.ac.uk/pdbe/docs/sifts/alignment.xsd"
  xmlns:data="http://www.ebi.ac.uk/pdbe/docs/sifts/dataTypes.xsd"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:sifts="http://www.ebi.ac.uk/pdbe/docs/sifts/eFamily.xsd"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
  exclude-result-prefixes="align data dc rdf sifts"&gt;
</xsl2:text>
    <xsl2:apply-templates/>
    <xsl2:text disable-output-escaping="yes">
&lt;/xsl:stylesheet&gt;</xsl2:text>
  </xsl2:template>

  <xsl2:variable name="merge_categories">pdbx_sifts_unp_segments pdbx_sifts_xref_db_segments</xsl2:variable>

  <xsl2:template match="/xsd:schema">
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:param name="sifts_file" required="yes"/&gt;
  &lt;xsl:param name="sifts" select="document($sifts_file)"/&gt;

  &lt;xsl:param name="sifts_entry" select="$sifts/sifts:entry"/&gt;

  &lt;xsl:output method="xml" indent="yes"/&gt;
  &lt;xsl:strip-space elements="*"/&gt;

  &lt;xsl:variable name="datablock" select="/PDBx:datablock"/&gt;

  &lt;xsl:variable name="entry_id"&gt;&lt;xsl:value-of select="$datablock/PDBx:entryCategory/PDBx:entry/@id"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="datablock_name"&gt;&lt;xsl:value-of select="concat($entry_id,'-noatom')"/&gt;&lt;/xsl:variable&gt;

  &lt;xsl:variable name="pdb_id"&gt;&lt;xsl:value-of select="translate($sifts_entry/@dbAccessionId,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/&gt;&lt;/xsl:variable&gt;

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
</xsl2:text>

    <xsl2:for-each select="tokenize($merge_categories,' ')">
      <xsl2:text disable-output-escaping="yes">
      &lt;xsl:call-template name="merge_</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">"/&gt;
</xsl2:text>
    </xsl2:for-each>
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

  &lt;xsl:template name="extract_pdbx_sifts_unp_segments"&gt;

    &lt;xsl:for-each select="$sifts_entry/sifts:entity"&gt;

      &lt;xsl:variable name="asym_id"&gt;&lt;xsl:value-of select="@entityId"/&gt;&lt;/xsl:variable&gt;
      &lt;xsl:variable name="entity_id"&gt;&lt;xsl:value-of select="$datablock/PDBx:pdbx_poly_seq_schemeCategory/PDBx:pdbx_poly_seq_scheme[@asym_id=$asym_id][1]/@entity_id"/&gt;&lt;/xsl:variable&gt;

      &lt;xsl:for-each select="sifts:segment"&gt;
        &lt;xsl:variable name="segment_id"&gt;&lt;xsl:value-of select="position()"/&gt;&lt;/xsl:variable&gt;
        &lt;xsl:variable name="seq_id_start"&gt;&lt;xsl:value-of select="@start"/&gt;&lt;/xsl:variable&gt;
        &lt;xsl:variable name="seq_id_end"&gt;&lt;xsl:value-of select="@end"/&gt;&lt;/xsl:variable&gt;
        &lt;xsl:variable name="seq_id_range"&gt;&lt;xsl:value-of select="number(@end) - number(@start)"/&gt;&lt;/xsl:variable&gt;

        &lt;xsl:variable name="max_range"&gt;
          &lt;xsl:for-each select="sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource='UniProt']"&gt;
            &lt;xsl:sort select="number(@end) - number(@start)" data-type="number" order="descending"/&gt;
            &lt;xsl:if test="position()=1"&gt;&lt;xsl:value-of select="number(@end) - number(@start)"/&gt;&lt;/xsl:if&gt;
          &lt;/xsl:for-each&gt;
        &lt;/xsl:variable&gt;

        &lt;xsl:for-each select="sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource='UniProt']"&gt;

          &lt;xsl:variable name="instance_id"&gt;&lt;xsl:value-of select="position()"/&gt;&lt;/xsl:variable&gt;
          &lt;xsl:variable name="unp_acc"&gt;&lt;xsl:value-of select="@dbAccessionId"/&gt;&lt;/xsl:variable&gt;

          &lt;PDBx:pdbx_sifts_unp_segments entity_id="{$entity_id}" asym_id="{$asym_id}" unp_acc="{$unp_acc}" segment_id="{$segment_id}" instance_id="{$instance_id}"&gt;

            &lt;xsl:variable name="range"&gt;&lt;xsl:value-of select="number(@end) - number(@start)"/&gt;&lt;/xsl:variable&gt;

            &lt;PDBx:unp_start&gt;&lt;xsl:value-of select="@start"/&gt;&lt;/PDBx:unp_start&gt;
            &lt;PDBx:unp_end&gt;&lt;xsl:value-of select="@end"/&gt;&lt;/PDBx:unp_end&gt;
            &lt;PDBx:seq_id_start&gt;&lt;xsl:value-of select="$seq_id_start"/&gt;&lt;/PDBx:seq_id_start&gt;
            &lt;PDBx:seq_id_end&gt;&lt;xsl:value-of select="$seq_id_end"/&gt;&lt;/PDBx:seq_id_end&gt;
            &lt;xsl:choose&gt;
              &lt;xsl:when test="number(@end) - number(@start)=$max_range"&gt;
                &lt;PDBx:best_mapping&gt;Y&lt;/PDBx:best_mapping&gt;
              &lt;/xsl:when&gt;
              &lt;xsl:otherwise&gt;
                &lt;PDBx:best_mapping&gt;N&lt;/PDBx:best_mapping&gt;
              &lt;/xsl:otherwise&gt;
            &lt;/xsl:choose&gt;
            &lt;PDBx:identity&gt;&lt;xsl:value-of select="format-number($seq_id_range div $range,'0.000')"/&gt;&lt;/PDBx:identity&gt;

          &lt;/PDBx:pdbx_sifts_unp_segments&gt;

        &lt;/xsl:for-each&gt;

      &lt;/xsl:for-each&gt;

    &lt;/xsl:for-each&gt;

  &lt;/xsl:template&gt;

  &lt;xsl:template name="extract_pdbx_sifts_xref_db_segments"&gt;

    &lt;xsl:for-each select="$sifts_entry/sifts:entity"&gt;

      &lt;xsl:variable name="asym_id"&gt;&lt;xsl:value-of select="@entityId"/&gt;&lt;/xsl:variable&gt;
      &lt;xsl:variable name="entity_id"&gt;&lt;xsl:value-of select="$datablock/PDBx:pdbx_poly_seq_schemeCategory/PDBx:pdbx_poly_seq_scheme[@asym_id=$asym_id][1]/@entity_id"/&gt;&lt;/xsl:variable&gt;

      &lt;xsl:for-each select="sifts:segment"&gt;
        &lt;xsl:variable name="segment_id"&gt;&lt;xsl:value-of select="position()"/&gt;&lt;/xsl:variable&gt;

        &lt;xsl:for-each select="sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource!='PDB' and @dbSource!='UniProt' and @dbSource!='EC']"&gt;

          &lt;xsl:variable name="seq_id_start"&gt;&lt;xsl:value-of select="../@start"/&gt;&lt;/xsl:variable&gt;
          &lt;xsl:variable name="seq_id_end"&gt;&lt;xsl:value-of select="../@end"/&gt;&lt;/xsl:variable&gt;

          &lt;xsl:variable name="instance_id"&gt;&lt;xsl:value-of select="position()"/&gt;&lt;/xsl:variable&gt;
          &lt;xsl:variable name="xref_db"&gt;&lt;xsl:value-of select="@dbSource"/&gt;&lt;/xsl:variable&gt;
          &lt;xsl:variable name="xref_db_acc"&gt;
            &lt;xsl:choose&gt;
              &lt;xsl:when test="contains(@dbAccessionId,':') and @dbSource!='GO'"&gt;
                &lt;xsl:value-of select="substring-after(@dbAccessionId,':')"/&gt;
              &lt;/xsl:when&gt;
              &lt;xsl:otherwise&gt;
                &lt;xsl:value-of select="@dbAccessionId"/&gt;
              &lt;/xsl:otherwise&gt;
            &lt;/xsl:choose&gt;
          &lt;/xsl:variable&gt;

          &lt;PDBx:pdbx_sifts_xref_db_segments entity_id="{$entity_id}" asym_id="{$asym_id}" xref_db="{$xref_db}" xref_db_acc="{$xref_db_acc}" segment_id="{$segment_id}" instance_id="{$instance_id}"&gt;

            &lt;PDBx:seq_id_start&gt;&lt;xsl:value-of select="$seq_id_start"/&gt;&lt;/PDBx:seq_id_start&gt;
            &lt;PDBx:seq_id_end&gt;&lt;xsl:value-of select="$seq_id_end"/&gt;&lt;/PDBx:seq_id_end&gt;

          &lt;/PDBx:pdbx_sifts_xref_db_segments&gt;

        &lt;/xsl:for-each&gt;

      &lt;/xsl:for-each&gt;

    &lt;/xsl:for-each&gt;

  &lt;/xsl:template&gt;
</xsl2:text>

    <xsl2:for-each select="tokenize($merge_categories,' ')">
      <xsl2:text disable-output-escaping="yes">
  &lt;xsl:template name="merge_</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">"&gt;
    &lt;xsl:if test="PDBx:datablock/PDBx:</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">Category or $sifts_entry/sifts:entity/sifts:segment</xsl2:text><xsl2:if test=".='pdbx_sifts_xref_db_segments'">/sifts:listMapRegion/sifts:mapRegion/sifts:db[@dbSource!='PDB' and @dbSource!='UniProt' and @dbSource!='EC']</xsl2:if><xsl2:text disable-output-escaping="yes">"&gt;
      &lt;xsl:element name="PDBx:</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">Category"&gt;
        &lt;xsl:choose&gt;
          &lt;xsl:when test="PDBx:datablock/PDBx:</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">Category"&gt;
            &lt;xsl:apply-templates select="PDBx:datablock/PDBx:</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">/*" mode="category-element"/&gt;
          &lt;/xsl:when&gt;
          &lt;xsl:otherwise&gt;
            &lt;xsl:call-template name="extract_</xsl2:text><xsl2:value-of select="."/><xsl2:text disable-output-escaping="yes">"/&gt;
          &lt;/xsl:otherwise&gt;
        &lt;/xsl:choose&gt;
      &lt;/xsl:element&gt;
    &lt;/xsl:if&gt;
  &lt;/xsl:template&gt;
</xsl2:text>
    </xsl2:for-each>

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
