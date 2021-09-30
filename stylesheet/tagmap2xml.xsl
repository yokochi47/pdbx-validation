<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  exclude-result-prefixes="xsl xsd">

  <xsl:param name="tagmap_csv_file" required="yes"/>

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template name="main">
    <xsl:variable name="input" select="unparsed-text($tagmap_csv_file)"/>
    <xsl:variable name="rows" select="tokenize($input,'\r?\n')"/>
    <pdbx-to-nmr-star>
      <xsl:for-each select="remove($rows,1)">
        <xsl:variable name="line"><xsl:value-of select="translate(lower-case(.),'&quot;','')"/></xsl:variable>
        <xsl:variable name="pdbx_category">
          <xsl:call-template name="parse_csv_line">
            <xsl:with-param name="line"><xsl:value-of select="$line"/></xsl:with-param>
            <xsl:with-param name="col">1</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="pdbx_item">
          <xsl:call-template name="parse_csv_line">
            <xsl:with-param name="line"><xsl:value-of select="$line"/></xsl:with-param>
            <xsl:with-param name="col">2</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="nmr-star_category">
          <xsl:call-template name="parse_csv_line">
            <xsl:with-param name="line"><xsl:value-of select="$line"/></xsl:with-param>
            <xsl:with-param name="col">3</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="nmr-star_item">
          <xsl:call-template name="parse_csv_line">
            <xsl:with-param name="line"><xsl:value-of select="$line"/></xsl:with-param>
            <xsl:with-param name="col">4</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="trans_func">
          <xsl:call-template name="parse_csv_line">
            <xsl:with-param name="line"><xsl:value-of select="$line"/></xsl:with-param>
            <xsl:with-param name="col">5</xsl:with-param>
          </xsl:call-template>
        </xsl:variable>
        <xsl:if test="$pdbx_category!='' and $pdbx_item!='' and $nmr-star_category!='' and $nmr-star_item!=''">
          <pdbx-item name="{$pdbx_category}.{$pdbx_item}" trans_func="{$trans_func}">
            <xsl:value-of select="concat($nmr-star_category,'.',$nmr-star_item)"/>
          </pdbx-item>
        </xsl:if>
      </xsl:for-each>
    </pdbx-to-nmr-star>
  </xsl:template>

  <xsl:template name="parse_csv_line">
    <xsl:param name="line"/>
    <xsl:param name="col"/>
    <xsl:for-each select="tokenize($line,',')">
      <xsl:if test="position()=$col">
        <xsl:value-of select="."/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>

