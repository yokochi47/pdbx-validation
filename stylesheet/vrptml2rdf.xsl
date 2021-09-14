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
  xmlns:VRPTx="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd"
  xmlns:VRPTo="https://rdf.wwpdb.org/schema/pdbx-validation-v4.owl#"
  xmlns:ext="http://exslt.org/common" exclude-result-prefixes="VRPTx ext">

  <xsl:param name="wurcs2glytoucan" select="'https://raw.githubusercontent.com/yokochi47/pdbx-validation/master/wurcs2glytoucan/glytoucan.xml'" required="no"/>
  <xsl:param name="glytoucan" select="document($wurcs2glytoucan)"/>

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="PDBID"><xsl:value-of select="/VRPTx:datablock/VRPTx:entryCategory/VRPTx:entry/@id"/></xsl:variable>
  <xsl:variable name="pdbid"><xsl:value-of select="translate($PDBID,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/></xsl:variable>
  <xsl:variable name="pdb_doi"><xsl:value-of select="concat('10.2210/pdb',$pdbid,'/pdb')"/></xsl:variable>
  <xsl:variable name="base">https://rdf.wwpdb.org/pdb-validation/<xsl:value-of select="$PDBID"/></xsl:variable>
  <xsl:variable name="base_lower">https://rdf.wwpdb.org/pdb/<xsl:value-of select="$pdbid"/></xsl:variable>
  <xsl:variable name="pdb_link">https://rdf.wwpdb.org/pdb/</xsl:variable>
  <xsl:variable name="bmrb_link">https://bmrbpub.pdbj.org/rdf/bmr</xsl:variable>
  <xsl:variable name="chem_comp">https://rdf.wwpdb.org/cc/</xsl:variable>
  <xsl:variable name="prd">https://rdf.wwpdb.org/prd/</xsl:variable>
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
  <xsl:variable name="uniprot">http://purl.uniprot.org/uniprot/</xsl:variable>
  <xsl:variable name="genbank">https://www.ncbi.nlm.nih.gov/nuccore/</xsl:variable>
  <xsl:variable name="embl">https://www.ncbi.nlm.nih.gov/nuccore/</xsl:variable>
  <xsl:variable name="pir">https://www.ncbi.nlm.nih.gov/nuccore/</xsl:variable>
  <xsl:variable name="refseq">https://www.ncbi.nlm.nih.gov/protein/</xsl:variable>
  <xsl:variable name="norine">https://bioinfo.lifl.fr/norine/result.jsp?ID=</xsl:variable>
  <xsl:variable name="enzyme">http://purl.uniprot.org/enzyme/</xsl:variable>
  <xsl:variable name="go">http://amigo.geneontology.org/amigo/term/GO:/</xsl:variable>
  <xsl:variable name="interpro">https://www.ebi.ac.uk/interpro/entry/</xsl:variable>
  <xsl:variable name="pfam">http://pfam.xfam.org/family/</xsl:variable>
  <xsl:variable name="cath_domain">http://www.cathdb.info/domain/</xsl:variable>
  <xsl:variable name="scop">http://scop.mrc-lmb.cam.ac.uk/scop/search.cgi?sunid=</xsl:variable>
  <xsl:variable name="ensemble">https://www.ensembl.org/id/</xsl:variable>
  <xsl:variable name="glycoinfo">http://rdf.glycoinfo.org/glycan/</xsl:variable>

  <xsl:template match="/">
    <rdf:RDF>
      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <!-- level 1 -->
  <xsl:template match="/VRPTx:datablock">
    <VRPTo:datablock rdf:about="{$base}">
      <dcterms:identifier><xsl:value-of select="$PDBID"/></dcterms:identifier>
      <skos:altLabel><xsl:value-of select="$pdbid"/></skos:altLabel>
      <dc:title><xsl:value-of select="VRPTx:structCategory/VRPTx:struct/VRPTx:title/text()"/></dc:title>
      <VRPTo:link_to_pdb_src rdf:resource="{$pdb_link}{$pdbid}"/>
      <VRPTo:link_to_pdbml rdf:resource="{$pdbml}{$pdbid}.xml.gz"/>
      <VRPTo:link_to_pdbml_noatom rdf:resource="{$pdbml_noatom}{$pdbid}-noatom.xml.gz"/>
      <VRPTo:link_to_pdbml_extatom rdf:resource="{$pdbml_extatom}{$pdbid}-extatom.xml.gz"/>
      <VRPTo:link_to_xml_vrpt rdf:resource="{$vrpt}{$pdbid}_validation.xml.gz"/>
      <VRPTo:link_to_doi rdf:resource="{$doi}{$pdb_doi}" rdfs:label="doi:{$pdb_doi}"/>
      <!-- VRPTo:link_to_pdbml_vrpt rdf:resource="{$vrpt}{$pdbid}-validation-full.xml.gz"/ -->
      <!-- VRPTo:link_to_pdbml_vrpt_alt rdf:resource="{$vrpt}{$pdbid}-validation-alt.xml.gz"/ -->
      <owl:sameAs rdf:resource="{$base_lower}"/>
      <rdfs:seeAlso rdf:resource="{$pdbj}{$PDBID}"/>
      <rdfs:seeAlso rdf:resource="{$rcsb}{$PDBID}"/>
      <rdfs:seeAlso rdf:resource="{$pdbe}{$PDBID}"/>

      <VRPTo:datablockName><xsl:value-of select="@datablockName"/></VRPTo:datablockName>
      <xsl:apply-templates select="./*"/>
    </VRPTo:datablock>
  </xsl:template>

  <!-- level 2 -->
  <xsl:template match="/VRPTx:datablock/*">
    <xsl:element name="VRPTo:has_{local-name(.)}">
      <xsl:element name="VRPTo:{local-name(.)}">
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
  <xsl:template match="/VRPTx:datablock/*/*/*[not(xsi:nil) and text()!='']">
    <xsl:element name="VRPTo:{concat(local-name(parent::node()),'.',local-name())}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (attribute) -->
  <xsl:template match="/VRPTx:datablock/*/*/@*">
    <xsl:element name="VRPTo:{concat(local-name(parent::node()),'.',translate(name(),'@',''))}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (linked data) -->
  <xsl:template match="VRPTx:chem_comp/@id" mode="linked">
    <VRPTo:link_to_chem_comp rdf:resource="{$chem_comp}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_molecule/@prd_id" mode="linked">
    <VRPTo:link_to_prd rdf:resource="{$prd}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_molecule_features/@prd_id" mode="linked">
    <VRPTo:link_to_prd rdf:resource="{$prd}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_linked_entity/VRPTx:prd_id[text()!='']" mode="linked">
    <VRPTo:link_to_prd rdf:resource="{$prd}{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:citation/VRPTx:pdbx_database_id_DOI[text()!='']" mode="linked">
    <VRPTo:link_to_doi rdf:resource="{$doi}{text()}" rdfs:label="doi:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:citation/VRPTx:pdbx_database_id_PubMed[text()!='']" mode="linked">
    <VRPTo:link_to_pubmed rdf:resource="{$pubmed}{text()}" rdfs:label="pubmed:{text()}"/>
    <dcterms:references rdf:resource="{$idorg}pubmed/{text()}" rdfs:label="pubmed:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:entity_src_gen/VRPTx:pdbx_gene_src_ncbi_taxonomy_id[text()!='']" mode="linked">
    <VRPTo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:entity_src_gen/VRPTx:pdbx_host_org_ncbi_taxonomy_id[text()!='']" mode="linked">
    <VRPTo:link_to_taxonomy_host rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:entity_src_nat/VRPTx:pdbx_ncbi_taxonomy_id[text()!='']" mode="linked">
    <VRPTo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:entity/VRPTx:pdbx_ec[text()!='']" mode="linked">
    <xsl:variable name="ec_norm"><xsl:value-of select="normalize-space(text())"/></xsl:variable>
    <xsl:if test="$ec_norm!=''">
      <xsl:variable name="ec_list">
        <xsl:call-template name="tokenize">
          <xsl:with-param name="string" select="$ec_norm"/>
          <xsl:with-param name="delimiter">,</xsl:with-param>
        </xsl:call-template>
      </xsl:variable>
      <xsl:for-each select="ext:node-set($ec_list)/token">
        <xsl:variable name="ec"><xsl:value-of select="normalize-space(text())"/></xsl:variable>
        <xsl:if test="string-length($ec)!=0">
          <VRPTo:link_to_enzyme rdf:resource="{$enzyme}{$ec}" rdfs:label="enzyme:{$ec}"/>
          <rdfs:seeAlso rdf:resource="{$idorg}ec-code/{$ec}" rdfs:label="ec-code:{$ec}"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <xsl:template name="tokenize">
    <xsl:param name="string"/>
    <xsl:param name="delimiter"/>
    <xsl:choose>
      <xsl:when test="$delimiter and contains($string,$delimiter)">
        <token>
          <xsl:value-of select="substring-before($string,$delimiter)"/>
        </token>
        <xsl:call-template name="tokenize">
          <xsl:with-param name="string" select="substring-after($string,$delimiter)"/>
          <xsl:with-param name="delimiter" select="$delimiter"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <token>
          <xsl:value-of select="$string"/>
        </token>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:pdbx_db_accession[../VRPTx:db_name='UNP' and text()!='']" mode="linked">
    <VRPTo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[(../VRPTx:db_name='GB' or ../VRPTx:db_name='GB ' or ../VRPTx:db_name='gb' or ../VRPTx:db_name='TPG') and text()!='']" mode="linked">
    <VRPTo:link_to_genbank rdf:resource="{$genbank}{text()}" rdfs:label="ncbiprotein:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[(../VRPTx:db_name='EMBL' or ../VRPTx:db_name='GENP') and text()!='']" mode="linked">
    <VRPTo:link_to_embl rdf:resource="{$embl}{text()}" rdfs:label="ncbiprotein:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='TREMBL' and string-length(text())=6 and contains(substring(text(),0,1),'OPQ') and contains(substring(text(),1,1),'0123456789')]" mode="linked">
    <VRPTo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='TREMBL' and text()!='' and not(string-length(text())=6 and contains(substring(text(),0,1),'OPQ') and contains(substring(text(),1,1),'0123456789'))]" mode="linked">
    <VRPTo:link_to_embl rdf:resource="{$embl}{text()}" rdfs:label="ncbiprotein:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='PIR' and text()!='']" mode="linked">
    <VRPTo:link_to_pir rdf:resource="{$pir}{text()}" rdfs:label="ncbiprotein:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='REF' and text()!='']" mode="linked">
    <VRPTo:link_to_refseq rdf:resource="{$refseq}{text()}" rdfs:label="refseq:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}refseq/{text()}" rdfs:label="refseq:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='PRF' and text()!='']" mode="linked">
    <VRPTo:link_to_sequence_db rdf:resource="{$pir}{text()}" rdfs:label="ncbiprotein:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='NOR' and text()!='']" mode="linked">
    <VRPTo:link_to_norine rdf:resource="{$norine}{text()}" rdfs:label="norine:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}norine/{text()}" rdfs:label="norine:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_unp_segments/VRPTx:unp_acc[text()!='']" mode="linked">
    <VRPTo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments/VRPTx:xref_db_acc[../VRPTx:xref_db='CATH' and text()!='']" mode="linked">
    <VRPTo:link_to_cath_domain rdf:resource="{$cath_domain}{text()}" rdfs:label="cath.domain:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}cath.domain/{text()}" rdfs:label="cath.domain:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments/VRPTx:xref_db_acc[(../VRPTx:xref_db='SCOP' or ../VRPTx:xref_db='SCOP2' or ../VRPTx:xref_db='SCOP2B') and text()!='']" mode="linked">
    <VRPTo:link_to_scop rdf:resource="{$scop}{text()}" rdfs:label="scop:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}scop/{text()}" rdfs:label="scop:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments/VRPTx:xref_db_acc[../VRPTx:xref_db='Ensemble' and text()!='']" mode="linked">
    <VRPTo:link_to_ensemble rdf:resource="{$ensemble}{text()}" rdfs:label="ensemble:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ensemble/{text()}" rdfs:label="ensemble:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_entity_branch_descriptor/VRPTx:descriptor[../VRPTx:type='WURCS' and text()!='']" mode="linked">
    <xsl:variable name="wurcs_id"><xsl:value-of select="text()"/></xsl:variable>
    <xsl:for-each select="$glytoucan/catalog/wurcs[@id=$wurcs_id]">
      <xsl:if test="text()!=''">
        <VRPTo:link_to_glycoinfo rdf:resource="{$glycoinfo}{text()}" rdfs:label="glytoucan:{text()}"/>
        <rdfs:seeAlso rdf:resource="{$idorg}glytoucan/{text()}" rdfs:label="glytoucan:{text()}"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_related[@db_name='PDB' and @content_type!='split']/@db_id" mode="linked">
    <VRPTo:link_to_pdb rdf:resource="{$pdb_link}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_related[@db_name='PDB' and @content_type='split']/@db_id" mode="linked">
    <VRPTo:link_to_pdb_split rdf:resource="{$pdb_link}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:chem_comp/VRPTx:pdbx_model_coordinates_db_code" mode="linked">
    <VRPTo:link_to_pdb rdf:resource="{$pdb_link}{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_related[@db_name='BMRB']/@db_id" mode="linked">
    <VRPTo:link_to_bmrb rdf:resource="{$bmrb_link}{.}"/>
  </xsl:template>

  <!-- level-3 templates follow -->
  <xsl:template match="VRPTx:datablock/VRPTx:diffrnCategory/VRPTx:diffrn">
      <VRPTo:has_diffrn>
      <VRPTo:diffrn rdf:about="{$base}/diffrn/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn>
      </VRPTo:has_diffrn>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_attenuatorCategory/VRPTx:diffrn_attenuator">
      <VRPTo:has_diffrn_attenuator>
      <VRPTo:diffrn_attenuator rdf:about="{$base}/diffrn_attenuator/{translate(@code,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_attenuator>
      </VRPTo:has_diffrn_attenuator>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_detectorCategory/VRPTx:diffrn_detector">
      <VRPTo:has_diffrn_detector>
      <VRPTo:diffrn_detector rdf:about="{$base}/diffrn_detector/{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_detector rdf:resource="{$base}/diffrn_detector/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_detector>
      </VRPTo:has_diffrn_detector>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_measurementCategory/VRPTx:diffrn_measurement">
      <VRPTo:has_diffrn_measurement>
      <VRPTo:diffrn_measurement rdf:about="{$base}/diffrn_measurement/{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_measurement rdf:resource="{$base}/diffrn_measurement/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_measurement>
      </VRPTo:has_diffrn_measurement>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_orient_matrixCategory/VRPTx:diffrn_orient_matrix">
      <VRPTo:has_diffrn_orient_matrix>
      <VRPTo:diffrn_orient_matrix rdf:about="{$base}/diffrn_orient_matrix/{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_orient_matrix rdf:resource="{$base}/diffrn_orient_matrix/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_orient_matrix>
      </VRPTo:has_diffrn_orient_matrix>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_orient_reflnCategory/VRPTx:diffrn_orient_refln">
      <VRPTo:has_diffrn_orient_refln>
      <VRPTo:diffrn_orient_refln rdf:about="{$base}/diffrn_orient_refln/{translate(@diffrn_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_orient_refln rdf:resource="{$base}/diffrn_orient_refln/{translate(@diffrn_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_orient_refln>
      </VRPTo:has_diffrn_orient_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_radiationCategory/VRPTx:diffrn_radiation">
      <VRPTo:has_diffrn_radiation>
      <VRPTo:diffrn_radiation rdf:about="{$base}/diffrn_radiation/{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_radiation rdf:resource="{$base}/diffrn_radiation/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_radiation>
      </VRPTo:has_diffrn_radiation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_radiation_wavelengthCategory/VRPTx:diffrn_radiation_wavelength">
      <VRPTo:has_diffrn_radiation_wavelength>
      <VRPTo:diffrn_radiation_wavelength rdf:about="{$base}/diffrn_radiation_wavelength/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_radiation_wavelength>
      </VRPTo:has_diffrn_radiation_wavelength>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_reflnCategory/VRPTx:diffrn_refln">
      <VRPTo:has_diffrn_refln>
      <VRPTo:diffrn_refln rdf:about="{$base}/diffrn_refln/{translate(@diffrn_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_refln rdf:resource="{$base}/diffrn_refln/{translate(@diffrn_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_refln>
      </VRPTo:has_diffrn_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_reflnsCategory/VRPTx:diffrn_reflns">
      <VRPTo:has_diffrn_reflns>
      <VRPTo:diffrn_reflns rdf:about="{$base}/diffrn_reflns/{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_reflns rdf:resource="{$base}/diffrn_reflns/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_reflns>
      </VRPTo:has_diffrn_reflns>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_reflns_classCategory/VRPTx:diffrn_reflns_class">
      <VRPTo:has_diffrn_reflns_class>
      <VRPTo:diffrn_reflns_class rdf:about="{$base}/diffrn_reflns_class/{translate(@code,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_reflns_class>
      </VRPTo:has_diffrn_reflns_class>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_scale_groupCategory/VRPTx:diffrn_scale_group">
      <VRPTo:has_diffrn_scale_group>
      <VRPTo:diffrn_scale_group rdf:about="{$base}/diffrn_scale_group/{translate(@code,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_scale_group>
      </VRPTo:has_diffrn_scale_group>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_sourceCategory/VRPTx:diffrn_source">
      <VRPTo:has_diffrn_source>
      <VRPTo:diffrn_source rdf:about="{$base}/diffrn_source/{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_source rdf:resource="{$base}/diffrn_source/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_source>
      </VRPTo:has_diffrn_source>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_standard_reflnCategory/VRPTx:diffrn_standard_refln">
      <VRPTo:has_diffrn_standard_refln>
      <VRPTo:diffrn_standard_refln rdf:about="{$base}/diffrn_standard_refln/{translate(@code,' ^','_')},{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_standard_refln rdf:resource="{$base}/diffrn_standard_refln/{translate(@code,' ^','_')},{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_standard_refln>
      </VRPTo:has_diffrn_standard_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_standardsCategory/VRPTx:diffrn_standards">
      <VRPTo:has_diffrn_standards>
      <VRPTo:diffrn_standards rdf:about="{$base}/diffrn_standards/{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_diffrn_standards rdf:resource="{$base}/diffrn_standards/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:diffrn_standards>
      </VRPTo:has_diffrn_standards>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_2d_crystal_entityCategory/VRPTx:em_2d_crystal_entity">
      <VRPTo:has_em_2d_crystal_entity>
      <VRPTo:em_2d_crystal_entity rdf:about="{$base}/em_2d_crystal_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_2d_crystal_entity>
      </VRPTo:has_em_2d_crystal_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_3d_crystal_entityCategory/VRPTx:em_3d_crystal_entity">
      <VRPTo:has_em_3d_crystal_entity>
      <VRPTo:em_3d_crystal_entity rdf:about="{$base}/em_3d_crystal_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_3d_crystal_entity>
      </VRPTo:has_em_3d_crystal_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_3d_fittingCategory/VRPTx:em_3d_fitting">
      <VRPTo:has_em_3d_fitting>
      <VRPTo:em_3d_fitting rdf:about="{$base}/em_3d_fitting/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_em_3d_fitting rdf:resource="{$base}/em_3d_fitting/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_3d_fitting>
      </VRPTo:has_em_3d_fitting>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_3d_fitting_listCategory/VRPTx:em_3d_fitting_list">
      <VRPTo:has_em_3d_fitting_list>
      <VRPTo:em_3d_fitting_list rdf:about="{$base}/em_3d_fitting_list/{translate(@_3d_fitting_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_3d_fitting_list>
      </VRPTo:has_em_3d_fitting_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_3d_reconstructionCategory/VRPTx:em_3d_reconstruction">
      <VRPTo:has_em_3d_reconstruction>
      <VRPTo:em_3d_reconstruction rdf:about="{$base}/em_3d_reconstruction/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(VRPTx:entry_id,' ^','_')}">
	    <VRPTo:referenced_by_em_3d_reconstruction rdf:resource="{$base}/em_3d_reconstruction/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_3d_reconstruction>
      </VRPTo:has_em_3d_reconstruction>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_adminCategory/VRPTx:em_admin">
      <VRPTo:has_em_admin>
      <VRPTo:em_admin rdf:about="{$base}/em_admin/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_admin>
      </VRPTo:has_em_admin>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_bufferCategory/VRPTx:em_buffer">
      <VRPTo:has_em_buffer>
      <VRPTo:em_buffer rdf:about="{$base}/em_buffer/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_buffer>
      </VRPTo:has_em_buffer>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_buffer_componentCategory/VRPTx:em_buffer_component">
      <VRPTo:has_em_buffer_component>
      <VRPTo:em_buffer_component rdf:about="{$base}/em_buffer_component/{translate(@buffer_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_buffer_component>
      </VRPTo:has_em_buffer_component>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_crystal_formationCategory/VRPTx:em_crystal_formation">
      <VRPTo:has_em_crystal_formation>
      <VRPTo:em_crystal_formation rdf:about="{$base}/em_crystal_formation/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_crystal_formation>
      </VRPTo:has_em_crystal_formation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_ctf_correctionCategory/VRPTx:em_ctf_correction">
      <VRPTo:has_em_ctf_correction>
      <VRPTo:em_ctf_correction rdf:about="{$base}/em_ctf_correction/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_ctf_correction>
      </VRPTo:has_em_ctf_correction>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_diffractionCategory/VRPTx:em_diffraction">
      <VRPTo:has_em_diffraction>
      <VRPTo:em_diffraction rdf:about="{$base}/em_diffraction/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_diffraction>
      </VRPTo:has_em_diffraction>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_diffraction_shellCategory/VRPTx:em_diffraction_shell">
      <VRPTo:has_em_diffraction_shell>
      <VRPTo:em_diffraction_shell rdf:about="{$base}/em_diffraction_shell/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_diffraction_shell>
      </VRPTo:has_em_diffraction_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_diffraction_statsCategory/VRPTx:em_diffraction_stats">
      <VRPTo:has_em_diffraction_stats>
      <VRPTo:em_diffraction_stats rdf:about="{$base}/em_diffraction_stats/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_diffraction_stats>
      </VRPTo:has_em_diffraction_stats>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_embeddingCategory/VRPTx:em_embedding">
      <VRPTo:has_em_embedding>
      <VRPTo:em_embedding rdf:about="{$base}/em_embedding/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_embedding>
      </VRPTo:has_em_embedding>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assemblyCategory/VRPTx:em_entity_assembly">
      <VRPTo:has_em_entity_assembly>
      <VRPTo:em_entity_assembly rdf:about="{$base}/em_entity_assembly/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_entity_assembly>
      </VRPTo:has_em_entity_assembly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assembly_molwtCategory/VRPTx:em_entity_assembly_molwt">
      <VRPTo:has_em_entity_assembly_molwt>
      <VRPTo:em_entity_assembly_molwt rdf:about="{$base}/em_entity_assembly_molwt/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <VRPTo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_em_entity_assembly_molwt rdf:resource="{$base}/em_entity_assembly_molwt/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_entity_assembly_molwt>
      </VRPTo:has_em_entity_assembly_molwt>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assembly_naturalsourceCategory/VRPTx:em_entity_assembly_naturalsource">
      <VRPTo:has_em_entity_assembly_naturalsource>
      <VRPTo:em_entity_assembly_naturalsource rdf:about="{$base}/em_entity_assembly_naturalsource/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <VRPTo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_em_entity_assembly_naturalsource rdf:resource="{$base}/em_entity_assembly_naturalsource/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_entity_assembly_naturalsource>
      </VRPTo:has_em_entity_assembly_naturalsource>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assembly_recombinantCategory/VRPTx:em_entity_assembly_recombinant">
      <VRPTo:has_em_entity_assembly_recombinant>
      <VRPTo:em_entity_assembly_recombinant rdf:about="{$base}/em_entity_assembly_recombinant/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <VRPTo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_em_entity_assembly_recombinant rdf:resource="{$base}/em_entity_assembly_recombinant/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_entity_assembly_recombinant>
      </VRPTo:has_em_entity_assembly_recombinant>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assembly_syntheticCategory/VRPTx:em_entity_assembly_synthetic">
      <VRPTo:has_em_entity_assembly_synthetic>
      <VRPTo:em_entity_assembly_synthetic rdf:about="{$base}/em_entity_assembly_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <VRPTo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_em_entity_assembly_synthetic rdf:resource="{$base}/em_entity_assembly_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_entity_assembly_synthetic>
      </VRPTo:has_em_entity_assembly_synthetic>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_experimentCategory/VRPTx:em_experiment">
      <VRPTo:has_em_experiment>
      <VRPTo:em_experiment rdf:about="{$base}/em_experiment/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_em_experiment rdf:resource="{$base}/em_experiment/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_experiment>
      </VRPTo:has_em_experiment>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_helical_entityCategory/VRPTx:em_helical_entity">
      <VRPTo:has_em_helical_entity>
      <VRPTo:em_helical_entity rdf:about="{$base}/em_helical_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_helical_entity>
      </VRPTo:has_em_helical_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_image_processingCategory/VRPTx:em_image_processing">
      <VRPTo:has_em_image_processing>
      <VRPTo:em_image_processing rdf:about="{$base}/em_image_processing/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_image_processing>
      </VRPTo:has_em_image_processing>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_image_recordingCategory/VRPTx:em_image_recording">
      <VRPTo:has_em_image_recording>
      <VRPTo:em_image_recording rdf:about="{$base}/em_image_recording/{translate(@id,' ^','_')},{translate(@imaging_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_image_recording>
      </VRPTo:has_em_image_recording>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_image_scansCategory/VRPTx:em_image_scans">
      <VRPTo:has_em_image_scans>
      <VRPTo:em_image_scans rdf:about="{$base}/em_image_scans/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(VRPTx:entry_id,' ^','_')}">
	    <VRPTo:referenced_by_em_image_scans rdf:resource="{$base}/em_image_scans/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_image_scans>
      </VRPTo:has_em_image_scans>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_imagingCategory/VRPTx:em_imaging">
      <VRPTo:has_em_imaging>
      <VRPTo:em_imaging rdf:about="{$base}/em_imaging/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_em_imaging rdf:resource="{$base}/em_imaging/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_imaging>
      </VRPTo:has_em_imaging>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_imaging_opticsCategory/VRPTx:em_imaging_optics">
      <VRPTo:has_em_imaging_optics>
      <VRPTo:em_imaging_optics rdf:about="{$base}/em_imaging_optics/{translate(@id,' ^','_')},{translate(@imaging_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_imaging_optics>
      </VRPTo:has_em_imaging_optics>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_particle_selectionCategory/VRPTx:em_particle_selection">
      <VRPTo:has_em_particle_selection>
      <VRPTo:em_particle_selection rdf:about="{$base}/em_particle_selection/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_particle_selection>
      </VRPTo:has_em_particle_selection>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_single_particle_entityCategory/VRPTx:em_single_particle_entity">
      <VRPTo:has_em_single_particle_entity>
      <VRPTo:em_single_particle_entity rdf:about="{$base}/em_single_particle_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_single_particle_entity>
      </VRPTo:has_em_single_particle_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_softwareCategory/VRPTx:em_software">
      <VRPTo:has_em_software>
      <VRPTo:em_software rdf:about="{$base}/em_software/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_software>
      </VRPTo:has_em_software>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_specimenCategory/VRPTx:em_specimen">
      <VRPTo:has_em_specimen>
      <VRPTo:em_specimen rdf:about="{$base}/em_specimen/{translate(@experiment_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_specimen>
      </VRPTo:has_em_specimen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_stainingCategory/VRPTx:em_staining">
      <VRPTo:has_em_staining>
      <VRPTo:em_staining rdf:about="{$base}/em_staining/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_staining>
      </VRPTo:has_em_staining>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_virus_entityCategory/VRPTx:em_virus_entity">
      <VRPTo:has_em_virus_entity>
      <VRPTo:em_virus_entity rdf:about="{$base}/em_virus_entity/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <VRPTo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_em_virus_entity rdf:resource="{$base}/em_virus_entity/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_virus_entity>
      </VRPTo:has_em_virus_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_virus_natural_hostCategory/VRPTx:em_virus_natural_host">
      <VRPTo:has_em_virus_natural_host>
      <VRPTo:em_virus_natural_host rdf:about="{$base}/em_virus_natural_host/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <VRPTo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_em_virus_natural_host rdf:resource="{$base}/em_virus_natural_host/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_virus_natural_host>
      </VRPTo:has_em_virus_natural_host>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_virus_shellCategory/VRPTx:em_virus_shell">
      <VRPTo:has_em_virus_shell>
      <VRPTo:em_virus_shell rdf:about="{$base}/em_virus_shell/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <VRPTo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_em_virus_shell rdf:resource="{$base}/em_virus_shell/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_virus_shell>
      </VRPTo:has_em_virus_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_virus_syntheticCategory/VRPTx:em_virus_synthetic">
      <VRPTo:has_em_virus_synthetic>
      <VRPTo:em_virus_synthetic rdf:about="{$base}/em_virus_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <VRPTo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_em_virus_synthetic rdf:resource="{$base}/em_virus_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_em_entity_assembly>
        <!-- em_entity_assemblyKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_virus_synthetic>
      </VRPTo:has_em_virus_synthetic>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_vitrificationCategory/VRPTx:em_vitrification">
      <VRPTo:has_em_vitrification>
      <VRPTo:em_vitrification rdf:about="{$base}/em_vitrification/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(VRPTx:entry_id,' ^','_')}">
	    <VRPTo:referenced_by_em_vitrification rdf:resource="{$base}/em_vitrification/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_vitrification>
      </VRPTo:has_em_vitrification>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_volume_selectionCategory/VRPTx:em_volume_selection">
      <VRPTo:has_em_volume_selection>
      <VRPTo:em_volume_selection rdf:about="{$base}/em_volume_selection/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:em_volume_selection>
      </VRPTo:has_em_volume_selection>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entityCategory/VRPTx:entity">
      <VRPTo:has_entity>
      <VRPTo:entity rdf:about="{$base}/entity/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:entity>
      </VRPTo:has_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entity_name_comCategory/VRPTx:entity_name_com">
      <VRPTo:has_entity_name_com>
      <VRPTo:entity_name_com rdf:about="{$base}/entity_name_com/{translate(@entity_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_entity_name_com rdf:resource="{$base}/entity_name_com/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:entity_name_com>
      </VRPTo:has_entity_name_com>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entity_name_sysCategory/VRPTx:entity_name_sys">
      <VRPTo:has_entity_name_sys>
      <VRPTo:entity_name_sys rdf:about="{$base}/entity_name_sys/{translate(@entity_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_entity_name_sys rdf:resource="{$base}/entity_name_sys/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:entity_name_sys>
      </VRPTo:has_entity_name_sys>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entity_polyCategory/VRPTx:entity_poly">
      <VRPTo:has_entity_poly>
      <VRPTo:entity_poly rdf:about="{$base}/entity_poly/{translate(@entity_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_entity_poly rdf:resource="{$base}/entity_poly/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:entity_poly>
      </VRPTo:has_entity_poly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entity_poly_seqCategory/VRPTx:entity_poly_seq">
      <VRPTo:has_entity_poly_seq>
      <VRPTo:entity_poly_seq rdf:about="{$base}/entity_poly_seq/{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity_poly>
	  <rdf:Description  rdf:about="{$base}/entity_poly/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_entity_poly_seq rdf:resource="{$base}/entity_poly_seq/{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity_poly>
        <!-- entity_polyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:entity_poly_seq>
      </VRPTo:has_entity_poly_seq>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entryCategory/VRPTx:entry">
      <VRPTo:has_entry>
      <VRPTo:entry rdf:about="{$base}/entry/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:entry>
      </VRPTo:has_entry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entry_linkCategory/VRPTx:entry_link">
      <VRPTo:has_entry_link>
      <VRPTo:entry_link rdf:about="{$base}/entry_link/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_entry_link rdf:resource="{$base}/entry_link/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:entry_link>
      </VRPTo:has_entry_link>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:exptlCategory/VRPTx:exptl">
      <VRPTo:has_exptl>
      <VRPTo:exptl rdf:about="{$base}/exptl/{translate(@entry_id,' ^','_')},{translate(@method,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_exptl rdf:resource="{$base}/exptl/{translate(@entry_id,' ^','_')},{translate(@method,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:exptl>
      </VRPTo:has_exptl>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:ndb_struct_conf_naCategory/VRPTx:ndb_struct_conf_na">
      <VRPTo:has_ndb_struct_conf_na>
      <VRPTo:ndb_struct_conf_na rdf:about="{$base}/ndb_struct_conf_na/{translate(@entry_id,' ^','_')},{translate(@feature,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_ndb_struct_conf_na rdf:resource="{$base}/ndb_struct_conf_na/{translate(@entry_id,' ^','_')},{translate(@feature,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:ndb_struct_conf_na>
      </VRPTo:has_ndb_struct_conf_na>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:ndb_struct_na_base_pairCategory/VRPTx:ndb_struct_na_base_pair">
      <VRPTo:has_ndb_struct_na_base_pair>
      <VRPTo:ndb_struct_na_base_pair rdf:about="{$base}/ndb_struct_na_base_pair/{translate(@i_label_asym_id,' ^','_')},{translate(@i_label_comp_id,' ^','_')},{translate(@i_label_seq_id,' ^','_')},{translate(@i_symmetry,' ^','_')},{translate(@j_label_asym_id,' ^','_')},{translate(@j_label_comp_id,' ^','_')},{translate(@j_label_seq_id,' ^','_')},{translate(@j_symmetry,' ^','_')},{translate(@model_number,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:ndb_struct_na_base_pair>
      </VRPTo:has_ndb_struct_na_base_pair>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:ndb_struct_na_base_pair_stepCategory/VRPTx:ndb_struct_na_base_pair_step">
      <VRPTo:has_ndb_struct_na_base_pair_step>
      <VRPTo:ndb_struct_na_base_pair_step rdf:about="{$base}/ndb_struct_na_base_pair_step/{translate(@i_label_asym_id_1,' ^','_')},{translate(@i_label_asym_id_2,' ^','_')},{translate(@i_label_comp_id_1,' ^','_')},{translate(@i_label_comp_id_2,' ^','_')},{translate(@i_label_seq_id_1,' ^','_')},{translate(@i_label_seq_id_2,' ^','_')},{translate(@i_symmetry_1,' ^','_')},{translate(@i_symmetry_2,' ^','_')},{translate(@j_label_asym_id_1,' ^','_')},{translate(@j_label_asym_id_2,' ^','_')},{translate(@j_label_comp_id_1,' ^','_')},{translate(@j_label_comp_id_2,' ^','_')},{translate(@j_label_seq_id_1,' ^','_')},{translate(@j_label_seq_id_2,' ^','_')},{translate(@j_symmetry_1,' ^','_')},{translate(@j_symmetry_2,' ^','_')},{translate(@model_number,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:ndb_struct_na_base_pair_step>
      </VRPTo:has_ndb_struct_na_base_pair_step>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_authorCategory/VRPTx:pdbx_audit_author">
      <VRPTo:has_pdbx_audit_author>
      <VRPTo:pdbx_audit_author rdf:about="{$base}/pdbx_audit_author/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_audit_author>
      </VRPTo:has_pdbx_audit_author>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_categoryCategory/VRPTx:pdbx_audit_revision_category">
      <VRPTo:has_pdbx_audit_revision_category>
      <VRPTo:pdbx_audit_revision_category rdf:about="{$base}/pdbx_audit_revision_category/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <VRPTo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_audit_revision_category rdf:resource="{$base}/pdbx_audit_revision_category/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_audit_revision_history>
        <!-- pdbx_audit_revision_historyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_audit_revision_category>
      </VRPTo:has_pdbx_audit_revision_category>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_detailsCategory/VRPTx:pdbx_audit_revision_details">
      <VRPTo:has_pdbx_audit_revision_details>
      <VRPTo:pdbx_audit_revision_details rdf:about="{$base}/pdbx_audit_revision_details/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <VRPTo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_audit_revision_details rdf:resource="{$base}/pdbx_audit_revision_details/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_audit_revision_history>
        <!-- pdbx_audit_revision_historyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_audit_revision_details>
      </VRPTo:has_pdbx_audit_revision_details>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_groupCategory/VRPTx:pdbx_audit_revision_group">
      <VRPTo:has_pdbx_audit_revision_group>
      <VRPTo:pdbx_audit_revision_group rdf:about="{$base}/pdbx_audit_revision_group/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <VRPTo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_audit_revision_group rdf:resource="{$base}/pdbx_audit_revision_group/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_audit_revision_history>
        <!-- pdbx_audit_revision_historyKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_audit_revision_group>
      </VRPTo:has_pdbx_audit_revision_group>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_historyCategory/VRPTx:pdbx_audit_revision_history">
      <VRPTo:has_pdbx_audit_revision_history>
      <VRPTo:pdbx_audit_revision_history rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_audit_revision_history>
      </VRPTo:has_pdbx_audit_revision_history>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_itemCategory/VRPTx:pdbx_audit_revision_item">
      <VRPTo:has_pdbx_audit_revision_item>
      <VRPTo:pdbx_audit_revision_item rdf:about="{$base}/pdbx_audit_revision_item/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <VRPTo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_audit_revision_item rdf:resource="{$base}/pdbx_audit_revision_item/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_audit_revision_history>
        <!-- pdbx_audit_revision_historyKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_audit_revision_item>
      </VRPTo:has_pdbx_audit_revision_item>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_bond_distance_limitsCategory/VRPTx:pdbx_bond_distance_limits">
      <VRPTo:has_pdbx_bond_distance_limits>
      <VRPTo:pdbx_bond_distance_limits rdf:about="{$base}/pdbx_bond_distance_limits/{translate(@atom_type_1,' ^','_')},{translate(@atom_type_2,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_bond_distance_limits>
      </VRPTo:has_pdbx_bond_distance_limits>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_branch_schemeCategory/VRPTx:pdbx_branch_scheme">
      <VRPTo:has_pdbx_branch_scheme>
      <VRPTo:pdbx_branch_scheme rdf:about="{$base}/pdbx_branch_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_branch_scheme rdf:resource="{$base}/pdbx_branch_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_branch_scheme>
      </VRPTo:has_pdbx_branch_scheme>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_coordinate_modelCategory/VRPTx:pdbx_coordinate_model">
      <VRPTo:has_pdbx_coordinate_model>
      <VRPTo:pdbx_coordinate_model rdf:about="{$base}/pdbx_coordinate_model/{translate(@asym_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
        <VRPTo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_coordinate_model rdf:resource="{$base}/pdbx_coordinate_model/{translate(@asym_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_asym>
        <!-- struct_asymKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_coordinate_model>
      </VRPTo:has_pdbx_coordinate_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_database_relatedCategory/VRPTx:pdbx_database_related">
      <VRPTo:has_pdbx_database_related>
      <VRPTo:pdbx_database_related rdf:about="{$base}/pdbx_database_related/{translate(@content_type,' ^','_')},{translate(@db_id,' ^','_')},{translate(@db_name,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_database_related>
      </VRPTo:has_pdbx_database_related>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_database_statusCategory/VRPTx:pdbx_database_status">
      <VRPTo:has_pdbx_database_status>
      <VRPTo:pdbx_database_status rdf:about="{$base}/pdbx_database_status/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_database_status rdf:resource="{$base}/pdbx_database_status/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_database_status>
      </VRPTo:has_pdbx_database_status>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_densityCategory/VRPTx:pdbx_dcc_density">
      <VRPTo:has_pdbx_dcc_density>
      <VRPTo:pdbx_dcc_density rdf:about="{$base}/pdbx_dcc_density/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_dcc_density rdf:resource="{$base}/pdbx_dcc_density/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_density>
      </VRPTo:has_pdbx_dcc_density>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_density_corrCategory/VRPTx:pdbx_dcc_density_corr">
      <VRPTo:has_pdbx_dcc_density_corr>
      <VRPTo:pdbx_dcc_density_corr rdf:about="{$base}/pdbx_dcc_density_corr/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_density_corr>
      </VRPTo:has_pdbx_dcc_density_corr>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_entity_geometryCategory/VRPTx:pdbx_dcc_entity_geometry">
      <VRPTo:has_pdbx_dcc_entity_geometry>
      <VRPTo:pdbx_dcc_entity_geometry rdf:about="{$base}/pdbx_dcc_entity_geometry/{translate(@PDB_model_num,' ^','_')},{translate(@label_asym_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_entity_geometry>
      </VRPTo:has_pdbx_dcc_entity_geometry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_geometryCategory/VRPTx:pdbx_dcc_geometry">
      <VRPTo:has_pdbx_dcc_geometry>
      <VRPTo:pdbx_dcc_geometry rdf:about="{$base}/pdbx_dcc_geometry/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_dcc_geometry rdf:resource="{$base}/pdbx_dcc_geometry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_geometry>
      </VRPTo:has_pdbx_dcc_geometry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_mapCategory/VRPTx:pdbx_dcc_map">
      <VRPTo:has_pdbx_dcc_map>
      <VRPTo:pdbx_dcc_map rdf:about="{$base}/pdbx_dcc_map/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_map>
      </VRPTo:has_pdbx_dcc_map>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_map_overallCategory/VRPTx:pdbx_dcc_map_overall">
      <VRPTo:has_pdbx_dcc_map_overall>
      <VRPTo:pdbx_dcc_map_overall rdf:about="{$base}/pdbx_dcc_map_overall/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_dcc_map_overall rdf:resource="{$base}/pdbx_dcc_map_overall/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_12_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_map_overall>
      </VRPTo:has_pdbx_dcc_map_overall>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_mapmanCategory/VRPTx:pdbx_dcc_mapman">
      <VRPTo:has_pdbx_dcc_mapman>
      <VRPTo:pdbx_dcc_mapman rdf:about="{$base}/pdbx_dcc_mapman/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_dcc_mapman rdf:resource="{$base}/pdbx_dcc_mapman/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_13_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_mapman>
      </VRPTo:has_pdbx_dcc_mapman>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_mon_geometryCategory/VRPTx:pdbx_dcc_mon_geometry">
      <VRPTo:has_pdbx_dcc_mon_geometry>
      <VRPTo:pdbx_dcc_mon_geometry rdf:about="{$base}/pdbx_dcc_mon_geometry/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_mon_geometry>
      </VRPTo:has_pdbx_dcc_mon_geometry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_rscc_mapmanCategory/VRPTx:pdbx_dcc_rscc_mapman">
      <VRPTo:has_pdbx_dcc_rscc_mapman>
      <VRPTo:pdbx_dcc_rscc_mapman rdf:about="{$base}/pdbx_dcc_rscc_mapman/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_rscc_mapman>
      </VRPTo:has_pdbx_dcc_rscc_mapman>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_rscc_mapman_overallCategory/VRPTx:pdbx_dcc_rscc_mapman_overall">
      <VRPTo:has_pdbx_dcc_rscc_mapman_overall>
      <VRPTo:pdbx_dcc_rscc_mapman_overall rdf:about="{$base}/pdbx_dcc_rscc_mapman_overall/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_dcc_rscc_mapman_overall rdf:resource="{$base}/pdbx_dcc_rscc_mapman_overall/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_14_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_dcc_rscc_mapman_overall>
      </VRPTo:has_pdbx_dcc_rscc_mapman_overall>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_diffrn_reflns_shellCategory/VRPTx:pdbx_diffrn_reflns_shell">
      <VRPTo:has_pdbx_diffrn_reflns_shell>
      <VRPTo:pdbx_diffrn_reflns_shell rdf:about="{$base}/pdbx_diffrn_reflns_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@diffrn_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <VRPTo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_diffrn_reflns_shell rdf:resource="{$base}/pdbx_diffrn_reflns_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_diffrn_reflns_shell>
      </VRPTo:has_pdbx_diffrn_reflns_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_distant_solvent_atomsCategory/VRPTx:pdbx_distant_solvent_atoms">
      <VRPTo:has_pdbx_distant_solvent_atoms>
      <VRPTo:pdbx_distant_solvent_atoms rdf:about="{$base}/pdbx_distant_solvent_atoms/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_distant_solvent_atoms>
      </VRPTo:has_pdbx_distant_solvent_atoms>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_domainCategory/VRPTx:pdbx_domain">
      <VRPTo:has_pdbx_domain>
      <VRPTo:pdbx_domain rdf:about="{$base}/pdbx_domain/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_domain>
      </VRPTo:has_pdbx_domain>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_domain_rangeCategory/VRPTx:pdbx_domain_range">
      <VRPTo:has_pdbx_domain_range>
      <VRPTo:pdbx_domain_range rdf:about="{$base}/pdbx_domain_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@domain_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@domain_id!=''">
        <VRPTo:reference_to_pdbx_domain>
	  <rdf:Description  rdf:about="{$base}/pdbx_domain/{translate(@domain_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_domain_range rdf:resource="{$base}/pdbx_domain_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@domain_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_domain>
        <!-- pdbx_domainKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_domain_range>
      </VRPTo:has_pdbx_domain_range>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_atom_inclusionCategory/VRPTx:pdbx_em_atom_inclusion">
      <VRPTo:has_pdbx_em_atom_inclusion>
      <VRPTo:pdbx_em_atom_inclusion rdf:about="{$base}/pdbx_em_atom_inclusion/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_atom_inclusion>
      </VRPTo:has_pdbx_em_atom_inclusion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_atom_inclusion_markerCategory/VRPTx:pdbx_em_atom_inclusion_marker">
      <VRPTo:has_pdbx_em_atom_inclusion_marker>
      <VRPTo:pdbx_em_atom_inclusion_marker rdf:about="{$base}/pdbx_em_atom_inclusion_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <VRPTo:reference_to_pdbx_em_atom_inclusion>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_atom_inclusion/{translate(@plot_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_atom_inclusion_marker rdf:resource="{$base}/pdbx_em_atom_inclusion_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_atom_inclusion>
        <!-- pdbx_em_atom_inclusionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_atom_inclusion_marker>
      </VRPTo:has_pdbx_em_atom_inclusion_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_density_distributionCategory/VRPTx:pdbx_em_density_distribution">
      <VRPTo:has_pdbx_em_density_distribution>
      <VRPTo:pdbx_em_density_distribution rdf:about="{$base}/pdbx_em_density_distribution/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_density_distribution>
      </VRPTo:has_pdbx_em_density_distribution>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_density_distribution_markerCategory/VRPTx:pdbx_em_density_distribution_marker">
      <VRPTo:has_pdbx_em_density_distribution_marker>
      <VRPTo:pdbx_em_density_distribution_marker rdf:about="{$base}/pdbx_em_density_distribution_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <VRPTo:reference_to_pdbx_em_density_distribution>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_density_distribution/{translate(@plot_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_density_distribution_marker rdf:resource="{$base}/pdbx_em_density_distribution_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_density_distribution>
        <!-- pdbx_em_density_distributionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_density_distribution_marker>
      </VRPTo:has_pdbx_em_density_distribution_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_curveCategory/VRPTx:pdbx_em_fsc_curve">
      <VRPTo:has_pdbx_em_fsc_curve>
      <VRPTo:pdbx_em_fsc_curve rdf:about="{$base}/pdbx_em_fsc_curve/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_fsc_curve>
      </VRPTo:has_pdbx_em_fsc_curve>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_curve_markerCategory/VRPTx:pdbx_em_fsc_curve_marker">
      <VRPTo:has_pdbx_em_fsc_curve_marker>
      <VRPTo:pdbx_em_fsc_curve_marker rdf:about="{$base}/pdbx_em_fsc_curve_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <VRPTo:reference_to_pdbx_em_fsc_curve>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_fsc_curve/{translate(@plot_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_fsc_curve_marker rdf:resource="{$base}/pdbx_em_fsc_curve_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_fsc_curve>
        <!-- pdbx_em_fsc_curveKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_fsc_curve_marker>
      </VRPTo:has_pdbx_em_fsc_curve_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_cutoff_curveCategory/VRPTx:pdbx_em_fsc_cutoff_curve">
      <VRPTo:has_pdbx_em_fsc_cutoff_curve>
      <VRPTo:pdbx_em_fsc_cutoff_curve rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_fsc_cutoff_curve>
      </VRPTo:has_pdbx_em_fsc_cutoff_curve>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_cutoff_curve_markerCategory/VRPTx:pdbx_em_fsc_cutoff_curve_marker">
      <VRPTo:has_pdbx_em_fsc_cutoff_curve_marker>
      <VRPTo:pdbx_em_fsc_cutoff_curve_marker rdf:about="{$base}/pdbx_em_fsc_cutoff_curve_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <VRPTo:reference_to_pdbx_em_fsc_cutoff_curve>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/{translate(@plot_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_fsc_cutoff_curve_marker rdf:resource="{$base}/pdbx_em_fsc_cutoff_curve_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_fsc_cutoff_curve>
        <!-- pdbx_em_fsc_cutoff_curveKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_fsc_cutoff_curve_marker>
      </VRPTo:has_pdbx_em_fsc_cutoff_curve_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_resolutionCategory/VRPTx:pdbx_em_fsc_resolution">
      <VRPTo:has_pdbx_em_fsc_resolution>
      <VRPTo:pdbx_em_fsc_resolution rdf:about="{$base}/pdbx_em_fsc_resolution/{translate(@criterion,' ^','_')},{translate(@source,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:fsc_curve_id!=''">
        <VRPTo:reference_to_pdbx_em_fsc_curve>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_fsc_curve/{translate(VRPTx:fsc_curve_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_fsc_resolution rdf:resource="{$base}/pdbx_em_fsc_resolution/{translate(@criterion,' ^','_')},{translate(@source,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_fsc_curve>
        <!-- pdbx_em_fsc_curveKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="VRPTx:fsc_cutoff_curve_id!=''">
        <VRPTo:reference_to_pdbx_em_fsc_cutoff_curve>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/{translate(VRPTx:fsc_cutoff_curve_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_fsc_resolution rdf:resource="{$base}/pdbx_em_fsc_resolution/{translate(@criterion,' ^','_')},{translate(@source,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_fsc_cutoff_curve>
        <!-- pdbx_em_fsc_cutoff_curveKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_fsc_resolution>
      </VRPTo:has_pdbx_em_fsc_resolution>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_rapsCategory/VRPTx:pdbx_em_raps">
      <VRPTo:has_pdbx_em_raps>
      <VRPTo:pdbx_em_raps rdf:about="{$base}/pdbx_em_raps/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_raps>
      </VRPTo:has_pdbx_em_raps>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_raps_markerCategory/VRPTx:pdbx_em_raps_marker">
      <VRPTo:has_pdbx_em_raps_marker>
      <VRPTo:pdbx_em_raps_marker rdf:about="{$base}/pdbx_em_raps_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <VRPTo:reference_to_pdbx_em_raps>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_raps/{translate(@plot_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_raps_marker rdf:resource="{$base}/pdbx_em_raps_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_raps>
        <!-- pdbx_em_rapsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_raps_marker>
      </VRPTo:has_pdbx_em_raps_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_raw_rapsCategory/VRPTx:pdbx_em_raw_raps">
      <VRPTo:has_pdbx_em_raw_raps>
      <VRPTo:pdbx_em_raw_raps rdf:about="{$base}/pdbx_em_raw_raps/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_raw_raps>
      </VRPTo:has_pdbx_em_raw_raps>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_raw_raps_markerCategory/VRPTx:pdbx_em_raw_raps_marker">
      <VRPTo:has_pdbx_em_raw_raps_marker>
      <VRPTo:pdbx_em_raw_raps_marker rdf:about="{$base}/pdbx_em_raw_raps_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <VRPTo:reference_to_pdbx_em_raw_raps>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_raw_raps/{translate(@plot_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_raw_raps_marker rdf:resource="{$base}/pdbx_em_raw_raps_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_raw_raps>
        <!-- pdbx_em_raw_rapsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_raw_raps_marker>
      </VRPTo:has_pdbx_em_raw_raps_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_validate_map_modelCategory/VRPTx:pdbx_em_validate_map_model">
      <VRPTo:has_pdbx_em_validate_map_model>
      <VRPTo:pdbx_em_validate_map_model rdf:about="{$base}/pdbx_em_validate_map_model/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_validate_map_model>
      </VRPTo:has_pdbx_em_validate_map_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_validate_map_model_entityCategory/VRPTx:pdbx_em_validate_map_model_entity">
      <VRPTo:has_pdbx_em_validate_map_model_entity>
      <VRPTo:pdbx_em_validate_map_model_entity rdf:about="{$base}/pdbx_em_validate_map_model_entity/{translate(@PDB_model_num,' ^','_')},{translate(@label_asym_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_validate_map_model_entity>
      </VRPTo:has_pdbx_em_validate_map_model_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_validate_map_model_overallCategory/VRPTx:pdbx_em_validate_map_model_overall">
      <VRPTo:has_pdbx_em_validate_map_model_overall>
      <VRPTo:pdbx_em_validate_map_model_overall rdf:about="{$base}/pdbx_em_validate_map_model_overall/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_validate_map_model_overall rdf:resource="{$base}/pdbx_em_validate_map_model_overall/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_15_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_validate_map_model_overall>
      </VRPTo:has_pdbx_em_validate_map_model_overall>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_volume_estimateCategory/VRPTx:pdbx_em_volume_estimate">
      <VRPTo:has_pdbx_em_volume_estimate>
      <VRPTo:pdbx_em_volume_estimate rdf:about="{$base}/pdbx_em_volume_estimate/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_volume_estimate>
      </VRPTo:has_pdbx_em_volume_estimate>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_volume_estimate_markerCategory/VRPTx:pdbx_em_volume_estimate_marker">
      <VRPTo:has_pdbx_em_volume_estimate_marker>
      <VRPTo:pdbx_em_volume_estimate_marker rdf:about="{$base}/pdbx_em_volume_estimate_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
        <VRPTo:reference_to_pdbx_em_volume_estimate>
	  <rdf:Description  rdf:about="{$base}/pdbx_em_volume_estimate/{translate(@plot_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_em_volume_estimate_marker rdf:resource="{$base}/pdbx_em_volume_estimate_marker/{translate(@ordinal,' ^','_')},{translate(@plot_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_em_volume_estimate>
        <!-- pdbx_em_volume_estimateKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_em_volume_estimate_marker>
      </VRPTo:has_pdbx_em_volume_estimate_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_assemblyCategory/VRPTx:pdbx_entity_assembly">
      <VRPTo:has_pdbx_entity_assembly>
      <VRPTo:pdbx_entity_assembly rdf:about="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entity_assembly rdf:resource="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:if test="VRPTx:biol_id!=''">
        <VRPTo:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(VRPTx:biol_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entity_assembly rdf:resource="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entity_assembly>
      </VRPTo:has_pdbx_entity_assembly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_branchCategory/VRPTx:pdbx_entity_branch">
      <VRPTo:has_pdbx_entity_branch>
      <VRPTo:pdbx_entity_branch rdf:about="{$base}/pdbx_entity_branch/{translate(@entity_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entity_branch rdf:resource="{$base}/pdbx_entity_branch/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entity_branch>
      </VRPTo:has_pdbx_entity_branch>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_branch_descriptorCategory/VRPTx:pdbx_entity_branch_descriptor">
      <VRPTo:has_pdbx_entity_branch_descriptor>
      <VRPTo:pdbx_entity_branch_descriptor rdf:about="{$base}/pdbx_entity_branch_descriptor/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(VRPTx:entity_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entity_branch_descriptor rdf:resource="{$base}/pdbx_entity_branch_descriptor/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entity_branch_descriptor>
      </VRPTo:has_pdbx_entity_branch_descriptor>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_branch_linkCategory/VRPTx:pdbx_entity_branch_link">
      <VRPTo:has_pdbx_entity_branch_link>
      <VRPTo:pdbx_entity_branch_link rdf:about="{$base}/pdbx_entity_branch_link/{translate(@link_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entity_branch_link>
      </VRPTo:has_pdbx_entity_branch_link>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_branch_listCategory/VRPTx:pdbx_entity_branch_list">
      <VRPTo:has_pdbx_entity_branch_list>
      <VRPTo:pdbx_entity_branch_list rdf:about="{$base}/pdbx_entity_branch_list/{translate(@comp_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@num,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entity_branch_list rdf:resource="{$base}/pdbx_entity_branch_list/{translate(@comp_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entity_branch_list>
      </VRPTo:has_pdbx_entity_branch_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_descriptorCategory/VRPTx:pdbx_entity_descriptor">
      <VRPTo:has_pdbx_entity_descriptor>
      <VRPTo:pdbx_entity_descriptor rdf:about="{$base}/pdbx_entity_descriptor/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(VRPTx:entity_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entity_descriptor rdf:resource="{$base}/pdbx_entity_descriptor/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entity_descriptor>
      </VRPTo:has_pdbx_entity_descriptor>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_nonpolyCategory/VRPTx:pdbx_entity_nonpoly">
      <VRPTo:has_pdbx_entity_nonpoly>
      <VRPTo:pdbx_entity_nonpoly rdf:about="{$base}/pdbx_entity_nonpoly/{translate(@entity_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entity_nonpoly rdf:resource="{$base}/pdbx_entity_nonpoly/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entity_nonpoly>
      </VRPTo:has_pdbx_entity_nonpoly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_poly_comp_link_listCategory/VRPTx:pdbx_entity_poly_comp_link_list">
      <VRPTo:has_pdbx_entity_poly_comp_link_list>
      <VRPTo:pdbx_entity_poly_comp_link_list rdf:about="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!='' and VRPTx:comp_id_1!='' and VRPTx:entity_comp_num_1!=''">
        <VRPTo:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(VRPTx:entity_id,' ^','_')},{translate(VRPTx:comp_id_1,' ^','_')},{translate(VRPTx:entity_comp_num_1,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entity_poly_comp_link_list rdf:resource="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entity_poly_comp_link_list>
      </VRPTo:has_pdbx_entity_poly_comp_link_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entry_detailsCategory/VRPTx:pdbx_entry_details">
      <VRPTo:has_pdbx_entry_details>
      <VRPTo:pdbx_entry_details rdf:about="{$base}/pdbx_entry_details/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_entry_details rdf:resource="{$base}/pdbx_entry_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_16_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_entry_details>
      </VRPTo:has_pdbx_entry_details>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_helical_symmetryCategory/VRPTx:pdbx_helical_symmetry">
      <VRPTo:has_pdbx_helical_symmetry>
      <VRPTo:pdbx_helical_symmetry rdf:about="{$base}/pdbx_helical_symmetry/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_helical_symmetry rdf:resource="{$base}/pdbx_helical_symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_17_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_helical_symmetry>
      </VRPTo:has_pdbx_helical_symmetry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_missing_nmr_star_itemCategory/VRPTx:pdbx_missing_nmr_star_item">
      <VRPTo:has_pdbx_missing_nmr_star_item>
      <VRPTo:pdbx_missing_nmr_star_item rdf:about="{$base}/pdbx_missing_nmr_star_item/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_missing_nmr_star_item rdf:resource="{$base}/pdbx_missing_nmr_star_item/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_missing_nmr_star_item>
      </VRPTo:has_pdbx_missing_nmr_star_item>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_assigned_chem_shift_listCategory/VRPTx:pdbx_nmr_assigned_chem_shift_list">
      <VRPTo:has_pdbx_nmr_assigned_chem_shift_list>
      <VRPTo:pdbx_nmr_assigned_chem_shift_list rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_assigned_chem_shift_list>
      </VRPTo:has_pdbx_nmr_assigned_chem_shift_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_chem_shift_annotationCategory/VRPTx:pdbx_nmr_chem_shift_annotation">
      <VRPTo:has_pdbx_nmr_chem_shift_annotation>
      <VRPTo:pdbx_nmr_chem_shift_annotation rdf:about="{$base}/pdbx_nmr_chem_shift_annotation/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_chem_shift_annotation rdf:resource="{$base}/pdbx_nmr_chem_shift_annotation/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_chem_shift_annotation>
      </VRPTo:has_pdbx_nmr_chem_shift_annotation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_chem_shift_completenessCategory/VRPTx:pdbx_nmr_chem_shift_completeness">
      <VRPTo:has_pdbx_nmr_chem_shift_completeness>
      <VRPTo:pdbx_nmr_chem_shift_completeness rdf:about="{$base}/pdbx_nmr_chem_shift_completeness/{translate(@atom_group,' ^','_')},{translate(@atom_type,' ^','_')},{translate(@list_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_chem_shift_completeness rdf:resource="{$base}/pdbx_nmr_chem_shift_completeness/{translate(@atom_group,' ^','_')},{translate(@atom_type,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_chem_shift_completeness>
      </VRPTo:has_pdbx_nmr_chem_shift_completeness>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_chem_shift_re_offsetCategory/VRPTx:pdbx_nmr_chem_shift_re_offset">
      <VRPTo:has_pdbx_nmr_chem_shift_re_offset>
      <VRPTo:pdbx_nmr_chem_shift_re_offset rdf:about="{$base}/pdbx_nmr_chem_shift_re_offset/{translate(@atom_type,' ^','_')},{translate(@list_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_chem_shift_re_offset rdf:resource="{$base}/pdbx_nmr_chem_shift_re_offset/{translate(@atom_type,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_chem_shift_re_offset>
      </VRPTo:has_pdbx_nmr_chem_shift_re_offset>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_constraintsCategory/VRPTx:pdbx_nmr_constraints">
      <VRPTo:has_pdbx_nmr_constraints>
      <VRPTo:pdbx_nmr_constraints rdf:about="{$base}/pdbx_nmr_constraints/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_constraints rdf:resource="{$base}/pdbx_nmr_constraints/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_18_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_constraints>
      </VRPTo:has_pdbx_nmr_constraints>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_detailsCategory/VRPTx:pdbx_nmr_details">
      <VRPTo:has_pdbx_nmr_details>
      <VRPTo:pdbx_nmr_details rdf:about="{$base}/pdbx_nmr_details/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_details rdf:resource="{$base}/pdbx_nmr_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_19_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_details>
      </VRPTo:has_pdbx_nmr_details>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violationCategory/VRPTx:pdbx_nmr_dihedral_angle_violation">
      <VRPTo:has_pdbx_nmr_dihedral_angle_violation>
      <VRPTo:pdbx_nmr_dihedral_angle_violation rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_dihedral_angle_violation>
      </VRPTo:has_pdbx_nmr_dihedral_angle_violation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violation_ensembleCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_ensemble">
      <VRPTo:has_pdbx_nmr_dihedral_angle_violation_ensemble>
      <VRPTo:pdbx_nmr_dihedral_angle_violation_ensemble rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_ensemble/{translate(@fraction_ensemble_size,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_dihedral_angle_violation_ensemble>
      </VRPTo:has_pdbx_nmr_dihedral_angle_violation_ensemble>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violation_modelCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_model">
      <VRPTo:has_pdbx_nmr_dihedral_angle_violation_model>
      <VRPTo:pdbx_nmr_dihedral_angle_violation_model rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_model/{translate(@PDB_model_num,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_dihedral_angle_violation_model>
      </VRPTo:has_pdbx_nmr_dihedral_angle_violation_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violation_pluralCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_plural">
      <VRPTo:has_pdbx_nmr_dihedral_angle_violation_plural>
      <VRPTo:pdbx_nmr_dihedral_angle_violation_plural rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_plural/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_dihedral_angle_violation_plural>
      </VRPTo:has_pdbx_nmr_dihedral_angle_violation_plural>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violation_summaryCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_summary">
      <VRPTo:has_pdbx_nmr_dihedral_angle_violation_summary>
      <VRPTo:pdbx_nmr_dihedral_angle_violation_summary rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_summary/{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_dihedral_angle_violation_summary>
      </VRPTo:has_pdbx_nmr_dihedral_angle_violation_summary>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violationCategory/VRPTx:pdbx_nmr_distance_violation">
      <VRPTo:has_pdbx_nmr_distance_violation>
      <VRPTo:pdbx_nmr_distance_violation rdf:about="{$base}/pdbx_nmr_distance_violation/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_distance_violation>
      </VRPTo:has_pdbx_nmr_distance_violation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violation_ensembleCategory/VRPTx:pdbx_nmr_distance_violation_ensemble">
      <VRPTo:has_pdbx_nmr_distance_violation_ensemble>
      <VRPTo:pdbx_nmr_distance_violation_ensemble rdf:about="{$base}/pdbx_nmr_distance_violation_ensemble/{translate(@fraction_ensemble_size,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_distance_violation_ensemble>
      </VRPTo:has_pdbx_nmr_distance_violation_ensemble>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violation_modelCategory/VRPTx:pdbx_nmr_distance_violation_model">
      <VRPTo:has_pdbx_nmr_distance_violation_model>
      <VRPTo:pdbx_nmr_distance_violation_model rdf:about="{$base}/pdbx_nmr_distance_violation_model/{translate(@PDB_model_num,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_distance_violation_model>
      </VRPTo:has_pdbx_nmr_distance_violation_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violation_pluralCategory/VRPTx:pdbx_nmr_distance_violation_plural">
      <VRPTo:has_pdbx_nmr_distance_violation_plural>
      <VRPTo:pdbx_nmr_distance_violation_plural rdf:about="{$base}/pdbx_nmr_distance_violation_plural/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_distance_violation_plural>
      </VRPTo:has_pdbx_nmr_distance_violation_plural>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violation_summaryCategory/VRPTx:pdbx_nmr_distance_violation_summary">
      <VRPTo:has_pdbx_nmr_distance_violation_summary>
      <VRPTo:pdbx_nmr_distance_violation_summary rdf:about="{$base}/pdbx_nmr_distance_violation_summary/{translate(@subtype,' ^','_')},{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_distance_violation_summary>
      </VRPTo:has_pdbx_nmr_distance_violation_summary>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_ensembleCategory/VRPTx:pdbx_nmr_ensemble">
      <VRPTo:has_pdbx_nmr_ensemble>
      <VRPTo:pdbx_nmr_ensemble rdf:about="{$base}/pdbx_nmr_ensemble/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_ensemble rdf:resource="{$base}/pdbx_nmr_ensemble/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_20_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_ensemble>
      </VRPTo:has_pdbx_nmr_ensemble>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_ensemble_rmsCategory/VRPTx:pdbx_nmr_ensemble_rms">
      <VRPTo:has_pdbx_nmr_ensemble_rms>
      <VRPTo:pdbx_nmr_ensemble_rms rdf:about="{$base}/pdbx_nmr_ensemble_rms/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_ensemble_rms rdf:resource="{$base}/pdbx_nmr_ensemble_rms/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_21_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_ensemble_rms>
      </VRPTo:has_pdbx_nmr_ensemble_rms>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_exptlCategory/VRPTx:pdbx_nmr_exptl">
      <VRPTo:has_pdbx_nmr_exptl>
      <VRPTo:pdbx_nmr_exptl rdf:about="{$base}/pdbx_nmr_exptl/{translate(@conditions_id,' ^','_')},{translate(@experiment_id,' ^','_')},{translate(@solution_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_exptl>
      </VRPTo:has_pdbx_nmr_exptl>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_exptl_sampleCategory/VRPTx:pdbx_nmr_exptl_sample">
      <VRPTo:has_pdbx_nmr_exptl_sample>
      <VRPTo:pdbx_nmr_exptl_sample rdf:about="{$base}/pdbx_nmr_exptl_sample/{translate(@component,' ^','_')},{translate(@solution_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_exptl_sample>
      </VRPTo:has_pdbx_nmr_exptl_sample>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_exptl_sample_conditionsCategory/VRPTx:pdbx_nmr_exptl_sample_conditions">
      <VRPTo:has_pdbx_nmr_exptl_sample_conditions>
      <VRPTo:pdbx_nmr_exptl_sample_conditions rdf:about="{$base}/pdbx_nmr_exptl_sample_conditions/{translate(@conditions_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_exptl_sample_conditions>
      </VRPTo:has_pdbx_nmr_exptl_sample_conditions>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_force_constantsCategory/VRPTx:pdbx_nmr_force_constants">
      <VRPTo:has_pdbx_nmr_force_constants>
      <VRPTo:pdbx_nmr_force_constants rdf:about="{$base}/pdbx_nmr_force_constants/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_force_constants rdf:resource="{$base}/pdbx_nmr_force_constants/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_22_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_force_constants>
      </VRPTo:has_pdbx_nmr_force_constants>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_refineCategory/VRPTx:pdbx_nmr_refine">
      <VRPTo:has_pdbx_nmr_refine>
      <VRPTo:pdbx_nmr_refine rdf:about="{$base}/pdbx_nmr_refine/{translate(@entry_id,' ^','_')},{translate(@software_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_refine rdf:resource="{$base}/pdbx_nmr_refine/{translate(@entry_id,' ^','_')},{translate(@software_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_23_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_refine>
      </VRPTo:has_pdbx_nmr_refine>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_representativeCategory/VRPTx:pdbx_nmr_representative">
      <VRPTo:has_pdbx_nmr_representative>
      <VRPTo:pdbx_nmr_representative rdf:about="{$base}/pdbx_nmr_representative/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_representative rdf:resource="{$base}/pdbx_nmr_representative/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_24_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_representative>
      </VRPTo:has_pdbx_nmr_representative>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_restraint_listCategory/VRPTx:pdbx_nmr_restraint_list">
      <VRPTo:has_pdbx_nmr_restraint_list>
      <VRPTo:pdbx_nmr_restraint_list rdf:about="{$base}/pdbx_nmr_restraint_list/{translate(@id,' ^','_')},{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_restraint_list>
      </VRPTo:has_pdbx_nmr_restraint_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_restraint_summaryCategory/VRPTx:pdbx_nmr_restraint_summary">
      <VRPTo:has_pdbx_nmr_restraint_summary>
      <VRPTo:pdbx_nmr_restraint_summary rdf:about="{$base}/pdbx_nmr_restraint_summary/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_restraint_summary rdf:resource="{$base}/pdbx_nmr_restraint_summary/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_25_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_restraint_summary>
      </VRPTo:has_pdbx_nmr_restraint_summary>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_restraint_violationCategory/VRPTx:pdbx_nmr_restraint_violation">
      <VRPTo:has_pdbx_nmr_restraint_violation>
      <VRPTo:pdbx_nmr_restraint_violation rdf:about="{$base}/pdbx_nmr_restraint_violation/{translate(@ordinal,' ^','_')},{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_restraint_violation>
      </VRPTo:has_pdbx_nmr_restraint_violation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_softwareCategory/VRPTx:pdbx_nmr_software">
      <VRPTo:has_pdbx_nmr_software>
      <VRPTo:pdbx_nmr_software rdf:about="{$base}/pdbx_nmr_software/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_software>
      </VRPTo:has_pdbx_nmr_software>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_spectrometerCategory/VRPTx:pdbx_nmr_spectrometer">
      <VRPTo:has_pdbx_nmr_spectrometer>
      <VRPTo:pdbx_nmr_spectrometer rdf:about="{$base}/pdbx_nmr_spectrometer/{translate(@spectrometer_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_spectrometer>
      </VRPTo:has_pdbx_nmr_spectrometer>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_unmapped_chem_shiftCategory/VRPTx:pdbx_nmr_unmapped_chem_shift">
      <VRPTo:has_pdbx_nmr_unmapped_chem_shift>
      <VRPTo:pdbx_nmr_unmapped_chem_shift rdf:about="{$base}/pdbx_nmr_unmapped_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_unmapped_chem_shift rdf:resource="{$base}/pdbx_nmr_unmapped_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_unmapped_chem_shift>
      </VRPTo:has_pdbx_nmr_unmapped_chem_shift>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_unparsed_chem_shiftCategory/VRPTx:pdbx_nmr_unparsed_chem_shift">
      <VRPTo:has_pdbx_nmr_unparsed_chem_shift>
      <VRPTo:pdbx_nmr_unparsed_chem_shift rdf:about="{$base}/pdbx_nmr_unparsed_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_nmr_unparsed_chem_shift rdf:resource="{$base}/pdbx_nmr_unparsed_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nmr_unparsed_chem_shift>
      </VRPTo:has_pdbx_nmr_unparsed_chem_shift>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nonpoly_schemeCategory/VRPTx:pdbx_nonpoly_scheme">
      <VRPTo:has_pdbx_nonpoly_scheme>
      <VRPTo:pdbx_nonpoly_scheme rdf:about="{$base}/pdbx_nonpoly_scheme/{translate(@asym_id,' ^','_')},{translate(@ndb_seq_num,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_nonpoly_scheme>
      </VRPTo:has_pdbx_nonpoly_scheme>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions">
      <VRPTo:has_pdbx_percentile_conditions>
      <VRPTo:pdbx_percentile_conditions rdf:about="{$base}/pdbx_percentile_conditions/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_percentile_conditions>
      </VRPTo:has_pdbx_percentile_conditions>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_percentile_entity_viewCategory/VRPTx:pdbx_percentile_entity_view">
      <VRPTo:has_pdbx_percentile_entity_view>
      <VRPTo:pdbx_percentile_entity_view rdf:about="{$base}/pdbx_percentile_entity_view/{translate(@PDB_model_num,' ^','_')},{translate(@conditions_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@conditions_id!=''">
        <VRPTo:reference_to_pdbx_percentile_conditions>
	  <rdf:Description  rdf:about="{$base}/pdbx_percentile_conditions/{translate(@conditions_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_percentile_entity_view rdf:resource="{$base}/pdbx_percentile_entity_view/{translate(@PDB_model_num,' ^','_')},{translate(@conditions_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_percentile_conditions>
        <!-- pdbx_percentile_conditionsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_percentile_entity_view>
      </VRPTo:has_pdbx_percentile_entity_view>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_percentile_listCategory/VRPTx:pdbx_percentile_list">
      <VRPTo:has_pdbx_percentile_list>
      <VRPTo:pdbx_percentile_list rdf:about="{$base}/pdbx_percentile_list/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_percentile_list rdf:resource="{$base}/pdbx_percentile_list/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_26_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_percentile_list>
      </VRPTo:has_pdbx_percentile_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_percentile_viewCategory/VRPTx:pdbx_percentile_view">
      <VRPTo:has_pdbx_percentile_view>
      <VRPTo:pdbx_percentile_view rdf:about="{$base}/pdbx_percentile_view/{translate(@conditions_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_percentile_view rdf:resource="{$base}/pdbx_percentile_view/{translate(@conditions_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_27_0 -->
      </xsl:if>
      <xsl:if test="@conditions_id!=''">
        <VRPTo:reference_to_pdbx_percentile_conditions>
	  <rdf:Description  rdf:about="{$base}/pdbx_percentile_conditions/{translate(@conditions_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_percentile_view rdf:resource="{$base}/pdbx_percentile_view/{translate(@conditions_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_percentile_conditions>
        <!-- pdbx_percentile_conditionsKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_percentile_view>
      </VRPTo:has_pdbx_percentile_view>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MAD_setCategory/VRPTx:pdbx_phasing_MAD_set">
      <VRPTo:has_pdbx_phasing_MAD_set>
      <VRPTo:pdbx_phasing_MAD_set rdf:about="{$base}/pdbx_phasing_MAD_set/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_phasing_MAD_set>
      </VRPTo:has_pdbx_phasing_MAD_set>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MAD_set_shellCategory/VRPTx:pdbx_phasing_MAD_set_shell">
      <VRPTo:has_pdbx_phasing_MAD_set_shell>
      <VRPTo:pdbx_phasing_MAD_set_shell rdf:about="{$base}/pdbx_phasing_MAD_set_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_phasing_MAD_set_shell>
      </VRPTo:has_pdbx_phasing_MAD_set_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MAD_set_siteCategory/VRPTx:pdbx_phasing_MAD_set_site">
      <VRPTo:has_pdbx_phasing_MAD_set_site>
      <VRPTo:pdbx_phasing_MAD_set_site rdf:about="{$base}/pdbx_phasing_MAD_set_site/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_phasing_MAD_set_site>
      </VRPTo:has_pdbx_phasing_MAD_set_site>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MAD_shellCategory/VRPTx:pdbx_phasing_MAD_shell">
      <VRPTo:has_pdbx_phasing_MAD_shell>
      <VRPTo:pdbx_phasing_MAD_shell rdf:about="{$base}/pdbx_phasing_MAD_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_phasing_MAD_shell>
      </VRPTo:has_pdbx_phasing_MAD_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MRCategory/VRPTx:pdbx_phasing_MR">
      <VRPTo:has_pdbx_phasing_MR>
      <VRPTo:pdbx_phasing_MR rdf:about="{$base}/pdbx_phasing_MR/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_phasing_MR>
      </VRPTo:has_pdbx_phasing_MR>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_dmCategory/VRPTx:pdbx_phasing_dm">
      <VRPTo:has_pdbx_phasing_dm>
      <VRPTo:pdbx_phasing_dm rdf:about="{$base}/pdbx_phasing_dm/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_phasing_dm>
      </VRPTo:has_pdbx_phasing_dm>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_dm_shellCategory/VRPTx:pdbx_phasing_dm_shell">
      <VRPTo:has_pdbx_phasing_dm_shell>
      <VRPTo:pdbx_phasing_dm_shell rdf:about="{$base}/pdbx_phasing_dm_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_phasing_dm_shell>
      </VRPTo:has_pdbx_phasing_dm_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_point_symmetryCategory/VRPTx:pdbx_point_symmetry">
      <VRPTo:has_pdbx_point_symmetry>
      <VRPTo:pdbx_point_symmetry rdf:about="{$base}/pdbx_point_symmetry/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_point_symmetry rdf:resource="{$base}/pdbx_point_symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_28_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_point_symmetry>
      </VRPTo:has_pdbx_point_symmetry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_poly_seq_schemeCategory/VRPTx:pdbx_poly_seq_scheme">
      <VRPTo:has_pdbx_poly_seq_scheme>
      <VRPTo:pdbx_poly_seq_scheme rdf:about="{$base}/pdbx_poly_seq_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!='' and @mon_id!='' and @seq_id!=''">
        <VRPTo:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_poly_seq_scheme rdf:resource="{$base}/pdbx_poly_seq_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@entity_id!='' and @asym_id!=''">
        <VRPTo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@entity_id,' ^','_')},{translate(@asym_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_poly_seq_scheme rdf:resource="{$base}/pdbx_poly_seq_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@seq_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_asym>
        <!-- struct_asymKeyref_1_1_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_poly_seq_scheme>
      </VRPTo:has_pdbx_poly_seq_scheme>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_re_refinementCategory/VRPTx:pdbx_re_refinement">
      <VRPTo:has_pdbx_re_refinement>
      <VRPTo:pdbx_re_refinement rdf:about="{$base}/pdbx_re_refinement/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_re_refinement>
      </VRPTo:has_pdbx_re_refinement>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refineCategory/VRPTx:pdbx_refine">
      <VRPTo:has_pdbx_refine>
      <VRPTo:pdbx_refine rdf:about="{$base}/pdbx_refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_refine rdf:resource="{$base}/pdbx_refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_29_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_refine>
      </VRPTo:has_pdbx_refine>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refine_componentCategory/VRPTx:pdbx_refine_component">
      <VRPTo:has_pdbx_refine_component>
      <VRPTo:pdbx_refine_component rdf:about="{$base}/pdbx_refine_component/{translate(@label_alt_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@label_comp_id,' ^','_')},{translate(@label_seq_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_refine_component>
      </VRPTo:has_pdbx_refine_component>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refine_tlsCategory/VRPTx:pdbx_refine_tls">
      <VRPTo:has_pdbx_refine_tls>
      <VRPTo:pdbx_refine_tls rdf:about="{$base}/pdbx_refine_tls/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_refine_tls>
      </VRPTo:has_pdbx_refine_tls>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refine_tls_groupCategory/VRPTx:pdbx_refine_tls_group">
      <VRPTo:has_pdbx_refine_tls_group>
      <VRPTo:pdbx_refine_tls_group rdf:about="{$base}/pdbx_refine_tls_group/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:refine_tls_id!=''">
        <VRPTo:reference_to_pdbx_refine_tls>
	  <rdf:Description  rdf:about="{$base}/pdbx_refine_tls/{translate(VRPTx:refine_tls_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_refine_tls_group rdf:resource="{$base}/pdbx_refine_tls_group/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_refine_tls>
        <!-- pdbx_refine_tlsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_refine_tls_group>
      </VRPTo:has_pdbx_refine_tls_group>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refln_signal_binningCategory/VRPTx:pdbx_refln_signal_binning">
      <VRPTo:has_pdbx_refln_signal_binning>
      <VRPTo:pdbx_refln_signal_binning rdf:about="{$base}/pdbx_refln_signal_binning/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_refln_signal_binning>
      </VRPTo:has_pdbx_refln_signal_binning>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_reflns_twinCategory/VRPTx:pdbx_reflns_twin">
      <VRPTo:has_pdbx_reflns_twin>
      <VRPTo:pdbx_reflns_twin rdf:about="{$base}/pdbx_reflns_twin/{translate(@crystal_id,' ^','_')},{translate(@diffrn_id,' ^','_')},{translate(@operator,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_reflns_twin>
      </VRPTo:has_pdbx_reflns_twin>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_sequence_rangeCategory/VRPTx:pdbx_sequence_range">
      <VRPTo:has_pdbx_sequence_range>
      <VRPTo:pdbx_sequence_range rdf:about="{$base}/pdbx_sequence_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')},{translate(@seq_range_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_sequence_range>
      </VRPTo:has_pdbx_sequence_range>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_sifts_unp_segmentsCategory/VRPTx:pdbx_sifts_unp_segments">
      <VRPTo:has_pdbx_sifts_unp_segments>
      <VRPTo:pdbx_sifts_unp_segments rdf:about="{$base}/pdbx_sifts_unp_segments/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@segment_id,' ^','_')},{translate(@unp_acc,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
        <VRPTo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_sifts_unp_segments rdf:resource="{$base}/pdbx_sifts_unp_segments/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@segment_id,' ^','_')},{translate(@unp_acc,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_asym>
        <!-- struct_asymKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_sifts_unp_segments>
      </VRPTo:has_pdbx_sifts_unp_segments>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_sifts_xref_dbCategory/VRPTx:pdbx_sifts_xref_db">
      <VRPTo:has_pdbx_sifts_xref_db>
      <VRPTo:pdbx_sifts_xref_db rdf:about="{$base}/pdbx_sifts_xref_db/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@seq_id,' ^','_')},{translate(@seq_id_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
        <VRPTo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_sifts_xref_db rdf:resource="{$base}/pdbx_sifts_xref_db/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@seq_id,' ^','_')},{translate(@seq_id_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_asym>
        <!-- struct_asymKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_sifts_xref_db>
      </VRPTo:has_pdbx_sifts_xref_db>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_sifts_xref_db_segmentsCategory/VRPTx:pdbx_sifts_xref_db_segments">
      <VRPTo:has_pdbx_sifts_xref_db_segments>
      <VRPTo:pdbx_sifts_xref_db_segments rdf:about="{$base}/pdbx_sifts_xref_db_segments/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@segment_id,' ^','_')},{translate(@xref_db,' ^','_')},{translate(@xref_db_acc,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
        <VRPTo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_sifts_xref_db_segments rdf:resource="{$base}/pdbx_sifts_xref_db_segments/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@segment_id,' ^','_')},{translate(@xref_db,' ^','_')},{translate(@xref_db_acc,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_asym>
        <!-- struct_asymKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_sifts_xref_db_segments>
      </VRPTo:has_pdbx_sifts_xref_db_segments>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_soln_scatterCategory/VRPTx:pdbx_soln_scatter">
      <VRPTo:has_pdbx_soln_scatter>
      <VRPTo:pdbx_soln_scatter rdf:about="{$base}/pdbx_soln_scatter/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_soln_scatter rdf:resource="{$base}/pdbx_soln_scatter/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_30_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_soln_scatter>
      </VRPTo:has_pdbx_soln_scatter>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_soln_scatter_modelCategory/VRPTx:pdbx_soln_scatter_model">
      <VRPTo:has_pdbx_soln_scatter_model>
      <VRPTo:pdbx_soln_scatter_model rdf:about="{$base}/pdbx_soln_scatter_model/{translate(@id,' ^','_')},{translate(@scatter_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_soln_scatter_model>
      </VRPTo:has_pdbx_soln_scatter_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_assemblyCategory/VRPTx:pdbx_struct_assembly">
      <VRPTo:has_pdbx_struct_assembly>
      <VRPTo:pdbx_struct_assembly rdf:about="{$base}/pdbx_struct_assembly/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_assembly>
      </VRPTo:has_pdbx_struct_assembly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_assembly_genCategory/VRPTx:pdbx_struct_assembly_gen">
      <VRPTo:has_pdbx_struct_assembly_gen>
      <VRPTo:pdbx_struct_assembly_gen rdf:about="{$base}/pdbx_struct_assembly_gen/{translate(@assembly_id,' ^','_')},{translate(@asym_id_list,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@assembly_id!=''">
        <VRPTo:reference_to_pdbx_struct_assembly>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_assembly/{translate(@assembly_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_struct_assembly_gen rdf:resource="{$base}/pdbx_struct_assembly_gen/{translate(@assembly_id,' ^','_')},{translate(@asym_id_list,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_struct_assembly>
        <!-- pdbx_struct_assemblyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_assembly_gen>
      </VRPTo:has_pdbx_struct_assembly_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_assembly_propCategory/VRPTx:pdbx_struct_assembly_prop">
      <VRPTo:has_pdbx_struct_assembly_prop>
      <VRPTo:pdbx_struct_assembly_prop rdf:about="{$base}/pdbx_struct_assembly_prop/{translate(@biol_id,' ^','_')},{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_assembly_prop>
      </VRPTo:has_pdbx_struct_assembly_prop>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_asym_genCategory/VRPTx:pdbx_struct_asym_gen">
      <VRPTo:has_pdbx_struct_asym_gen>
      <VRPTo:pdbx_struct_asym_gen rdf:about="{$base}/pdbx_struct_asym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_inst_id!=''">
        <VRPTo:reference_to_pdbx_struct_entity_inst>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@entity_inst_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_struct_asym_gen rdf:resource="{$base}/pdbx_struct_asym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_struct_entity_inst>
        <!-- pdbx_struct_entity_instKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_asym_gen>
      </VRPTo:has_pdbx_struct_asym_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_chem_comp_diagnosticsCategory/VRPTx:pdbx_struct_chem_comp_diagnostics">
      <VRPTo:has_pdbx_struct_chem_comp_diagnostics>
      <VRPTo:pdbx_struct_chem_comp_diagnostics rdf:about="{$base}/pdbx_struct_chem_comp_diagnostics/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_chem_comp_diagnostics>
      </VRPTo:has_pdbx_struct_chem_comp_diagnostics>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_conn_angleCategory/VRPTx:pdbx_struct_conn_angle">
      <VRPTo:has_pdbx_struct_conn_angle>
      <VRPTo:pdbx_struct_conn_angle rdf:about="{$base}/pdbx_struct_conn_angle/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_conn_angle>
      </VRPTo:has_pdbx_struct_conn_angle>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_entity_instCategory/VRPTx:pdbx_struct_entity_inst">
      <VRPTo:has_pdbx_struct_entity_inst>
      <VRPTo:pdbx_struct_entity_inst rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_entity_inst>
      </VRPTo:has_pdbx_struct_entity_inst>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_group_component_rangeCategory/VRPTx:pdbx_struct_group_component_range">
      <VRPTo:has_pdbx_struct_group_component_range>
      <VRPTo:pdbx_struct_group_component_range rdf:about="{$base}/pdbx_struct_group_component_range/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:struct_group_id!=''">
        <VRPTo:reference_to_pdbx_struct_group_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_group_list/{translate(VRPTx:struct_group_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_struct_group_component_range rdf:resource="{$base}/pdbx_struct_group_component_range/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_struct_group_list>
        <!-- pdbx_struct_group_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_group_component_range>
      </VRPTo:has_pdbx_struct_group_component_range>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_group_componentsCategory/VRPTx:pdbx_struct_group_components">
      <VRPTo:has_pdbx_struct_group_components>
      <VRPTo:pdbx_struct_group_components rdf:about="{$base}/pdbx_struct_group_components/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:struct_group_id!=''">
        <VRPTo:reference_to_pdbx_struct_group_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_group_list/{translate(VRPTx:struct_group_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_struct_group_components rdf:resource="{$base}/pdbx_struct_group_components/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_struct_group_list>
        <!-- pdbx_struct_group_listKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_group_components>
      </VRPTo:has_pdbx_struct_group_components>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_group_listCategory/VRPTx:pdbx_struct_group_list">
      <VRPTo:has_pdbx_struct_group_list>
      <VRPTo:pdbx_struct_group_list rdf:about="{$base}/pdbx_struct_group_list/{translate(@struct_group_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_group_list>
      </VRPTo:has_pdbx_struct_group_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_infoCategory/VRPTx:pdbx_struct_info">
      <VRPTo:has_pdbx_struct_info>
      <VRPTo:pdbx_struct_info rdf:about="{$base}/pdbx_struct_info/{translate(@type,' ^','_')},{translate(@value,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_info>
      </VRPTo:has_pdbx_struct_info>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_legacy_oper_listCategory/VRPTx:pdbx_struct_legacy_oper_list">
      <VRPTo:has_pdbx_struct_legacy_oper_list>
      <VRPTo:pdbx_struct_legacy_oper_list rdf:about="{$base}/pdbx_struct_legacy_oper_list/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_legacy_oper_list>
      </VRPTo:has_pdbx_struct_legacy_oper_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_mod_residueCategory/VRPTx:pdbx_struct_mod_residue">
      <VRPTo:has_pdbx_struct_mod_residue>
      <VRPTo:pdbx_struct_mod_residue rdf:about="{$base}/pdbx_struct_mod_residue/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_mod_residue>
      </VRPTo:has_pdbx_struct_mod_residue>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_msym_genCategory/VRPTx:pdbx_struct_msym_gen">
      <VRPTo:has_pdbx_struct_msym_gen>
      <VRPTo:pdbx_struct_msym_gen rdf:about="{$base}/pdbx_struct_msym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@msym_id,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_inst_id!=''">
        <VRPTo:reference_to_pdbx_struct_entity_inst>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@entity_inst_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_struct_msym_gen rdf:resource="{$base}/pdbx_struct_msym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@msym_id,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_struct_entity_inst>
        <!-- pdbx_struct_entity_instKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_msym_gen>
      </VRPTo:has_pdbx_struct_msym_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_nmr_ens_clustCategory/VRPTx:pdbx_struct_nmr_ens_clust">
      <VRPTo:has_pdbx_struct_nmr_ens_clust>
      <VRPTo:pdbx_struct_nmr_ens_clust rdf:about="{$base}/pdbx_struct_nmr_ens_clust/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_struct_nmr_ens_clust rdf:resource="{$base}/pdbx_struct_nmr_ens_clust/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_31_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_nmr_ens_clust>
      </VRPTo:has_pdbx_struct_nmr_ens_clust>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_nmr_ens_clust_genCategory/VRPTx:pdbx_struct_nmr_ens_clust_gen">
      <VRPTo:has_pdbx_struct_nmr_ens_clust_gen>
      <VRPTo:pdbx_struct_nmr_ens_clust_gen rdf:about="{$base}/pdbx_struct_nmr_ens_clust_gen/{translate(@PDB_model_num,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_nmr_ens_clust_gen>
      </VRPTo:has_pdbx_struct_nmr_ens_clust_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_nmr_ens_domCategory/VRPTx:pdbx_struct_nmr_ens_dom">
      <VRPTo:has_pdbx_struct_nmr_ens_dom>
      <VRPTo:pdbx_struct_nmr_ens_dom rdf:about="{$base}/pdbx_struct_nmr_ens_dom/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_nmr_ens_dom>
      </VRPTo:has_pdbx_struct_nmr_ens_dom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_nmr_ens_dom_limCategory/VRPTx:pdbx_struct_nmr_ens_dom_lim">
      <VRPTo:has_pdbx_struct_nmr_ens_dom_lim>
      <VRPTo:pdbx_struct_nmr_ens_dom_lim rdf:about="{$base}/pdbx_struct_nmr_ens_dom_lim/{translate(@component_id,' ^','_')},{translate(@dom_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@dom_id!=''">
        <VRPTo:reference_to_pdbx_struct_nmr_ens_dom>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_nmr_ens_dom/{translate(@dom_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_struct_nmr_ens_dom_lim rdf:resource="{$base}/pdbx_struct_nmr_ens_dom_lim/{translate(@component_id,' ^','_')},{translate(@dom_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_struct_nmr_ens_dom>
        <!-- pdbx_struct_nmr_ens_domKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_nmr_ens_dom_lim>
      </VRPTo:has_pdbx_struct_nmr_ens_dom_lim>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_oper_listCategory/VRPTx:pdbx_struct_oper_list">
      <VRPTo:has_pdbx_struct_oper_list>
      <VRPTo:pdbx_struct_oper_list rdf:about="{$base}/pdbx_struct_oper_list/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_oper_list>
      </VRPTo:has_pdbx_struct_oper_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_ref_seq_deletionCategory/VRPTx:pdbx_struct_ref_seq_deletion">
      <VRPTo:has_pdbx_struct_ref_seq_deletion>
      <VRPTo:pdbx_struct_ref_seq_deletion rdf:about="{$base}/pdbx_struct_ref_seq_deletion/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_ref_seq_deletion>
      </VRPTo:has_pdbx_struct_ref_seq_deletion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_ref_seq_insertionCategory/VRPTx:pdbx_struct_ref_seq_insertion">
      <VRPTo:has_pdbx_struct_ref_seq_insertion>
      <VRPTo:pdbx_struct_ref_seq_insertion rdf:about="{$base}/pdbx_struct_ref_seq_insertion/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_ref_seq_insertion>
      </VRPTo:has_pdbx_struct_ref_seq_insertion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_sheet_hbondCategory/VRPTx:pdbx_struct_sheet_hbond">
      <VRPTo:has_pdbx_struct_sheet_hbond>
      <VRPTo:pdbx_struct_sheet_hbond rdf:about="{$base}/pdbx_struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <VRPTo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_struct_sheet_hbond rdf:resource="{$base}/pdbx_struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_sheet_hbond>
      </VRPTo:has_pdbx_struct_sheet_hbond>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_special_symmetryCategory/VRPTx:pdbx_struct_special_symmetry">
      <VRPTo:has_pdbx_struct_special_symmetry>
      <VRPTo:pdbx_struct_special_symmetry rdf:about="{$base}/pdbx_struct_special_symmetry/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_struct_special_symmetry>
      </VRPTo:has_pdbx_struct_special_symmetry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_unobs_or_zero_occ_atomsCategory/VRPTx:pdbx_unobs_or_zero_occ_atoms">
      <VRPTo:has_pdbx_unobs_or_zero_occ_atoms>
      <VRPTo:pdbx_unobs_or_zero_occ_atoms rdf:about="{$base}/pdbx_unobs_or_zero_occ_atoms/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_unobs_or_zero_occ_atoms>
      </VRPTo:has_pdbx_unobs_or_zero_occ_atoms>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_unobs_or_zero_occ_residuesCategory/VRPTx:pdbx_unobs_or_zero_occ_residues">
      <VRPTo:has_pdbx_unobs_or_zero_occ_residues>
      <VRPTo:pdbx_unobs_or_zero_occ_residues rdf:about="{$base}/pdbx_unobs_or_zero_occ_residues/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_unobs_or_zero_occ_residues>
      </VRPTo:has_pdbx_unobs_or_zero_occ_residues>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_chiralCategory/VRPTx:pdbx_validate_chiral">
      <VRPTo:has_pdbx_validate_chiral>
      <VRPTo:pdbx_validate_chiral rdf:about="{$base}/pdbx_validate_chiral/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_chiral>
      </VRPTo:has_pdbx_validate_chiral>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_close_contactCategory/VRPTx:pdbx_validate_close_contact">
      <VRPTo:has_pdbx_validate_close_contact>
      <VRPTo:pdbx_validate_close_contact rdf:about="{$base}/pdbx_validate_close_contact/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_close_contact>
      </VRPTo:has_pdbx_validate_close_contact>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_main_chain_planeCategory/VRPTx:pdbx_validate_main_chain_plane">
      <VRPTo:has_pdbx_validate_main_chain_plane>
      <VRPTo:pdbx_validate_main_chain_plane rdf:about="{$base}/pdbx_validate_main_chain_plane/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_main_chain_plane>
      </VRPTo:has_pdbx_validate_main_chain_plane>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_nmr_chem_shiftCategory/VRPTx:pdbx_validate_nmr_chem_shift">
      <VRPTo:has_pdbx_validate_nmr_chem_shift>
      <VRPTo:pdbx_validate_nmr_chem_shift rdf:about="{$base}/pdbx_validate_nmr_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
        <VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@list_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_validate_nmr_chem_shift rdf:resource="{$base}/pdbx_validate_nmr_chem_shift/{translate(@id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_nmr_assigned_chem_shift_list>
        <!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_nmr_chem_shift>
      </VRPTo:has_pdbx_validate_nmr_chem_shift>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_peptide_omegaCategory/VRPTx:pdbx_validate_peptide_omega">
      <VRPTo:has_pdbx_validate_peptide_omega>
      <VRPTo:pdbx_validate_peptide_omega rdf:about="{$base}/pdbx_validate_peptide_omega/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_peptide_omega>
      </VRPTo:has_pdbx_validate_peptide_omega>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_planesCategory/VRPTx:pdbx_validate_planes">
      <VRPTo:has_pdbx_validate_planes>
      <VRPTo:pdbx_validate_planes rdf:about="{$base}/pdbx_validate_planes/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_planes>
      </VRPTo:has_pdbx_validate_planes>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_planes_atomCategory/VRPTx:pdbx_validate_planes_atom">
      <VRPTo:has_pdbx_validate_planes_atom>
      <VRPTo:pdbx_validate_planes_atom rdf:about="{$base}/pdbx_validate_planes_atom/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:plane_id!=''">
        <VRPTo:reference_to_pdbx_validate_planes>
	  <rdf:Description  rdf:about="{$base}/pdbx_validate_planes/{translate(VRPTx:plane_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_validate_planes_atom rdf:resource="{$base}/pdbx_validate_planes_atom/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_validate_planes>
        <!-- pdbx_validate_planesKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_planes_atom>
      </VRPTo:has_pdbx_validate_planes_atom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_polymer_linkageCategory/VRPTx:pdbx_validate_polymer_linkage">
      <VRPTo:has_pdbx_validate_polymer_linkage>
      <VRPTo:pdbx_validate_polymer_linkage rdf:about="{$base}/pdbx_validate_polymer_linkage/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_polymer_linkage>
      </VRPTo:has_pdbx_validate_polymer_linkage>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_angleCategory/VRPTx:pdbx_validate_rmsd_angle">
      <VRPTo:has_pdbx_validate_rmsd_angle>
      <VRPTo:pdbx_validate_rmsd_angle rdf:about="{$base}/pdbx_validate_rmsd_angle/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_rmsd_angle>
      </VRPTo:has_pdbx_validate_rmsd_angle>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_bondCategory/VRPTx:pdbx_validate_rmsd_bond">
      <VRPTo:has_pdbx_validate_rmsd_bond>
      <VRPTo:pdbx_validate_rmsd_bond rdf:about="{$base}/pdbx_validate_rmsd_bond/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_rmsd_bond>
      </VRPTo:has_pdbx_validate_rmsd_bond>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_ringCategory/VRPTx:pdbx_validate_rmsd_ring">
      <VRPTo:has_pdbx_validate_rmsd_ring>
      <VRPTo:pdbx_validate_rmsd_ring rdf:about="{$base}/pdbx_validate_rmsd_ring/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_rmsd_ring>
      </VRPTo:has_pdbx_validate_rmsd_ring>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_rings_atomCategory/VRPTx:pdbx_validate_rmsd_rings_atom">
      <VRPTo:has_pdbx_validate_rmsd_rings_atom>
      <VRPTo:pdbx_validate_rmsd_rings_atom rdf:about="{$base}/pdbx_validate_rmsd_rings_atom/{translate(@id,' ^','_')},{translate(@ring_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@ring_id!=''">
        <VRPTo:reference_to_pdbx_validate_rmsd_ring>
	  <rdf:Description  rdf:about="{$base}/pdbx_validate_rmsd_ring/{translate(@ring_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_validate_rmsd_rings_atom rdf:resource="{$base}/pdbx_validate_rmsd_rings_atom/{translate(@id,' ^','_')},{translate(@ring_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_validate_rmsd_ring>
        <!-- pdbx_validate_rmsd_ringKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_rmsd_rings_atom>
      </VRPTo:has_pdbx_validate_rmsd_rings_atom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_torsionCategory/VRPTx:pdbx_validate_rmsd_torsion">
      <VRPTo:has_pdbx_validate_rmsd_torsion>
      <VRPTo:pdbx_validate_rmsd_torsion rdf:about="{$base}/pdbx_validate_rmsd_torsion/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_rmsd_torsion>
      </VRPTo:has_pdbx_validate_rmsd_torsion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_torsions_atomCategory/VRPTx:pdbx_validate_rmsd_torsions_atom">
      <VRPTo:has_pdbx_validate_rmsd_torsions_atom>
      <VRPTo:pdbx_validate_rmsd_torsions_atom rdf:about="{$base}/pdbx_validate_rmsd_torsions_atom/{translate(@id,' ^','_')},{translate(@torsion_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@torsion_id!=''">
        <VRPTo:reference_to_pdbx_validate_rmsd_torsion>
	  <rdf:Description  rdf:about="{$base}/pdbx_validate_rmsd_torsion/{translate(@torsion_id,' ^','_')}">
	    <VRPTo:referenced_by_pdbx_validate_rmsd_torsions_atom rdf:resource="{$base}/pdbx_validate_rmsd_torsions_atom/{translate(@id,' ^','_')},{translate(@torsion_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_pdbx_validate_rmsd_torsion>
        <!-- pdbx_validate_rmsd_torsionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_rmsd_torsions_atom>
      </VRPTo:has_pdbx_validate_rmsd_torsions_atom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_symm_contactCategory/VRPTx:pdbx_validate_symm_contact">
      <VRPTo:has_pdbx_validate_symm_contact>
      <VRPTo:pdbx_validate_symm_contact rdf:about="{$base}/pdbx_validate_symm_contact/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_symm_contact>
      </VRPTo:has_pdbx_validate_symm_contact>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_torsionCategory/VRPTx:pdbx_validate_torsion">
      <VRPTo:has_pdbx_validate_torsion>
      <VRPTo:pdbx_validate_torsion rdf:about="{$base}/pdbx_validate_torsion/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validate_torsion>
      </VRPTo:has_pdbx_validate_torsion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validation_softwareCategory/VRPTx:pdbx_validation_software">
      <VRPTo:has_pdbx_validation_software>
      <VRPTo:pdbx_validation_software rdf:about="{$base}/pdbx_validation_software/{translate(@ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:pdbx_validation_software>
      </VRPTo:has_pdbx_validation_software>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasingCategory/VRPTx:phasing">
      <VRPTo:has_phasing>
      <VRPTo:phasing rdf:about="{$base}/phasing/{translate(@method,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing>
      </VRPTo:has_phasing>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MADCategory/VRPTx:phasing_MAD">
      <VRPTo:has_phasing_MAD>
      <VRPTo:phasing_MAD rdf:about="{$base}/phasing_MAD/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MAD rdf:resource="{$base}/phasing_MAD/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_32_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MAD>
      </VRPTo:has_phasing_MAD>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MAD_clustCategory/VRPTx:phasing_MAD_clust">
      <VRPTo:has_phasing_MAD_clust>
      <VRPTo:phasing_MAD_clust rdf:about="{$base}/phasing_MAD_clust/{translate(@expt_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <VRPTo:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MAD_clust rdf:resource="{$base}/phasing_MAD_clust/{translate(@expt_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_MAD_expt>
        <!-- phasing_MAD_exptKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MAD_clust>
      </VRPTo:has_phasing_MAD_clust>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MAD_exptCategory/VRPTx:phasing_MAD_expt">
      <VRPTo:has_phasing_MAD_expt>
      <VRPTo:phasing_MAD_expt rdf:about="{$base}/phasing_MAD_expt/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MAD_expt>
      </VRPTo:has_phasing_MAD_expt>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MAD_ratioCategory/VRPTx:phasing_MAD_ratio">
      <VRPTo:has_phasing_MAD_ratio>
      <VRPTo:phasing_MAD_ratio rdf:about="{$base}/phasing_MAD_ratio/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@wavelength_1,' ^','_')},{translate(@wavelength_2,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <VRPTo:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MAD_ratio rdf:resource="{$base}/phasing_MAD_ratio/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@wavelength_1,' ^','_')},{translate(@wavelength_2,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_MAD_expt>
        <!-- phasing_MAD_exptKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MAD_ratio>
      </VRPTo:has_phasing_MAD_ratio>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MAD_setCategory/VRPTx:phasing_MAD_set">
      <VRPTo:has_phasing_MAD_set>
      <VRPTo:phasing_MAD_set rdf:about="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <VRPTo:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MAD_set rdf:resource="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_MAD_expt>
        <!-- phasing_MAD_exptKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:if test="@set_id!=''">
        <VRPTo:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MAD_set rdf:resource="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_set>
        <!-- phasing_setKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MAD_set>
      </VRPTo:has_phasing_MAD_set>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIRCategory/VRPTx:phasing_MIR">
      <VRPTo:has_phasing_MIR>
      <VRPTo:phasing_MIR rdf:about="{$base}/phasing_MIR/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MIR rdf:resource="{$base}/phasing_MIR/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_33_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MIR>
      </VRPTo:has_phasing_MIR>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_derCategory/VRPTx:phasing_MIR_der">
      <VRPTo:has_phasing_MIR_der>
      <VRPTo:phasing_MIR_der rdf:about="{$base}/phasing_MIR_der/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:der_set_id!=''">
        <VRPTo:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(VRPTx:der_set_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MIR_der rdf:resource="{$base}/phasing_MIR_der/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_set>
        <!-- phasing_setKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MIR_der>
      </VRPTo:has_phasing_MIR_der>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_der_reflnCategory/VRPTx:phasing_MIR_der_refln">
      <VRPTo:has_phasing_MIR_der_refln>
      <VRPTo:phasing_MIR_der_refln rdf:about="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <VRPTo:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MIR_der_refln rdf:resource="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_MIR_der>
        <!-- phasing_MIR_derKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@set_id!=''">
        <VRPTo:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MIR_der_refln rdf:resource="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_set>
        <!-- phasing_setKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MIR_der_refln>
      </VRPTo:has_phasing_MIR_der_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_der_shellCategory/VRPTx:phasing_MIR_der_shell">
      <VRPTo:has_phasing_MIR_der_shell>
      <VRPTo:phasing_MIR_der_shell rdf:about="{$base}/phasing_MIR_der_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@der_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <VRPTo:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MIR_der_shell rdf:resource="{$base}/phasing_MIR_der_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@der_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_MIR_der>
        <!-- phasing_MIR_derKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MIR_der_shell>
      </VRPTo:has_phasing_MIR_der_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_der_siteCategory/VRPTx:phasing_MIR_der_site">
      <VRPTo:has_phasing_MIR_der_site>
      <VRPTo:phasing_MIR_der_site rdf:about="{$base}/phasing_MIR_der_site/{translate(@der_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <VRPTo:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_MIR_der_site rdf:resource="{$base}/phasing_MIR_der_site/{translate(@der_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_MIR_der>
        <!-- phasing_MIR_derKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MIR_der_site>
      </VRPTo:has_phasing_MIR_der_site>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_shellCategory/VRPTx:phasing_MIR_shell">
      <VRPTo:has_phasing_MIR_shell>
      <VRPTo:phasing_MIR_shell rdf:about="{$base}/phasing_MIR_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_MIR_shell>
      </VRPTo:has_phasing_MIR_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_averagingCategory/VRPTx:phasing_averaging">
      <VRPTo:has_phasing_averaging>
      <VRPTo:phasing_averaging rdf:about="{$base}/phasing_averaging/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_averaging rdf:resource="{$base}/phasing_averaging/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_34_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_averaging>
      </VRPTo:has_phasing_averaging>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_isomorphousCategory/VRPTx:phasing_isomorphous">
      <VRPTo:has_phasing_isomorphous>
      <VRPTo:phasing_isomorphous rdf:about="{$base}/phasing_isomorphous/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_isomorphous rdf:resource="{$base}/phasing_isomorphous/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_35_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_isomorphous>
      </VRPTo:has_phasing_isomorphous>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_setCategory/VRPTx:phasing_set">
      <VRPTo:has_phasing_set>
      <VRPTo:phasing_set rdf:about="{$base}/phasing_set/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_set>
      </VRPTo:has_phasing_set>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_set_reflnCategory/VRPTx:phasing_set_refln">
      <VRPTo:has_phasing_set_refln>
      <VRPTo:phasing_set_refln rdf:about="{$base}/phasing_set_refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@set_id!=''">
        <VRPTo:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <VRPTo:referenced_by_phasing_set_refln rdf:resource="{$base}/phasing_set_refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_phasing_set>
        <!-- phasing_setKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:phasing_set_refln>
      </VRPTo:has_phasing_set_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refineCategory/VRPTx:refine">
      <VRPTo:has_refine>
      <VRPTo:refine rdf:about="{$base}/refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_refine rdf:resource="{$base}/refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_36_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine>
      </VRPTo:has_refine>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_B_isoCategory/VRPTx:refine_B_iso">
      <VRPTo:has_refine_B_iso>
      <VRPTo:refine_B_iso rdf:about="{$base}/refine_B_iso/{translate(@class,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_B_iso>
      </VRPTo:has_refine_B_iso>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_analyzeCategory/VRPTx:refine_analyze">
      <VRPTo:has_refine_analyze>
      <VRPTo:refine_analyze rdf:about="{$base}/refine_analyze/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_refine_analyze rdf:resource="{$base}/refine_analyze/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_37_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_analyze>
      </VRPTo:has_refine_analyze>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_funct_minimizedCategory/VRPTx:refine_funct_minimized">
      <VRPTo:has_refine_funct_minimized>
      <VRPTo:refine_funct_minimized rdf:about="{$base}/refine_funct_minimized/{translate(@pdbx_refine_id,' ^','_')},{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_funct_minimized>
      </VRPTo:has_refine_funct_minimized>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_histCategory/VRPTx:refine_hist">
      <VRPTo:has_refine_hist>
      <VRPTo:refine_hist rdf:about="{$base}/refine_hist/{translate(@cycle_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_hist>
      </VRPTo:has_refine_hist>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_classCategory/VRPTx:refine_ls_class">
      <VRPTo:has_refine_ls_class>
      <VRPTo:refine_ls_class rdf:about="{$base}/refine_ls_class/{translate(@code,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_ls_class>
      </VRPTo:has_refine_ls_class>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_restrCategory/VRPTx:refine_ls_restr">
      <VRPTo:has_refine_ls_restr>
      <VRPTo:refine_ls_restr rdf:about="{$base}/refine_ls_restr/{translate(@pdbx_refine_id,' ^','_')},{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_ls_restr>
      </VRPTo:has_refine_ls_restr>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_restr_ncsCategory/VRPTx:refine_ls_restr_ncs">
      <VRPTo:has_refine_ls_restr_ncs>
      <VRPTo:refine_ls_restr_ncs rdf:about="{$base}/refine_ls_restr_ncs/{translate(@pdbx_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_ls_restr_ncs>
      </VRPTo:has_refine_ls_restr_ncs>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_restr_typeCategory/VRPTx:refine_ls_restr_type">
      <VRPTo:has_refine_ls_restr_type>
      <VRPTo:refine_ls_restr_type rdf:about="{$base}/refine_ls_restr_type/{translate(@type,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_ls_restr_type>
      </VRPTo:has_refine_ls_restr_type>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_shellCategory/VRPTx:refine_ls_shell">
      <VRPTo:has_refine_ls_shell>
      <VRPTo:refine_ls_shell rdf:about="{$base}/refine_ls_shell/{translate(@d_res_high,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_ls_shell>
      </VRPTo:has_refine_ls_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_occupancyCategory/VRPTx:refine_occupancy">
      <VRPTo:has_refine_occupancy>
      <VRPTo:refine_occupancy rdf:about="{$base}/refine_occupancy/{translate(@class,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refine_occupancy>
      </VRPTo:has_refine_occupancy>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflnCategory/VRPTx:refln">
      <VRPTo:has_refln>
      <VRPTo:refln rdf:about="{$base}/refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refln>
      </VRPTo:has_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refln_sys_absCategory/VRPTx:refln_sys_abs">
      <VRPTo:has_refln_sys_abs>
      <VRPTo:refln_sys_abs rdf:about="{$base}/refln_sys_abs/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:refln_sys_abs>
      </VRPTo:has_refln_sys_abs>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflnsCategory/VRPTx:reflns">
      <VRPTo:has_reflns>
      <VRPTo:reflns rdf:about="{$base}/reflns/{translate(@pdbx_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(VRPTx:entry_id,' ^','_')}">
	    <VRPTo:referenced_by_reflns rdf:resource="{$base}/reflns/{translate(@pdbx_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_38_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:reflns>
      </VRPTo:has_reflns>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflns_classCategory/VRPTx:reflns_class">
      <VRPTo:has_reflns_class>
      <VRPTo:reflns_class rdf:about="{$base}/reflns_class/{translate(@code,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:reflns_class>
      </VRPTo:has_reflns_class>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflns_scaleCategory/VRPTx:reflns_scale">
      <VRPTo:has_reflns_scale>
      <VRPTo:reflns_scale rdf:about="{$base}/reflns_scale/{translate(@group_code,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:reflns_scale>
      </VRPTo:has_reflns_scale>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflns_shellCategory/VRPTx:reflns_shell">
      <VRPTo:has_reflns_shell>
      <VRPTo:reflns_shell rdf:about="{$base}/reflns_shell/{translate(@pdbx_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:reflns_shell>
      </VRPTo:has_reflns_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:space_groupCategory/VRPTx:space_group">
      <VRPTo:has_space_group>
      <VRPTo:space_group rdf:about="{$base}/space_group/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:space_group>
      </VRPTo:has_space_group>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:space_group_symopCategory/VRPTx:space_group_symop">
      <VRPTo:has_space_group_symop>
      <VRPTo:space_group_symop rdf:about="{$base}/space_group_symop/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:space_group_symop>
      </VRPTo:has_space_group_symop>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:structCategory/VRPTx:struct">
      <VRPTo:has_struct>
      <VRPTo:struct rdf:about="{$base}/struct/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_struct rdf:resource="{$base}/struct/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_39_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct>
      </VRPTo:has_struct>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_asymCategory/VRPTx:struct_asym">
      <VRPTo:has_struct_asym>
      <VRPTo:struct_asym rdf:about="{$base}/struct_asym/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!='' and @id!=''">
        <owl:sameAs>
          <VRPTo:struct_asym rdf:about="{$base}/struct_asym/{translate(VRPTx:entity_id,' ^','_')},{translate(@id,' ^','_')}">
            <rdfs:label>struct_asymUnique_1</rdfs:label>
          </VRPTo:struct_asym>
        </owl:sameAs>
      </xsl:if>
      <xsl:if test="VRPTx:entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(VRPTx:entity_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_asym rdf:resource="{$base}/struct_asym/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_asym>
      </VRPTo:has_struct_asym>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_biolCategory/VRPTx:struct_biol">
      <VRPTo:has_struct_biol>
      <VRPTo:struct_biol rdf:about="{$base}/struct_biol/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_biol>
      </VRPTo:has_struct_biol>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_biol_viewCategory/VRPTx:struct_biol_view">
      <VRPTo:has_struct_biol_view>
      <VRPTo:struct_biol_view rdf:about="{$base}/struct_biol_view/{translate(@biol_id,' ^','_')},{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@biol_id!=''">
        <VRPTo:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(@biol_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_biol_view rdf:resource="{$base}/struct_biol_view/{translate(@biol_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_biol_view>
      </VRPTo:has_struct_biol_view>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_confCategory/VRPTx:struct_conf">
      <VRPTo:has_struct_conf>
      <VRPTo:struct_conf rdf:about="{$base}/struct_conf/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:conf_type_id!=''">
        <VRPTo:reference_to_struct_conf_type>
	  <rdf:Description  rdf:about="{$base}/struct_conf_type/{translate(VRPTx:conf_type_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_conf rdf:resource="{$base}/struct_conf/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_conf_type>
        <!-- struct_conf_typeKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_conf>
      </VRPTo:has_struct_conf>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_conf_typeCategory/VRPTx:struct_conf_type">
      <VRPTo:has_struct_conf_type>
      <VRPTo:struct_conf_type rdf:about="{$base}/struct_conf_type/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_conf_type>
      </VRPTo:has_struct_conf_type>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_connCategory/VRPTx:struct_conn">
      <VRPTo:has_struct_conn>
      <VRPTo:struct_conn rdf:about="{$base}/struct_conn/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_conn>
      </VRPTo:has_struct_conn>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_conn_typeCategory/VRPTx:struct_conn_type">
      <VRPTo:has_struct_conn_type>
      <VRPTo:struct_conn_type rdf:about="{$base}/struct_conn_type/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_conn_type>
      </VRPTo:has_struct_conn_type>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_mon_detailsCategory/VRPTx:struct_mon_details">
      <VRPTo:has_struct_mon_details>
      <VRPTo:struct_mon_details rdf:about="{$base}/struct_mon_details/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_mon_details rdf:resource="{$base}/struct_mon_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_40_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_mon_details>
      </VRPTo:has_struct_mon_details>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_mon_nuclCategory/VRPTx:struct_mon_nucl">
      <VRPTo:has_struct_mon_nucl>
      <VRPTo:struct_mon_nucl rdf:about="{$base}/struct_mon_nucl/{translate(@pdbx_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_mon_nucl>
      </VRPTo:has_struct_mon_nucl>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_mon_protCategory/VRPTx:struct_mon_prot">
      <VRPTo:has_struct_mon_prot>
      <VRPTo:struct_mon_prot rdf:about="{$base}/struct_mon_prot/{translate(@pdbx_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_mon_prot>
      </VRPTo:has_struct_mon_prot>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_mon_prot_cisCategory/VRPTx:struct_mon_prot_cis">
      <VRPTo:has_struct_mon_prot_cis>
      <VRPTo:struct_mon_prot_cis rdf:about="{$base}/struct_mon_prot_cis/{translate(@pdbx_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_mon_prot_cis>
      </VRPTo:has_struct_mon_prot_cis>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_domCategory/VRPTx:struct_ncs_dom">
      <VRPTo:has_struct_ncs_dom>
      <VRPTo:struct_ncs_dom rdf:about="{$base}/struct_ncs_dom/{translate(@id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@pdbx_ens_id!=''">
        <VRPTo:reference_to_struct_ncs_ens>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_ens/{translate(@pdbx_ens_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_ncs_dom rdf:resource="{$base}/struct_ncs_dom/{translate(@id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_ncs_ens>
        <!-- struct_ncs_ensKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_ncs_dom>
      </VRPTo:has_struct_ncs_dom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_dom_limCategory/VRPTx:struct_ncs_dom_lim">
      <VRPTo:has_struct_ncs_dom_lim>
      <VRPTo:struct_ncs_dom_lim rdf:about="{$base}/struct_ncs_dom_lim/{translate(@dom_id,' ^','_')},{translate(@pdbx_component_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@dom_id!='' and @pdbx_ens_id!=''">
        <VRPTo:reference_to_struct_ncs_dom>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_dom/{translate(@dom_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_ncs_dom_lim rdf:resource="{$base}/struct_ncs_dom_lim/{translate(@dom_id,' ^','_')},{translate(@pdbx_component_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_ncs_dom>
        <!-- struct_ncs_domKeyref_1_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_ncs_dom_lim>
      </VRPTo:has_struct_ncs_dom_lim>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_ensCategory/VRPTx:struct_ncs_ens">
      <VRPTo:has_struct_ncs_ens>
      <VRPTo:struct_ncs_ens rdf:about="{$base}/struct_ncs_ens/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_ncs_ens>
      </VRPTo:has_struct_ncs_ens>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_ens_genCategory/VRPTx:struct_ncs_ens_gen">
      <VRPTo:has_struct_ncs_ens_gen>
      <VRPTo:struct_ncs_ens_gen rdf:about="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@ens_id!=''">
        <VRPTo:reference_to_struct_ncs_ens>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_ens/{translate(@ens_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_ncs_ens_gen rdf:resource="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_ncs_ens>
        <!-- struct_ncs_ensKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@oper_id!=''">
        <VRPTo:reference_to_struct_ncs_oper>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_oper/{translate(@oper_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_ncs_ens_gen rdf:resource="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_ncs_oper>
        <!-- struct_ncs_operKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_ncs_ens_gen>
      </VRPTo:has_struct_ncs_ens_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_operCategory/VRPTx:struct_ncs_oper">
      <VRPTo:has_struct_ncs_oper>
      <VRPTo:struct_ncs_oper rdf:about="{$base}/struct_ncs_oper/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_ncs_oper>
      </VRPTo:has_struct_ncs_oper>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_refCategory/VRPTx:struct_ref">
      <VRPTo:has_struct_ref>
      <VRPTo:struct_ref rdf:about="{$base}/struct_ref/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!=''">
        <VRPTo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(VRPTx:entity_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_ref rdf:resource="{$base}/struct_ref/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entity>
        <!-- entityKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_ref>
      </VRPTo:has_struct_ref>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ref_seqCategory/VRPTx:struct_ref_seq">
      <VRPTo:has_struct_ref_seq>
      <VRPTo:struct_ref_seq rdf:about="{$base}/struct_ref_seq/{translate(@align_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:ref_id!=''">
        <VRPTo:reference_to_struct_ref>
	  <rdf:Description  rdf:about="{$base}/struct_ref/{translate(VRPTx:ref_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_ref_seq rdf:resource="{$base}/struct_ref_seq/{translate(@align_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_ref>
        <!-- struct_refKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_ref_seq>
      </VRPTo:has_struct_ref_seq>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ref_seq_difCategory/VRPTx:struct_ref_seq_dif">
      <VRPTo:has_struct_ref_seq_dif>
      <VRPTo:struct_ref_seq_dif rdf:about="{$base}/struct_ref_seq_dif/{translate(@pdbx_ordinal,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:align_id!=''">
        <VRPTo:reference_to_struct_ref_seq>
	  <rdf:Description  rdf:about="{$base}/struct_ref_seq/{translate(VRPTx:align_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_ref_seq_dif rdf:resource="{$base}/struct_ref_seq_dif/{translate(@pdbx_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_ref_seq>
        <!-- struct_ref_seqKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_ref_seq_dif>
      </VRPTo:has_struct_ref_seq_dif>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheetCategory/VRPTx:struct_sheet">
      <VRPTo:has_struct_sheet>
      <VRPTo:struct_sheet rdf:about="{$base}/struct_sheet/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_sheet>
      </VRPTo:has_struct_sheet>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheet_hbondCategory/VRPTx:struct_sheet_hbond">
      <VRPTo:has_struct_sheet_hbond>
      <VRPTo:struct_sheet_hbond rdf:about="{$base}/struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <VRPTo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_sheet_hbond rdf:resource="{$base}/struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_sheet_hbond>
      </VRPTo:has_struct_sheet_hbond>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheet_orderCategory/VRPTx:struct_sheet_order">
      <VRPTo:has_struct_sheet_order>
      <VRPTo:struct_sheet_order rdf:about="{$base}/struct_sheet_order/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <VRPTo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_sheet_order rdf:resource="{$base}/struct_sheet_order/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_sheet_order>
      </VRPTo:has_struct_sheet_order>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheet_rangeCategory/VRPTx:struct_sheet_range">
      <VRPTo:has_struct_sheet_range>
      <VRPTo:struct_sheet_range rdf:about="{$base}/struct_sheet_range/{translate(@id,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <VRPTo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_sheet_range rdf:resource="{$base}/struct_sheet_range/{translate(@id,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_sheet_range>
      </VRPTo:has_struct_sheet_range>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheet_topologyCategory/VRPTx:struct_sheet_topology">
      <VRPTo:has_struct_sheet_topology>
      <VRPTo:struct_sheet_topology rdf:about="{$base}/struct_sheet_topology/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <VRPTo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_sheet_topology rdf:resource="{$base}/struct_sheet_topology/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_sheet>
        <!-- struct_sheetKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_sheet_topology>
      </VRPTo:has_struct_sheet_topology>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_siteCategory/VRPTx:struct_site">
      <VRPTo:has_struct_site>
      <VRPTo:struct_site rdf:about="{$base}/struct_site/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_site>
      </VRPTo:has_struct_site>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_site_genCategory/VRPTx:struct_site_gen">
      <VRPTo:has_struct_site_gen>
      <VRPTo:struct_site_gen rdf:about="{$base}/struct_site_gen/{translate(@id,' ^','_')},{translate(@site_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@site_id!=''">
        <VRPTo:reference_to_struct_site>
	  <rdf:Description  rdf:about="{$base}/struct_site/{translate(@site_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_site_gen rdf:resource="{$base}/struct_site_gen/{translate(@id,' ^','_')},{translate(@site_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_site>
        <!-- struct_siteKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_site_gen>
      </VRPTo:has_struct_site_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_site_viewCategory/VRPTx:struct_site_view">
      <VRPTo:has_struct_site_view>
      <VRPTo:struct_site_view rdf:about="{$base}/struct_site_view/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:site_id!=''">
        <VRPTo:reference_to_struct_site>
	  <rdf:Description  rdf:about="{$base}/struct_site/{translate(VRPTx:site_id,' ^','_')}">
	    <VRPTo:referenced_by_struct_site_view rdf:resource="{$base}/struct_site_view/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_struct_site>
        <!-- struct_siteKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:struct_site_view>
      </VRPTo:has_struct_site_view>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:symmetryCategory/VRPTx:symmetry">
      <VRPTo:has_symmetry>
      <VRPTo:symmetry rdf:about="{$base}/symmetry/{translate(@entry_id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <VRPTo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <VRPTo:referenced_by_symmetry rdf:resource="{$base}/symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </VRPTo:reference_to_entry>
        <!-- entryKeyref_0_0_41_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:symmetry>
      </VRPTo:has_symmetry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:symmetry_equivCategory/VRPTx:symmetry_equiv">
      <VRPTo:has_symmetry_equiv>
      <VRPTo:symmetry_equiv rdf:about="{$base}/symmetry_equiv/{translate(@id,' ^','_')}">
      <VRPTo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </VRPTo:symmetry_equiv>
      </VRPTo:has_symmetry_equiv>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>
  <xsl:template match="*|text()|@*" mode="linked"/>

</xsl:stylesheet>
