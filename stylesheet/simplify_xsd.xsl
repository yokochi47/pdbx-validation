<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
  exclude-result-prefixes="xsi">

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/xsd:schema">
    <xsd:schema xmlns:xsd="http://www.w3.org/2001/XMLSchema"
      xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
      targetNamespace="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
      elementFormDefault="qualified" attributeFormDefault="unqualified">
      <xsd:annotation>
        <xsd:appinfo>PDBML Schema v5.315</xsd:appinfo>
        <xsd:documentation source="http://pdbml.pdb.org/schema/pdbx-v50.xsd" xml:lang="en">

PDBML Schema translated from the PDBx/mmCIF Dictionary v5.315:
 http://mmcif.wwpdb.org/dictionaries/ascii/mmcif_pdbx_v50.dic

        </xsd:documentation>
      </xsd:annotation>
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
          <xsl:with-param name="category"><xsl:value-of select="$name"/></xsl:with-param>
        </xsl:call-template>
      </xsd:complexType>
    </xsl:if>
  </xsl:template>

  <xsl:template name="category_type">
    <xsl:param name="category"/>
    <xsl:for-each select="xsd:annotation[1]">
      <xsd:annotation>
        <xsl:call-template name="collect_attrs"/>
        <xsl:for-each select="xsd:documentation">
          <xsl:variable name="content"><xsl:value-of select="."/></xsl:variable>
          <xsd:documentation>
            <xsl:call-template name="collect_attrs"/>
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
                        <xsl:with-param name="category"><xsl:value-of select="$category"/></xsl:with-param>
                        <xsl:with-param name="item"><xsl:value-of select="@name"/></xsl:with-param>
                      </xsl:call-template>
                    </xsl:for-each>
                  </xsd:all>
                </xsl:if>
                <xsl:for-each select="xsd:complexType[1]/xsd:attribute">
                  <xsl:call-template name="key_item">
                    <xsl:with-param name="category"><xsl:value-of select="$category"/></xsl:with-param>
                    <xsl:with-param name="item"><xsl:value-of select="@name"/></xsl:with-param>
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
    <xsl:param name="item"/>
    <xsd:element>
      <xsl:call-template name="collect_attrs"/>
      <xsl:for-each select="xsd:annotation[1]">
      <xsd:annotation>
        <xsl:call-template name="collect_attrs"/>
        <xsl:for-each select="xsd:documentation">
          <xsl:variable name="content"><xsl:value-of select="."/></xsl:variable>
          <xsd:documentation>
            <xsl:call-template name="collect_attrs"/>
            <xsl:value-of select="$content"/>
          </xsd:documentation>
        </xsl:for-each>
      </xsd:annotation>
      </xsl:for-each>
      <xsl:call-template name="fuse_copy">
        <xsl:with-param name="category"><xsl:value-of select="replace($category,'Type$','')"/></xsl:with-param>
        <xsl:with-param name="item"><xsl:value-of select="$item"/></xsl:with-param>
      </xsl:call-template>
    </xsd:element>
  </xsl:template>

  <xsl:template name="key_item">
    <xsl:param name="category"/>
    <xsl:param name="item"/>
    <xsd:attribute>
      <xsl:call-template name="collect_attrs"/>
      <xsl:for-each select="xsd:annotation[1]">
      <xsd:annotation>
        <xsl:call-template name="collect_attrs"/>
        <xsl:for-each select="xsd:documentation">
          <xsl:variable name="content"><xsl:value-of select="."/></xsl:variable>
          <xsd:documentation>
            <xsl:call-template name="collect_attrs"/>
            <xsl:value-of select="$content"/>
          </xsd:documentation>
        </xsl:for-each>
      </xsd:annotation>
      </xsl:for-each>
      <xsl:call-template name="fuse_copy">
        <xsl:with-param name="category"><xsl:value-of select="replace($category,'Type$','')"/></xsl:with-param>
        <xsl:with-param name="item"><xsl:value-of select="$item"/></xsl:with-param>
      </xsl:call-template>
    </xsd:attribute>
  </xsl:template>

  <xsl:template name="fuse_copy">
    <xsl:param name="category"/>
    <xsl:param name="item"/>
    <xsl:choose>
      <xsl:when test="xsd:simpleType/xsd:union">
        <xsl:variable name="simple_types"><xsl:value-of select="count(xsd:simpleType/xsd:union/xsd:simpleType)"/></xsl:variable>
        <xsl:variable name="base"><xsl:value-of select="xsd:simpleType/xsd:union/xsd:simpleType[1]/xsd:restriction/@base"/></xsl:variable>
        <xsl:variable name="min_inc_value">
          <xsl:if test="xsd:simpleType/xsd:union/xsd:simpleType/xsd:restriction/xsd:minInclusive/@value">
            <xsl:value-of select="min(xsd:simpleType/xsd:union/xsd:simpleType/xsd:restriction/xsd:minInclusive/@value)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="max_inc_value">
          <xsl:if test="xsd:simpleType/xsd:union/xsd:simpleType/xsd:restriction/xsd:maxInclusive/@value">
            <xsl:value-of select="max(xsd:simpleType/xsd:union/xsd:simpleType/xsd:restriction/xsd:maxInclusive/@value)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="min_exc_value">
          <xsl:if test="xsd:simpleType/xsd:union/xsd:simpleType/xsd:restriction/xsd:minExclusive/@value">
            <xsl:value-of select="min(xsd:simpleType/xsd:union/xsd:simpleType/xsd:restriction/xsd:minExclusive/@value)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="max_exc_value">
          <xsl:if test="xsd:simpleType/xsd:union/xsd:simpleType/xsd:restriction/xsd:maxExclusive/@value">
            <xsl:value-of select="max(xsd:simpleType/xsd:union/xsd:simpleType/xsd:restriction/xsd:maxExclusive/@value)"/>
          </xsl:if>
        </xsl:variable>
        <xsl:variable name="fuse_min"><xsl:value-of select="$min_inc_value!='' and $min_exc_value=$min_inc_value"/></xsl:variable>
        <xsl:variable name="fuse_max"><xsl:value-of select="$max_inc_value!='' and $max_exc_value=$max_inc_value"/></xsl:variable>
        <xsl:choose>
          <xsl:when test="$simple_types=1">
            <xsl:copy-of select="xsd:simpleType/xsd:union/xsd:simpleType"/>
          </xsl:when>
          <xsl:when test="$simple_types=2">
            <xsl:choose>
              <xsl:when test="$fuse_min=true() and $fuse_max=false()">
                  <xsd:simpleType>
                    <xsd:restriction base="{$base}">
                      <xsd:minInclusive value="{$min_inc_value}"/>
                      <xsl:choose>
                        <xsl:when test="$max_inc_value!='' and $max_inc_value!=$min_inc_value">
                          <xsd:maxInclusive value="{$max_inc_value}"/>
                        </xsl:when>
                        <xsl:when test="$max_exc_value!='' and $max_exc_value!=$min_inc_value">
                          <xsd:maxExclusive value="{$max_exc_value}"/>
                        </xsl:when>
                      </xsl:choose>
                    </xsd:restriction>
                  </xsd:simpleType>
              </xsl:when>
              <xsl:when test="$fuse_max=true() and $fuse_min=false()">
                  <xsd:simpleType>
                    <xsd:restriction base="{$base}">
                      <xsl:choose>
                        <xsl:when test="$min_inc_value!='' and $min_inc_value!=$max_inc_value">
                          <xsd:minInclusive value="{$min_inc_value}"/>
                        </xsl:when>
                        <xsl:when test="$min_exc_value!='' and $min_exc_value!=$max_inc_value">
                          <xsd:minExclusive value="{$min_exc_value}"/>
                        </xsl:when>
                      </xsl:choose>
                      <xsd:maxInclusive value="{$max_inc_value}"/>
                    </xsd:restriction>
                  </xsd:simpleType>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="error_handler">
                  <xsl:with-param name="terminate">yes</xsl:with-param>
                  <xsl:with-param name="error_message">
