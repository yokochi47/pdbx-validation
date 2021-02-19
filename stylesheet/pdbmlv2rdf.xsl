<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:PDBxv="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd"
  xmlns:PDBov="https://rdf.wwpdb.org/schema/pdbx-validation-v4.owl#"
  exclude-result-prefixes="PDBxv">

  <xsl:param name="wurcs2glytoucan" select="'https://raw.githubusercontent.com/yokochi47/pdbx-validation/master/wurcs2glytoucan/glytoucan.xml'" required="no"/>
  <xsl:param name="glytoucan" select="document($wurcs2glytoucan)"/>

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="PDBID"><xsl:value-of select="/PDBxv:datablock/PDBxv:entryCategory/PDBxv:entry/@id"/></xsl:variable>
  <xsl:variable name="pdbid"><xsl:value-of select="translate($PDBID,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/></xsl:variable>
  <xsl:variable name="pdb_doi"><xsl:value-of select="concat('10.2210/pdb',$pdbid,'/pdb')"/></xsl:variable>
  <xsl:variable name="base">https://rdf.wwpdb.org/pdb-validation/<xsl:value-of select="$PDBID"/></xsl:variable>
  <xsl:variable name="base_lower">https://rdf.wwpdb.org/pdb/<xsl:value-of select="$pdbid"/></xsl:variable>
  <xsl:variable name="pdb_link">https://rdf.wwpdb.org/pdb/</xsl:variable>
  <xsl:variable name="bmrb_link">https://bmrbpub.pdbj.org/rdf/bmr</xsl:variable>
  <xsl:variable name="chem_comp">https://rdf.wwpdb.org/cc/</xsl:variable>
  <xsl:variable name="pdbj">https://pdbj.org/pdb/</xsl:variable>
  <xsl:variable name="rcsb">https://www.rcsb.org/pdb/explore.do?structureId=</xsl:variable>
  <xsl:variable name="pdbe">https://www.ebi.ac.uk/pdbe/entry/pdb/</xsl:variable>
  <xsl:variable name="pdbml">ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML/</xsl:variable>
  <xsl:variable name="pdbml_noatom">ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML-noatom/</xsl:variable>
  <xsl:variable name="pdbml_extatom">ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML-extatom/</xsl:variable>
  <xsl:variable name="vrpt">ftp://ftp.wwpdb.org/pub/pdb/validation_reports/<xsl:value-of select="substring($pdbid,2,2)"/>/<xsl:value-of select="$pdbid"/>/</xsl:variable>
  <xsl:variable name="idorg">http://identifiers.org/</xsl:variable>
  <xsl:variable name="doi">https://doi.org/</xsl:variable>
  <xsl:variable name="pubmed">https://www.ncbi.nlm.nih.gov/pubmed/</xsl:variable>
  <xsl:variable name="taxonomy">http://purl.uniprot.org/taxonomy/</xsl:variable>
  <xsl:variable name="genbank">https://www.ncbi.nlm.nih.gov/nuccore/</xsl:variable>
  <xsl:variable name="uniprot">http://purl.uniprot.org/uniprot/</xsl:variable>
  <xsl:variable name="enzyme">http://purl.uniprot.org/enzyme/</xsl:variable>
  <xsl:variable name="go">http://amigo.geneontology.org/amigo/term/GO:/</xsl:variable>
  <xsl:variable name="glycoinfo">http://rdf.glycoinfo.org/glycan/</xsl:variable>

  <xsl:template match="/">
    <rdf:RDF>
      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <!-- level 1 -->
  <xsl:template match="/PDBxv:datablock">
    <PDBov:datablock rdf:about="{$base}">
      <dcterms:identifier><xsl:value-of select="$PDBID"/></dcterms:identifier>
      <skos:altLabel><xsl:value-of select="$pdbid"/></skos:altLabel>
      <dc:title><xsl:value-of select="PDBxv:structCategory/PDBxv:struct/PDBxv:title/text()"/></dc:title>
      <PDBov:link_to_pdb_src rdf:resource="{$pdb_link}{$pdbid}"/>
      <PDBov:link_to_pdbml rdf:resource="{$pdbml}{$pdbid}.xml.gz"/>
      <PDBov:link_to_pdbml_noatom rdf:resource="{$pdbml_noatom}{$pdbid}-noatom.xml.gz"/>
      <PDBov:link_to_pdbml_extatom rdf:resource="{$pdbml_extatom}{$pdbid}-extatom.xml.gz"/>
      <PDBov:link_to_xml_vrpt rdf:resource="{$vrpt}{$pdbid}_validation.xml.gz"/>
      <PDBov:link_to_doi rdf:resource="{$doi}{$pdb_doi}" rdfs:label="doi:{$pdb_doi}"/>
      <!-- PDBov:link_to_pdbml_vrpt rdf:resource="{$vrpt}{$pdbid}-validation-full.xml.gz"/ -->
      <!-- PDBov:link_to_pdbml_vrpt_alt rdf:resource="{$vrpt}{$pdbid}-validation-alt.xml.gz"/ -->
      <owl:sameAs rdf:resource="{$base_lower}"/>
      <rdfs:seeAlso rdf:resource="{$pdbj}{$PDBID}"/>
      <rdfs:seeAlso rdf:resource="{$rcsb}{$PDBID}"/>
      <rdfs:seeAlso rdf:resource="{$pdbe}{$PDBID}"/>

      <PDBov:datablockName><xsl:value-of select="@datablockName"/></PDBov:datablockName>
      <xsl:apply-templates select="./*"/>
    </PDBov:datablock>
  </xsl:template>

  <!-- level 2 -->
  <xsl:template match="/PDBxv:datablock/*">
    <xsl:element name="PDBov:has_{local-name(.)}">
      <xsl:element name="PDBov:{local-name(.)}">
        <xsl:attribute name="rdf:about">
          <xsl:value-of select="concat($base,'/',local-name(.))"/>
        </xsl:attribute>
        <xsl:apply-templates>
          <xsl:with-param name="base" select="$base"/>
        </xsl:apply-templates>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (PCData) -->
  <xsl:template match="/PDBxv:datablock/*/*/*[not(xsi:nil) and text()!='']">
    <xsl:element name="PDBov:{concat(local-name(parent::node()),'.',local-name())}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (attribute) -->
  <xsl:template match="/PDBxv:datablock/*/*/@*">
    <xsl:element name="PDBov:{concat(local-name(parent::node()),'.',translate(name(),'@',''))}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (linked data) -->
  <xsl:template match="PDBxv:chem_comp/@id" mode="linked">
    <PDBov:link_to_chem_comp rdf:resource="{$chem_comp}{.}"/>
  </xsl:template>

  <xsl:template match="PDBxv:citation/PDBxv:pdbx_database_id_DOI[text()!='']" mode="linked">
    <PDBov:link_to_doi rdf:resource="{$doi}{text()}" rdfs:label="doi:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:citation/PDBxv:pdbx_database_id_PubMed[text()!='']" mode="linked">
    <PDBov:link_to_pubmed rdf:resource="{$pubmed}{text()}" rdfs:label="pubmed:{text()}"/>
    <dcterms:references rdf:resource="{$idorg}pubmed/{text()}" rdfs:label="pubmed:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:entity_src_gen/PDBxv:pdbx_gene_src_ncbi_taxonomy_id[text()!='']" mode="linked">
    <PDBov:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:entity_src_gen/PDBxv:pdbx_host_org_ncbi_taxonomy_id[text()!='']" mode="linked">
    <PDBov:link_to_taxonomy_host rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:entity_src_nat/PDBxv:pdbx_ncbi_taxonomy_id[text()!='']" mode="linked">
    <PDBov:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:entity/PDBxv:pdbx_ec[text()!='']" mode="linked">
    <PDBov:link_to_enzyme rdf:resource="{$enzyme}{text()}" rdfs:label="enzyme:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ec-code/{text()}" rdfs:label="ec-code:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ref/PDBxv:pdbx_db_accession[../PDBxv:db_name='UNP' and text()!='']" mode="linked">
    <PDBov:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:struct_ref/PDBxv:db_code[../PDBxv:db_name='GB' and text()!='']" mode="linked">
    <PDBov:link_to_genbank rdf:resource="{$genbank}{text()}" rdfs:label="genbank:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}insdc/{text()}" rdfs:label="nuccore:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_entity_branch_descriptor/PDBxv:descriptor[../PDBxv:type='WURCS' and text()!='']" mode="linked">
    <xsl:variable name="wurcs_id"><xsl:value-of select="text()"/></xsl:variable>
    <xsl:for-each select="$glytoucan/catalog/wurcs[@id=$wurcs_id]">
      <xsl:if test="text()!=''">
        <PDBov:link_to_glycoinfo rdf:resource="{$glycoinfo}{text()}" rdfs:label="glytoucan:{text()}"/>
        <rdfs:seeAlso rdf:resource="{$idorg}glytoucan/{text()}" rdfs:label="glytoucan:{text()}"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_database_related[@db_name='PDB' and @content_type!='split']/@db_id" mode="linked">
    <PDBov:link_to_pdb rdf:resource="{$pdb_link}{.}"/>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_database_related[@db_name='PDB' and @content_type='split']/@db_id" mode="linked">
    <PDBov:link_to_pdb_split rdf:resource="{$pdb_link}{.}"/>
  </xsl:template>

  <xsl:template match="PDBxv:chem_comp/PDBxv:pdbx_model_coordinates_db_code" mode="linked">
    <PDBov:link_to_pdb rdf:resource="{$pdb_link}{text()}"/>
  </xsl:template>

  <xsl:template match="PDBxv:pdbx_database_related[@db_name='BMRB']/@db_id" mode="linked">
    <PDBov:link_to_bmrb rdf:resource="{$bmrb_link}{.}"/>
  </xsl:template>

  <!-- level-3 templates follow -->
  <xsl:template match="PDBxv:datablock/PDBxv:diffrnCategory/PDBxv:diffrn">
      <PDBov:has_diffrn>
      <PDBov:diffrn rdf:about="{$base}/diffrn/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn>
      </PDBov:has_diffrn>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_attenuatorCategory/PDBxv:diffrn_attenuator">
      <PDBov:has_diffrn_attenuator>
      <PDBov:diffrn_attenuator rdf:about="{$base}/diffrn_attenuator/{translate(@code,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_attenuator>
      </PDBov:has_diffrn_attenuator>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_detectorCategory/PDBxv:diffrn_detector">
      <PDBov:has_diffrn_detector>
      <PDBov:diffrn_detector rdf:about="{$base}/diffrn_detector/{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_detector rdf:resource="{$base}/diffrn_detector/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_detector>
      </PDBov:has_diffrn_detector>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_measurementCategory/PDBxv:diffrn_measurement">
      <PDBov:has_diffrn_measurement>
      <PDBov:diffrn_measurement rdf:about="{$base}/diffrn_measurement/{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_measurement rdf:resource="{$base}/diffrn_measurement/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_measurement>
      </PDBov:has_diffrn_measurement>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_orient_matrixCategory/PDBxv:diffrn_orient_matrix">
      <PDBov:has_diffrn_orient_matrix>
      <PDBov:diffrn_orient_matrix rdf:about="{$base}/diffrn_orient_matrix/{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_orient_matrix rdf:resource="{$base}/diffrn_orient_matrix/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_orient_matrix>
      </PDBov:has_diffrn_orient_matrix>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_orient_reflnCategory/PDBxv:diffrn_orient_refln">
      <PDBov:has_diffrn_orient_refln>
      <PDBov:diffrn_orient_refln rdf:about="{$base}/diffrn_orient_refln/{translate(@diffrn_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_orient_refln rdf:resource="{$base}/diffrn_orient_refln/{translate(@diffrn_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_orient_refln>
      </PDBov:has_diffrn_orient_refln>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_radiationCategory/PDBxv:diffrn_radiation">
      <PDBov:has_diffrn_radiation>
      <PDBov:diffrn_radiation rdf:about="{$base}/diffrn_radiation/{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_radiation rdf:resource="{$base}/diffrn_radiation/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_radiation>
      </PDBov:has_diffrn_radiation>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_radiation_wavelengthCategory/PDBxv:diffrn_radiation_wavelength">
      <PDBov:has_diffrn_radiation_wavelength>
      <PDBov:diffrn_radiation_wavelength rdf:about="{$base}/diffrn_radiation_wavelength/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_radiation_wavelength>
      </PDBov:has_diffrn_radiation_wavelength>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_reflnCategory/PDBxv:diffrn_refln">
      <PDBov:has_diffrn_refln>
      <PDBov:diffrn_refln rdf:about="{$base}/diffrn_refln/{translate(@diffrn_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_refln rdf:resource="{$base}/diffrn_refln/{translate(@diffrn_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_refln>
      </PDBov:has_diffrn_refln>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_reflnsCategory/PDBxv:diffrn_reflns">
      <PDBov:has_diffrn_reflns>
      <PDBov:diffrn_reflns rdf:about="{$base}/diffrn_reflns/{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_reflns rdf:resource="{$base}/diffrn_reflns/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_reflns>
      </PDBov:has_diffrn_reflns>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_reflns_classCategory/PDBxv:diffrn_reflns_class">
      <PDBov:has_diffrn_reflns_class>
      <PDBov:diffrn_reflns_class rdf:about="{$base}/diffrn_reflns_class/{translate(@code,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_reflns_class>
      </PDBov:has_diffrn_reflns_class>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_scale_groupCategory/PDBxv:diffrn_scale_group">
      <PDBov:has_diffrn_scale_group>
      <PDBov:diffrn_scale_group rdf:about="{$base}/diffrn_scale_group/{translate(@code,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_scale_group>
      </PDBov:has_diffrn_scale_group>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_sourceCategory/PDBxv:diffrn_source">
      <PDBov:has_diffrn_source>
      <PDBov:diffrn_source rdf:about="{$base}/diffrn_source/{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_source rdf:resource="{$base}/diffrn_source/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_source>
      </PDBov:has_diffrn_source>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_standard_reflnCategory/PDBxv:diffrn_standard_refln">
      <PDBov:has_diffrn_standard_refln>
      <PDBov:diffrn_standard_refln rdf:about="{$base}/diffrn_standard_refln/{translate(@code,' ^','_')},{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_standard_refln rdf:resource="{$base}/diffrn_standard_refln/{translate(@code,' ^','_')},{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_standard_refln>
      </PDBov:has_diffrn_standard_refln>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:diffrn_standardsCategory/PDBxv:diffrn_standards">
      <PDBov:has_diffrn_standards>
      <PDBov:diffrn_standards rdf:about="{$base}/diffrn_standards/{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_diffrn_standards rdf:resource="{$base}/diffrn_standards/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:diffrn_standards>
      </PDBov:has_diffrn_standards>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_2d_crystal_entityCategory/PDBxv:em_2d_crystal_entity">
      <PDBov:has_em_2d_crystal_entity>
      <PDBov:em_2d_crystal_entity rdf:about="{$base}/em_2d_crystal_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_2d_crystal_entity>
      </PDBov:has_em_2d_crystal_entity>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_3d_crystal_entityCategory/PDBxv:em_3d_crystal_entity">
      <PDBov:has_em_3d_crystal_entity>
      <PDBov:em_3d_crystal_entity rdf:about="{$base}/em_3d_crystal_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_3d_crystal_entity>
      </PDBov:has_em_3d_crystal_entity>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_3d_fittingCategory/PDBxv:em_3d_fitting">
      <PDBov:has_em_3d_fitting>
      <PDBov:em_3d_fitting rdf:about="{$base}/em_3d_fitting/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_em_3d_fitting rdf:resource="{$base}/em_3d_fitting/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_3d_fitting>
      </PDBov:has_em_3d_fitting>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_3d_fitting_listCategory/PDBxv:em_3d_fitting_list">
      <PDBov:has_em_3d_fitting_list>
      <PDBov:em_3d_fitting_list rdf:about="{$base}/em_3d_fitting_list/{translate(@_3d_fitting_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_3d_fitting_list>
      </PDBov:has_em_3d_fitting_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_3d_reconstructionCategory/PDBxv:em_3d_reconstruction">
      <PDBov:has_em_3d_reconstruction>
      <PDBov:em_3d_reconstruction rdf:about="{$base}/em_3d_reconstruction/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBxv:entry_id,' ^','_')}">
	    <PDBov:referenced_by_em_3d_reconstruction rdf:resource="{$base}/em_3d_reconstruction/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_3d_reconstruction>
      </PDBov:has_em_3d_reconstruction>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_adminCategory/PDBxv:em_admin">
      <PDBov:has_em_admin>
      <PDBov:em_admin rdf:about="{$base}/em_admin/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_admin>
      </PDBov:has_em_admin>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_bufferCategory/PDBxv:em_buffer">
      <PDBov:has_em_buffer>
      <PDBov:em_buffer rdf:about="{$base}/em_buffer/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_buffer>
      </PDBov:has_em_buffer>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_buffer_componentCategory/PDBxv:em_buffer_component">
      <PDBov:has_em_buffer_component>
      <PDBov:em_buffer_component rdf:about="{$base}/em_buffer_component/{translate(@buffer_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_buffer_component>
      </PDBov:has_em_buffer_component>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_crystal_formationCategory/PDBxv:em_crystal_formation">
      <PDBov:has_em_crystal_formation>
      <PDBov:em_crystal_formation rdf:about="{$base}/em_crystal_formation/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_crystal_formation>
      </PDBov:has_em_crystal_formation>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_ctf_correctionCategory/PDBxv:em_ctf_correction">
      <PDBov:has_em_ctf_correction>
      <PDBov:em_ctf_correction rdf:about="{$base}/em_ctf_correction/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_ctf_correction>
      </PDBov:has_em_ctf_correction>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_diffractionCategory/PDBxv:em_diffraction">
      <PDBov:has_em_diffraction>
      <PDBov:em_diffraction rdf:about="{$base}/em_diffraction/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_diffraction>
      </PDBov:has_em_diffraction>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_diffraction_shellCategory/PDBxv:em_diffraction_shell">
      <PDBov:has_em_diffraction_shell>
      <PDBov:em_diffraction_shell rdf:about="{$base}/em_diffraction_shell/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_diffraction_shell>
      </PDBov:has_em_diffraction_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_diffraction_statsCategory/PDBxv:em_diffraction_stats">
      <PDBov:has_em_diffraction_stats>
      <PDBov:em_diffraction_stats rdf:about="{$base}/em_diffraction_stats/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_diffraction_stats>
      </PDBov:has_em_diffraction_stats>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_embeddingCategory/PDBxv:em_embedding">
      <PDBov:has_em_embedding>
      <PDBov:em_embedding rdf:about="{$base}/em_embedding/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_embedding>
      </PDBov:has_em_embedding>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_entity_assemblyCategory/PDBxv:em_entity_assembly">
      <PDBov:has_em_entity_assembly>
      <PDBov:em_entity_assembly rdf:about="{$base}/em_entity_assembly/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_entity_assembly>
      </PDBov:has_em_entity_assembly>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_entity_assembly_molwtCategory/PDBxv:em_entity_assembly_molwt">
      <PDBov:has_em_entity_assembly_molwt>
      <PDBov:em_entity_assembly_molwt rdf:about="{$base}/em_entity_assembly_molwt/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBov:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBov:referenced_by_em_entity_assembly_molwt rdf:resource="{$base}/em_entity_assembly_molwt/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_entity_assembly_molwt>
      </PDBov:has_em_entity_assembly_molwt>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_entity_assembly_naturalsourceCategory/PDBxv:em_entity_assembly_naturalsource">
      <PDBov:has_em_entity_assembly_naturalsource>
      <PDBov:em_entity_assembly_naturalsource rdf:about="{$base}/em_entity_assembly_naturalsource/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBov:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBov:referenced_by_em_entity_assembly_naturalsource rdf:resource="{$base}/em_entity_assembly_naturalsource/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_entity_assembly_naturalsource>
      </PDBov:has_em_entity_assembly_naturalsource>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_entity_assembly_recombinantCategory/PDBxv:em_entity_assembly_recombinant">
      <PDBov:has_em_entity_assembly_recombinant>
      <PDBov:em_entity_assembly_recombinant rdf:about="{$base}/em_entity_assembly_recombinant/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBov:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBov:referenced_by_em_entity_assembly_recombinant rdf:resource="{$base}/em_entity_assembly_recombinant/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_entity_assembly_recombinant>
      </PDBov:has_em_entity_assembly_recombinant>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_entity_assembly_syntheticCategory/PDBxv:em_entity_assembly_synthetic">
      <PDBov:has_em_entity_assembly_synthetic>
      <PDBov:em_entity_assembly_synthetic rdf:about="{$base}/em_entity_assembly_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBov:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBov:referenced_by_em_entity_assembly_synthetic rdf:resource="{$base}/em_entity_assembly_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_entity_assembly_synthetic>
      </PDBov:has_em_entity_assembly_synthetic>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_experimentCategory/PDBxv:em_experiment">
      <PDBov:has_em_experiment>
      <PDBov:em_experiment rdf:about="{$base}/em_experiment/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_em_experiment rdf:resource="{$base}/em_experiment/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_experiment>
      </PDBov:has_em_experiment>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_helical_entityCategory/PDBxv:em_helical_entity">
      <PDBov:has_em_helical_entity>
      <PDBov:em_helical_entity rdf:about="{$base}/em_helical_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_helical_entity>
      </PDBov:has_em_helical_entity>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_image_processingCategory/PDBxv:em_image_processing">
      <PDBov:has_em_image_processing>
      <PDBov:em_image_processing rdf:about="{$base}/em_image_processing/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_image_processing>
      </PDBov:has_em_image_processing>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_image_recordingCategory/PDBxv:em_image_recording">
      <PDBov:has_em_image_recording>
      <PDBov:em_image_recording rdf:about="{$base}/em_image_recording/{translate(@id,' ^','_')},{translate(@imaging_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_image_recording>
      </PDBov:has_em_image_recording>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_image_scansCategory/PDBxv:em_image_scans">
      <PDBov:has_em_image_scans>
      <PDBov:em_image_scans rdf:about="{$base}/em_image_scans/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBxv:entry_id,' ^','_')}">
	    <PDBov:referenced_by_em_image_scans rdf:resource="{$base}/em_image_scans/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_image_scans>
      </PDBov:has_em_image_scans>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_imagingCategory/PDBxv:em_imaging">
      <PDBov:has_em_imaging>
      <PDBov:em_imaging rdf:about="{$base}/em_imaging/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_em_imaging rdf:resource="{$base}/em_imaging/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_imaging>
      </PDBov:has_em_imaging>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_imaging_opticsCategory/PDBxv:em_imaging_optics">
      <PDBov:has_em_imaging_optics>
      <PDBov:em_imaging_optics rdf:about="{$base}/em_imaging_optics/{translate(@id,' ^','_')},{translate(@imaging_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_imaging_optics>
      </PDBov:has_em_imaging_optics>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_particle_selectionCategory/PDBxv:em_particle_selection">
      <PDBov:has_em_particle_selection>
      <PDBov:em_particle_selection rdf:about="{$base}/em_particle_selection/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_particle_selection>
      </PDBov:has_em_particle_selection>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_single_particle_entityCategory/PDBxv:em_single_particle_entity">
      <PDBov:has_em_single_particle_entity>
      <PDBov:em_single_particle_entity rdf:about="{$base}/em_single_particle_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_single_particle_entity>
      </PDBov:has_em_single_particle_entity>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_softwareCategory/PDBxv:em_software">
      <PDBov:has_em_software>
      <PDBov:em_software rdf:about="{$base}/em_software/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_software>
      </PDBov:has_em_software>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_specimenCategory/PDBxv:em_specimen">
      <PDBov:has_em_specimen>
      <PDBov:em_specimen rdf:about="{$base}/em_specimen/{translate(@experiment_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_specimen>
      </PDBov:has_em_specimen>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_stainingCategory/PDBxv:em_staining">
      <PDBov:has_em_staining>
      <PDBov:em_staining rdf:about="{$base}/em_staining/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_staining>
      </PDBov:has_em_staining>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_virus_entityCategory/PDBxv:em_virus_entity">
      <PDBov:has_em_virus_entity>
      <PDBov:em_virus_entity rdf:about="{$base}/em_virus_entity/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBov:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBov:referenced_by_em_virus_entity rdf:resource="{$base}/em_virus_entity/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_virus_entity>
      </PDBov:has_em_virus_entity>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_virus_natural_hostCategory/PDBxv:em_virus_natural_host">
      <PDBov:has_em_virus_natural_host>
      <PDBov:em_virus_natural_host rdf:about="{$base}/em_virus_natural_host/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBov:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBov:referenced_by_em_virus_natural_host rdf:resource="{$base}/em_virus_natural_host/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_virus_natural_host>
      </PDBov:has_em_virus_natural_host>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_virus_shellCategory/PDBxv:em_virus_shell">
      <PDBov:has_em_virus_shell>
      <PDBov:em_virus_shell rdf:about="{$base}/em_virus_shell/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBov:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBov:referenced_by_em_virus_shell rdf:resource="{$base}/em_virus_shell/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_virus_shell>
      </PDBov:has_em_virus_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_virus_syntheticCategory/PDBxv:em_virus_synthetic">
      <PDBov:has_em_virus_synthetic>
      <PDBov:em_virus_synthetic rdf:about="{$base}/em_virus_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBov:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBov:referenced_by_em_virus_synthetic rdf:resource="{$base}/em_virus_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_virus_synthetic>
      </PDBov:has_em_virus_synthetic>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_vitrificationCategory/PDBxv:em_vitrification">
      <PDBov:has_em_vitrification>
      <PDBov:em_vitrification rdf:about="{$base}/em_vitrification/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBxv:entry_id,' ^','_')}">
	    <PDBov:referenced_by_em_vitrification rdf:resource="{$base}/em_vitrification/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_vitrification>
      </PDBov:has_em_vitrification>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:em_volume_selectionCategory/PDBxv:em_volume_selection">
      <PDBov:has_em_volume_selection>
      <PDBov:em_volume_selection rdf:about="{$base}/em_volume_selection/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:em_volume_selection>
      </PDBov:has_em_volume_selection>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:entityCategory/PDBxv:entity">
      <PDBov:has_entity>
      <PDBov:entity rdf:about="{$base}/entity/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:entity>
      </PDBov:has_entity>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:entity_name_comCategory/PDBxv:entity_name_com">
      <PDBov:has_entity_name_com>
      <PDBov:entity_name_com rdf:about="{$base}/entity_name_com/{translate(@entity_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_entity_name_com rdf:resource="{$base}/entity_name_com/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:entity_name_com>
      </PDBov:has_entity_name_com>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:entity_name_sysCategory/PDBxv:entity_name_sys">
      <PDBov:has_entity_name_sys>
      <PDBov:entity_name_sys rdf:about="{$base}/entity_name_sys/{translate(@entity_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_entity_name_sys rdf:resource="{$base}/entity_name_sys/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:entity_name_sys>
      </PDBov:has_entity_name_sys>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:entity_polyCategory/PDBxv:entity_poly">
      <PDBov:has_entity_poly>
      <PDBov:entity_poly rdf:about="{$base}/entity_poly/{translate(@entity_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_entity_poly rdf:resource="{$base}/entity_poly/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:entity_poly>
      </PDBov:has_entity_poly>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:entity_poly_seqCategory/PDBxv:entity_poly_seq">
      <PDBov:has_entity_poly_seq>
      <PDBov:entity_poly_seq rdf:about="{$base}/entity_poly_seq/{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity_poly>
	  <rdf:Description  rdf:about="{$base}/entity_poly/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_entity_poly_seq rdf:resource="{$base}/entity_poly_seq/{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity_poly>
        <!-- entity_polyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:entity_poly_seq>
      </PDBov:has_entity_poly_seq>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:entryCategory/PDBxv:entry">
      <PDBov:has_entry>
      <PDBov:entry rdf:about="{$base}/entry/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:entry>
      </PDBov:has_entry>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:entry_linkCategory/PDBxv:entry_link">
      <PDBov:has_entry_link>
      <PDBov:entry_link rdf:about="{$base}/entry_link/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_entry_link rdf:resource="{$base}/entry_link/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:entry_link>
      </PDBov:has_entry_link>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:exptlCategory/PDBxv:exptl">
      <PDBov:has_exptl>
      <PDBov:exptl rdf:about="{$base}/exptl/{translate(@entry_id,' ^','_')},{translate(@method,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_exptl rdf:resource="{$base}/exptl/{translate(@entry_id,' ^','_')},{translate(@method,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:exptl>
      </PDBov:has_exptl>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:ndb_struct_conf_naCategory/PDBxv:ndb_struct_conf_na">
      <PDBov:has_ndb_struct_conf_na>
      <PDBov:ndb_struct_conf_na rdf:about="{$base}/ndb_struct_conf_na/{translate(@entry_id,' ^','_')},{translate(@feature,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_ndb_struct_conf_na rdf:resource="{$base}/ndb_struct_conf_na/{translate(@entry_id,' ^','_')},{translate(@feature,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:ndb_struct_conf_na>
      </PDBov:has_ndb_struct_conf_na>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:ndb_struct_na_base_pairCategory/PDBxv:ndb_struct_na_base_pair">
      <PDBov:has_ndb_struct_na_base_pair>
      <PDBov:ndb_struct_na_base_pair rdf:about="{$base}/ndb_struct_na_base_pair/{translate(@i_label_asym_id,' ^','_')},{translate(@i_label_comp_id,' ^','_')},{translate(@i_label_seq_id,' ^','_')},{translate(@i_symmetry,' ^','_')},{translate(@j_label_asym_id,' ^','_')},{translate(@j_label_comp_id,' ^','_')},{translate(@j_label_seq_id,' ^','_')},{translate(@j_symmetry,' ^','_')},{translate(@model_number,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:ndb_struct_na_base_pair>
      </PDBov:has_ndb_struct_na_base_pair>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:ndb_struct_na_base_pair_stepCategory/PDBxv:ndb_struct_na_base_pair_step">
      <PDBov:has_ndb_struct_na_base_pair_step>
      <PDBov:ndb_struct_na_base_pair_step rdf:about="{$base}/ndb_struct_na_base_pair_step/{translate(@i_label_asym_id_1,' ^','_')},{translate(@i_label_asym_id_2,' ^','_')},{translate(@i_label_comp_id_1,' ^','_')},{translate(@i_label_comp_id_2,' ^','_')},{translate(@i_label_seq_id_1,' ^','_')},{translate(@i_label_seq_id_2,' ^','_')},{translate(@i_symmetry_1,' ^','_')},{translate(@i_symmetry_2,' ^','_')},{translate(@j_label_asym_id_1,' ^','_')},{translate(@j_label_asym_id_2,' ^','_')},{translate(@j_label_comp_id_1,' ^','_')},{translate(@j_label_comp_id_2,' ^','_')},{translate(@j_label_seq_id_1,' ^','_')},{translate(@j_label_seq_id_2,' ^','_')},{translate(@j_symmetry_1,' ^','_')},{translate(@j_symmetry_2,' ^','_')},{translate(@model_number,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:ndb_struct_na_base_pair_step>
      </PDBov:has_ndb_struct_na_base_pair_step>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_audit_authorCategory/PDBxv:pdbx_audit_author">
      <PDBov:has_pdbx_audit_author>
      <PDBov:pdbx_audit_author rdf:about="{$base}/pdbx_audit_author/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_audit_author>
      </PDBov:has_pdbx_audit_author>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_audit_revision_categoryCategory/PDBxv:pdbx_audit_revision_category">
      <PDBov:has_pdbx_audit_revision_category>
      <PDBov:pdbx_audit_revision_category rdf:about="{$base}/pdbx_audit_revision_category/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <PDBov:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <PDBov:referenced_by_pdbx_audit_revision_category rdf:resource="{$base}/pdbx_audit_revision_category/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_audit_revision_history>
        <!-- pdbx_audit_revision_historyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_audit_revision_category>
      </PDBov:has_pdbx_audit_revision_category>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_audit_revision_detailsCategory/PDBxv:pdbx_audit_revision_details">
      <PDBov:has_pdbx_audit_revision_details>
      <PDBov:pdbx_audit_revision_details rdf:about="{$base}/pdbx_audit_revision_details/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <PDBov:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <PDBov:referenced_by_pdbx_audit_revision_details rdf:resource="{$base}/pdbx_audit_revision_details/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_audit_revision_history>
        <!-- pdbx_audit_revision_historyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_audit_revision_details>
      </PDBov:has_pdbx_audit_revision_details>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_audit_revision_groupCategory/PDBxv:pdbx_audit_revision_group">
      <PDBov:has_pdbx_audit_revision_group>
      <PDBov:pdbx_audit_revision_group rdf:about="{$base}/pdbx_audit_revision_group/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <PDBov:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <PDBov:referenced_by_pdbx_audit_revision_group rdf:resource="{$base}/pdbx_audit_revision_group/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_audit_revision_history>
        <!-- pdbx_audit_revision_historyKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_audit_revision_group>
      </PDBov:has_pdbx_audit_revision_group>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_audit_revision_historyCategory/PDBxv:pdbx_audit_revision_history">
      <PDBov:has_pdbx_audit_revision_history>
      <PDBov:pdbx_audit_revision_history rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_audit_revision_history>
      </PDBov:has_pdbx_audit_revision_history>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_audit_revision_itemCategory/PDBxv:pdbx_audit_revision_item">
      <PDBov:has_pdbx_audit_revision_item>
      <PDBov:pdbx_audit_revision_item rdf:about="{$base}/pdbx_audit_revision_item/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <PDBov:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <PDBov:referenced_by_pdbx_audit_revision_item rdf:resource="{$base}/pdbx_audit_revision_item/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_audit_revision_history>
        <!-- pdbx_audit_revision_historyKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_audit_revision_item>
      </PDBov:has_pdbx_audit_revision_item>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_bond_distance_limitsCategory/PDBxv:pdbx_bond_distance_limits">
      <PDBov:has_pdbx_bond_distance_limits>
      <PDBov:pdbx_bond_distance_limits rdf:about="{$base}/pdbx_bond_distance_limits/{translate(@atom_type_1,' ^','_')},{translate(@atom_type_2,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_bond_distance_limits>
      </PDBov:has_pdbx_bond_distance_limits>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_branch_schemeCategory/PDBxv:pdbx_branch_scheme">
      <PDBov:has_pdbx_branch_scheme>
      <PDBov:pdbx_branch_scheme rdf:about="{$base}/pdbx_branch_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_branch_scheme rdf:resource="{$base}/pdbx_branch_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_branch_scheme>
      </PDBov:has_pdbx_branch_scheme>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_coordinate_modelCategory/PDBxv:pdbx_coordinate_model">
      <PDBov:has_pdbx_coordinate_model>
      <PDBov:pdbx_coordinate_model rdf:about="{$base}/pdbx_coordinate_model/{translate(@asym_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
        <PDBov:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_coordinate_model rdf:resource="{$base}/pdbx_coordinate_model/{translate(@asym_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_asym>
        <!-- struct_asymKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_coordinate_model>
      </PDBov:has_pdbx_coordinate_model>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_database_relatedCategory/PDBxv:pdbx_database_related">
      <PDBov:has_pdbx_database_related>
      <PDBov:pdbx_database_related rdf:about="{$base}/pdbx_database_related/{translate(@content_type,' ^','_')},{translate(@db_id,' ^','_')},{translate(@db_name,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_database_related>
      </PDBov:has_pdbx_database_related>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_database_statusCategory/PDBxv:pdbx_database_status">
      <PDBov:has_pdbx_database_status>
      <PDBov:pdbx_database_status rdf:about="{$base}/pdbx_database_status/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_database_status rdf:resource="{$base}/pdbx_database_status/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_database_status>
      </PDBov:has_pdbx_database_status>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_densityCategory/PDBxv:pdbx_dcc_density">
      <PDBov:has_pdbx_dcc_density>
      <PDBov:pdbx_dcc_density rdf:about="{$base}/pdbx_dcc_density/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_dcc_density rdf:resource="{$base}/pdbx_dcc_density/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_density>
      </PDBov:has_pdbx_dcc_density>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_density_corrCategory/PDBxv:pdbx_dcc_density_corr">
      <PDBov:has_pdbx_dcc_density_corr>
      <PDBov:pdbx_dcc_density_corr rdf:about="{$base}/pdbx_dcc_density_corr/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_density_corr>
      </PDBov:has_pdbx_dcc_density_corr>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_entity_geometryCategory/PDBxv:pdbx_dcc_entity_geometry">
      <PDBov:has_pdbx_dcc_entity_geometry>
      <PDBov:pdbx_dcc_entity_geometry rdf:about="{$base}/pdbx_dcc_entity_geometry/{translate(@PDB_model_num,' ^','_')},{translate(@label_asym_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_entity_geometry>
      </PDBov:has_pdbx_dcc_entity_geometry>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_geometryCategory/PDBxv:pdbx_dcc_geometry">
      <PDBov:has_pdbx_dcc_geometry>
      <PDBov:pdbx_dcc_geometry rdf:about="{$base}/pdbx_dcc_geometry/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_dcc_geometry rdf:resource="{$base}/pdbx_dcc_geometry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_geometry>
      </PDBov:has_pdbx_dcc_geometry>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_mapCategory/PDBxv:pdbx_dcc_map">
      <PDBov:has_pdbx_dcc_map>
      <PDBov:pdbx_dcc_map rdf:about="{$base}/pdbx_dcc_map/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_map>
      </PDBov:has_pdbx_dcc_map>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_map_overallCategory/PDBxv:pdbx_dcc_map_overall">
      <PDBov:has_pdbx_dcc_map_overall>
      <PDBov:pdbx_dcc_map_overall rdf:about="{$base}/pdbx_dcc_map_overall/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_dcc_map_overall rdf:resource="{$base}/pdbx_dcc_map_overall/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_12_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_map_overall>
      </PDBov:has_pdbx_dcc_map_overall>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_mapmanCategory/PDBxv:pdbx_dcc_mapman">
      <PDBov:has_pdbx_dcc_mapman>
      <PDBov:pdbx_dcc_mapman rdf:about="{$base}/pdbx_dcc_mapman/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_dcc_mapman rdf:resource="{$base}/pdbx_dcc_mapman/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_13_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_mapman>
      </PDBov:has_pdbx_dcc_mapman>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_mon_geometryCategory/PDBxv:pdbx_dcc_mon_geometry">
      <PDBov:has_pdbx_dcc_mon_geometry>
      <PDBov:pdbx_dcc_mon_geometry rdf:about="{$base}/pdbx_dcc_mon_geometry/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_mon_geometry>
      </PDBov:has_pdbx_dcc_mon_geometry>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_rscc_mapmanCategory/PDBxv:pdbx_dcc_rscc_mapman">
      <PDBov:has_pdbx_dcc_rscc_mapman>
      <PDBov:pdbx_dcc_rscc_mapman rdf:about="{$base}/pdbx_dcc_rscc_mapman/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_rscc_mapman>
      </PDBov:has_pdbx_dcc_rscc_mapman>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_dcc_rscc_mapman_overallCategory/PDBxv:pdbx_dcc_rscc_mapman_overall">
      <PDBov:has_pdbx_dcc_rscc_mapman_overall>
      <PDBov:pdbx_dcc_rscc_mapman_overall rdf:about="{$base}/pdbx_dcc_rscc_mapman_overall/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_dcc_rscc_mapman_overall rdf:resource="{$base}/pdbx_dcc_rscc_mapman_overall/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_14_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_dcc_rscc_mapman_overall>
      </PDBov:has_pdbx_dcc_rscc_mapman_overall>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_diffrn_reflns_shellCategory/PDBxv:pdbx_diffrn_reflns_shell">
      <PDBov:has_pdbx_diffrn_reflns_shell>
      <PDBov:pdbx_diffrn_reflns_shell rdf:about="{$base}/pdbx_diffrn_reflns_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@diffrn_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBov:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_diffrn_reflns_shell rdf:resource="{$base}/pdbx_diffrn_reflns_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_diffrn_reflns_shell>
      </PDBov:has_pdbx_diffrn_reflns_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_distant_solvent_atomsCategory/PDBxv:pdbx_distant_solvent_atoms">
      <PDBov:has_pdbx_distant_solvent_atoms>
      <PDBov:pdbx_distant_solvent_atoms rdf:about="{$base}/pdbx_distant_solvent_atoms/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_distant_solvent_atoms>
      </PDBov:has_pdbx_distant_solvent_atoms>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_domainCategory/PDBxv:pdbx_domain">
      <PDBov:has_pdbx_domain>
      <PDBov:pdbx_domain rdf:about="{$base}/pdbx_domain/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_domain>
      </PDBov:has_pdbx_domain>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_domain_rangeCategory/PDBxv:pdbx_domain_range">
      <PDBov:has_pdbx_domain_range>
      <PDBov:pdbx_domain_range rdf:about="{$base}/pdbx_domain_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@domain_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@domain_id!=''">
        <PDBov:reference_to_pdbx_domain>
	  <rdf:Description  rdf:about="{$base}/pdbx_domain/{translate(@domain_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_domain_range rdf:resource="{$base}/pdbx_domain_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@domain_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_domain>
        <!-- pdbx_domainKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_domain_range>
      </PDBov:has_pdbx_domain_range>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_atom_inclusionCategory/PDBxv:pdbx_em_atom_inclusion">
      <PDBov:has_pdbx_em_atom_inclusion>
      <PDBov:pdbx_em_atom_inclusion rdf:about="{$base}/pdbx_em_atom_inclusion/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_atom_inclusion>
      </PDBov:has_pdbx_em_atom_inclusion>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_atom_inclusion_markerCategory/PDBxv:pdbx_em_atom_inclusion_marker">
      <PDBov:has_pdbx_em_atom_inclusion_marker>
      <PDBov:pdbx_em_atom_inclusion_marker rdf:about="{$base}/pdbx_em_atom_inclusion_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <PDBov:reference_to_pdbx_em_atom_inclusion>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_atom_inclusion/{translate(@plot_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_atom_inclusion_marker rdf:resource="{$base}/pdbx_em_atom_inclusion_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_atom_inclusion>
        <!-- pdbx_em_atom_inclusionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_atom_inclusion_marker>
      </PDBov:has_pdbx_em_atom_inclusion_marker>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_density_distributionCategory/PDBxv:pdbx_em_density_distribution">
      <PDBov:has_pdbx_em_density_distribution>
      <PDBov:pdbx_em_density_distribution rdf:about="{$base}/pdbx_em_density_distribution/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_density_distribution>
      </PDBov:has_pdbx_em_density_distribution>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_density_distribution_markerCategory/PDBxv:pdbx_em_density_distribution_marker">
      <PDBov:has_pdbx_em_density_distribution_marker>
      <PDBov:pdbx_em_density_distribution_marker rdf:about="{$base}/pdbx_em_density_distribution_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <PDBov:reference_to_pdbx_em_density_distribution>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_density_distribution/{translate(@plot_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_density_distribution_marker rdf:resource="{$base}/pdbx_em_density_distribution_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_density_distribution>
        <!-- pdbx_em_density_distributionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_density_distribution_marker>
      </PDBov:has_pdbx_em_density_distribution_marker>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_fsc_curveCategory/PDBxv:pdbx_em_fsc_curve">
      <PDBov:has_pdbx_em_fsc_curve>
      <PDBov:pdbx_em_fsc_curve rdf:about="{$base}/pdbx_em_fsc_curve/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_fsc_curve>
      </PDBov:has_pdbx_em_fsc_curve>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_fsc_curve_markerCategory/PDBxv:pdbx_em_fsc_curve_marker">
      <PDBov:has_pdbx_em_fsc_curve_marker>
      <PDBov:pdbx_em_fsc_curve_marker rdf:about="{$base}/pdbx_em_fsc_curve_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <PDBov:reference_to_pdbx_em_fsc_curve>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_fsc_curve/{translate(@plot_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_fsc_curve_marker rdf:resource="{$base}/pdbx_em_fsc_curve_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_fsc_curve>
        <!-- pdbx_em_fsc_curveKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_fsc_curve_marker>
      </PDBov:has_pdbx_em_fsc_curve_marker>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_fsc_cutoff_curveCategory/PDBxv:pdbx_em_fsc_cutoff_curve">
      <PDBov:has_pdbx_em_fsc_cutoff_curve>
      <PDBov:pdbx_em_fsc_cutoff_curve rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_fsc_cutoff_curve>
      </PDBov:has_pdbx_em_fsc_cutoff_curve>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_fsc_cutoff_curve_markerCategory/PDBxv:pdbx_em_fsc_cutoff_curve_marker">
      <PDBov:has_pdbx_em_fsc_cutoff_curve_marker>
      <PDBov:pdbx_em_fsc_cutoff_curve_marker rdf:about="{$base}/pdbx_em_fsc_cutoff_curve_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <PDBov:reference_to_pdbx_em_fsc_cutoff_curve>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/{translate(@plot_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_fsc_cutoff_curve_marker rdf:resource="{$base}/pdbx_em_fsc_cutoff_curve_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_fsc_cutoff_curve>
        <!-- pdbx_em_fsc_cutoff_curveKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_fsc_cutoff_curve_marker>
      </PDBov:has_pdbx_em_fsc_cutoff_curve_marker>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_fsc_resolutionCategory/PDBxv:pdbx_em_fsc_resolution">
      <PDBov:has_pdbx_em_fsc_resolution>
      <PDBov:pdbx_em_fsc_resolution rdf:about="{$base}/pdbx_em_fsc_resolution/{translate(@criterion,' ^','_')},{translate(@source,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:fsc_curve_id!=''">
        <PDBov:reference_to_pdbx_em_fsc_curve>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_fsc_curve/{translate(PDBxv:fsc_curve_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_fsc_resolution rdf:resource="{$base}/pdbx_em_fsc_resolution/{translate(@criterion,' ^','_')},{translate(@source,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_fsc_curve>
        <!-- pdbx_em_fsc_curveKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="PDBxv:fsc_cutoff_curve_id!=''">
        <PDBov:reference_to_pdbx_em_fsc_cutoff_curve>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/{translate(PDBxv:fsc_cutoff_curve_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_fsc_resolution rdf:resource="{$base}/pdbx_em_fsc_resolution/{translate(@criterion,' ^','_')},{translate(@source,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_fsc_cutoff_curve>
        <!-- pdbx_em_fsc_cutoff_curveKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_fsc_resolution>
      </PDBov:has_pdbx_em_fsc_resolution>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_rapsCategory/PDBxv:pdbx_em_raps">
      <PDBov:has_pdbx_em_raps>
      <PDBov:pdbx_em_raps rdf:about="{$base}/pdbx_em_raps/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_raps>
      </PDBov:has_pdbx_em_raps>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_raps_markerCategory/PDBxv:pdbx_em_raps_marker">
      <PDBov:has_pdbx_em_raps_marker>
      <PDBov:pdbx_em_raps_marker rdf:about="{$base}/pdbx_em_raps_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <PDBov:reference_to_pdbx_em_raps>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_raps/{translate(@plot_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_raps_marker rdf:resource="{$base}/pdbx_em_raps_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_raps>
        <!-- pdbx_em_rapsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_raps_marker>
      </PDBov:has_pdbx_em_raps_marker>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_raw_rapsCategory/PDBxv:pdbx_em_raw_raps">
      <PDBov:has_pdbx_em_raw_raps>
      <PDBov:pdbx_em_raw_raps rdf:about="{$base}/pdbx_em_raw_raps/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_raw_raps>
      </PDBov:has_pdbx_em_raw_raps>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_raw_raps_markerCategory/PDBxv:pdbx_em_raw_raps_marker">
      <PDBov:has_pdbx_em_raw_raps_marker>
      <PDBov:pdbx_em_raw_raps_marker rdf:about="{$base}/pdbx_em_raw_raps_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <PDBov:reference_to_pdbx_em_raw_raps>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_raw_raps/{translate(@plot_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_raw_raps_marker rdf:resource="{$base}/pdbx_em_raw_raps_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_raw_raps>
        <!-- pdbx_em_raw_rapsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_raw_raps_marker>
      </PDBov:has_pdbx_em_raw_raps_marker>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_validate_map_modelCategory/PDBxv:pdbx_em_validate_map_model">
      <PDBov:has_pdbx_em_validate_map_model>
      <PDBov:pdbx_em_validate_map_model rdf:about="{$base}/pdbx_em_validate_map_model/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_validate_map_model>
      </PDBov:has_pdbx_em_validate_map_model>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_validate_map_model_entityCategory/PDBxv:pdbx_em_validate_map_model_entity">
      <PDBov:has_pdbx_em_validate_map_model_entity>
      <PDBov:pdbx_em_validate_map_model_entity rdf:about="{$base}/pdbx_em_validate_map_model_entity/{translate(@PDB_model_num,' ^','_')},{translate(@label_asym_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_validate_map_model_entity>
      </PDBov:has_pdbx_em_validate_map_model_entity>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_validate_map_model_overallCategory/PDBxv:pdbx_em_validate_map_model_overall">
      <PDBov:has_pdbx_em_validate_map_model_overall>
      <PDBov:pdbx_em_validate_map_model_overall rdf:about="{$base}/pdbx_em_validate_map_model_overall/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_validate_map_model_overall rdf:resource="{$base}/pdbx_em_validate_map_model_overall/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_15_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_validate_map_model_overall>
      </PDBov:has_pdbx_em_validate_map_model_overall>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_volume_estimateCategory/PDBxv:pdbx_em_volume_estimate">
      <PDBov:has_pdbx_em_volume_estimate>
      <PDBov:pdbx_em_volume_estimate rdf:about="{$base}/pdbx_em_volume_estimate/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_volume_estimate>
      </PDBov:has_pdbx_em_volume_estimate>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_em_volume_estimate_markerCategory/PDBxv:pdbx_em_volume_estimate_marker">
      <PDBov:has_pdbx_em_volume_estimate_marker>
      <PDBov:pdbx_em_volume_estimate_marker rdf:about="{$base}/pdbx_em_volume_estimate_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <PDBov:reference_to_pdbx_em_volume_estimate>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_volume_estimate/{translate(@plot_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_em_volume_estimate_marker rdf:resource="{$base}/pdbx_em_volume_estimate_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_em_volume_estimate>
        <!-- pdbx_em_volume_estimateKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_em_volume_estimate_marker>
      </PDBov:has_pdbx_em_volume_estimate_marker>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entity_assemblyCategory/PDBxv:pdbx_entity_assembly">
      <PDBov:has_pdbx_entity_assembly>
      <PDBov:pdbx_entity_assembly rdf:about="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_assembly rdf:resource="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:if test="PDBxv:biol_id!=''">
        <PDBov:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(PDBxv:biol_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_assembly rdf:resource="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entity_assembly>
      </PDBov:has_pdbx_entity_assembly>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entity_branchCategory/PDBxv:pdbx_entity_branch">
      <PDBov:has_pdbx_entity_branch>
      <PDBov:pdbx_entity_branch rdf:about="{$base}/pdbx_entity_branch/{translate(@entity_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_branch rdf:resource="{$base}/pdbx_entity_branch/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entity_branch>
      </PDBov:has_pdbx_entity_branch>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entity_branch_descriptorCategory/PDBxv:pdbx_entity_branch_descriptor">
      <PDBov:has_pdbx_entity_branch_descriptor>
      <PDBov:pdbx_entity_branch_descriptor rdf:about="{$base}/pdbx_entity_branch_descriptor/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBxv:entity_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_branch_descriptor rdf:resource="{$base}/pdbx_entity_branch_descriptor/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entity_branch_descriptor>
      </PDBov:has_pdbx_entity_branch_descriptor>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entity_branch_linkCategory/PDBxv:pdbx_entity_branch_link">
      <PDBov:has_pdbx_entity_branch_link>
      <PDBov:pdbx_entity_branch_link rdf:about="{$base}/pdbx_entity_branch_link/{translate(@link_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entity_branch_link>
      </PDBov:has_pdbx_entity_branch_link>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entity_branch_listCategory/PDBxv:pdbx_entity_branch_list">
      <PDBov:has_pdbx_entity_branch_list>
      <PDBov:pdbx_entity_branch_list rdf:about="{$base}/pdbx_entity_branch_list/{translate(@comp_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@num,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_branch_list rdf:resource="{$base}/pdbx_entity_branch_list/{translate(@comp_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entity_branch_list>
      </PDBov:has_pdbx_entity_branch_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entity_descriptorCategory/PDBxv:pdbx_entity_descriptor">
      <PDBov:has_pdbx_entity_descriptor>
      <PDBov:pdbx_entity_descriptor rdf:about="{$base}/pdbx_entity_descriptor/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBxv:entity_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_descriptor rdf:resource="{$base}/pdbx_entity_descriptor/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entity_descriptor>
      </PDBov:has_pdbx_entity_descriptor>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entity_nonpolyCategory/PDBxv:pdbx_entity_nonpoly">
      <PDBov:has_pdbx_entity_nonpoly>
      <PDBov:pdbx_entity_nonpoly rdf:about="{$base}/pdbx_entity_nonpoly/{translate(@entity_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_nonpoly rdf:resource="{$base}/pdbx_entity_nonpoly/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entity_nonpoly>
      </PDBov:has_pdbx_entity_nonpoly>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entity_poly_comp_link_listCategory/PDBxv:pdbx_entity_poly_comp_link_list">
      <PDBov:has_pdbx_entity_poly_comp_link_list>
      <PDBov:pdbx_entity_poly_comp_link_list rdf:about="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entity_id!='' and PDBxv:comp_id_1!='' and PDBxv:entity_comp_num_1!=''">
        <PDBov:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(PDBxv:entity_id,' ^','_')},{translate(PDBxv:comp_id_1,' ^','_')},{translate(PDBxv:entity_comp_num_1,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_poly_comp_link_list rdf:resource="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="PDBxv:entity_id!='' and PDBxv:comp_id_1!='' and PDBxv:entity_comp_num_1!=''">
        <PDBov:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(PDBxv:entity_id,' ^','_')},{translate(PDBxv:comp_id_1,' ^','_')},{translate(PDBxv:entity_comp_num_1,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entity_poly_comp_link_list rdf:resource="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_2_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entity_poly_comp_link_list>
      </PDBov:has_pdbx_entity_poly_comp_link_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_entry_detailsCategory/PDBxv:pdbx_entry_details">
      <PDBov:has_pdbx_entry_details>
      <PDBov:pdbx_entry_details rdf:about="{$base}/pdbx_entry_details/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_entry_details rdf:resource="{$base}/pdbx_entry_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_16_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_entry_details>
      </PDBov:has_pdbx_entry_details>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_helical_symmetryCategory/PDBxv:pdbx_helical_symmetry">
      <PDBov:has_pdbx_helical_symmetry>
      <PDBov:pdbx_helical_symmetry rdf:about="{$base}/pdbx_helical_symmetry/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_helical_symmetry rdf:resource="{$base}/pdbx_helical_symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_17_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_helical_symmetry>
      </PDBov:has_pdbx_helical_symmetry>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_missing_nmr_star_itemCategory/PDBxv:pdbx_missing_nmr_star_item">
      <PDBov:has_pdbx_missing_nmr_star_item>
      <PDBov:pdbx_missing_nmr_star_item rdf:about="{$base}/pdbx_missing_nmr_star_item/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_missing_nmr_star_item rdf:resource="{$base}/pdbx_missing_nmr_star_item/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_missing_nmr_star_item>
      </PDBov:has_pdbx_missing_nmr_star_item>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_assigned_chem_shift_listCategory/PDBxv:pdbx_nmr_assigned_chem_shift_list">
      <PDBov:has_pdbx_nmr_assigned_chem_shift_list>
      <PDBov:pdbx_nmr_assigned_chem_shift_list rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_assigned_chem_shift_list>
      </PDBov:has_pdbx_nmr_assigned_chem_shift_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_chem_shift_annotationCategory/PDBxv:pdbx_nmr_chem_shift_annotation">
      <PDBov:has_pdbx_nmr_chem_shift_annotation>
      <PDBov:pdbx_nmr_chem_shift_annotation rdf:about="{$base}/pdbx_nmr_chem_shift_annotation/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_chem_shift_annotation rdf:resource="{$base}/pdbx_nmr_chem_shift_annotation/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_chem_shift_annotation>
      </PDBov:has_pdbx_nmr_chem_shift_annotation>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_chem_shift_completenessCategory/PDBxv:pdbx_nmr_chem_shift_completeness">
      <PDBov:has_pdbx_nmr_chem_shift_completeness>
      <PDBov:pdbx_nmr_chem_shift_completeness rdf:about="{$base}/pdbx_nmr_chem_shift_completeness/{translate(@atom_group,' ^','_')},{translate(@atom_type,' ^','_')},{translate(@list_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_chem_shift_completeness rdf:resource="{$base}/pdbx_nmr_chem_shift_completeness/{translate(@atom_group,' ^','_')},{translate(@atom_type,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_chem_shift_completeness>
      </PDBov:has_pdbx_nmr_chem_shift_completeness>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_chem_shift_re_offsetCategory/PDBxv:pdbx_nmr_chem_shift_re_offset">
      <PDBov:has_pdbx_nmr_chem_shift_re_offset>
      <PDBov:pdbx_nmr_chem_shift_re_offset rdf:about="{$base}/pdbx_nmr_chem_shift_re_offset/{translate(@atom_type,' ^','_')},{translate(@list_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_chem_shift_re_offset rdf:resource="{$base}/pdbx_nmr_chem_shift_re_offset/{translate(@atom_type,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_chem_shift_re_offset>
      </PDBov:has_pdbx_nmr_chem_shift_re_offset>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_constraintsCategory/PDBxv:pdbx_nmr_constraints">
      <PDBov:has_pdbx_nmr_constraints>
      <PDBov:pdbx_nmr_constraints rdf:about="{$base}/pdbx_nmr_constraints/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_constraints rdf:resource="{$base}/pdbx_nmr_constraints/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_18_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_constraints>
      </PDBov:has_pdbx_nmr_constraints>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_detailsCategory/PDBxv:pdbx_nmr_details">
      <PDBov:has_pdbx_nmr_details>
      <PDBov:pdbx_nmr_details rdf:about="{$base}/pdbx_nmr_details/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_details rdf:resource="{$base}/pdbx_nmr_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_19_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_details>
      </PDBov:has_pdbx_nmr_details>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_dihedral_angle_violationCategory/PDBxv:pdbx_nmr_dihedral_angle_violation">
      <PDBov:has_pdbx_nmr_dihedral_angle_violation>
      <PDBov:pdbx_nmr_dihedral_angle_violation rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_dihedral_angle_violation>
      </PDBov:has_pdbx_nmr_dihedral_angle_violation>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_dihedral_angle_violation_ensembleCategory/PDBxv:pdbx_nmr_dihedral_angle_violation_ensemble">
      <PDBov:has_pdbx_nmr_dihedral_angle_violation_ensemble>
      <PDBov:pdbx_nmr_dihedral_angle_violation_ensemble rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_ensemble/{translate(@fraction_ensemble_size,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_dihedral_angle_violation_ensemble>
      </PDBov:has_pdbx_nmr_dihedral_angle_violation_ensemble>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_dihedral_angle_violation_modelCategory/PDBxv:pdbx_nmr_dihedral_angle_violation_model">
      <PDBov:has_pdbx_nmr_dihedral_angle_violation_model>
      <PDBov:pdbx_nmr_dihedral_angle_violation_model rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_model/{translate(@PDB_model_num,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_dihedral_angle_violation_model>
      </PDBov:has_pdbx_nmr_dihedral_angle_violation_model>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_dihedral_angle_violation_pluralCategory/PDBxv:pdbx_nmr_dihedral_angle_violation_plural">
      <PDBov:has_pdbx_nmr_dihedral_angle_violation_plural>
      <PDBov:pdbx_nmr_dihedral_angle_violation_plural rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_plural/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_dihedral_angle_violation_plural>
      </PDBov:has_pdbx_nmr_dihedral_angle_violation_plural>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_dihedral_angle_violation_summaryCategory/PDBxv:pdbx_nmr_dihedral_angle_violation_summary">
      <PDBov:has_pdbx_nmr_dihedral_angle_violation_summary>
      <PDBov:pdbx_nmr_dihedral_angle_violation_summary rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_summary/{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_dihedral_angle_violation_summary>
      </PDBov:has_pdbx_nmr_dihedral_angle_violation_summary>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_distance_violationCategory/PDBxv:pdbx_nmr_distance_violation">
      <PDBov:has_pdbx_nmr_distance_violation>
      <PDBov:pdbx_nmr_distance_violation rdf:about="{$base}/pdbx_nmr_distance_violation/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_distance_violation>
      </PDBov:has_pdbx_nmr_distance_violation>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_distance_violation_ensembleCategory/PDBxv:pdbx_nmr_distance_violation_ensemble">
      <PDBov:has_pdbx_nmr_distance_violation_ensemble>
      <PDBov:pdbx_nmr_distance_violation_ensemble rdf:about="{$base}/pdbx_nmr_distance_violation_ensemble/{translate(@fraction_ensemble_size,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_distance_violation_ensemble>
      </PDBov:has_pdbx_nmr_distance_violation_ensemble>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_distance_violation_modelCategory/PDBxv:pdbx_nmr_distance_violation_model">
      <PDBov:has_pdbx_nmr_distance_violation_model>
      <PDBov:pdbx_nmr_distance_violation_model rdf:about="{$base}/pdbx_nmr_distance_violation_model/{translate(@PDB_model_num,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_distance_violation_model>
      </PDBov:has_pdbx_nmr_distance_violation_model>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_distance_violation_pluralCategory/PDBxv:pdbx_nmr_distance_violation_plural">
      <PDBov:has_pdbx_nmr_distance_violation_plural>
      <PDBov:pdbx_nmr_distance_violation_plural rdf:about="{$base}/pdbx_nmr_distance_violation_plural/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_distance_violation_plural>
      </PDBov:has_pdbx_nmr_distance_violation_plural>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_distance_violation_summaryCategory/PDBxv:pdbx_nmr_distance_violation_summary">
      <PDBov:has_pdbx_nmr_distance_violation_summary>
      <PDBov:pdbx_nmr_distance_violation_summary rdf:about="{$base}/pdbx_nmr_distance_violation_summary/{translate(@subtype,' ^','_')},{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_distance_violation_summary>
      </PDBov:has_pdbx_nmr_distance_violation_summary>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_ensembleCategory/PDBxv:pdbx_nmr_ensemble">
      <PDBov:has_pdbx_nmr_ensemble>
      <PDBov:pdbx_nmr_ensemble rdf:about="{$base}/pdbx_nmr_ensemble/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_ensemble rdf:resource="{$base}/pdbx_nmr_ensemble/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_20_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_ensemble>
      </PDBov:has_pdbx_nmr_ensemble>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_ensemble_rmsCategory/PDBxv:pdbx_nmr_ensemble_rms">
      <PDBov:has_pdbx_nmr_ensemble_rms>
      <PDBov:pdbx_nmr_ensemble_rms rdf:about="{$base}/pdbx_nmr_ensemble_rms/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_ensemble_rms rdf:resource="{$base}/pdbx_nmr_ensemble_rms/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_21_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_ensemble_rms>
      </PDBov:has_pdbx_nmr_ensemble_rms>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_exptlCategory/PDBxv:pdbx_nmr_exptl">
      <PDBov:has_pdbx_nmr_exptl>
      <PDBov:pdbx_nmr_exptl rdf:about="{$base}/pdbx_nmr_exptl/{translate(@conditions_id,' ^','_')},{translate(@experiment_id,' ^','_')},{translate(@solution_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_exptl>
      </PDBov:has_pdbx_nmr_exptl>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_exptl_sampleCategory/PDBxv:pdbx_nmr_exptl_sample">
      <PDBov:has_pdbx_nmr_exptl_sample>
      <PDBov:pdbx_nmr_exptl_sample rdf:about="{$base}/pdbx_nmr_exptl_sample/{translate(@component,' ^','_')},{translate(@solution_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_exptl_sample>
      </PDBov:has_pdbx_nmr_exptl_sample>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_exptl_sample_conditionsCategory/PDBxv:pdbx_nmr_exptl_sample_conditions">
      <PDBov:has_pdbx_nmr_exptl_sample_conditions>
      <PDBov:pdbx_nmr_exptl_sample_conditions rdf:about="{$base}/pdbx_nmr_exptl_sample_conditions/{translate(@conditions_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_exptl_sample_conditions>
      </PDBov:has_pdbx_nmr_exptl_sample_conditions>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_force_constantsCategory/PDBxv:pdbx_nmr_force_constants">
      <PDBov:has_pdbx_nmr_force_constants>
      <PDBov:pdbx_nmr_force_constants rdf:about="{$base}/pdbx_nmr_force_constants/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_force_constants rdf:resource="{$base}/pdbx_nmr_force_constants/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_22_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_force_constants>
      </PDBov:has_pdbx_nmr_force_constants>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_refineCategory/PDBxv:pdbx_nmr_refine">
      <PDBov:has_pdbx_nmr_refine>
      <PDBov:pdbx_nmr_refine rdf:about="{$base}/pdbx_nmr_refine/{translate(@entry_id,' ^','_')},{translate(@software_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_refine rdf:resource="{$base}/pdbx_nmr_refine/{translate(@entry_id,' ^','_')},{translate(@software_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_23_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_refine>
      </PDBov:has_pdbx_nmr_refine>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_representativeCategory/PDBxv:pdbx_nmr_representative">
      <PDBov:has_pdbx_nmr_representative>
      <PDBov:pdbx_nmr_representative rdf:about="{$base}/pdbx_nmr_representative/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_representative rdf:resource="{$base}/pdbx_nmr_representative/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_24_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_representative>
      </PDBov:has_pdbx_nmr_representative>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_restraint_listCategory/PDBxv:pdbx_nmr_restraint_list">
      <PDBov:has_pdbx_nmr_restraint_list>
      <PDBov:pdbx_nmr_restraint_list rdf:about="{$base}/pdbx_nmr_restraint_list/{translate(@id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_restraint_list>
      </PDBov:has_pdbx_nmr_restraint_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_restraint_summaryCategory/PDBxv:pdbx_nmr_restraint_summary">
      <PDBov:has_pdbx_nmr_restraint_summary>
      <PDBov:pdbx_nmr_restraint_summary rdf:about="{$base}/pdbx_nmr_restraint_summary/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_restraint_summary rdf:resource="{$base}/pdbx_nmr_restraint_summary/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_25_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_restraint_summary>
      </PDBov:has_pdbx_nmr_restraint_summary>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_restraint_violationCategory/PDBxv:pdbx_nmr_restraint_violation">
      <PDBov:has_pdbx_nmr_restraint_violation>
      <PDBov:pdbx_nmr_restraint_violation rdf:about="{$base}/pdbx_nmr_restraint_violation/{translate(@ordinal,' ^','_')},{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_restraint_violation>
      </PDBov:has_pdbx_nmr_restraint_violation>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_softwareCategory/PDBxv:pdbx_nmr_software">
      <PDBov:has_pdbx_nmr_software>
      <PDBov:pdbx_nmr_software rdf:about="{$base}/pdbx_nmr_software/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_software>
      </PDBov:has_pdbx_nmr_software>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_spectrometerCategory/PDBxv:pdbx_nmr_spectrometer">
      <PDBov:has_pdbx_nmr_spectrometer>
      <PDBov:pdbx_nmr_spectrometer rdf:about="{$base}/pdbx_nmr_spectrometer/{translate(@spectrometer_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_spectrometer>
      </PDBov:has_pdbx_nmr_spectrometer>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_unmapped_chem_shiftCategory/PDBxv:pdbx_nmr_unmapped_chem_shift">
      <PDBov:has_pdbx_nmr_unmapped_chem_shift>
      <PDBov:pdbx_nmr_unmapped_chem_shift rdf:about="{$base}/pdbx_nmr_unmapped_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_unmapped_chem_shift rdf:resource="{$base}/pdbx_nmr_unmapped_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_unmapped_chem_shift>
      </PDBov:has_pdbx_nmr_unmapped_chem_shift>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nmr_unparsed_chem_shiftCategory/PDBxv:pdbx_nmr_unparsed_chem_shift">
      <PDBov:has_pdbx_nmr_unparsed_chem_shift>
      <PDBov:pdbx_nmr_unparsed_chem_shift rdf:about="{$base}/pdbx_nmr_unparsed_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_nmr_unparsed_chem_shift rdf:resource="{$base}/pdbx_nmr_unparsed_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nmr_unparsed_chem_shift>
      </PDBov:has_pdbx_nmr_unparsed_chem_shift>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_nonpoly_schemeCategory/PDBxv:pdbx_nonpoly_scheme">
      <PDBov:has_pdbx_nonpoly_scheme>
      <PDBov:pdbx_nonpoly_scheme rdf:about="{$base}/pdbx_nonpoly_scheme/{translate(@asym_id,' ^','_')},{translate(@ndb_seq_num,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_nonpoly_scheme>
      </PDBov:has_pdbx_nonpoly_scheme>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_percentile_conditionsCategory/PDBxv:pdbx_percentile_conditions">
      <PDBov:has_pdbx_percentile_conditions>
      <PDBov:pdbx_percentile_conditions rdf:about="{$base}/pdbx_percentile_conditions/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_percentile_conditions>
      </PDBov:has_pdbx_percentile_conditions>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_percentile_entity_viewCategory/PDBxv:pdbx_percentile_entity_view">
      <PDBov:has_pdbx_percentile_entity_view>
      <PDBov:pdbx_percentile_entity_view rdf:about="{$base}/pdbx_percentile_entity_view/{translate(@PDB_model_num,' ^','_')},{translate(@conditions_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@conditions_id!=''">
        <PDBov:reference_to_pdbx_percentile_conditions>
	  <rdf:Description  rdf:about="{$base}/pdbx_percentile_conditions/{translate(@conditions_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_percentile_entity_view rdf:resource="{$base}/pdbx_percentile_entity_view/{translate(@PDB_model_num,' ^','_')},{translate(@conditions_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_percentile_conditions>
        <!-- pdbx_percentile_conditionsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_percentile_entity_view>
      </PDBov:has_pdbx_percentile_entity_view>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_percentile_listCategory/PDBxv:pdbx_percentile_list">
      <PDBov:has_pdbx_percentile_list>
      <PDBov:pdbx_percentile_list rdf:about="{$base}/pdbx_percentile_list/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_percentile_list rdf:resource="{$base}/pdbx_percentile_list/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_26_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_percentile_list>
      </PDBov:has_pdbx_percentile_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_percentile_viewCategory/PDBxv:pdbx_percentile_view">
      <PDBov:has_pdbx_percentile_view>
      <PDBov:pdbx_percentile_view rdf:about="{$base}/pdbx_percentile_view/{translate(@conditions_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_percentile_view rdf:resource="{$base}/pdbx_percentile_view/{translate(@conditions_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_27_0 -->
      </xsl:if>
      <xsl:if test="@conditions_id!=''">
        <PDBov:reference_to_pdbx_percentile_conditions>
	  <rdf:Description  rdf:about="{$base}/pdbx_percentile_conditions/{translate(@conditions_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_percentile_view rdf:resource="{$base}/pdbx_percentile_view/{translate(@conditions_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_percentile_conditions>
        <!-- pdbx_percentile_conditionsKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_percentile_view>
      </PDBov:has_pdbx_percentile_view>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_phasing_MAD_setCategory/PDBxv:pdbx_phasing_MAD_set">
      <PDBov:has_pdbx_phasing_MAD_set>
      <PDBov:pdbx_phasing_MAD_set rdf:about="{$base}/pdbx_phasing_MAD_set/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_phasing_MAD_set>
      </PDBov:has_pdbx_phasing_MAD_set>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_phasing_MAD_set_shellCategory/PDBxv:pdbx_phasing_MAD_set_shell">
      <PDBov:has_pdbx_phasing_MAD_set_shell>
      <PDBov:pdbx_phasing_MAD_set_shell rdf:about="{$base}/pdbx_phasing_MAD_set_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_phasing_MAD_set_shell>
      </PDBov:has_pdbx_phasing_MAD_set_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_phasing_MAD_set_siteCategory/PDBxv:pdbx_phasing_MAD_set_site">
      <PDBov:has_pdbx_phasing_MAD_set_site>
      <PDBov:pdbx_phasing_MAD_set_site rdf:about="{$base}/pdbx_phasing_MAD_set_site/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_phasing_MAD_set_site>
      </PDBov:has_pdbx_phasing_MAD_set_site>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_phasing_MAD_shellCategory/PDBxv:pdbx_phasing_MAD_shell">
      <PDBov:has_pdbx_phasing_MAD_shell>
      <PDBov:pdbx_phasing_MAD_shell rdf:about="{$base}/pdbx_phasing_MAD_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_phasing_MAD_shell>
      </PDBov:has_pdbx_phasing_MAD_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_phasing_MRCategory/PDBxv:pdbx_phasing_MR">
      <PDBov:has_pdbx_phasing_MR>
      <PDBov:pdbx_phasing_MR rdf:about="{$base}/pdbx_phasing_MR/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_phasing_MR>
      </PDBov:has_pdbx_phasing_MR>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_phasing_dmCategory/PDBxv:pdbx_phasing_dm">
      <PDBov:has_pdbx_phasing_dm>
      <PDBov:pdbx_phasing_dm rdf:about="{$base}/pdbx_phasing_dm/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_phasing_dm>
      </PDBov:has_pdbx_phasing_dm>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_phasing_dm_shellCategory/PDBxv:pdbx_phasing_dm_shell">
      <PDBov:has_pdbx_phasing_dm_shell>
      <PDBov:pdbx_phasing_dm_shell rdf:about="{$base}/pdbx_phasing_dm_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_phasing_dm_shell>
      </PDBov:has_pdbx_phasing_dm_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_point_symmetryCategory/PDBxv:pdbx_point_symmetry">
      <PDBov:has_pdbx_point_symmetry>
      <PDBov:pdbx_point_symmetry rdf:about="{$base}/pdbx_point_symmetry/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_point_symmetry rdf:resource="{$base}/pdbx_point_symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_28_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_point_symmetry>
      </PDBov:has_pdbx_point_symmetry>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_poly_seq_schemeCategory/PDBxv:pdbx_poly_seq_scheme">
      <PDBov:has_pdbx_poly_seq_scheme>
      <PDBov:pdbx_poly_seq_scheme rdf:about="{$base}/pdbx_poly_seq_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!='' and @mon_id!='' and @seq_id!=''">
        <PDBov:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_poly_seq_scheme rdf:resource="{$base}/pdbx_poly_seq_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@entity_id!='' and @mon_id!='' and @seq_id!=''">
        <PDBov:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_poly_seq_scheme rdf:resource="{$base}/pdbx_poly_seq_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_2_0_1_0 -->
      </xsl:if>
      <xsl:if test="@entity_id!='' and @asym_id!=''">
        <PDBov:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@entity_id,' ^','_')},{translate(@asym_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_poly_seq_scheme rdf:resource="{$base}/pdbx_poly_seq_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_asym>
        <!-- struct_asymKeyref_1_1_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_poly_seq_scheme>
      </PDBov:has_pdbx_poly_seq_scheme>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_re_refinementCategory/PDBxv:pdbx_re_refinement">
      <PDBov:has_pdbx_re_refinement>
      <PDBov:pdbx_re_refinement rdf:about="{$base}/pdbx_re_refinement/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_re_refinement>
      </PDBov:has_pdbx_re_refinement>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_refineCategory/PDBxv:pdbx_refine">
      <PDBov:has_pdbx_refine>
      <PDBov:pdbx_refine rdf:about="{$base}/pdbx_refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_refine rdf:resource="{$base}/pdbx_refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_29_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_refine>
      </PDBov:has_pdbx_refine>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_refine_componentCategory/PDBxv:pdbx_refine_component">
      <PDBov:has_pdbx_refine_component>
      <PDBov:pdbx_refine_component rdf:about="{$base}/pdbx_refine_component/{translate(@label_alt_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@label_comp_id,' ^','_')},{translate(@label_seq_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_refine_component>
      </PDBov:has_pdbx_refine_component>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_refine_tlsCategory/PDBxv:pdbx_refine_tls">
      <PDBov:has_pdbx_refine_tls>
      <PDBov:pdbx_refine_tls rdf:about="{$base}/pdbx_refine_tls/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_refine_tls>
      </PDBov:has_pdbx_refine_tls>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_refine_tls_groupCategory/PDBxv:pdbx_refine_tls_group">
      <PDBov:has_pdbx_refine_tls_group>
      <PDBov:pdbx_refine_tls_group rdf:about="{$base}/pdbx_refine_tls_group/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:refine_tls_id!=''">
        <PDBov:reference_to_pdbx_refine_tls>
	  <rdf:Description  rdf:about="{$base}/pdbx_refine_tls/{translate(PDBxv:refine_tls_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_refine_tls_group rdf:resource="{$base}/pdbx_refine_tls_group/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_refine_tls>
        <!-- pdbx_refine_tlsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_refine_tls_group>
      </PDBov:has_pdbx_refine_tls_group>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_refln_signal_binningCategory/PDBxv:pdbx_refln_signal_binning">
      <PDBov:has_pdbx_refln_signal_binning>
      <PDBov:pdbx_refln_signal_binning rdf:about="{$base}/pdbx_refln_signal_binning/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_refln_signal_binning>
      </PDBov:has_pdbx_refln_signal_binning>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_reflns_twinCategory/PDBxv:pdbx_reflns_twin">
      <PDBov:has_pdbx_reflns_twin>
      <PDBov:pdbx_reflns_twin rdf:about="{$base}/pdbx_reflns_twin/{translate(@crystal_id,' ^','_')},{translate(@diffrn_id,' ^','_')},{translate(@operator,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_reflns_twin>
      </PDBov:has_pdbx_reflns_twin>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_sequence_rangeCategory/PDBxv:pdbx_sequence_range">
      <PDBov:has_pdbx_sequence_range>
      <PDBov:pdbx_sequence_range rdf:about="{$base}/pdbx_sequence_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')},{translate(@seq_range_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_sequence_range>
      </PDBov:has_pdbx_sequence_range>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_soln_scatterCategory/PDBxv:pdbx_soln_scatter">
      <PDBov:has_pdbx_soln_scatter>
      <PDBov:pdbx_soln_scatter rdf:about="{$base}/pdbx_soln_scatter/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_soln_scatter rdf:resource="{$base}/pdbx_soln_scatter/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_30_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_soln_scatter>
      </PDBov:has_pdbx_soln_scatter>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_soln_scatter_modelCategory/PDBxv:pdbx_soln_scatter_model">
      <PDBov:has_pdbx_soln_scatter_model>
      <PDBov:pdbx_soln_scatter_model rdf:about="{$base}/pdbx_soln_scatter_model/{translate(@id,' ^','_')},{translate(@scatter_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_soln_scatter_model>
      </PDBov:has_pdbx_soln_scatter_model>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_assemblyCategory/PDBxv:pdbx_struct_assembly">
      <PDBov:has_pdbx_struct_assembly>
      <PDBov:pdbx_struct_assembly rdf:about="{$base}/pdbx_struct_assembly/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_assembly>
      </PDBov:has_pdbx_struct_assembly>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_assembly_genCategory/PDBxv:pdbx_struct_assembly_gen">
      <PDBov:has_pdbx_struct_assembly_gen>
      <PDBov:pdbx_struct_assembly_gen rdf:about="{$base}/pdbx_struct_assembly_gen/{translate(@assembly_id,' ^','_')},{translate(@asym_id_list,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@assembly_id!=''">
        <PDBov:reference_to_pdbx_struct_assembly>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_assembly/{translate(@assembly_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_struct_assembly_gen rdf:resource="{$base}/pdbx_struct_assembly_gen/{translate(@assembly_id,' ^','_')},{translate(@asym_id_list,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_struct_assembly>
        <!-- pdbx_struct_assemblyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_assembly_gen>
      </PDBov:has_pdbx_struct_assembly_gen>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_assembly_propCategory/PDBxv:pdbx_struct_assembly_prop">
      <PDBov:has_pdbx_struct_assembly_prop>
      <PDBov:pdbx_struct_assembly_prop rdf:about="{$base}/pdbx_struct_assembly_prop/{translate(@biol_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_assembly_prop>
      </PDBov:has_pdbx_struct_assembly_prop>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_asym_genCategory/PDBxv:pdbx_struct_asym_gen">
      <PDBov:has_pdbx_struct_asym_gen>
      <PDBov:pdbx_struct_asym_gen rdf:about="{$base}/pdbx_struct_asym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_inst_id!=''">
        <PDBov:reference_to_pdbx_struct_entity_inst>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@entity_inst_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_struct_asym_gen rdf:resource="{$base}/pdbx_struct_asym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_struct_entity_inst>
        <!-- pdbx_struct_entity_instKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_asym_gen>
      </PDBov:has_pdbx_struct_asym_gen>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_chem_comp_diagnosticsCategory/PDBxv:pdbx_struct_chem_comp_diagnostics">
      <PDBov:has_pdbx_struct_chem_comp_diagnostics>
      <PDBov:pdbx_struct_chem_comp_diagnostics rdf:about="{$base}/pdbx_struct_chem_comp_diagnostics/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_chem_comp_diagnostics>
      </PDBov:has_pdbx_struct_chem_comp_diagnostics>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_conn_angleCategory/PDBxv:pdbx_struct_conn_angle">
      <PDBov:has_pdbx_struct_conn_angle>
      <PDBov:pdbx_struct_conn_angle rdf:about="{$base}/pdbx_struct_conn_angle/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_conn_angle>
      </PDBov:has_pdbx_struct_conn_angle>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_entity_instCategory/PDBxv:pdbx_struct_entity_inst">
      <PDBov:has_pdbx_struct_entity_inst>
      <PDBov:pdbx_struct_entity_inst rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_entity_inst>
      </PDBov:has_pdbx_struct_entity_inst>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_group_component_rangeCategory/PDBxv:pdbx_struct_group_component_range">
      <PDBov:has_pdbx_struct_group_component_range>
      <PDBov:pdbx_struct_group_component_range rdf:about="{$base}/pdbx_struct_group_component_range/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:struct_group_id!=''">
        <PDBov:reference_to_pdbx_struct_group_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_group_list/{translate(PDBxv:struct_group_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_struct_group_component_range rdf:resource="{$base}/pdbx_struct_group_component_range/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_struct_group_list>
        <!-- pdbx_struct_group_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_group_component_range>
      </PDBov:has_pdbx_struct_group_component_range>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_group_componentsCategory/PDBxv:pdbx_struct_group_components">
      <PDBov:has_pdbx_struct_group_components>
      <PDBov:pdbx_struct_group_components rdf:about="{$base}/pdbx_struct_group_components/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:struct_group_id!=''">
        <PDBov:reference_to_pdbx_struct_group_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_group_list/{translate(PDBxv:struct_group_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_struct_group_components rdf:resource="{$base}/pdbx_struct_group_components/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_struct_group_list>
        <!-- pdbx_struct_group_listKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_group_components>
      </PDBov:has_pdbx_struct_group_components>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_group_listCategory/PDBxv:pdbx_struct_group_list">
      <PDBov:has_pdbx_struct_group_list>
      <PDBov:pdbx_struct_group_list rdf:about="{$base}/pdbx_struct_group_list/{translate(@struct_group_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_group_list>
      </PDBov:has_pdbx_struct_group_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_infoCategory/PDBxv:pdbx_struct_info">
      <PDBov:has_pdbx_struct_info>
      <PDBov:pdbx_struct_info rdf:about="{$base}/pdbx_struct_info/{translate(@type,' ^','_')},{translate(@value,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_info>
      </PDBov:has_pdbx_struct_info>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_legacy_oper_listCategory/PDBxv:pdbx_struct_legacy_oper_list">
      <PDBov:has_pdbx_struct_legacy_oper_list>
      <PDBov:pdbx_struct_legacy_oper_list rdf:about="{$base}/pdbx_struct_legacy_oper_list/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_legacy_oper_list>
      </PDBov:has_pdbx_struct_legacy_oper_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_mod_residueCategory/PDBxv:pdbx_struct_mod_residue">
      <PDBov:has_pdbx_struct_mod_residue>
      <PDBov:pdbx_struct_mod_residue rdf:about="{$base}/pdbx_struct_mod_residue/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_mod_residue>
      </PDBov:has_pdbx_struct_mod_residue>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_msym_genCategory/PDBxv:pdbx_struct_msym_gen">
      <PDBov:has_pdbx_struct_msym_gen>
      <PDBov:pdbx_struct_msym_gen rdf:about="{$base}/pdbx_struct_msym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@msym_id,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_inst_id!=''">
        <PDBov:reference_to_pdbx_struct_entity_inst>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@entity_inst_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_struct_msym_gen rdf:resource="{$base}/pdbx_struct_msym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@msym_id,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_struct_entity_inst>
        <!-- pdbx_struct_entity_instKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_msym_gen>
      </PDBov:has_pdbx_struct_msym_gen>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_nmr_ens_clustCategory/PDBxv:pdbx_struct_nmr_ens_clust">
      <PDBov:has_pdbx_struct_nmr_ens_clust>
      <PDBov:pdbx_struct_nmr_ens_clust rdf:about="{$base}/pdbx_struct_nmr_ens_clust/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_struct_nmr_ens_clust rdf:resource="{$base}/pdbx_struct_nmr_ens_clust/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_31_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_nmr_ens_clust>
      </PDBov:has_pdbx_struct_nmr_ens_clust>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_nmr_ens_clust_genCategory/PDBxv:pdbx_struct_nmr_ens_clust_gen">
      <PDBov:has_pdbx_struct_nmr_ens_clust_gen>
      <PDBov:pdbx_struct_nmr_ens_clust_gen rdf:about="{$base}/pdbx_struct_nmr_ens_clust_gen/{translate(@PDB_model_num,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_nmr_ens_clust_gen>
      </PDBov:has_pdbx_struct_nmr_ens_clust_gen>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_nmr_ens_domCategory/PDBxv:pdbx_struct_nmr_ens_dom">
      <PDBov:has_pdbx_struct_nmr_ens_dom>
      <PDBov:pdbx_struct_nmr_ens_dom rdf:about="{$base}/pdbx_struct_nmr_ens_dom/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_nmr_ens_dom>
      </PDBov:has_pdbx_struct_nmr_ens_dom>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_nmr_ens_dom_limCategory/PDBxv:pdbx_struct_nmr_ens_dom_lim">
      <PDBov:has_pdbx_struct_nmr_ens_dom_lim>
      <PDBov:pdbx_struct_nmr_ens_dom_lim rdf:about="{$base}/pdbx_struct_nmr_ens_dom_lim/{translate(@component_id,' ^','_')},{translate(@dom_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@dom_id!=''">
        <PDBov:reference_to_pdbx_struct_nmr_ens_dom>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_nmr_ens_dom/{translate(@dom_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_struct_nmr_ens_dom_lim rdf:resource="{$base}/pdbx_struct_nmr_ens_dom_lim/{translate(@component_id,' ^','_')},{translate(@dom_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_struct_nmr_ens_dom>
        <!-- pdbx_struct_nmr_ens_domKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_nmr_ens_dom_lim>
      </PDBov:has_pdbx_struct_nmr_ens_dom_lim>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_oper_listCategory/PDBxv:pdbx_struct_oper_list">
      <PDBov:has_pdbx_struct_oper_list>
      <PDBov:pdbx_struct_oper_list rdf:about="{$base}/pdbx_struct_oper_list/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_oper_list>
      </PDBov:has_pdbx_struct_oper_list>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_ref_seq_deletionCategory/PDBxv:pdbx_struct_ref_seq_deletion">
      <PDBov:has_pdbx_struct_ref_seq_deletion>
      <PDBov:pdbx_struct_ref_seq_deletion rdf:about="{$base}/pdbx_struct_ref_seq_deletion/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_ref_seq_deletion>
      </PDBov:has_pdbx_struct_ref_seq_deletion>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_ref_seq_insertionCategory/PDBxv:pdbx_struct_ref_seq_insertion">
      <PDBov:has_pdbx_struct_ref_seq_insertion>
      <PDBov:pdbx_struct_ref_seq_insertion rdf:about="{$base}/pdbx_struct_ref_seq_insertion/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_ref_seq_insertion>
      </PDBov:has_pdbx_struct_ref_seq_insertion>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_sheet_hbondCategory/PDBxv:pdbx_struct_sheet_hbond">
      <PDBov:has_pdbx_struct_sheet_hbond>
      <PDBov:pdbx_struct_sheet_hbond rdf:about="{$base}/pdbx_struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBov:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_struct_sheet_hbond rdf:resource="{$base}/pdbx_struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_sheet_hbond>
      </PDBov:has_pdbx_struct_sheet_hbond>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_struct_special_symmetryCategory/PDBxv:pdbx_struct_special_symmetry">
      <PDBov:has_pdbx_struct_special_symmetry>
      <PDBov:pdbx_struct_special_symmetry rdf:about="{$base}/pdbx_struct_special_symmetry/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_struct_special_symmetry>
      </PDBov:has_pdbx_struct_special_symmetry>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_unobs_or_zero_occ_atomsCategory/PDBxv:pdbx_unobs_or_zero_occ_atoms">
      <PDBov:has_pdbx_unobs_or_zero_occ_atoms>
      <PDBov:pdbx_unobs_or_zero_occ_atoms rdf:about="{$base}/pdbx_unobs_or_zero_occ_atoms/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_unobs_or_zero_occ_atoms>
      </PDBov:has_pdbx_unobs_or_zero_occ_atoms>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_unobs_or_zero_occ_residuesCategory/PDBxv:pdbx_unobs_or_zero_occ_residues">
      <PDBov:has_pdbx_unobs_or_zero_occ_residues>
      <PDBov:pdbx_unobs_or_zero_occ_residues rdf:about="{$base}/pdbx_unobs_or_zero_occ_residues/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_unobs_or_zero_occ_residues>
      </PDBov:has_pdbx_unobs_or_zero_occ_residues>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_chiralCategory/PDBxv:pdbx_validate_chiral">
      <PDBov:has_pdbx_validate_chiral>
      <PDBov:pdbx_validate_chiral rdf:about="{$base}/pdbx_validate_chiral/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_chiral>
      </PDBov:has_pdbx_validate_chiral>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_close_contactCategory/PDBxv:pdbx_validate_close_contact">
      <PDBov:has_pdbx_validate_close_contact>
      <PDBov:pdbx_validate_close_contact rdf:about="{$base}/pdbx_validate_close_contact/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_close_contact>
      </PDBov:has_pdbx_validate_close_contact>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_main_chain_planeCategory/PDBxv:pdbx_validate_main_chain_plane">
      <PDBov:has_pdbx_validate_main_chain_plane>
      <PDBov:pdbx_validate_main_chain_plane rdf:about="{$base}/pdbx_validate_main_chain_plane/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_main_chain_plane>
      </PDBov:has_pdbx_validate_main_chain_plane>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_nmr_chem_shiftCategory/PDBxv:pdbx_validate_nmr_chem_shift">
      <PDBov:has_pdbx_validate_nmr_chem_shift>
      <PDBov:pdbx_validate_nmr_chem_shift rdf:about="{$base}/pdbx_validate_nmr_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_validate_nmr_chem_shift rdf:resource="{$base}/pdbx_validate_nmr_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_nmr_chem_shift>
      </PDBov:has_pdbx_validate_nmr_chem_shift>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_peptide_omegaCategory/PDBxv:pdbx_validate_peptide_omega">
      <PDBov:has_pdbx_validate_peptide_omega>
      <PDBov:pdbx_validate_peptide_omega rdf:about="{$base}/pdbx_validate_peptide_omega/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_peptide_omega>
      </PDBov:has_pdbx_validate_peptide_omega>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_planesCategory/PDBxv:pdbx_validate_planes">
      <PDBov:has_pdbx_validate_planes>
      <PDBov:pdbx_validate_planes rdf:about="{$base}/pdbx_validate_planes/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_planes>
      </PDBov:has_pdbx_validate_planes>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_planes_atomCategory/PDBxv:pdbx_validate_planes_atom">
      <PDBov:has_pdbx_validate_planes_atom>
      <PDBov:pdbx_validate_planes_atom rdf:about="{$base}/pdbx_validate_planes_atom/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:plane_id!=''">
        <PDBov:reference_to_pdbx_validate_planes>
	  <rdf:Description  rdf:about="{$base}/pdbx_validate_planes/{translate(PDBxv:plane_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_validate_planes_atom rdf:resource="{$base}/pdbx_validate_planes_atom/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_validate_planes>
        <!-- pdbx_validate_planesKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_planes_atom>
      </PDBov:has_pdbx_validate_planes_atom>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_polymer_linkageCategory/PDBxv:pdbx_validate_polymer_linkage">
      <PDBov:has_pdbx_validate_polymer_linkage>
      <PDBov:pdbx_validate_polymer_linkage rdf:about="{$base}/pdbx_validate_polymer_linkage/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_polymer_linkage>
      </PDBov:has_pdbx_validate_polymer_linkage>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_angleCategory/PDBxv:pdbx_validate_rmsd_angle">
      <PDBov:has_pdbx_validate_rmsd_angle>
      <PDBov:pdbx_validate_rmsd_angle rdf:about="{$base}/pdbx_validate_rmsd_angle/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_rmsd_angle>
      </PDBov:has_pdbx_validate_rmsd_angle>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_bondCategory/PDBxv:pdbx_validate_rmsd_bond">
      <PDBov:has_pdbx_validate_rmsd_bond>
      <PDBov:pdbx_validate_rmsd_bond rdf:about="{$base}/pdbx_validate_rmsd_bond/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_rmsd_bond>
      </PDBov:has_pdbx_validate_rmsd_bond>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_ringCategory/PDBxv:pdbx_validate_rmsd_ring">
      <PDBov:has_pdbx_validate_rmsd_ring>
      <PDBov:pdbx_validate_rmsd_ring rdf:about="{$base}/pdbx_validate_rmsd_ring/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_rmsd_ring>
      </PDBov:has_pdbx_validate_rmsd_ring>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_rings_atomCategory/PDBxv:pdbx_validate_rmsd_rings_atom">
      <PDBov:has_pdbx_validate_rmsd_rings_atom>
      <PDBov:pdbx_validate_rmsd_rings_atom rdf:about="{$base}/pdbx_validate_rmsd_rings_atom/{translate(@id,' ^','_')},{translate(@ring_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@ring_id!=''">
        <PDBov:reference_to_pdbx_validate_rmsd_ring>
	  <rdf:Description  rdf:about="{$base}/pdbx_validate_rmsd_ring/{translate(@ring_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_validate_rmsd_rings_atom rdf:resource="{$base}/pdbx_validate_rmsd_rings_atom/{translate(@id,' ^','_')},{translate(@ring_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_validate_rmsd_ring>
        <!-- pdbx_validate_rmsd_ringKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_rmsd_rings_atom>
      </PDBov:has_pdbx_validate_rmsd_rings_atom>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_torsionCategory/PDBxv:pdbx_validate_rmsd_torsion">
      <PDBov:has_pdbx_validate_rmsd_torsion>
      <PDBov:pdbx_validate_rmsd_torsion rdf:about="{$base}/pdbx_validate_rmsd_torsion/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_rmsd_torsion>
      </PDBov:has_pdbx_validate_rmsd_torsion>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_rmsd_torsions_atomCategory/PDBxv:pdbx_validate_rmsd_torsions_atom">
      <PDBov:has_pdbx_validate_rmsd_torsions_atom>
      <PDBov:pdbx_validate_rmsd_torsions_atom rdf:about="{$base}/pdbx_validate_rmsd_torsions_atom/{translate(@id,' ^','_')},{translate(@torsion_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@torsion_id!=''">
        <PDBov:reference_to_pdbx_validate_rmsd_torsion>
	  <rdf:Description  rdf:about="{$base}/pdbx_validate_rmsd_torsion/{translate(@torsion_id,' ^','_')}">
	    <PDBov:referenced_by_pdbx_validate_rmsd_torsions_atom rdf:resource="{$base}/pdbx_validate_rmsd_torsions_atom/{translate(@id,' ^','_')},{translate(@torsion_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_pdbx_validate_rmsd_torsion>
        <!-- pdbx_validate_rmsd_torsionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_rmsd_torsions_atom>
      </PDBov:has_pdbx_validate_rmsd_torsions_atom>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_symm_contactCategory/PDBxv:pdbx_validate_symm_contact">
      <PDBov:has_pdbx_validate_symm_contact>
      <PDBov:pdbx_validate_symm_contact rdf:about="{$base}/pdbx_validate_symm_contact/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_symm_contact>
      </PDBov:has_pdbx_validate_symm_contact>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validate_torsionCategory/PDBxv:pdbx_validate_torsion">
      <PDBov:has_pdbx_validate_torsion>
      <PDBov:pdbx_validate_torsion rdf:about="{$base}/pdbx_validate_torsion/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validate_torsion>
      </PDBov:has_pdbx_validate_torsion>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:pdbx_validation_softwareCategory/PDBxv:pdbx_validation_software">
      <PDBov:has_pdbx_validation_software>
      <PDBov:pdbx_validation_software rdf:about="{$base}/pdbx_validation_software/{translate(@ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:pdbx_validation_software>
      </PDBov:has_pdbx_validation_software>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasingCategory/PDBxv:phasing">
      <PDBov:has_phasing>
      <PDBov:phasing rdf:about="{$base}/phasing/{translate(@method,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing>
      </PDBov:has_phasing>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MADCategory/PDBxv:phasing_MAD">
      <PDBov:has_phasing_MAD>
      <PDBov:phasing_MAD rdf:about="{$base}/phasing_MAD/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MAD rdf:resource="{$base}/phasing_MAD/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_32_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MAD>
      </PDBov:has_phasing_MAD>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MAD_clustCategory/PDBxv:phasing_MAD_clust">
      <PDBov:has_phasing_MAD_clust>
      <PDBov:phasing_MAD_clust rdf:about="{$base}/phasing_MAD_clust/{translate(@expt_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <PDBov:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MAD_clust rdf:resource="{$base}/phasing_MAD_clust/{translate(@expt_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_MAD_expt>
        <!-- phasing_MAD_exptKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MAD_clust>
      </PDBov:has_phasing_MAD_clust>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MAD_exptCategory/PDBxv:phasing_MAD_expt">
      <PDBov:has_phasing_MAD_expt>
      <PDBov:phasing_MAD_expt rdf:about="{$base}/phasing_MAD_expt/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MAD_expt>
      </PDBov:has_phasing_MAD_expt>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MAD_ratioCategory/PDBxv:phasing_MAD_ratio">
      <PDBov:has_phasing_MAD_ratio>
      <PDBov:phasing_MAD_ratio rdf:about="{$base}/phasing_MAD_ratio/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@wavelength_1,' ^','_')},{translate(@wavelength_2,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <PDBov:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MAD_ratio rdf:resource="{$base}/phasing_MAD_ratio/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@wavelength_1,' ^','_')},{translate(@wavelength_2,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_MAD_expt>
        <!-- phasing_MAD_exptKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MAD_ratio>
      </PDBov:has_phasing_MAD_ratio>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MAD_setCategory/PDBxv:phasing_MAD_set">
      <PDBov:has_phasing_MAD_set>
      <PDBov:phasing_MAD_set rdf:about="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <PDBov:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MAD_set rdf:resource="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_MAD_expt>
        <!-- phasing_MAD_exptKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:if test="@set_id!=''">
        <PDBov:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MAD_set rdf:resource="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_set>
        <!-- phasing_setKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MAD_set>
      </PDBov:has_phasing_MAD_set>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MIRCategory/PDBxv:phasing_MIR">
      <PDBov:has_phasing_MIR>
      <PDBov:phasing_MIR rdf:about="{$base}/phasing_MIR/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MIR rdf:resource="{$base}/phasing_MIR/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_33_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MIR>
      </PDBov:has_phasing_MIR>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MIR_derCategory/PDBxv:phasing_MIR_der">
      <PDBov:has_phasing_MIR_der>
      <PDBov:phasing_MIR_der rdf:about="{$base}/phasing_MIR_der/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:der_set_id!=''">
        <PDBov:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(PDBxv:der_set_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MIR_der rdf:resource="{$base}/phasing_MIR_der/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_set>
        <!-- phasing_setKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MIR_der>
      </PDBov:has_phasing_MIR_der>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MIR_der_reflnCategory/PDBxv:phasing_MIR_der_refln">
      <PDBov:has_phasing_MIR_der_refln>
      <PDBov:phasing_MIR_der_refln rdf:about="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <PDBov:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MIR_der_refln rdf:resource="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_MIR_der>
        <!-- phasing_MIR_derKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@set_id!=''">
        <PDBov:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MIR_der_refln rdf:resource="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_set>
        <!-- phasing_setKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MIR_der_refln>
      </PDBov:has_phasing_MIR_der_refln>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MIR_der_shellCategory/PDBxv:phasing_MIR_der_shell">
      <PDBov:has_phasing_MIR_der_shell>
      <PDBov:phasing_MIR_der_shell rdf:about="{$base}/phasing_MIR_der_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@der_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <PDBov:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MIR_der_shell rdf:resource="{$base}/phasing_MIR_der_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@der_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_MIR_der>
        <!-- phasing_MIR_derKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MIR_der_shell>
      </PDBov:has_phasing_MIR_der_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MIR_der_siteCategory/PDBxv:phasing_MIR_der_site">
      <PDBov:has_phasing_MIR_der_site>
      <PDBov:phasing_MIR_der_site rdf:about="{$base}/phasing_MIR_der_site/{translate(@der_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <PDBov:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_MIR_der_site rdf:resource="{$base}/phasing_MIR_der_site/{translate(@der_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_MIR_der>
        <!-- phasing_MIR_derKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MIR_der_site>
      </PDBov:has_phasing_MIR_der_site>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_MIR_shellCategory/PDBxv:phasing_MIR_shell">
      <PDBov:has_phasing_MIR_shell>
      <PDBov:phasing_MIR_shell rdf:about="{$base}/phasing_MIR_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_MIR_shell>
      </PDBov:has_phasing_MIR_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_averagingCategory/PDBxv:phasing_averaging">
      <PDBov:has_phasing_averaging>
      <PDBov:phasing_averaging rdf:about="{$base}/phasing_averaging/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_averaging rdf:resource="{$base}/phasing_averaging/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_34_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_averaging>
      </PDBov:has_phasing_averaging>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_isomorphousCategory/PDBxv:phasing_isomorphous">
      <PDBov:has_phasing_isomorphous>
      <PDBov:phasing_isomorphous rdf:about="{$base}/phasing_isomorphous/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_isomorphous rdf:resource="{$base}/phasing_isomorphous/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_35_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_isomorphous>
      </PDBov:has_phasing_isomorphous>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_setCategory/PDBxv:phasing_set">
      <PDBov:has_phasing_set>
      <PDBov:phasing_set rdf:about="{$base}/phasing_set/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_set>
      </PDBov:has_phasing_set>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:phasing_set_reflnCategory/PDBxv:phasing_set_refln">
      <PDBov:has_phasing_set_refln>
      <PDBov:phasing_set_refln rdf:about="{$base}/phasing_set_refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@set_id!=''">
        <PDBov:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <PDBov:referenced_by_phasing_set_refln rdf:resource="{$base}/phasing_set_refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_phasing_set>
        <!-- phasing_setKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:phasing_set_refln>
      </PDBov:has_phasing_set_refln>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refineCategory/PDBxv:refine">
      <PDBov:has_refine>
      <PDBov:refine rdf:about="{$base}/refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_refine rdf:resource="{$base}/refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_36_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine>
      </PDBov:has_refine>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_B_isoCategory/PDBxv:refine_B_iso">
      <PDBov:has_refine_B_iso>
      <PDBov:refine_B_iso rdf:about="{$base}/refine_B_iso/{translate(@class,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_B_iso>
      </PDBov:has_refine_B_iso>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_analyzeCategory/PDBxv:refine_analyze">
      <PDBov:has_refine_analyze>
      <PDBov:refine_analyze rdf:about="{$base}/refine_analyze/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_refine_analyze rdf:resource="{$base}/refine_analyze/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_37_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_analyze>
      </PDBov:has_refine_analyze>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_funct_minimizedCategory/PDBxv:refine_funct_minimized">
      <PDBov:has_refine_funct_minimized>
      <PDBov:refine_funct_minimized rdf:about="{$base}/refine_funct_minimized/{translate(@pdbx_refine_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_funct_minimized>
      </PDBov:has_refine_funct_minimized>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_histCategory/PDBxv:refine_hist">
      <PDBov:has_refine_hist>
      <PDBov:refine_hist rdf:about="{$base}/refine_hist/{translate(@cycle_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_hist>
      </PDBov:has_refine_hist>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_ls_classCategory/PDBxv:refine_ls_class">
      <PDBov:has_refine_ls_class>
      <PDBov:refine_ls_class rdf:about="{$base}/refine_ls_class/{translate(@code,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_ls_class>
      </PDBov:has_refine_ls_class>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_ls_restrCategory/PDBxv:refine_ls_restr">
      <PDBov:has_refine_ls_restr>
      <PDBov:refine_ls_restr rdf:about="{$base}/refine_ls_restr/{translate(@pdbx_refine_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_ls_restr>
      </PDBov:has_refine_ls_restr>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_ls_restr_ncsCategory/PDBxv:refine_ls_restr_ncs">
      <PDBov:has_refine_ls_restr_ncs>
      <PDBov:refine_ls_restr_ncs rdf:about="{$base}/refine_ls_restr_ncs/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_ls_restr_ncs>
      </PDBov:has_refine_ls_restr_ncs>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_ls_restr_typeCategory/PDBxv:refine_ls_restr_type">
      <PDBov:has_refine_ls_restr_type>
      <PDBov:refine_ls_restr_type rdf:about="{$base}/refine_ls_restr_type/{translate(@type,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_ls_restr_type>
      </PDBov:has_refine_ls_restr_type>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_ls_shellCategory/PDBxv:refine_ls_shell">
      <PDBov:has_refine_ls_shell>
      <PDBov:refine_ls_shell rdf:about="{$base}/refine_ls_shell/{translate(@d_res_high,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_ls_shell>
      </PDBov:has_refine_ls_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refine_occupancyCategory/PDBxv:refine_occupancy">
      <PDBov:has_refine_occupancy>
      <PDBov:refine_occupancy rdf:about="{$base}/refine_occupancy/{translate(@class,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refine_occupancy>
      </PDBov:has_refine_occupancy>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:reflnCategory/PDBxv:refln">
      <PDBov:has_refln>
      <PDBov:refln rdf:about="{$base}/refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refln>
      </PDBov:has_refln>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:refln_sys_absCategory/PDBxv:refln_sys_abs">
      <PDBov:has_refln_sys_abs>
      <PDBov:refln_sys_abs rdf:about="{$base}/refln_sys_abs/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:refln_sys_abs>
      </PDBov:has_refln_sys_abs>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:reflnsCategory/PDBxv:reflns">
      <PDBov:has_reflns>
      <PDBov:reflns rdf:about="{$base}/reflns/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBxv:entry_id,' ^','_')}">
	    <PDBov:referenced_by_reflns rdf:resource="{$base}/reflns/{translate(@pdbx_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_38_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:reflns>
      </PDBov:has_reflns>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:reflns_classCategory/PDBxv:reflns_class">
      <PDBov:has_reflns_class>
      <PDBov:reflns_class rdf:about="{$base}/reflns_class/{translate(@code,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:reflns_class>
      </PDBov:has_reflns_class>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:reflns_scaleCategory/PDBxv:reflns_scale">
      <PDBov:has_reflns_scale>
      <PDBov:reflns_scale rdf:about="{$base}/reflns_scale/{translate(@group_code,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:reflns_scale>
      </PDBov:has_reflns_scale>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:reflns_shellCategory/PDBxv:reflns_shell">
      <PDBov:has_reflns_shell>
      <PDBov:reflns_shell rdf:about="{$base}/reflns_shell/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:reflns_shell>
      </PDBov:has_reflns_shell>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:space_groupCategory/PDBxv:space_group">
      <PDBov:has_space_group>
      <PDBov:space_group rdf:about="{$base}/space_group/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:space_group>
      </PDBov:has_space_group>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:space_group_symopCategory/PDBxv:space_group_symop">
      <PDBov:has_space_group_symop>
      <PDBov:space_group_symop rdf:about="{$base}/space_group_symop/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:space_group_symop>
      </PDBov:has_space_group_symop>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:structCategory/PDBxv:struct">
      <PDBov:has_struct>
      <PDBov:struct rdf:about="{$base}/struct/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_struct rdf:resource="{$base}/struct/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_39_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct>
      </PDBov:has_struct>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_asymCategory/PDBxv:struct_asym">
      <PDBov:has_struct_asym>
      <PDBov:struct_asym rdf:about="{$base}/struct_asym/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entity_id!='' and @id!=''">
        <owl:sameAs>
          <PDBov:struct_asym rdf:about="{$base}/struct_asym/{translate(PDBxv:entity_id,' ^','_')},{translate(@id,' ^','_')}">
            <rdfs:label>struct_asymUnique_1</rdfs:label>
          </PDBov:struct_asym>
        </owl:sameAs>
      </xsl:if>
      <xsl:if test="PDBxv:entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBxv:entity_id,' ^','_')}">
	    <PDBov:referenced_by_struct_asym rdf:resource="{$base}/struct_asym/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_asym>
      </PDBov:has_struct_asym>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_biolCategory/PDBxv:struct_biol">
      <PDBov:has_struct_biol>
      <PDBov:struct_biol rdf:about="{$base}/struct_biol/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_biol>
      </PDBov:has_struct_biol>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_biol_viewCategory/PDBxv:struct_biol_view">
      <PDBov:has_struct_biol_view>
      <PDBov:struct_biol_view rdf:about="{$base}/struct_biol_view/{translate(@biol_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@biol_id!=''">
        <PDBov:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(@biol_id,' ^','_')}">
	    <PDBov:referenced_by_struct_biol_view rdf:resource="{$base}/struct_biol_view/{translate(@biol_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_biol_view>
      </PDBov:has_struct_biol_view>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_confCategory/PDBxv:struct_conf">
      <PDBov:has_struct_conf>
      <PDBov:struct_conf rdf:about="{$base}/struct_conf/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:conf_type_id!=''">
        <PDBov:reference_to_struct_conf_type>
	  <rdf:Description  rdf:about="{$base}/struct_conf_type/{translate(PDBxv:conf_type_id,' ^','_')}">
	    <PDBov:referenced_by_struct_conf rdf:resource="{$base}/struct_conf/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_conf_type>
        <!-- struct_conf_typeKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_conf>
      </PDBov:has_struct_conf>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_conf_typeCategory/PDBxv:struct_conf_type">
      <PDBov:has_struct_conf_type>
      <PDBov:struct_conf_type rdf:about="{$base}/struct_conf_type/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_conf_type>
      </PDBov:has_struct_conf_type>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_connCategory/PDBxv:struct_conn">
      <PDBov:has_struct_conn>
      <PDBov:struct_conn rdf:about="{$base}/struct_conn/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_conn>
      </PDBov:has_struct_conn>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_conn_typeCategory/PDBxv:struct_conn_type">
      <PDBov:has_struct_conn_type>
      <PDBov:struct_conn_type rdf:about="{$base}/struct_conn_type/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_conn_type>
      </PDBov:has_struct_conn_type>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_mon_detailsCategory/PDBxv:struct_mon_details">
      <PDBov:has_struct_mon_details>
      <PDBov:struct_mon_details rdf:about="{$base}/struct_mon_details/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_struct_mon_details rdf:resource="{$base}/struct_mon_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_40_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_mon_details>
      </PDBov:has_struct_mon_details>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_mon_nuclCategory/PDBxv:struct_mon_nucl">
      <PDBov:has_struct_mon_nucl>
      <PDBov:struct_mon_nucl rdf:about="{$base}/struct_mon_nucl/{translate(@pdbx_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_mon_nucl>
      </PDBov:has_struct_mon_nucl>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_mon_protCategory/PDBxv:struct_mon_prot">
      <PDBov:has_struct_mon_prot>
      <PDBov:struct_mon_prot rdf:about="{$base}/struct_mon_prot/{translate(@pdbx_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_mon_prot>
      </PDBov:has_struct_mon_prot>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_mon_prot_cisCategory/PDBxv:struct_mon_prot_cis">
      <PDBov:has_struct_mon_prot_cis>
      <PDBov:struct_mon_prot_cis rdf:about="{$base}/struct_mon_prot_cis/{translate(@pdbx_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_mon_prot_cis>
      </PDBov:has_struct_mon_prot_cis>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_ncs_domCategory/PDBxv:struct_ncs_dom">
      <PDBov:has_struct_ncs_dom>
      <PDBov:struct_ncs_dom rdf:about="{$base}/struct_ncs_dom/{translate(@id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@pdbx_ens_id!=''">
        <PDBov:reference_to_struct_ncs_ens>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_ens/{translate(@pdbx_ens_id,' ^','_')}">
	    <PDBov:referenced_by_struct_ncs_dom rdf:resource="{$base}/struct_ncs_dom/{translate(@id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_ncs_ens>
        <!-- struct_ncs_ensKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_ncs_dom>
      </PDBov:has_struct_ncs_dom>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_ncs_dom_limCategory/PDBxv:struct_ncs_dom_lim">
      <PDBov:has_struct_ncs_dom_lim>
      <PDBov:struct_ncs_dom_lim rdf:about="{$base}/struct_ncs_dom_lim/{translate(@dom_id,' ^','_')},{translate(@pdbx_component_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@dom_id!='' and @pdbx_ens_id!=''">
        <PDBov:reference_to_struct_ncs_dom>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_dom/{translate(@dom_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
	    <PDBov:referenced_by_struct_ncs_dom_lim rdf:resource="{$base}/struct_ncs_dom_lim/{translate(@dom_id,' ^','_')},{translate(@pdbx_component_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_ncs_dom>
        <!-- struct_ncs_domKeyref_1_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_ncs_dom_lim>
      </PDBov:has_struct_ncs_dom_lim>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_ncs_ensCategory/PDBxv:struct_ncs_ens">
      <PDBov:has_struct_ncs_ens>
      <PDBov:struct_ncs_ens rdf:about="{$base}/struct_ncs_ens/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_ncs_ens>
      </PDBov:has_struct_ncs_ens>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_ncs_ens_genCategory/PDBxv:struct_ncs_ens_gen">
      <PDBov:has_struct_ncs_ens_gen>
      <PDBov:struct_ncs_ens_gen rdf:about="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@ens_id!=''">
        <PDBov:reference_to_struct_ncs_ens>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_ens/{translate(@ens_id,' ^','_')}">
	    <PDBov:referenced_by_struct_ncs_ens_gen rdf:resource="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_ncs_ens>
        <!-- struct_ncs_ensKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@oper_id!=''">
        <PDBov:reference_to_struct_ncs_oper>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_oper/{translate(@oper_id,' ^','_')}">
	    <PDBov:referenced_by_struct_ncs_ens_gen rdf:resource="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_ncs_oper>
        <!-- struct_ncs_operKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_ncs_ens_gen>
      </PDBov:has_struct_ncs_ens_gen>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_ncs_operCategory/PDBxv:struct_ncs_oper">
      <PDBov:has_struct_ncs_oper>
      <PDBov:struct_ncs_oper rdf:about="{$base}/struct_ncs_oper/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_ncs_oper>
      </PDBov:has_struct_ncs_oper>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_refCategory/PDBxv:struct_ref">
      <PDBov:has_struct_ref>
      <PDBov:struct_ref rdf:about="{$base}/struct_ref/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:entity_id!=''">
        <PDBov:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBxv:entity_id,' ^','_')}">
	    <PDBov:referenced_by_struct_ref rdf:resource="{$base}/struct_ref/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entity>
        <!-- entityKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_ref>
      </PDBov:has_struct_ref>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_ref_seqCategory/PDBxv:struct_ref_seq">
      <PDBov:has_struct_ref_seq>
      <PDBov:struct_ref_seq rdf:about="{$base}/struct_ref_seq/{translate(@align_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:ref_id!=''">
        <PDBov:reference_to_struct_ref>
	  <rdf:Description  rdf:about="{$base}/struct_ref/{translate(PDBxv:ref_id,' ^','_')}">
	    <PDBov:referenced_by_struct_ref_seq rdf:resource="{$base}/struct_ref_seq/{translate(@align_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_ref>
        <!-- struct_refKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_ref_seq>
      </PDBov:has_struct_ref_seq>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_ref_seq_difCategory/PDBxv:struct_ref_seq_dif">
      <PDBov:has_struct_ref_seq_dif>
      <PDBov:struct_ref_seq_dif rdf:about="{$base}/struct_ref_seq_dif/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:align_id!=''">
        <PDBov:reference_to_struct_ref_seq>
	  <rdf:Description  rdf:about="{$base}/struct_ref_seq/{translate(PDBxv:align_id,' ^','_')}">
	    <PDBov:referenced_by_struct_ref_seq_dif rdf:resource="{$base}/struct_ref_seq_dif/{translate(@pdbx_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_ref_seq>
        <!-- struct_ref_seqKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_ref_seq_dif>
      </PDBov:has_struct_ref_seq_dif>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_sheetCategory/PDBxv:struct_sheet">
      <PDBov:has_struct_sheet>
      <PDBov:struct_sheet rdf:about="{$base}/struct_sheet/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_sheet>
      </PDBov:has_struct_sheet>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_sheet_hbondCategory/PDBxv:struct_sheet_hbond">
      <PDBov:has_struct_sheet_hbond>
      <PDBov:struct_sheet_hbond rdf:about="{$base}/struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBov:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBov:referenced_by_struct_sheet_hbond rdf:resource="{$base}/struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_sheet_hbond>
      </PDBov:has_struct_sheet_hbond>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_sheet_orderCategory/PDBxv:struct_sheet_order">
      <PDBov:has_struct_sheet_order>
      <PDBov:struct_sheet_order rdf:about="{$base}/struct_sheet_order/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBov:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBov:referenced_by_struct_sheet_order rdf:resource="{$base}/struct_sheet_order/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_sheet_order>
      </PDBov:has_struct_sheet_order>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_sheet_rangeCategory/PDBxv:struct_sheet_range">
      <PDBov:has_struct_sheet_range>
      <PDBov:struct_sheet_range rdf:about="{$base}/struct_sheet_range/{translate(@id,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBov:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBov:referenced_by_struct_sheet_range rdf:resource="{$base}/struct_sheet_range/{translate(@id,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_sheet_range>
      </PDBov:has_struct_sheet_range>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_sheet_topologyCategory/PDBxv:struct_sheet_topology">
      <PDBov:has_struct_sheet_topology>
      <PDBov:struct_sheet_topology rdf:about="{$base}/struct_sheet_topology/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBov:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBov:referenced_by_struct_sheet_topology rdf:resource="{$base}/struct_sheet_topology/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_sheet_topology>
      </PDBov:has_struct_sheet_topology>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_siteCategory/PDBxv:struct_site">
      <PDBov:has_struct_site>
      <PDBov:struct_site rdf:about="{$base}/struct_site/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_site>
      </PDBov:has_struct_site>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_site_genCategory/PDBxv:struct_site_gen">
      <PDBov:has_struct_site_gen>
      <PDBov:struct_site_gen rdf:about="{$base}/struct_site_gen/{translate(@id,' ^','_')},{translate(@site_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@site_id!=''">
        <PDBov:reference_to_struct_site>
	  <rdf:Description  rdf:about="{$base}/struct_site/{translate(@site_id,' ^','_')}">
	    <PDBov:referenced_by_struct_site_gen rdf:resource="{$base}/struct_site_gen/{translate(@id,' ^','_')},{translate(@site_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_site>
        <!-- struct_siteKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_site_gen>
      </PDBov:has_struct_site_gen>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:struct_site_viewCategory/PDBxv:struct_site_view">
      <PDBov:has_struct_site_view>
      <PDBov:struct_site_view rdf:about="{$base}/struct_site_view/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBxv:site_id!=''">
        <PDBov:reference_to_struct_site>
	  <rdf:Description  rdf:about="{$base}/struct_site/{translate(PDBxv:site_id,' ^','_')}">
	    <PDBov:referenced_by_struct_site_view rdf:resource="{$base}/struct_site_view/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_struct_site>
        <!-- struct_siteKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:struct_site_view>
      </PDBov:has_struct_site_view>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:symmetryCategory/PDBxv:symmetry">
      <PDBov:has_symmetry>
      <PDBov:symmetry rdf:about="{$base}/symmetry/{translate(@entry_id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBov:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBov:referenced_by_symmetry rdf:resource="{$base}/symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBov:reference_to_entry>
        <!-- entryKeyref_0_0_41_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:symmetry>
      </PDBov:has_symmetry>
  </xsl:template>

  <xsl:template match="PDBxv:datablock/PDBxv:symmetry_equivCategory/PDBxv:symmetry_equiv">
      <PDBov:has_symmetry_equiv>
      <PDBov:symmetry_equiv rdf:about="{$base}/symmetry_equiv/{translate(@id,' ^','_')}">
      <PDBov:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBov:symmetry_equiv>
      </PDBov:has_symmetry_equiv>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>
  <xsl:template match="*|text()|@*" mode="linked"/>

</xsl:stylesheet>