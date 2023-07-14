<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  exclude-result-prefixes="xsd xsl xsi">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/xsd:schema">
    <primitive_type_mapping>
      <xsl:apply-templates select="xsd:complexType/xsd:sequence/xsd:element/xsd:complexType"/>
    </primitive_type_mapping>
  </xsl:template>

  <xsl:template match="xsd:complexType/xsd:sequence/xsd:element/xsd:complexType">
    <xsl:variable name="category"><xsl:value-of select="../@name"/></xsl:variable>
    <category_item name="{$category}">
    <xsl:for-each select="xsd:all/xsd:element">
      <xsl:variable name="name"><xsl:value-of select="@name"/></xsl:variable>
      <xsl:choose>
	<xsl:when test="@type and @type!='xsd:string'">
	  <xsl:element name="data_item">
	    <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
	    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
	  </xsl:element>
	</xsl:when>
	<xsl:when test="xsd:simpleType/xsd:restriction[@base and @base!='xsd:string']">
	  <xsl:element name="data_item">
	    <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
	    <xsl:attribute name="type"><xsl:value-of select="xsd:simpleType/xsd:restriction/@base"/></xsl:attribute>
	  </xsl:element>
	</xsl:when>
	<xsl:when test="xsd:complexType/xsd:simpleContent/xsd:extension[@base and @base!='xsd:string']">
	  <xsl:element name="data_item">
	    <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
	    <xsl:attribute name="type"><xsl:value-of select="xsd:complexType/xsd:simpleContent/xsd:extension/@base"/></xsl:attribute>
	  </xsl:element>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
    <xsl:for-each select="xsd:attribute">
      <xsl:variable name="name"><xsl:value-of select="@name"/></xsl:variable>
      <xsl:choose>
	<xsl:when test="@type and @type!='xsd:string'">
	  <xsl:element name="data_item">
	    <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
	    <xsl:attribute name="type"><xsl:value-of select="@type"/></xsl:attribute>
	  </xsl:element>
	</xsl:when>
	<xsl:when test="xsd:simpleType/xsd:restriction[@base and @base!='xsd:string']">
	  <xsl:element name="data_item">
	    <xsl:attribute name="name"><xsl:value-of select="$name"/></xsl:attribute>
	    <xsl:attribute name="type"><xsl:value-of select="xsd:simpleType/xsd:restriction/@base"/></xsl:attribute>
	  </xsl:element>
	</xsl:when>
      </xsl:choose>
    </xsl:for-each>
    </category_item>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

</xsl:stylesheet>