Invalid pair of restrictions <xsd:value-of select="$simple_types"/> (fuse_min:<xsd:value-of select="$fuse_min"/>, fuse_max:<xsd:value-of select="$fuse_max"/>), in xsd:simpleType/xsd:union element of <xsl:value-of select="$category"/>.<xsl:value-of select="$item"/>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:when test="$simple_types=3">
            <xsl:choose>
              <xsl:when test="$fuse_min=true() and $fuse_max=false()">
                  <xsd:simpleType>
                    <xsd:restriction base="{$base}">
                      <xsd:minInclusive value="{$min_inc_value}"/>
                      <xsl:choose>
                        <xsl:when test="$max_inc_value!='' and $max_inc_value!=$min_inc_value">
                          <xsd:maxInclusive value="{$max_inc_value}"/>
                        </xsl:when>
                        <xsl:when test="$max_exc_value!='' and $max_exc_value!=$min_inc_value">
                          <xsd:maxExclusive value="{$max_exc_value}"/>
                        </xsl:when>
                      </xsl:choose>
                    </xsd:restriction>
                  </xsd:simpleType>
              </xsl:when>
              <xsl:when test="$fuse_max=true() and $fuse_min=false()">
                  <xsd:simpleType>
                    <xsd:restriction base="{$base}">
                      <xsl:choose>
                        <xsl:when test="$min_inc_value!='' and $min_inc_value!=$max_inc_value">
                          <xsd:minInclusive value="{$min_inc_value}"/>
                        </xsl:when>
                        <xsl:when test="$min_exc_value!='' and $min_exc_value!=$max_inc_value">
                          <xsd:minExclusive value="{$min_exc_value}"/>
                        </xsl:when>
                      </xsl:choose>
                      <xsd:maxInclusive value="{$max_inc_value}"/>
                    </xsd:restriction>
                  </xsd:simpleType>
              </xsl:when>
              <xsl:when test="$fuse_min=true() and $fuse_max=true()">
                  <xsd:simpleType>
                    <xsd:restriction base="{$base}">
                      <xsd:minInclusive value="{$min_inc_value}"/>
                      <xsd:maxInclusive value="{$max_inc_value}"/>
                    </xsd:restriction>
                  </xsd:simpleType>
              </xsl:when>
              <xsl:otherwise>
                <xsl:call-template name="error_handler">
                  <xsl:with-param name="terminate">yes</xsl:with-param>
                  <xsl:with-param name="error_message">
