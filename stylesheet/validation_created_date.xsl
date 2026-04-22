<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">

  <xsl:output method="text"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">

    <xsl:variable name="xml_creation_date"><xsl:value-of select="wwPDB-validation-information/Entry/@XMLcreationDate"/></xsl:variable>

    <xsl:variable name="validation_created_year"><xsl:value-of select="substring($xml_creation_date,9,4)"/></xsl:variable>
    <xsl:variable name="validation_created_day"><xsl:value-of select="translate(substring($xml_creation_date,5,2),' ','0')"/></xsl:variable>
    <xsl:variable name="validation_created_month">
      <xsl:variable name="month_name"><xsl:value-of select="upper-case(substring($xml_creation_date,1,3))"/></xsl:variable>
      <xsl:choose>
        <xsl:when test="$month_name='JAN'">01</xsl:when>
        <xsl:when test="$month_name='FEB'">02</xsl:when>
        <xsl:when test="$month_name='MAR'">03</xsl:when>
        <xsl:when test="$month_name='APR'">04</xsl:when>
        <xsl:when test="$month_name='MAY'">05</xsl:when>
        <xsl:when test="$month_name='JUN'">06</xsl:when>
        <xsl:when test="$month_name='JUL'">07</xsl:when>
        <xsl:when test="$month_name='AUG'">08</xsl:when>
        <xsl:when test="$month_name='SEP'">09</xsl:when>
        <xsl:when test="$month_name='OCT'">10</xsl:when>
        <xsl:when test="$month_name='NOV'">11</xsl:when>
        <xsl:when test="$month_name='DEC'">12</xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="error_handler">
            <xsl:with-param name="terminate">yes</xsl:with-param>
            <xsl:with-param name="error_message">
Month name, <xsl:value-of select="$month_name"/>, is not listed in XSLT code.
            </xsl:with-param>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:value-of select="concat($validation_created_year,'-',$validation_created_month,'-',$validation_created_day)"/>

  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

  <xsl:template name="error_handler">
    <xsl:param name="error_message"/>
    <xsl:param name="terminate">no</xsl:param>
    <xsl:choose>
      <xsl:when test="$terminate='yes'">
        <xsl:message terminate="yes">
          <xsl:text>ERROR in validation_created_date.xsl: </xsl:text>
          <xsl:value-of select="$error_message"/>
        </xsl:message>
      </xsl:when>
      <xsl:otherwise>
        <span style="font-weight: bold; color: red">
          <xsl:text>ERROR: </xsl:text>
          <xsl:value-of select="$error_message"/>
        </span>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
