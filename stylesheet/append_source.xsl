<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
  xmlns:PDBxv="http://pdbml.pdb.org/schema/pdbx-validation-v0.xsd"
  exclude-result-prefixes="PDBx">

  <xsl:param name="pdbx_xsd_file" required="yes"/>
  <xsl:param name="pdbx_xsd" select="document($pdbx_xsd_file)"/>

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="category_source_url">http://pdbml.pdb.org/dictionaries/mmcif_pdbx_v50.dic/Categories/</xsl:variable>
  <xsl:variable name="data_item_source_url">http://mmcif.wwpdb.org/dictionaries/mmcif_pdbx_v50.dic/Items/_</xsl:variable>

  <xsl:template match="/xsd:schema">
    <xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"
       xmlns:PDBxv="http://pdbml.pdb.org/schema/pdbx-validation-v0.xsd"
       targetNamespace="http://pdbml.pdb.org/schema/pdbx-validation-v0.xsd"
       elementFormDefault="qualified" attributeFormDefault="unqualified">
      <xsl:apply-templates mode="category"/>
      <xsl:call-template name="datablock_type"/>
      <xsl:call-template name="datablock_element"/>
    </xsd:schema>
  </xsl:template>

  <xsl:template match="xsd:complexType" mode="category">
    <xsl:variable name="name"><xsl:value-of select="@name"/></xsl:variable>
    <xsl:if test="$name!='datablockType'">
      <xsd:complexType name="{$name}">
        <xsl:call-template name="category_type">
          <xsl:with-param name="name"><xsl:value-of select="$name"/></xsl:with-param>
        </xsl:call-template>
      </xsd:complexType>
    </xsl:if>
  </xsl:template>

  <xsl:template name="category_type">
    <xsl:param name="name"/>
    <xsl:for-each select="xsd:annotation[1]">
      <xsd:annotation>
        <xsl:call-template name="collect_attrs"/>
        <xsl:for-each select="xsd:documentation">
          <xsl:variable name="content"><xsl:value-of select="."/></xsl:variable>
          <xsd:documentation>
            <xsl:call-template name="collect_attrs"/>
            <xsl:if test="$pdbx_xsd/xsd:schema/xsd:complexType[@name='datablockType']/xsd:all/xsd:element[replace(@type,'PDBx:','')=$name]">
              <xsl:attribute name="source"><xsl:value-of select="concat($category_source_url,replace($name,'Type$',''),'.html')"/></xsl:attribute>
            </xsl:if>
            <xsl:value-of select="$content"/>
          </xsd:documentation>
        </xsl:for-each>
      </xsd:annotation>
    </xsl:for-each>
    <xsl:if test="xsd:sequence">
      <xsd:sequence>
        <xsl:for-each select="xsd:sequence[1]/xsd:element[1]">
          <xsl:copy>
            <xsl:call-template name="collect_attrs"/>
            <xsl:if test="xsd:complexType">
              <xsd:complexType>
                <xsl:if test="xsd:complexType[1]/xsd:all">
                  <xsd:all>
                    <xsl:for-each select="xsd:complexType[1]/xsd:all[1]/xsd:element">
                      <xsl:call-template name="data_item">
                        <xsl:with-param name="category"><xsl:value-of select="$name"/></xsl:with-param>
                        <xsl:with-param name="name"><xsl:value-of select="@name"/></xsl:with-param>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsd:all>
                </xsl:if>
                <xsl:for-each select="xsd:complexType[1]/xsd:attribute">
                  <xsl:call-template name="key_item">
                    <xsl:with-param name="category"><xsl:value-of select="$name"/></xsl:with-param>
                    <xsl:with-param name="name"><xsl:value-of select="@name"/></xsl:with-param>
                  </xsl:call-template>
                </xsl:for-each>
              </xsd:complexType>
            </xsl:if>
          </xsl:copy>
        </xsl:for-each>
      </xsd:sequence>
    </xsl:if>
  </xsl:template>

  <xsl:template name="collect_attrs">
    <xsl:for-each select="@*">
      <xsl:copy/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="data_item">
    <xsl:param name="category"/>
    <xsl:param name="name"/>
    <xsd:element>
      <xsl:call-template name="collect_attrs"/>
      <xsl:for-each select="xsd:annotation[1]">
        <xsd:annotation>
          <xsl:call-template name="collect_attrs"/>
          <xsl:for-each select="xsd:documentation">
            <xsl:variable name="content"><xsl:value-of select="."/></xsl:variable>
            <xsd:documentation>
              <xsl:call-template name="collect_attrs"/>
              <xsl:if test="$pdbx_xsd/xsd:schema/xsd:complexType[@name=$category]/xsd:sequence/xsd:element/xsd:complexType/xsd:all/xsd:element[@name=$name]">
                <xsl:attribute name="source"><xsl:value-of select="concat($data_item_source_url,replace($category,'Type$',''),'.',$name,'.html')"/></xsl:attribute>
              </xsl:if>
              <xsl:value-of select="$content"/>
            </xsd:documentation>
          </xsl:for-each>
        </xsd:annotation>
      </xsl:for-each>
      <xsl:copy-of select="*[not(name()='xsd:annotation')]"/>
    </xsd:element>
  </xsl:template>

  <xsl:template name="key_item">
    <xsl:param name="category"/>
    <xsl:param name="name"/>
    <xsd:attribute>
      <xsl:call-template name="collect_attrs"/>
      <xsl:for-each select="xsd:annotation[1]">
        <xsd:annotation>
          <xsl:call-template name="collect_attrs"/>
          <xsl:for-each select="xsd:documentation">
            <xsl:variable name="content"><xsl:value-of select="."/></xsl:variable>
            <xsd:documentation>
              <xsl:call-template name="collect_attrs"/>
              <xsl:if test="$pdbx_xsd/xsd:schema/xsd:complexType[@name=$category]/xsd:sequence/xsd:element/xsd:complexType/xsd:attribute[@name=$name]">
                <xsl:attribute name="source"><xsl:value-of select="concat($data_item_source_url,replace($category,'Type$',''),'.',$name,'.html')"/></xsl:attribute>
              </xsl:if>
              <xsl:value-of select="$content"/>
            </xsd:documentation>
          </xsl:for-each>
        </xsd:annotation>
      </xsl:for-each>
      <xsl:copy-of select="*[not(name()='xsd:annotation')]"/>
    </xsd:attribute>
  </xsl:template>

  <xsl:template name="datablock_type">
    <xsl:copy-of select="xsd:complexType[@name='datablockType']"/>
  </xsl:template>

  <xsl:template name="datablock_element">
    <xsl:copy-of select="xsd:element[@name='datablock']"/>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

</xsl:stylesheet>