Invalid pair of restrictions <xsd:value-of select="$simple_types"/> (fuse_min:<xsd:value-of select="$fuse_min"/>, fuse_max:<xsd:value-of select="$fuse_max"/>), in xsd:simpleType/xsd:union element of <xsl:value-of select="$category"/>.<xsl:value-of select="$item"/>
                  </xsl:with-param>
                </xsl:call-template>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="error_handler">
              <xsl:with-param name="terminate">yes</xsl:with-param>
              <xsl:with-param name="error_message">
Too many xsd:simpleType elements, <xsl:value-of select="$simple_types"/>, in xsd:simpleType/xsd:union element of <xsl:value-of select="$category"/>.<xsl:value-of select="$item"/>
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>
        <xsl:copy-of select="*[not(name()='xsd:annotation')]"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="datablock_type">
    <xsl:copy-of select="xsd:complexType[@name='datablockType']"/>
  </xsl:template>

  <xsl:template name="datablock_element">
    <xsl:copy-of select="xsd:element[@name='datablock']"/>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>

  <xsl:template name="error_handler">
    <xsl:param name="error_message"/>
    <xsl:param name="terminate">no</xsl:param>
    <xsl:choose>
      <xsl:when test="$terminate='yes'">
        <xsl:message terminate="yes">
          <xsl:text>ERROR in simplify_xsd.xsl: </xsl:text>
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
