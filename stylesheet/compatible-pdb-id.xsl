<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template name="compatible-pdb-id">
    <xsl:param name="str"/>
    <xsl:if test="$str">
      <xsl:variable name="pdb_id"><xsl:value-of select="translate(translate($str,' ',''),'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/></xsl:variable>
      <xsl:choose>
        <xsl:when test="string-length($pdb_id)=4">
          <xsl:value-of select="translate($pdb_id,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
        </xsl:when>
        <xsl:when test="starts-with($pdb_id,'pdb_0000')">
          <xsl:value-of select="translate(substring-after($pdb_id,'pdb_0000'),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/>
        </xsl:when>
        <xsl:when test="starts-with($pdb_id,'pdb_')">
          <xsl:value-of select="$pdb_id"/>
        </xsl:when>
      </xsl:choose>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
