<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:xsd="http://www.w3.org/2001/XMLSchema#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:VRPTx="http://pdbml.pdb.org/schema/pdbx-validation-v4.xsd"
  xmlns:PDBo="http://rdf.wwpdb.org/schema/pdbx-with-vrptx-v50.owl#"
  xmlns:ext="http://exslt.org/common" exclude-result-prefixes="VRPTx ext">

  <xsl:include href="url-encode.xsl"/>

  <xsl:param name="wurcs2glytoucan" select="'https://raw.githubusercontent.com/yokochi47/pdbx-validation/master/wurcs2glytoucan/glytoucan.xml'" required="no"/>
  <xsl:param name="glytoucan" select="document($wurcs2glytoucan)"/>

  <xsl:param name="primitive_type_mapping" select="'https://raw.githubusercontent.com/yokochi47/pdbx-validation/master/stylesheet/vrptx_primitive_type_mapping.xml'" required="no"/>
  <xsl:param name="type_mapping" select="document($primitive_type_mapping)"/>

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:variable name="PDB_ID"><xsl:value-of select="/VRPTx:datablock/VRPTx:entryCategory/VRPTx:entry/@id"/></xsl:variable>
  <xsl:variable name="pdb_id"><xsl:value-of select="translate($PDB_ID,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/></xsl:variable>
  <xsl:variable name="pdb_doi"><xsl:value-of select="concat('10.2210/pdb',$pdb_id,'/pdb')"/></xsl:variable>
  <xsl:variable name="base">http://rdf.wwpdb.org/vrpt/<xsl:value-of select="$PDB_ID"/></xsl:variable>
  <xsl:variable name="base_lower">http://rdf.wwpdb.org/vrpt/<xsl:value-of select="$pdb_id"/></xsl:variable>
  <xsl:variable name="pdb_link">http://rdf.wwpdb.org/pdb/</xsl:variable>
  <xsl:variable name="chem_comp">http://rdf.wwpdb.org/cc/</xsl:variable>
  <xsl:variable name="prd">http://rdf.wwpdb.org/prd/</xsl:variable>
  <xsl:variable name="pdbj">http://pdbj.org/pdb/</xsl:variable>
  <xsl:variable name="rcsb">http://www.rcsb.org/pdb/structure/</xsl:variable>
  <xsl:variable name="pdbe">http://www.ebi.ac.uk/pdbe/entry/pdb/</xsl:variable>
  <xsl:variable name="pdbml">http://files.wwpdb.org/pub/pdb/data/structures/all/XML/</xsl:variable>
  <xsl:variable name="pdbml_noatom">http://files.wwpdb.org/pub/pdb/data/structures/all/XML-noatom/</xsl:variable>
  <xsl:variable name="pdbml_extatom">http://files.wwpdb.org/pub/pdb/data/structures/all/XML-extatom/</xsl:variable>
  <xsl:variable name="vrpt">http://files.wwpdb.org/pub/pdb/validation_reports/<xsl:value-of select="substring($pdb_id,2,2)"/>/<xsl:value-of select="$pdb_id"/>/</xsl:variable>
  <xsl:variable name="bmrb">http://bmrbpub.pdbj.org/rdf/bmr</xsl:variable>
  <xsl:variable name="emdb">http://www.ebi.ac.uk/emdb/</xsl:variable>
  <xsl:variable name="sasbdb">http://www.sasbdb.org/data/</xsl:variable>
  <xsl:variable name="idorg">http://identifiers.org/</xsl:variable>
  <xsl:variable name="doi">http://doi.org/</xsl:variable>
  <xsl:variable name="pubmed">http://rdf.ncbi.nlm.nih.gov/pubmed/</xsl:variable>
  <xsl:variable name="taxonomy">http://purl.uniprot.org/taxonomy/</xsl:variable>
  <xsl:variable name="uniprot">http://purl.uniprot.org/uniprot/</xsl:variable>
  <xsl:variable name="genbank">http://www.ncbi.nlm.nih.gov/protein/</xsl:variable>
  <xsl:variable name="embl">http://www.ncbi.nlm.nih.gov/protein/</xsl:variable>
  <xsl:variable name="pir">http://www.ncbi.nlm.nih.gov/protein/</xsl:variable>
  <xsl:variable name="refseq">http://www.ncbi.nlm.nih.gov/protein/</xsl:variable>
  <xsl:variable name="norine">http://bioinfo.lifl.fr/norine/result.jsp?ID=</xsl:variable>
  <xsl:variable name="enzyme">http://purl.uniprot.org/enzyme/</xsl:variable>
  <xsl:variable name="go">http://purl.obolibrary.org/obo/GO_</xsl:variable>
  <xsl:variable name="interpro">http://www.ebi.ac.uk/interpro/entry/</xsl:variable>
  <xsl:variable name="pfam">http://pfam.xfam.org/family/</xsl:variable>
  <xsl:variable name="cath">http://www.cathdb.info/cathnode/</xsl:variable>
  <xsl:variable name="scop">http://scop.berkeley.edu/sunid=</xsl:variable>
  <xsl:variable name="scop2">http://scop2.mrc-lmb.cam.ac.uk/term/</xsl:variable>
  <xsl:variable name="ensembl">http://www.ensembl.org/id/</xsl:variable>
  <xsl:variable name="glycoinfo">http://rdf.glycoinfo.org/glycan/</xsl:variable>

  <xsl:template match="/">
    <rdf:RDF>
      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <!-- level 1 -->
  <xsl:template match="/VRPTx:datablock">
    <PDBo:datablock rdf:about="{$base}">
      <dcterms:references rdf:resource="{$doi}{$pdb_doi}" rdfs:label="doi:{$pdb_doi}"/>
      <dcterms:identifier><xsl:value-of select="concat($PDB_ID,'-validation')"/></dcterms:identifier>
      <skos:altLabel><xsl:value-of select="concat($pdb_id,'-validation')"/></skos:altLabel>
      <dc:title><xsl:value-of select="concat('wwPDB validation report of PDB entry ',$PDB_ID)"/></dc:title>
      <PDBo:link_to_pdb_src rdf:resource="{$pdb_link}{$PDB_ID}"/>
      <PDBo:link_to_pdbml rdf:resource="{$pdbml}{$pdb_id}.xml.gz"/>
      <PDBo:link_to_pdbml_noatom rdf:resource="{$pdbml_noatom}{$pdb_id}-noatom.xml.gz"/>
      <PDBo:link_to_pdbml_extatom rdf:resource="{$pdbml_extatom}{$pdb_id}-extatom.xml.gz"/>
      <PDBo:link_to_xml_vrpt rdf:resource="{$vrpt}{$pdb_id}_validation.xml.gz"/>
      <owl:sameAs rdf:resource="{$base_lower}"/>
      <rdfs:seeAlso rdf:resource="{$pdbj}{$PDB_ID}"/>
      <rdfs:seeAlso rdf:resource="{$rcsb}{$PDB_ID}"/>
      <rdfs:seeAlso rdf:resource="{$pdbe}{$PDB_ID}"/>

      <PDBo:datablockName><xsl:value-of select="@datablockName"/></PDBo:datablockName>
      <xsl:apply-templates select="./*"/>
    </PDBo:datablock>
  </xsl:template>

  <!-- level 2 -->
  <xsl:template match="/VRPTx:datablock/*">
    <xsl:element name="PDBo:has_{local-name(.)}">
      <xsl:element name="PDBo:{local-name(.)}">
	<xsl:attribute name="rdf:about">
	  <xsl:value-of select="concat($base,'/',local-name(.))"/>
	</xsl:attribute>
	<xsl:apply-templates>
	  <xsl:with-param name="base" select="$base"/>
	</xsl:apply-templates>
      </xsl:element>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (element) -->
  <xsl:template match="/VRPTx:datablock/*/*/*[not(xsi:nil) and text()!='']">
    <xsl:variable name="category_item"><xsl:value-of select="local-name(parent::node())"/></xsl:variable>
    <xsl:variable name="data_item"><xsl:value-of select="local-name()"/></xsl:variable>
    <xsl:variable name="tag_name"><xsl:value-of select="concat($category_item,'.',$data_item)"/></xsl:variable>
    <xsl:variable name="data_type"><xsl:value-of select="$type_mapping/primitive_type_mapping/category_item[@name=$category_item]/data_item[@name=$data_item]/@type"/></xsl:variable>
    <xsl:element name="PDBo:{$tag_name}">
      <xsl:if test="$data_type!=''">
	<xsl:attribute name="rdf:datatype"><xsl:value-of select="$data_type"/></xsl:attribute>
      </xsl:if>
      <xsl:choose>
	<xsl:when test="contains(local-name(),'one_letter_code')">
	  <xsl:choose>
	    <xsl:when test=".='?' or .='.'"/>
	    <xsl:otherwise>
	      <xsl:value-of select="translate(normalize-space(.),'
','')"/>
	    </xsl:otherwise>
	  </xsl:choose>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:value-of select="."/>
	</xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (attribute) -->
  <xsl:template match="/VRPTx:datablock/*/*/@*">
    <xsl:variable name="category_item"><xsl:value-of select="local-name(parent::node())"/></xsl:variable>
    <xsl:variable name="data_item"><xsl:value-of select="translate(name(),'@','')"/></xsl:variable>
    <xsl:variable name="tag_name"><xsl:value-of select="concat($category_item,'.',$data_item)"/></xsl:variable>
    <xsl:variable name="data_type"><xsl:value-of select="$type_mapping/primitive_type_mapping/category_item[@name=$category_item]/data_item[@name=$data_item]/@type"/></xsl:variable>
    <xsl:element name="PDBo:{$tag_name}">
      <xsl:if test="$data_type!=''">
	<xsl:attribute name="rdf:datatype"><xsl:value-of select="$data_type"/></xsl:attribute>
      </xsl:if>
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (linked data) -->
  <xsl:template match="VRPTx:chem_comp/@id" mode="linked">
    <PDBo:link_to_chem_comp rdf:resource="{$chem_comp}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_molecule/@prd_id" mode="linked">
    <PDBo:link_to_prd rdf:resource="{$prd}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_molecule_features/@prd_id" mode="linked">
    <PDBo:link_to_prd rdf:resource="{$prd}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_linked_entity/VRPTx:prd_id[text()!='']" mode="linked">
    <PDBo:link_to_prd rdf:resource="{$prd}{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:citation/VRPTx:pdbx_database_id_DOI[text()!='']" mode="linked">
    <xsl:variable name="doi_url">
      <xsl:value-of select="$doi"/>
      <xsl:call-template name="replace-string">
	<xsl:with-param name="str">
	  <xsl:call-template name="replace-string">
	    <xsl:with-param name="str" select="text()"/>
	    <xsl:with-param name="replace">&lt;</xsl:with-param>
	    <xsl:with-param name="with">&amp;lt;</xsl:with-param>
	  </xsl:call-template>
	</xsl:with-param>
	<xsl:with-param name="replace">&gt;</xsl:with-param>
	<xsl:with-param name="with">&amp;gt;</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <PDBo:link_to_doi rdf:resource="{$doi_url}" rdfs:label="doi:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:citation/VRPTx:pdbx_database_id_PubMed[text()!='']" mode="linked">
    <PDBo:link_to_pubmed rdf:resource="{$pubmed}{text()}" rdfs:label="pubmed:{text()}"/>
    <dcterms:references rdf:resource="{$idorg}pubmed/{text()}" rdfs:label="pubmed:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_related_exp_data_set/VRPTx:data_reference[text()!='']" mode="linked">
    <xsl:variable name="doi_url">
      <xsl:value-of select="$doi"/>
      <xsl:call-template name="replace-string">
        <xsl:with-param name="str">
          <xsl:call-template name="replace-string">
            <xsl:with-param name="str" select="text()"/>
            <xsl:with-param name="replace">&lt;</xsl:with-param>
            <xsl:with-param name="with">&amp;lt;</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="replace">&gt;</xsl:with-param>
        <xsl:with-param name="with">&amp;gt;</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <PDBo:link_to_doi rdf:resource="{$doi_url}" rdfs:label="doi:{text()}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_related_exp_data_set/VRPTx:metadata_reference[text()!='']" mode="linked">
    <xsl:if test="../VRPTx:data_reference/text()!=text()">
    <xsl:variable name="doi_url">
      <xsl:value-of select="$doi"/>
      <xsl:call-template name="replace-string">
        <xsl:with-param name="str">
          <xsl:call-template name="replace-string">
            <xsl:with-param name="str" select="text()"/>
            <xsl:with-param name="replace">&lt;</xsl:with-param>
            <xsl:with-param name="with">&amp;lt;</xsl:with-param>
          </xsl:call-template>
        </xsl:with-param>
        <xsl:with-param name="replace">&gt;</xsl:with-param>
        <xsl:with-param name="with">&amp;gt;</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <PDBo:link_to_doi rdf:resource="{$doi_url}" rdfs:label="doi:{text()}"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="VRPTx:entity_src_gen/VRPTx:pdbx_gene_src_ncbi_taxonomy_id[text()!='']" mode="linked">
    <xsl:variable name="tax_list">
      <xsl:call-template name="tokenize">
	<xsl:with-param name="str" select="text()"/>
	<xsl:with-param name="substr">,</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:for-each select="ext:node-set($tax_list)/token">
      <xsl:variable name="tax"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
      <xsl:if test="string-length($tax)!=0">
	<PDBo:link_to_taxonomy_source rdf:resource="{$taxonomy}{$tax}" rdfs:label="taxonomy:{$tax}"/>
	<rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{$tax}" rdfs:label="taxonomy:{$tax}"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="VRPTx:entity_src_gen/VRPTx:pdbx_host_org_ncbi_taxonomy_id[text()!='']" mode="linked">
    <xsl:variable name="tax_list">
      <xsl:call-template name="tokenize">
	<xsl:with-param name="str" select="text()"/>
	<xsl:with-param name="substr">,</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:for-each select="ext:node-set($tax_list)/token">
      <xsl:variable name="tax"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
      <xsl:if test="string-length($tax)!=0">
	<PDBo:link_to_taxonomy_host rdf:resource="{$taxonomy}{$tax}" rdfs:label="taxonomy:{$tax}"/>
	<rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{$tax}" rdfs:label="taxonomy:{$tax}"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="VRPTx:entity_src_nat/VRPTx:pdbx_ncbi_taxonomy_id[text()!='']" mode="linked">
    <xsl:variable name="tax_list">
      <xsl:call-template name="tokenize">
	<xsl:with-param name="str" select="text()"/>
	<xsl:with-param name="substr">,</xsl:with-param>
      </xsl:call-template>
    </xsl:variable>
    <xsl:for-each select="ext:node-set($tax_list)/token">
      <xsl:variable name="tax"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
      <xsl:if test="string-length($tax)!=0">
	<PDBo:link_to_taxonomy_source rdf:resource="{$taxonomy}{$tax}" rdfs:label="taxonomy:{$tax}"/>
	<rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{$tax}" rdfs:label="taxonomy:{$tax}"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="VRPTx:entity/VRPTx:pdbx_ec[text()!='']" mode="linked">
    <xsl:variable name="ec_norm"><xsl:value-of select="normalize-space(text())"/></xsl:variable>
    <xsl:if test="$ec_norm!=''">
      <xsl:variable name="ec_list">
	<xsl:call-template name="tokenize">
	  <xsl:with-param name="str" select="$ec_norm"/>
	  <xsl:with-param name="substr">,</xsl:with-param>
	</xsl:call-template>
      </xsl:variable>
      <xsl:for-each select="ext:node-set($ec_list)/token">
	<xsl:variable name="ec"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
	<xsl:if test="string-length($ec)!=0">
	  <PDBo:link_to_enzyme rdf:resource="{$enzyme}{$ec}" rdfs:label="ec-code:{$ec}"/>
	  <rdfs:seeAlso rdf:resource="{$idorg}ec-code/{$ec}" rdfs:label="ec-code:{$ec}"/>
	</xsl:if>
      </xsl:for-each>
    </xsl:if>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:pdbx_db_accession[../VRPTx:db_name='UNP' and text()!='']" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_uniprot rdf:resource="{$uniprot}{$acc}" rdfs:label="uniprot:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}uniprot/{$acc}" rdfs:label="uniprot:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[(../VRPTx:db_name='GB' or ../VRPTx:db_name='GB ' or ../VRPTx:db_name='gb' or ../VRPTx:db_name='TPG') and text()!='']" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_genbank rdf:resource="{$genbank}{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[(../VRPTx:db_name='EMBL' or ../VRPTx:db_name='GENP') and text()!='']" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_embl rdf:resource="{$embl}{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='TREMBL' and string-length(text())=6 and contains(substring(text(),0,1),'OPQ') and contains(substring(text(),1,1),'0123456789')]" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_uniprot rdf:resource="{$uniprot}{$acc}" rdfs:label="uniprot:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}uniprot/{$acc}" rdfs:label="uniprot:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='TREMBL' and text()!='' and not(string-length(text())=6 and contains(substring(text(),0,1),'OPQ') and contains(substring(text(),1,1),'0123456789'))]" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_embl rdf:resource="{$embl}{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='PIR' and text()!='']" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_pir rdf:resource="{$pir}{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='REF' and text()!='']" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_refseq rdf:resource="{$refseq}{$acc}" rdfs:label="refseq:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}refseq/{$acc}" rdfs:label="refseq:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='PRF' and text()!='']" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_sequence_db rdf:resource="{$pir}{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{$acc}" rdfs:label="ncbiprotein:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='NOR' and text()!='']" mode="linked">
    <xsl:variable name="acc"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <PDBo:link_to_norine rdf:resource="{$norine}{$acc}" rdfs:label="norine:{$acc}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}norine/{$acc}" rdfs:label="norine:{$acc}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_unp_segments[@unp_acc!='']/@unp_acc" mode="linked">
    <PDBo:link_to_uniprot rdf:resource="{$uniprot}{.}" rdfs:label="uniprot:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}uniprot/{.}" rdfs:label="uniprot:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='GO' and @xref_db_acc!='']/@xref_db_acc" mode="linked">
    <xsl:variable name="go_id"><xsl:value-of select="substring-after(.,':')"/></xsl:variable>
    <PDBo:link_to_go rdf:resource="{$go}{$go_id}" rdfs:label="{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}go/{.}" rdfs:label="{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='InterPro' and @xref_db_acc!='']/@xref_db_acc" mode="linked">
    <PDBo:link_to_interpro rdf:resource="{$interpro}{.}" rdfs:label="interpro:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}interpro/{.}" rdfs:label="interpro:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='Pfam' and @xref_db_acc!='']/@xref_db_acc" mode="linked">
    <PDBo:link_to_pfam rdf:resource="{$pfam}{.}" rdfs:label="pfam:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}pfam/{.}" rdfs:label="pfam:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='CATH' and @xref_db_acc!='']/@xref_db_acc" mode="linked">
    <PDBo:link_to_cath rdf:resource="{$cath}{.}" rdfs:label="cath:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}cath/{.}" rdfs:label="cath:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='SCOP' and @xref_db_acc!='']/@xref_db_acc" mode="linked">
    <PDBo:link_to_scop rdf:resource="{$scop}{.}" rdfs:label="scop:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}scop/{.}" rdfs:label="scop:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[(@xref_db='SCOP2' or @xref_db='SCOP2B') and @xref_db_acc!='']/@xref_db_acc" mode="linked">
    <PDBo:link_to_scop rdf:resource="{$scop2}{.}" rdfs:label="scop2:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='Ensembl' and @xref_db_acc!='']/@xref_db_acc" mode="linked">
    <PDBo:link_to_ensembl rdf:resource="{$ensembl}{.}" rdfs:label="ensembl:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}ensembl/{.}" rdfs:label="ensembl:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_entity_branch_descriptor/VRPTx:descriptor[../VRPTx:type='WURCS' and text()!='']" mode="linked">
    <xsl:variable name="wurcs_id"><xsl:value-of select="translate(text(),' ','')"/></xsl:variable>
    <xsl:for-each select="$glytoucan/catalog/wurcs[@id=$wurcs_id]">
      <xsl:if test="text()!=''">
	<PDBo:link_to_glycoinfo rdf:resource="{$glycoinfo}{text()}" rdfs:label="glytoucan:{text()}"/>
	<rdfs:seeAlso rdf:resource="{$idorg}glytoucan/{text()}" rdfs:label="glytoucan:{text()}"/>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_related[@db_name='PDB' and @content_type!='split']/@db_id" mode="linked">
    <PDBo:link_to_pdb rdf:resource="{$pdb_link}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_related[@db_name='PDB' and @content_type='split']/@db_id" mode="linked">
    <PDBo:link_to_pdb_split rdf:resource="{$pdb_link}{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:chem_comp/VRPTx:pdbx_model_coordinates_db_code" mode="linked">
    <PDBo:link_to_pdb rdf:resource="{$pdb_link}{translate(text(),' ','')}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_related[@db_name='BMRB']/@db_id" mode="linked">
    <PDBo:link_to_bmrb rdf:resource="{$bmrb}{.}" rdfs:label="bmrb:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}bmrb/{.}" rdfs:label="bmrb:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_related[@db_name='EMDB']/@db_id" mode="linked">
    <PDBo:link_to_emdb rdf:resource="{$emdb}{.}" rdfs:label="emdb:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}emdb/{.}" rdfs:label="emdb:{.}"/>
  </xsl:template>

  <xsl:template match="VRPTx:pdbx_database_related[@db_name='SASBDB']/@db_id" mode="linked">
    <PDBo:link_to_sasbdb rdf:resource="{$sasbdb}{.}" rdfs:label="sasbdb:{.}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}sasbdb/{.}" rdfs:label="sasbdb:{.}"/>
  </xsl:template>

  <!-- level 3 templates follow -->
  <xsl:template match="VRPTx:datablock/VRPTx:diffrnCategory/VRPTx:diffrn">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn>
      <PDBo:diffrn rdf:about="{$base}/diffrn/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn>
      </PDBo:has_diffrn>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_attenuatorCategory/VRPTx:diffrn_attenuator">
      <xsl:variable name="code_truncated"><xsl:choose><xsl:when test="string-length(@code)&lt;64"><xsl:value-of select="@code"/></xsl:when><xsl:when test="contains(@code,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@code,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@code,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="code_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($code_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_attenuator>
      <PDBo:diffrn_attenuator rdf:about="{$base}/diffrn_attenuator/{$code_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_attenuator>
      </PDBo:has_diffrn_attenuator>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_detectorCategory/VRPTx:diffrn_detector">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_detector>
      <PDBo:diffrn_detector rdf:about="{$base}/diffrn_detector/{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_detector rdf:resource="{$base}/diffrn_detector/{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_detector>
      </PDBo:has_diffrn_detector>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_measurementCategory/VRPTx:diffrn_measurement">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_measurement>
      <PDBo:diffrn_measurement rdf:about="{$base}/diffrn_measurement/{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_measurement rdf:resource="{$base}/diffrn_measurement/{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_measurement>
      </PDBo:has_diffrn_measurement>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_orient_matrixCategory/VRPTx:diffrn_orient_matrix">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_orient_matrix>
      <PDBo:diffrn_orient_matrix rdf:about="{$base}/diffrn_orient_matrix/{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_orient_matrix rdf:resource="{$base}/diffrn_orient_matrix/{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_orient_matrix>
      </PDBo:has_diffrn_orient_matrix>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_orient_reflnCategory/VRPTx:diffrn_orient_refln">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_h_truncated"><xsl:choose><xsl:when test="string-length(@index_h)&lt;64"><xsl:value-of select="@index_h"/></xsl:when><xsl:when test="contains(@index_h,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_h,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_h,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_h_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_h_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_k_truncated"><xsl:choose><xsl:when test="string-length(@index_k)&lt;64"><xsl:value-of select="@index_k"/></xsl:when><xsl:when test="contains(@index_k,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_k,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_k,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_k_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_k_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_l_truncated"><xsl:choose><xsl:when test="string-length(@index_l)&lt;64"><xsl:value-of select="@index_l"/></xsl:when><xsl:when test="contains(@index_l,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_l,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_l,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_l_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_l_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_orient_refln>
      <PDBo:diffrn_orient_refln rdf:about="{$base}/diffrn_orient_refln/{$diffrn_id_encoded},{$index_h_encoded},{$index_k_encoded},{$index_l_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_orient_refln rdf:resource="{$base}/diffrn_orient_refln/{$diffrn_id_encoded},{$index_h_encoded},{$index_k_encoded},{$index_l_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_orient_refln>
      </PDBo:has_diffrn_orient_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_radiationCategory/VRPTx:diffrn_radiation">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_radiation>
      <PDBo:diffrn_radiation rdf:about="{$base}/diffrn_radiation/{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_radiation rdf:resource="{$base}/diffrn_radiation/{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_radiation>
      </PDBo:has_diffrn_radiation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_radiation_wavelengthCategory/VRPTx:diffrn_radiation_wavelength">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_radiation_wavelength>
      <PDBo:diffrn_radiation_wavelength rdf:about="{$base}/diffrn_radiation_wavelength/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_radiation_wavelength>
      </PDBo:has_diffrn_radiation_wavelength>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_reflnCategory/VRPTx:diffrn_refln">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_refln>
      <PDBo:diffrn_refln rdf:about="{$base}/diffrn_refln/{$diffrn_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_refln rdf:resource="{$base}/diffrn_refln/{$diffrn_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_refln>
      </PDBo:has_diffrn_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_reflnsCategory/VRPTx:diffrn_reflns">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_reflns>
      <PDBo:diffrn_reflns rdf:about="{$base}/diffrn_reflns/{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_reflns rdf:resource="{$base}/diffrn_reflns/{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_reflns>
      </PDBo:has_diffrn_reflns>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_reflns_classCategory/VRPTx:diffrn_reflns_class">
      <xsl:variable name="code_truncated"><xsl:choose><xsl:when test="string-length(@code)&lt;64"><xsl:value-of select="@code"/></xsl:when><xsl:when test="contains(@code,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@code,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@code,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="code_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($code_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_reflns_class>
      <PDBo:diffrn_reflns_class rdf:about="{$base}/diffrn_reflns_class/{$code_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_reflns_class>
      </PDBo:has_diffrn_reflns_class>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_scale_groupCategory/VRPTx:diffrn_scale_group">
      <xsl:variable name="code_truncated"><xsl:choose><xsl:when test="string-length(@code)&lt;64"><xsl:value-of select="@code"/></xsl:when><xsl:when test="contains(@code,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@code,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@code,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="code_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($code_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_scale_group>
      <PDBo:diffrn_scale_group rdf:about="{$base}/diffrn_scale_group/{$code_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_scale_group>
      </PDBo:has_diffrn_scale_group>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_sourceCategory/VRPTx:diffrn_source">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_source>
      <PDBo:diffrn_source rdf:about="{$base}/diffrn_source/{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_source rdf:resource="{$base}/diffrn_source/{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_source>
      </PDBo:has_diffrn_source>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_standard_reflnCategory/VRPTx:diffrn_standard_refln">
      <xsl:variable name="code_truncated"><xsl:choose><xsl:when test="string-length(@code)&lt;64"><xsl:value-of select="@code"/></xsl:when><xsl:when test="contains(@code,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@code,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@code,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="code_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($code_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_standard_refln>
      <PDBo:diffrn_standard_refln rdf:about="{$base}/diffrn_standard_refln/{$code_encoded},{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_standard_refln rdf:resource="{$base}/diffrn_standard_refln/{$code_encoded},{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_standard_refln>
      </PDBo:has_diffrn_standard_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:diffrn_standardsCategory/VRPTx:diffrn_standards">
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_diffrn_standards>
      <PDBo:diffrn_standards rdf:about="{$base}/diffrn_standards/{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_diffrn_standards rdf:resource="{$base}/diffrn_standards/{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_standards>
      </PDBo:has_diffrn_standards>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_2d_crystal_entityCategory/VRPTx:em_2d_crystal_entity">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_processing_id_truncated"><xsl:choose><xsl:when test="string-length(@image_processing_id)&lt;64"><xsl:value-of select="@image_processing_id"/></xsl:when><xsl:when test="contains(@image_processing_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_processing_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_processing_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_processing_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_processing_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_2d_crystal_entity>
      <PDBo:em_2d_crystal_entity rdf:about="{$base}/em_2d_crystal_entity/{$id_encoded},{$image_processing_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_2d_crystal_entity>
      </PDBo:has_em_2d_crystal_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_3d_crystal_entityCategory/VRPTx:em_3d_crystal_entity">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_processing_id_truncated"><xsl:choose><xsl:when test="string-length(@image_processing_id)&lt;64"><xsl:value-of select="@image_processing_id"/></xsl:when><xsl:when test="contains(@image_processing_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_processing_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_processing_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_processing_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_processing_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_3d_crystal_entity>
      <PDBo:em_3d_crystal_entity rdf:about="{$base}/em_3d_crystal_entity/{$id_encoded},{$image_processing_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_3d_crystal_entity>
      </PDBo:has_em_3d_crystal_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_3d_fittingCategory/VRPTx:em_3d_fitting">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_3d_fitting>
      <PDBo:em_3d_fitting rdf:about="{$base}/em_3d_fitting/{$entry_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_em_3d_fitting rdf:resource="{$base}/em_3d_fitting/{$entry_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_3d_fitting>
      </PDBo:has_em_3d_fitting>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_3d_fitting_listCategory/VRPTx:em_3d_fitting_list">
      <xsl:variable name="_3d_fitting_id_truncated"><xsl:choose><xsl:when test="string-length(@_3d_fitting_id)&lt;64"><xsl:value-of select="@_3d_fitting_id"/></xsl:when><xsl:when test="contains(@_3d_fitting_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@_3d_fitting_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@_3d_fitting_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="_3d_fitting_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($_3d_fitting_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_3d_fitting_list>
      <PDBo:em_3d_fitting_list rdf:about="{$base}/em_3d_fitting_list/{$_3d_fitting_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_3d_fitting_list>
      </PDBo:has_em_3d_fitting_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_3d_reconstructionCategory/VRPTx:em_3d_reconstruction">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_processing_id_truncated"><xsl:choose><xsl:when test="string-length(@image_processing_id)&lt;64"><xsl:value-of select="@image_processing_id"/></xsl:when><xsl:when test="contains(@image_processing_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_processing_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_processing_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_processing_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_processing_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_3d_reconstruction>
      <PDBo:em_3d_reconstruction rdf:about="{$base}/em_3d_reconstruction/{$id_encoded},{$image_processing_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/{translate(VRPTx:entry_id,' ^','__')}">
	    <PDBo:referenced_by_em_3d_reconstruction rdf:resource="{$base}/em_3d_reconstruction/{$id_encoded},{$image_processing_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_3d_reconstruction>
      </PDBo:has_em_3d_reconstruction>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_adminCategory/VRPTx:em_admin">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_admin>
      <PDBo:em_admin rdf:about="{$base}/em_admin/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_admin>
      </PDBo:has_em_admin>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_bufferCategory/VRPTx:em_buffer">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="specimen_id_truncated"><xsl:choose><xsl:when test="string-length(@specimen_id)&lt;64"><xsl:value-of select="@specimen_id"/></xsl:when><xsl:when test="contains(@specimen_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@specimen_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@specimen_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="specimen_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($specimen_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_buffer>
      <PDBo:em_buffer rdf:about="{$base}/em_buffer/{$id_encoded},{$specimen_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_buffer>
      </PDBo:has_em_buffer>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_buffer_componentCategory/VRPTx:em_buffer_component">
      <xsl:variable name="buffer_id_truncated"><xsl:choose><xsl:when test="string-length(@buffer_id)&lt;64"><xsl:value-of select="@buffer_id"/></xsl:when><xsl:when test="contains(@buffer_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@buffer_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@buffer_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="buffer_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($buffer_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_buffer_component>
      <PDBo:em_buffer_component rdf:about="{$base}/em_buffer_component/{$buffer_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_buffer_component>
      </PDBo:has_em_buffer_component>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_crystal_formationCategory/VRPTx:em_crystal_formation">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_crystal_formation>
      <PDBo:em_crystal_formation rdf:about="{$base}/em_crystal_formation/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_crystal_formation>
      </PDBo:has_em_crystal_formation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_ctf_correctionCategory/VRPTx:em_ctf_correction">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_ctf_correction>
      <PDBo:em_ctf_correction rdf:about="{$base}/em_ctf_correction/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_ctf_correction>
      </PDBo:has_em_ctf_correction>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_diffractionCategory/VRPTx:em_diffraction">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_diffraction>
      <PDBo:em_diffraction rdf:about="{$base}/em_diffraction/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_diffraction>
      </PDBo:has_em_diffraction>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_diffraction_shellCategory/VRPTx:em_diffraction_shell">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_diffraction_shell>
      <PDBo:em_diffraction_shell rdf:about="{$base}/em_diffraction_shell/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_diffraction_shell>
      </PDBo:has_em_diffraction_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_diffraction_statsCategory/VRPTx:em_diffraction_stats">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_diffraction_stats>
      <PDBo:em_diffraction_stats rdf:about="{$base}/em_diffraction_stats/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_diffraction_stats>
      </PDBo:has_em_diffraction_stats>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_embeddingCategory/VRPTx:em_embedding">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_embedding>
      <PDBo:em_embedding rdf:about="{$base}/em_embedding/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_embedding>
      </PDBo:has_em_embedding>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assemblyCategory/VRPTx:em_entity_assembly">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_entity_assembly>
      <PDBo:em_entity_assembly rdf:about="{$base}/em_entity_assembly/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_entity_assembly>
      </PDBo:has_em_entity_assembly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assembly_molwtCategory/VRPTx:em_entity_assembly_molwt">
      <xsl:variable name="entity_assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_assembly_id)&lt;64"><xsl:value-of select="@entity_assembly_id"/></xsl:when><xsl:when test="contains(@entity_assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_entity_assembly_molwt>
      <PDBo:em_entity_assembly_molwt rdf:about="{$base}/em_entity_assembly_molwt/{$entity_assembly_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
	<PDBo:reference_to_em_entity_assembly>
	  <rdf:Description rdf:about="{$base}/em_entity_assembly/">
	    <PDBo:referenced_by_em_entity_assembly_molwt rdf:resource="{$base}/em_entity_assembly_molwt/{$entity_assembly_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_em_entity_assembly>
	<!-- em_entity_assemblyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_entity_assembly_molwt>
      </PDBo:has_em_entity_assembly_molwt>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assembly_naturalsourceCategory/VRPTx:em_entity_assembly_naturalsource">
      <xsl:variable name="entity_assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_assembly_id)&lt;64"><xsl:value-of select="@entity_assembly_id"/></xsl:when><xsl:when test="contains(@entity_assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_entity_assembly_naturalsource>
      <PDBo:em_entity_assembly_naturalsource rdf:about="{$base}/em_entity_assembly_naturalsource/{$entity_assembly_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
	<PDBo:reference_to_em_entity_assembly>
	  <rdf:Description rdf:about="{$base}/em_entity_assembly/">
	    <PDBo:referenced_by_em_entity_assembly_naturalsource rdf:resource="{$base}/em_entity_assembly_naturalsource/{$entity_assembly_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_em_entity_assembly>
	<!-- em_entity_assemblyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_entity_assembly_naturalsource>
      </PDBo:has_em_entity_assembly_naturalsource>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assembly_recombinantCategory/VRPTx:em_entity_assembly_recombinant">
      <xsl:variable name="entity_assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_assembly_id)&lt;64"><xsl:value-of select="@entity_assembly_id"/></xsl:when><xsl:when test="contains(@entity_assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_entity_assembly_recombinant>
      <PDBo:em_entity_assembly_recombinant rdf:about="{$base}/em_entity_assembly_recombinant/{$entity_assembly_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
	<PDBo:reference_to_em_entity_assembly>
	  <rdf:Description rdf:about="{$base}/em_entity_assembly/">
	    <PDBo:referenced_by_em_entity_assembly_recombinant rdf:resource="{$base}/em_entity_assembly_recombinant/{$entity_assembly_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_em_entity_assembly>
	<!-- em_entity_assemblyKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_entity_assembly_recombinant>
      </PDBo:has_em_entity_assembly_recombinant>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_entity_assembly_syntheticCategory/VRPTx:em_entity_assembly_synthetic">
      <xsl:variable name="entity_assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_assembly_id)&lt;64"><xsl:value-of select="@entity_assembly_id"/></xsl:when><xsl:when test="contains(@entity_assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_entity_assembly_synthetic>
      <PDBo:em_entity_assembly_synthetic rdf:about="{$base}/em_entity_assembly_synthetic/{$entity_assembly_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
	<PDBo:reference_to_em_entity_assembly>
	  <rdf:Description rdf:about="{$base}/em_entity_assembly/">
	    <PDBo:referenced_by_em_entity_assembly_synthetic rdf:resource="{$base}/em_entity_assembly_synthetic/{$entity_assembly_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_em_entity_assembly>
	<!-- em_entity_assemblyKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_entity_assembly_synthetic>
      </PDBo:has_em_entity_assembly_synthetic>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_experimentCategory/VRPTx:em_experiment">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_experiment>
      <PDBo:em_experiment rdf:about="{$base}/em_experiment/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_em_experiment rdf:resource="{$base}/em_experiment/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_experiment>
      </PDBo:has_em_experiment>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_helical_entityCategory/VRPTx:em_helical_entity">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_processing_id_truncated"><xsl:choose><xsl:when test="string-length(@image_processing_id)&lt;64"><xsl:value-of select="@image_processing_id"/></xsl:when><xsl:when test="contains(@image_processing_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_processing_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_processing_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_processing_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_processing_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_helical_entity>
      <PDBo:em_helical_entity rdf:about="{$base}/em_helical_entity/{$id_encoded},{$image_processing_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_helical_entity>
      </PDBo:has_em_helical_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_image_processingCategory/VRPTx:em_image_processing">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_recording_id_truncated"><xsl:choose><xsl:when test="string-length(@image_recording_id)&lt;64"><xsl:value-of select="@image_recording_id"/></xsl:when><xsl:when test="contains(@image_recording_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_recording_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_recording_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_recording_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_recording_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_image_processing>
      <PDBo:em_image_processing rdf:about="{$base}/em_image_processing/{$id_encoded},{$image_recording_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_image_processing>
      </PDBo:has_em_image_processing>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_image_recordingCategory/VRPTx:em_image_recording">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="imaging_id_truncated"><xsl:choose><xsl:when test="string-length(@imaging_id)&lt;64"><xsl:value-of select="@imaging_id"/></xsl:when><xsl:when test="contains(@imaging_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@imaging_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@imaging_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="imaging_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($imaging_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_image_recording>
      <PDBo:em_image_recording rdf:about="{$base}/em_image_recording/{$id_encoded},{$imaging_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_image_recording>
      </PDBo:has_em_image_recording>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_image_scansCategory/VRPTx:em_image_scans">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_recording_id_truncated"><xsl:choose><xsl:when test="string-length(@image_recording_id)&lt;64"><xsl:value-of select="@image_recording_id"/></xsl:when><xsl:when test="contains(@image_recording_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_recording_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_recording_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_recording_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_recording_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_image_scans>
      <PDBo:em_image_scans rdf:about="{$base}/em_image_scans/{$id_encoded},{$image_recording_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/{translate(VRPTx:entry_id,' ^','__')}">
	    <PDBo:referenced_by_em_image_scans rdf:resource="{$base}/em_image_scans/{$id_encoded},{$image_recording_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_image_scans>
      </PDBo:has_em_image_scans>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_imagingCategory/VRPTx:em_imaging">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_imaging>
      <PDBo:em_imaging rdf:about="{$base}/em_imaging/{$entry_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_em_imaging rdf:resource="{$base}/em_imaging/{$entry_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_imaging>
      </PDBo:has_em_imaging>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_imaging_opticsCategory/VRPTx:em_imaging_optics">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="imaging_id_truncated"><xsl:choose><xsl:when test="string-length(@imaging_id)&lt;64"><xsl:value-of select="@imaging_id"/></xsl:when><xsl:when test="contains(@imaging_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@imaging_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@imaging_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="imaging_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($imaging_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_imaging_optics>
      <PDBo:em_imaging_optics rdf:about="{$base}/em_imaging_optics/{$id_encoded},{$imaging_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_imaging_optics>
      </PDBo:has_em_imaging_optics>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_particle_selectionCategory/VRPTx:em_particle_selection">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_processing_id_truncated"><xsl:choose><xsl:when test="string-length(@image_processing_id)&lt;64"><xsl:value-of select="@image_processing_id"/></xsl:when><xsl:when test="contains(@image_processing_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_processing_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_processing_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_processing_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_processing_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_particle_selection>
      <PDBo:em_particle_selection rdf:about="{$base}/em_particle_selection/{$id_encoded},{$image_processing_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_particle_selection>
      </PDBo:has_em_particle_selection>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_single_particle_entityCategory/VRPTx:em_single_particle_entity">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_processing_id_truncated"><xsl:choose><xsl:when test="string-length(@image_processing_id)&lt;64"><xsl:value-of select="@image_processing_id"/></xsl:when><xsl:when test="contains(@image_processing_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_processing_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_processing_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_processing_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_processing_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_single_particle_entity>
      <PDBo:em_single_particle_entity rdf:about="{$base}/em_single_particle_entity/{$id_encoded},{$image_processing_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_single_particle_entity>
      </PDBo:has_em_single_particle_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_softwareCategory/VRPTx:em_software">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_software>
      <PDBo:em_software rdf:about="{$base}/em_software/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_software>
      </PDBo:has_em_software>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_specimenCategory/VRPTx:em_specimen">
      <xsl:variable name="experiment_id_truncated"><xsl:choose><xsl:when test="string-length(@experiment_id)&lt;64"><xsl:value-of select="@experiment_id"/></xsl:when><xsl:when test="contains(@experiment_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@experiment_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@experiment_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="experiment_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($experiment_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_specimen>
      <PDBo:em_specimen rdf:about="{$base}/em_specimen/{$experiment_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_specimen>
      </PDBo:has_em_specimen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_stainingCategory/VRPTx:em_staining">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_staining>
      <PDBo:em_staining rdf:about="{$base}/em_staining/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_staining>
      </PDBo:has_em_staining>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_virus_entityCategory/VRPTx:em_virus_entity">
      <xsl:variable name="entity_assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_assembly_id)&lt;64"><xsl:value-of select="@entity_assembly_id"/></xsl:when><xsl:when test="contains(@entity_assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_virus_entity>
      <PDBo:em_virus_entity rdf:about="{$base}/em_virus_entity/{$entity_assembly_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
	<PDBo:reference_to_em_entity_assembly>
	  <rdf:Description rdf:about="{$base}/em_entity_assembly/">
	    <PDBo:referenced_by_em_virus_entity rdf:resource="{$base}/em_virus_entity/{$entity_assembly_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_em_entity_assembly>
	<!-- em_entity_assemblyKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_virus_entity>
      </PDBo:has_em_virus_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_virus_natural_hostCategory/VRPTx:em_virus_natural_host">
      <xsl:variable name="entity_assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_assembly_id)&lt;64"><xsl:value-of select="@entity_assembly_id"/></xsl:when><xsl:when test="contains(@entity_assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_virus_natural_host>
      <PDBo:em_virus_natural_host rdf:about="{$base}/em_virus_natural_host/{$entity_assembly_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
	<PDBo:reference_to_em_entity_assembly>
	  <rdf:Description rdf:about="{$base}/em_entity_assembly/">
	    <PDBo:referenced_by_em_virus_natural_host rdf:resource="{$base}/em_virus_natural_host/{$entity_assembly_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_em_entity_assembly>
	<!-- em_entity_assemblyKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_virus_natural_host>
      </PDBo:has_em_virus_natural_host>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_virus_shellCategory/VRPTx:em_virus_shell">
      <xsl:variable name="entity_assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_assembly_id)&lt;64"><xsl:value-of select="@entity_assembly_id"/></xsl:when><xsl:when test="contains(@entity_assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_virus_shell>
      <PDBo:em_virus_shell rdf:about="{$base}/em_virus_shell/{$entity_assembly_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
	<PDBo:reference_to_em_entity_assembly>
	  <rdf:Description rdf:about="{$base}/em_entity_assembly/">
	    <PDBo:referenced_by_em_virus_shell rdf:resource="{$base}/em_virus_shell/{$entity_assembly_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_em_entity_assembly>
	<!-- em_entity_assemblyKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_virus_shell>
      </PDBo:has_em_virus_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_virus_syntheticCategory/VRPTx:em_virus_synthetic">
      <xsl:variable name="entity_assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_assembly_id)&lt;64"><xsl:value-of select="@entity_assembly_id"/></xsl:when><xsl:when test="contains(@entity_assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_virus_synthetic>
      <PDBo:em_virus_synthetic rdf:about="{$base}/em_virus_synthetic/{$entity_assembly_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
	<PDBo:reference_to_em_entity_assembly>
	  <rdf:Description rdf:about="{$base}/em_entity_assembly/">
	    <PDBo:referenced_by_em_virus_synthetic rdf:resource="{$base}/em_virus_synthetic/{$entity_assembly_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_em_entity_assembly>
	<!-- em_entity_assemblyKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_virus_synthetic>
      </PDBo:has_em_virus_synthetic>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_vitrificationCategory/VRPTx:em_vitrification">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="specimen_id_truncated"><xsl:choose><xsl:when test="string-length(@specimen_id)&lt;64"><xsl:value-of select="@specimen_id"/></xsl:when><xsl:when test="contains(@specimen_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@specimen_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@specimen_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="specimen_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($specimen_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_vitrification>
      <PDBo:em_vitrification rdf:about="{$base}/em_vitrification/{$id_encoded},{$specimen_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/{translate(VRPTx:entry_id,' ^','__')}">
	    <PDBo:referenced_by_em_vitrification rdf:resource="{$base}/em_vitrification/{$id_encoded},{$specimen_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_vitrification>
      </PDBo:has_em_vitrification>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:em_volume_selectionCategory/VRPTx:em_volume_selection">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="image_processing_id_truncated"><xsl:choose><xsl:when test="string-length(@image_processing_id)&lt;64"><xsl:value-of select="@image_processing_id"/></xsl:when><xsl:when test="contains(@image_processing_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@image_processing_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@image_processing_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="image_processing_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($image_processing_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_em_volume_selection>
      <PDBo:em_volume_selection rdf:about="{$base}/em_volume_selection/{$id_encoded},{$image_processing_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_volume_selection>
      </PDBo:has_em_volume_selection>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entityCategory/VRPTx:entity">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_entity>
      <PDBo:entity rdf:about="{$base}/entity/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity>
      </PDBo:has_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entity_name_comCategory/VRPTx:entity_name_com">
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_entity_name_com>
      <PDBo:entity_name_com rdf:about="{$base}/entity_name_com/{$entity_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/">
	    <PDBo:referenced_by_entity_name_com rdf:resource="{$base}/entity_name_com/{$entity_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_name_com>
      </PDBo:has_entity_name_com>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entity_name_sysCategory/VRPTx:entity_name_sys">
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_entity_name_sys>
      <PDBo:entity_name_sys rdf:about="{$base}/entity_name_sys/{$entity_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/">
	    <PDBo:referenced_by_entity_name_sys rdf:resource="{$base}/entity_name_sys/{$entity_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_name_sys>
      </PDBo:has_entity_name_sys>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entity_polyCategory/VRPTx:entity_poly">
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_entity_poly>
      <PDBo:entity_poly rdf:about="{$base}/entity_poly/{$entity_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/">
	    <PDBo:referenced_by_entity_poly rdf:resource="{$base}/entity_poly/{$entity_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_poly>
      </PDBo:has_entity_poly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entity_poly_seqCategory/VRPTx:entity_poly_seq">
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="mon_id_truncated"><xsl:choose><xsl:when test="string-length(@mon_id)&lt;64"><xsl:value-of select="@mon_id"/></xsl:when><xsl:when test="contains(@mon_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@mon_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@mon_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="mon_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($mon_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="num_truncated"><xsl:choose><xsl:when test="string-length(@num)&lt;64"><xsl:value-of select="@num"/></xsl:when><xsl:when test="contains(@num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_entity_poly_seq>
      <PDBo:entity_poly_seq rdf:about="{$base}/entity_poly_seq/{$entity_id_encoded},{$mon_id_encoded},{$num_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity_poly>
	  <rdf:Description rdf:about="{$base}/entity_poly/">
	    <PDBo:referenced_by_entity_poly_seq rdf:resource="{$base}/entity_poly_seq/{$entity_id_encoded},{$mon_id_encoded},{$num_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity_poly>
	<!-- entity_polyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_poly_seq>
      </PDBo:has_entity_poly_seq>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entryCategory/VRPTx:entry">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_entry>
      <PDBo:entry rdf:about="{$base}/entry/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entry>
      </PDBo:has_entry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:entry_linkCategory/VRPTx:entry_link">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_entry_link>
      <PDBo:entry_link rdf:about="{$base}/entry_link/{$entry_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_entry_link rdf:resource="{$base}/entry_link/{$entry_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entry_link>
      </PDBo:has_entry_link>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:exptlCategory/VRPTx:exptl">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="method_truncated"><xsl:choose><xsl:when test="string-length(@method)&lt;64"><xsl:value-of select="@method"/></xsl:when><xsl:when test="contains(@method,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@method,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@method,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="method_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($method_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_exptl>
      <PDBo:exptl rdf:about="{$base}/exptl/{$entry_id_encoded},{$method_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_exptl rdf:resource="{$base}/exptl/{$entry_id_encoded},{$method_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:exptl>
      </PDBo:has_exptl>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:ndb_struct_conf_naCategory/VRPTx:ndb_struct_conf_na">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="feature_truncated"><xsl:choose><xsl:when test="string-length(@feature)&lt;64"><xsl:value-of select="@feature"/></xsl:when><xsl:when test="contains(@feature,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@feature,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@feature,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="feature_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($feature_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_ndb_struct_conf_na>
      <PDBo:ndb_struct_conf_na rdf:about="{$base}/ndb_struct_conf_na/{$entry_id_encoded},{$feature_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_ndb_struct_conf_na rdf:resource="{$base}/ndb_struct_conf_na/{$entry_id_encoded},{$feature_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:ndb_struct_conf_na>
      </PDBo:has_ndb_struct_conf_na>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:ndb_struct_na_base_pairCategory/VRPTx:ndb_struct_na_base_pair">
      <xsl:variable name="i_label_asym_id_truncated"><xsl:choose><xsl:when test="string-length(@i_label_asym_id)&lt;64"><xsl:value-of select="@i_label_asym_id"/></xsl:when><xsl:when test="contains(@i_label_asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_label_comp_id_truncated"><xsl:choose><xsl:when test="string-length(@i_label_comp_id)&lt;64"><xsl:value-of select="@i_label_comp_id"/></xsl:when><xsl:when test="contains(@i_label_comp_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_comp_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_comp_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_comp_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_comp_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_label_seq_id_truncated"><xsl:choose><xsl:when test="string-length(@i_label_seq_id)&lt;64"><xsl:value-of select="@i_label_seq_id"/></xsl:when><xsl:when test="contains(@i_label_seq_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_seq_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_seq_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_seq_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_seq_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_symmetry_truncated"><xsl:choose><xsl:when test="string-length(@i_symmetry)&lt;64"><xsl:value-of select="@i_symmetry"/></xsl:when><xsl:when test="contains(@i_symmetry,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_symmetry,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_symmetry,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_symmetry_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_symmetry_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_asym_id_truncated"><xsl:choose><xsl:when test="string-length(@j_label_asym_id)&lt;64"><xsl:value-of select="@j_label_asym_id"/></xsl:when><xsl:when test="contains(@j_label_asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_comp_id_truncated"><xsl:choose><xsl:when test="string-length(@j_label_comp_id)&lt;64"><xsl:value-of select="@j_label_comp_id"/></xsl:when><xsl:when test="contains(@j_label_comp_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_comp_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_comp_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_comp_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_comp_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_seq_id_truncated"><xsl:choose><xsl:when test="string-length(@j_label_seq_id)&lt;64"><xsl:value-of select="@j_label_seq_id"/></xsl:when><xsl:when test="contains(@j_label_seq_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_seq_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_seq_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_seq_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_seq_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_symmetry_truncated"><xsl:choose><xsl:when test="string-length(@j_symmetry)&lt;64"><xsl:value-of select="@j_symmetry"/></xsl:when><xsl:when test="contains(@j_symmetry,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_symmetry,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_symmetry,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_symmetry_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_symmetry_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="model_number_truncated"><xsl:choose><xsl:when test="string-length(@model_number)&lt;64"><xsl:value-of select="@model_number"/></xsl:when><xsl:when test="contains(@model_number,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@model_number,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@model_number,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="model_number_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($model_number_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_ndb_struct_na_base_pair>
      <PDBo:ndb_struct_na_base_pair rdf:about="{$base}/ndb_struct_na_base_pair/{$i_label_asym_id_encoded},{$i_label_comp_id_encoded},{$i_label_seq_id_encoded},{$i_symmetry_encoded},{$j_label_asym_id_encoded},{$j_label_comp_id_encoded},{$j_label_seq_id_encoded},{$j_symmetry_encoded},{$model_number_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:ndb_struct_na_base_pair>
      </PDBo:has_ndb_struct_na_base_pair>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:ndb_struct_na_base_pair_stepCategory/VRPTx:ndb_struct_na_base_pair_step">
      <xsl:variable name="i_label_asym_id_1_truncated"><xsl:choose><xsl:when test="string-length(@i_label_asym_id_1)&lt;64"><xsl:value-of select="@i_label_asym_id_1"/></xsl:when><xsl:when test="contains(@i_label_asym_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_asym_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_asym_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_asym_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_asym_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_label_asym_id_2_truncated"><xsl:choose><xsl:when test="string-length(@i_label_asym_id_2)&lt;64"><xsl:value-of select="@i_label_asym_id_2"/></xsl:when><xsl:when test="contains(@i_label_asym_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_asym_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_asym_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_asym_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_asym_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_label_comp_id_1_truncated"><xsl:choose><xsl:when test="string-length(@i_label_comp_id_1)&lt;64"><xsl:value-of select="@i_label_comp_id_1"/></xsl:when><xsl:when test="contains(@i_label_comp_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_comp_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_comp_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_comp_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_comp_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_label_comp_id_2_truncated"><xsl:choose><xsl:when test="string-length(@i_label_comp_id_2)&lt;64"><xsl:value-of select="@i_label_comp_id_2"/></xsl:when><xsl:when test="contains(@i_label_comp_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_comp_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_comp_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_comp_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_comp_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_label_seq_id_1_truncated"><xsl:choose><xsl:when test="string-length(@i_label_seq_id_1)&lt;64"><xsl:value-of select="@i_label_seq_id_1"/></xsl:when><xsl:when test="contains(@i_label_seq_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_seq_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_seq_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_seq_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_seq_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_label_seq_id_2_truncated"><xsl:choose><xsl:when test="string-length(@i_label_seq_id_2)&lt;64"><xsl:value-of select="@i_label_seq_id_2"/></xsl:when><xsl:when test="contains(@i_label_seq_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_label_seq_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_label_seq_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_label_seq_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_label_seq_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_symmetry_1_truncated"><xsl:choose><xsl:when test="string-length(@i_symmetry_1)&lt;64"><xsl:value-of select="@i_symmetry_1"/></xsl:when><xsl:when test="contains(@i_symmetry_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_symmetry_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_symmetry_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_symmetry_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_symmetry_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="i_symmetry_2_truncated"><xsl:choose><xsl:when test="string-length(@i_symmetry_2)&lt;64"><xsl:value-of select="@i_symmetry_2"/></xsl:when><xsl:when test="contains(@i_symmetry_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@i_symmetry_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@i_symmetry_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="i_symmetry_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($i_symmetry_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_asym_id_1_truncated"><xsl:choose><xsl:when test="string-length(@j_label_asym_id_1)&lt;64"><xsl:value-of select="@j_label_asym_id_1"/></xsl:when><xsl:when test="contains(@j_label_asym_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_asym_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_asym_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_asym_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_asym_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_asym_id_2_truncated"><xsl:choose><xsl:when test="string-length(@j_label_asym_id_2)&lt;64"><xsl:value-of select="@j_label_asym_id_2"/></xsl:when><xsl:when test="contains(@j_label_asym_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_asym_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_asym_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_asym_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_asym_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_comp_id_1_truncated"><xsl:choose><xsl:when test="string-length(@j_label_comp_id_1)&lt;64"><xsl:value-of select="@j_label_comp_id_1"/></xsl:when><xsl:when test="contains(@j_label_comp_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_comp_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_comp_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_comp_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_comp_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_comp_id_2_truncated"><xsl:choose><xsl:when test="string-length(@j_label_comp_id_2)&lt;64"><xsl:value-of select="@j_label_comp_id_2"/></xsl:when><xsl:when test="contains(@j_label_comp_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_comp_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_comp_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_comp_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_comp_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_seq_id_1_truncated"><xsl:choose><xsl:when test="string-length(@j_label_seq_id_1)&lt;64"><xsl:value-of select="@j_label_seq_id_1"/></xsl:when><xsl:when test="contains(@j_label_seq_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_seq_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_seq_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_seq_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_seq_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_label_seq_id_2_truncated"><xsl:choose><xsl:when test="string-length(@j_label_seq_id_2)&lt;64"><xsl:value-of select="@j_label_seq_id_2"/></xsl:when><xsl:when test="contains(@j_label_seq_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_label_seq_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_label_seq_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_label_seq_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_label_seq_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_symmetry_1_truncated"><xsl:choose><xsl:when test="string-length(@j_symmetry_1)&lt;64"><xsl:value-of select="@j_symmetry_1"/></xsl:when><xsl:when test="contains(@j_symmetry_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_symmetry_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_symmetry_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_symmetry_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_symmetry_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="j_symmetry_2_truncated"><xsl:choose><xsl:when test="string-length(@j_symmetry_2)&lt;64"><xsl:value-of select="@j_symmetry_2"/></xsl:when><xsl:when test="contains(@j_symmetry_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@j_symmetry_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@j_symmetry_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="j_symmetry_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($j_symmetry_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="model_number_truncated"><xsl:choose><xsl:when test="string-length(@model_number)&lt;64"><xsl:value-of select="@model_number"/></xsl:when><xsl:when test="contains(@model_number,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@model_number,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@model_number,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="model_number_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($model_number_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_ndb_struct_na_base_pair_step>
      <PDBo:ndb_struct_na_base_pair_step rdf:about="{$base}/ndb_struct_na_base_pair_step/{$i_label_asym_id_1_encoded},{$i_label_asym_id_2_encoded},{$i_label_comp_id_1_encoded},{$i_label_comp_id_2_encoded},{$i_label_seq_id_1_encoded},{$i_label_seq_id_2_encoded},{$i_symmetry_1_encoded},{$i_symmetry_2_encoded},{$j_label_asym_id_1_encoded},{$j_label_asym_id_2_encoded},{$j_label_comp_id_1_encoded},{$j_label_comp_id_2_encoded},{$j_label_seq_id_1_encoded},{$j_label_seq_id_2_encoded},{$j_symmetry_1_encoded},{$j_symmetry_2_encoded},{$model_number_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:ndb_struct_na_base_pair_step>
      </PDBo:has_ndb_struct_na_base_pair_step>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_authorCategory/VRPTx:pdbx_audit_author">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_audit_author>
      <PDBo:pdbx_audit_author rdf:about="{$base}/pdbx_audit_author/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_author>
      </PDBo:has_pdbx_audit_author>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_categoryCategory/VRPTx:pdbx_audit_revision_category">
      <xsl:variable name="data_content_type_truncated"><xsl:choose><xsl:when test="string-length(@data_content_type)&lt;64"><xsl:value-of select="@data_content_type"/></xsl:when><xsl:when test="contains(@data_content_type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@data_content_type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@data_content_type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="data_content_type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($data_content_type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="revision_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@revision_ordinal)&lt;64"><xsl:value-of select="@revision_ordinal"/></xsl:when><xsl:when test="contains(@revision_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@revision_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@revision_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="revision_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($revision_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_audit_revision_category>
      <PDBo:pdbx_audit_revision_category rdf:about="{$base}/pdbx_audit_revision_category/{$data_content_type_encoded},{$ordinal_encoded},{$revision_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
	<PDBo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description rdf:about="{$base}/pdbx_audit_revision_history/,">
	    <PDBo:referenced_by_pdbx_audit_revision_category rdf:resource="{$base}/pdbx_audit_revision_category/{$data_content_type_encoded},{$ordinal_encoded},{$revision_ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_audit_revision_history>
	<!-- pdbx_audit_revision_historyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_revision_category>
      </PDBo:has_pdbx_audit_revision_category>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_detailsCategory/VRPTx:pdbx_audit_revision_details">
      <xsl:variable name="data_content_type_truncated"><xsl:choose><xsl:when test="string-length(@data_content_type)&lt;64"><xsl:value-of select="@data_content_type"/></xsl:when><xsl:when test="contains(@data_content_type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@data_content_type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@data_content_type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="data_content_type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($data_content_type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="revision_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@revision_ordinal)&lt;64"><xsl:value-of select="@revision_ordinal"/></xsl:when><xsl:when test="contains(@revision_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@revision_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@revision_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="revision_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($revision_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_audit_revision_details>
      <PDBo:pdbx_audit_revision_details rdf:about="{$base}/pdbx_audit_revision_details/{$data_content_type_encoded},{$ordinal_encoded},{$revision_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
	<PDBo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description rdf:about="{$base}/pdbx_audit_revision_history/,">
	    <PDBo:referenced_by_pdbx_audit_revision_details rdf:resource="{$base}/pdbx_audit_revision_details/{$data_content_type_encoded},{$ordinal_encoded},{$revision_ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_audit_revision_history>
	<!-- pdbx_audit_revision_historyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_revision_details>
      </PDBo:has_pdbx_audit_revision_details>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_groupCategory/VRPTx:pdbx_audit_revision_group">
      <xsl:variable name="data_content_type_truncated"><xsl:choose><xsl:when test="string-length(@data_content_type)&lt;64"><xsl:value-of select="@data_content_type"/></xsl:when><xsl:when test="contains(@data_content_type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@data_content_type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@data_content_type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="data_content_type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($data_content_type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="revision_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@revision_ordinal)&lt;64"><xsl:value-of select="@revision_ordinal"/></xsl:when><xsl:when test="contains(@revision_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@revision_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@revision_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="revision_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($revision_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_audit_revision_group>
      <PDBo:pdbx_audit_revision_group rdf:about="{$base}/pdbx_audit_revision_group/{$data_content_type_encoded},{$ordinal_encoded},{$revision_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
	<PDBo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description rdf:about="{$base}/pdbx_audit_revision_history/,">
	    <PDBo:referenced_by_pdbx_audit_revision_group rdf:resource="{$base}/pdbx_audit_revision_group/{$data_content_type_encoded},{$ordinal_encoded},{$revision_ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_audit_revision_history>
	<!-- pdbx_audit_revision_historyKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_revision_group>
      </PDBo:has_pdbx_audit_revision_group>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_historyCategory/VRPTx:pdbx_audit_revision_history">
      <xsl:variable name="data_content_type_truncated"><xsl:choose><xsl:when test="string-length(@data_content_type)&lt;64"><xsl:value-of select="@data_content_type"/></xsl:when><xsl:when test="contains(@data_content_type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@data_content_type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@data_content_type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="data_content_type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($data_content_type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_audit_revision_history>
      <PDBo:pdbx_audit_revision_history rdf:about="{$base}/pdbx_audit_revision_history/{$data_content_type_encoded},{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_revision_history>
      </PDBo:has_pdbx_audit_revision_history>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_audit_revision_itemCategory/VRPTx:pdbx_audit_revision_item">
      <xsl:variable name="data_content_type_truncated"><xsl:choose><xsl:when test="string-length(@data_content_type)&lt;64"><xsl:value-of select="@data_content_type"/></xsl:when><xsl:when test="contains(@data_content_type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@data_content_type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@data_content_type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="data_content_type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($data_content_type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="revision_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@revision_ordinal)&lt;64"><xsl:value-of select="@revision_ordinal"/></xsl:when><xsl:when test="contains(@revision_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@revision_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@revision_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="revision_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($revision_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_audit_revision_item>
      <PDBo:pdbx_audit_revision_item rdf:about="{$base}/pdbx_audit_revision_item/{$data_content_type_encoded},{$ordinal_encoded},{$revision_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
	<PDBo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description rdf:about="{$base}/pdbx_audit_revision_history/,">
	    <PDBo:referenced_by_pdbx_audit_revision_item rdf:resource="{$base}/pdbx_audit_revision_item/{$data_content_type_encoded},{$ordinal_encoded},{$revision_ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_audit_revision_history>
	<!-- pdbx_audit_revision_historyKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_revision_item>
      </PDBo:has_pdbx_audit_revision_item>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_bond_distance_limitsCategory/VRPTx:pdbx_bond_distance_limits">
      <xsl:variable name="atom_type_1_truncated"><xsl:choose><xsl:when test="string-length(@atom_type_1)&lt;64"><xsl:value-of select="@atom_type_1"/></xsl:when><xsl:when test="contains(@atom_type_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@atom_type_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@atom_type_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="atom_type_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($atom_type_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="atom_type_2_truncated"><xsl:choose><xsl:when test="string-length(@atom_type_2)&lt;64"><xsl:value-of select="@atom_type_2"/></xsl:when><xsl:when test="contains(@atom_type_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@atom_type_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@atom_type_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="atom_type_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($atom_type_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_bond_distance_limits>
      <PDBo:pdbx_bond_distance_limits rdf:about="{$base}/pdbx_bond_distance_limits/{$atom_type_1_encoded},{$atom_type_2_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_bond_distance_limits>
      </PDBo:has_pdbx_bond_distance_limits>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_branch_schemeCategory/VRPTx:pdbx_branch_scheme">
      <xsl:variable name="asym_id_truncated"><xsl:choose><xsl:when test="string-length(@asym_id)&lt;64"><xsl:value-of select="@asym_id"/></xsl:when><xsl:when test="contains(@asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="mon_id_truncated"><xsl:choose><xsl:when test="string-length(@mon_id)&lt;64"><xsl:value-of select="@mon_id"/></xsl:when><xsl:when test="contains(@mon_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@mon_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@mon_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="mon_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($mon_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="num_truncated"><xsl:choose><xsl:when test="string-length(@num)&lt;64"><xsl:value-of select="@num"/></xsl:when><xsl:when test="contains(@num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_branch_scheme>
      <PDBo:pdbx_branch_scheme rdf:about="{$base}/pdbx_branch_scheme/{$asym_id_encoded},{$entity_id_encoded},{$mon_id_encoded},{$num_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/">
	    <PDBo:referenced_by_pdbx_branch_scheme rdf:resource="{$base}/pdbx_branch_scheme/{$asym_id_encoded},{$entity_id_encoded},{$mon_id_encoded},{$num_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_branch_scheme>
      </PDBo:has_pdbx_branch_scheme>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_coordinate_modelCategory/VRPTx:pdbx_coordinate_model">
      <xsl:variable name="asym_id_truncated"><xsl:choose><xsl:when test="string-length(@asym_id)&lt;64"><xsl:value-of select="@asym_id"/></xsl:when><xsl:when test="contains(@asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_coordinate_model>
      <PDBo:pdbx_coordinate_model rdf:about="{$base}/pdbx_coordinate_model/{$asym_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
	<PDBo:reference_to_struct_asym>
	  <rdf:Description rdf:about="{$base}/struct_asym/">
	    <PDBo:referenced_by_pdbx_coordinate_model rdf:resource="{$base}/pdbx_coordinate_model/{$asym_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_asym>
	<!-- struct_asymKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_coordinate_model>
      </PDBo:has_pdbx_coordinate_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_database_relatedCategory/VRPTx:pdbx_database_related">
      <xsl:variable name="content_type_truncated"><xsl:choose><xsl:when test="string-length(@content_type)&lt;64"><xsl:value-of select="@content_type"/></xsl:when><xsl:when test="contains(@content_type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@content_type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@content_type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="content_type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($content_type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="db_id_truncated"><xsl:choose><xsl:when test="string-length(@db_id)&lt;64"><xsl:value-of select="@db_id"/></xsl:when><xsl:when test="contains(@db_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@db_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@db_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="db_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($db_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="db_name_truncated"><xsl:choose><xsl:when test="string-length(@db_name)&lt;64"><xsl:value-of select="@db_name"/></xsl:when><xsl:when test="contains(@db_name,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@db_name,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@db_name,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="db_name_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($db_name_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_database_related>
      <PDBo:pdbx_database_related rdf:about="{$base}/pdbx_database_related/{$content_type_encoded},{$db_id_encoded},{$db_name_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_related>
      </PDBo:has_pdbx_database_related>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_database_statusCategory/VRPTx:pdbx_database_status">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_database_status>
      <PDBo:pdbx_database_status rdf:about="{$base}/pdbx_database_status/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_database_status rdf:resource="{$base}/pdbx_database_status/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_status>
      </PDBo:has_pdbx_database_status>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_densityCategory/VRPTx:pdbx_dcc_density">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_density>
      <PDBo:pdbx_dcc_density rdf:about="{$base}/pdbx_dcc_density/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_dcc_density rdf:resource="{$base}/pdbx_dcc_density/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_density>
      </PDBo:has_pdbx_dcc_density>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_density_corrCategory/VRPTx:pdbx_dcc_density_corr">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_density_corr>
      <PDBo:pdbx_dcc_density_corr rdf:about="{$base}/pdbx_dcc_density_corr/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_density_corr>
      </PDBo:has_pdbx_dcc_density_corr>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_entity_geometryCategory/VRPTx:pdbx_dcc_entity_geometry">
      <xsl:variable name="PDB_model_num_truncated"><xsl:choose><xsl:when test="string-length(@PDB_model_num)&lt;64"><xsl:value-of select="@PDB_model_num"/></xsl:when><xsl:when test="contains(@PDB_model_num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@PDB_model_num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@PDB_model_num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="PDB_model_num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($PDB_model_num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="label_asym_id_truncated"><xsl:choose><xsl:when test="string-length(@label_asym_id)&lt;64"><xsl:value-of select="@label_asym_id"/></xsl:when><xsl:when test="contains(@label_asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@label_asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@label_asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="label_asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($label_asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_entity_geometry>
      <PDBo:pdbx_dcc_entity_geometry rdf:about="{$base}/pdbx_dcc_entity_geometry/{$PDB_model_num_encoded},{$label_asym_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_entity_geometry>
      </PDBo:has_pdbx_dcc_entity_geometry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_geometryCategory/VRPTx:pdbx_dcc_geometry">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_geometry>
      <PDBo:pdbx_dcc_geometry rdf:about="{$base}/pdbx_dcc_geometry/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_dcc_geometry rdf:resource="{$base}/pdbx_dcc_geometry/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_geometry>
      </PDBo:has_pdbx_dcc_geometry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_mapCategory/VRPTx:pdbx_dcc_map">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_map>
      <PDBo:pdbx_dcc_map rdf:about="{$base}/pdbx_dcc_map/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_map>
      </PDBo:has_pdbx_dcc_map>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_map_overallCategory/VRPTx:pdbx_dcc_map_overall">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_map_overall>
      <PDBo:pdbx_dcc_map_overall rdf:about="{$base}/pdbx_dcc_map_overall/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_dcc_map_overall rdf:resource="{$base}/pdbx_dcc_map_overall/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_12_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_map_overall>
      </PDBo:has_pdbx_dcc_map_overall>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_mapmanCategory/VRPTx:pdbx_dcc_mapman">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_mapman>
      <PDBo:pdbx_dcc_mapman rdf:about="{$base}/pdbx_dcc_mapman/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_dcc_mapman rdf:resource="{$base}/pdbx_dcc_mapman/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_13_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_mapman>
      </PDBo:has_pdbx_dcc_mapman>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_mon_geometryCategory/VRPTx:pdbx_dcc_mon_geometry">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_mon_geometry>
      <PDBo:pdbx_dcc_mon_geometry rdf:about="{$base}/pdbx_dcc_mon_geometry/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_mon_geometry>
      </PDBo:has_pdbx_dcc_mon_geometry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_rscc_mapmanCategory/VRPTx:pdbx_dcc_rscc_mapman">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_rscc_mapman>
      <PDBo:pdbx_dcc_rscc_mapman rdf:about="{$base}/pdbx_dcc_rscc_mapman/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_rscc_mapman>
      </PDBo:has_pdbx_dcc_rscc_mapman>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_dcc_rscc_mapman_overallCategory/VRPTx:pdbx_dcc_rscc_mapman_overall">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_dcc_rscc_mapman_overall>
      <PDBo:pdbx_dcc_rscc_mapman_overall rdf:about="{$base}/pdbx_dcc_rscc_mapman_overall/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_dcc_rscc_mapman_overall rdf:resource="{$base}/pdbx_dcc_rscc_mapman_overall/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_14_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_rscc_mapman_overall>
      </PDBo:has_pdbx_dcc_rscc_mapman_overall>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_diffrn_reflns_shellCategory/VRPTx:pdbx_diffrn_reflns_shell">
      <xsl:variable name="d_res_high_truncated"><xsl:choose><xsl:when test="string-length(@d_res_high)&lt;64"><xsl:value-of select="@d_res_high"/></xsl:when><xsl:when test="contains(@d_res_high,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_high,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_high,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_high_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_high_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="d_res_low_truncated"><xsl:choose><xsl:when test="string-length(@d_res_low)&lt;64"><xsl:value-of select="@d_res_low"/></xsl:when><xsl:when test="contains(@d_res_low,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_low,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_low,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_low_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_low_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_diffrn_reflns_shell>
      <PDBo:pdbx_diffrn_reflns_shell rdf:about="{$base}/pdbx_diffrn_reflns_shell/{$d_res_high_encoded},{$d_res_low_encoded},{$diffrn_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
	<PDBo:reference_to_diffrn>
	  <rdf:Description rdf:about="{$base}/diffrn/">
	    <PDBo:referenced_by_pdbx_diffrn_reflns_shell rdf:resource="{$base}/pdbx_diffrn_reflns_shell/{$d_res_high_encoded},{$d_res_low_encoded},{$diffrn_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_diffrn>
	<!-- diffrnKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_diffrn_reflns_shell>
      </PDBo:has_pdbx_diffrn_reflns_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_distant_solvent_atomsCategory/VRPTx:pdbx_distant_solvent_atoms">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_distant_solvent_atoms>
      <PDBo:pdbx_distant_solvent_atoms rdf:about="{$base}/pdbx_distant_solvent_atoms/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_distant_solvent_atoms>
      </PDBo:has_pdbx_distant_solvent_atoms>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_domainCategory/VRPTx:pdbx_domain">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_domain>
      <PDBo:pdbx_domain rdf:about="{$base}/pdbx_domain/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_domain>
      </PDBo:has_pdbx_domain>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_domain_rangeCategory/VRPTx:pdbx_domain_range">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_domain_range>
      <PDBo:pdbx_domain_range rdf:about="{$base}/pdbx_domain_range/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:domain_id!=''">
	<PDBo:reference_to_pdbx_domain>
	  <rdf:Description rdf:about="{$base}/pdbx_domain/{translate(VRPTx:domain_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_domain_range rdf:resource="{$base}/pdbx_domain_range/{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_domain>
	<!-- pdbx_domainKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_domain_range>
      </PDBo:has_pdbx_domain_range>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_atom_inclusionCategory/VRPTx:pdbx_em_atom_inclusion">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_atom_inclusion>
      <PDBo:pdbx_em_atom_inclusion rdf:about="{$base}/pdbx_em_atom_inclusion/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_atom_inclusion>
      </PDBo:has_pdbx_em_atom_inclusion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_atom_inclusion_markerCategory/VRPTx:pdbx_em_atom_inclusion_marker">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="plot_id_truncated"><xsl:choose><xsl:when test="string-length(@plot_id)&lt;64"><xsl:value-of select="@plot_id"/></xsl:when><xsl:when test="contains(@plot_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@plot_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@plot_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="plot_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($plot_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_atom_inclusion_marker>
      <PDBo:pdbx_em_atom_inclusion_marker rdf:about="{$base}/pdbx_em_atom_inclusion_marker/{$ordinal_encoded},{$plot_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
	<PDBo:reference_to_pdbx_em_atom_inclusion>
	  <rdf:Description rdf:about="{$base}/pdbx_em_atom_inclusion/">
	    <PDBo:referenced_by_pdbx_em_atom_inclusion_marker rdf:resource="{$base}/pdbx_em_atom_inclusion_marker/{$ordinal_encoded},{$plot_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_atom_inclusion>
	<!-- pdbx_em_atom_inclusionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_atom_inclusion_marker>
      </PDBo:has_pdbx_em_atom_inclusion_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_density_distributionCategory/VRPTx:pdbx_em_density_distribution">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_density_distribution>
      <PDBo:pdbx_em_density_distribution rdf:about="{$base}/pdbx_em_density_distribution/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_density_distribution>
      </PDBo:has_pdbx_em_density_distribution>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_density_distribution_markerCategory/VRPTx:pdbx_em_density_distribution_marker">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="plot_id_truncated"><xsl:choose><xsl:when test="string-length(@plot_id)&lt;64"><xsl:value-of select="@plot_id"/></xsl:when><xsl:when test="contains(@plot_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@plot_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@plot_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="plot_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($plot_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_density_distribution_marker>
      <PDBo:pdbx_em_density_distribution_marker rdf:about="{$base}/pdbx_em_density_distribution_marker/{$ordinal_encoded},{$plot_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
	<PDBo:reference_to_pdbx_em_density_distribution>
	  <rdf:Description rdf:about="{$base}/pdbx_em_density_distribution/">
	    <PDBo:referenced_by_pdbx_em_density_distribution_marker rdf:resource="{$base}/pdbx_em_density_distribution_marker/{$ordinal_encoded},{$plot_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_density_distribution>
	<!-- pdbx_em_density_distributionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_density_distribution_marker>
      </PDBo:has_pdbx_em_density_distribution_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_curveCategory/VRPTx:pdbx_em_fsc_curve">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_fsc_curve>
      <PDBo:pdbx_em_fsc_curve rdf:about="{$base}/pdbx_em_fsc_curve/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_fsc_curve>
      </PDBo:has_pdbx_em_fsc_curve>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_curve_markerCategory/VRPTx:pdbx_em_fsc_curve_marker">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="plot_id_truncated"><xsl:choose><xsl:when test="string-length(@plot_id)&lt;64"><xsl:value-of select="@plot_id"/></xsl:when><xsl:when test="contains(@plot_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@plot_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@plot_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="plot_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($plot_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_fsc_curve_marker>
      <PDBo:pdbx_em_fsc_curve_marker rdf:about="{$base}/pdbx_em_fsc_curve_marker/{$ordinal_encoded},{$plot_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
	<PDBo:reference_to_pdbx_em_fsc_curve>
	  <rdf:Description rdf:about="{$base}/pdbx_em_fsc_curve/">
	    <PDBo:referenced_by_pdbx_em_fsc_curve_marker rdf:resource="{$base}/pdbx_em_fsc_curve_marker/{$ordinal_encoded},{$plot_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_fsc_curve>
	<!-- pdbx_em_fsc_curveKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_fsc_curve_marker>
      </PDBo:has_pdbx_em_fsc_curve_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_cutoff_curveCategory/VRPTx:pdbx_em_fsc_cutoff_curve">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_fsc_cutoff_curve>
      <PDBo:pdbx_em_fsc_cutoff_curve rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_fsc_cutoff_curve>
      </PDBo:has_pdbx_em_fsc_cutoff_curve>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_cutoff_curve_markerCategory/VRPTx:pdbx_em_fsc_cutoff_curve_marker">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="plot_id_truncated"><xsl:choose><xsl:when test="string-length(@plot_id)&lt;64"><xsl:value-of select="@plot_id"/></xsl:when><xsl:when test="contains(@plot_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@plot_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@plot_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="plot_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($plot_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_fsc_cutoff_curve_marker>
      <PDBo:pdbx_em_fsc_cutoff_curve_marker rdf:about="{$base}/pdbx_em_fsc_cutoff_curve_marker/{$ordinal_encoded},{$plot_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
	<PDBo:reference_to_pdbx_em_fsc_cutoff_curve>
	  <rdf:Description rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/">
	    <PDBo:referenced_by_pdbx_em_fsc_cutoff_curve_marker rdf:resource="{$base}/pdbx_em_fsc_cutoff_curve_marker/{$ordinal_encoded},{$plot_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_fsc_cutoff_curve>
	<!-- pdbx_em_fsc_cutoff_curveKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_fsc_cutoff_curve_marker>
      </PDBo:has_pdbx_em_fsc_cutoff_curve_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_fsc_resolutionCategory/VRPTx:pdbx_em_fsc_resolution">
      <xsl:variable name="criterion_truncated"><xsl:choose><xsl:when test="string-length(@criterion)&lt;64"><xsl:value-of select="@criterion"/></xsl:when><xsl:when test="contains(@criterion,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@criterion,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@criterion,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="criterion_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($criterion_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="source_truncated"><xsl:choose><xsl:when test="string-length(@source)&lt;64"><xsl:value-of select="@source"/></xsl:when><xsl:when test="contains(@source,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@source,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@source,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="source_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($source_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_fsc_resolution>
      <PDBo:pdbx_em_fsc_resolution rdf:about="{$base}/pdbx_em_fsc_resolution/{$criterion_encoded},{$source_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:fsc_curve_id!=''">
	<PDBo:reference_to_pdbx_em_fsc_curve>
	  <rdf:Description rdf:about="{$base}/pdbx_em_fsc_curve/{translate(VRPTx:fsc_curve_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_em_fsc_resolution rdf:resource="{$base}/pdbx_em_fsc_resolution/{$criterion_encoded},{$source_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_fsc_curve>
	<!-- pdbx_em_fsc_curveKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="VRPTx:fsc_cutoff_curve_id!=''">
	<PDBo:reference_to_pdbx_em_fsc_cutoff_curve>
	  <rdf:Description rdf:about="{$base}/pdbx_em_fsc_cutoff_curve/{translate(VRPTx:fsc_cutoff_curve_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_em_fsc_resolution rdf:resource="{$base}/pdbx_em_fsc_resolution/{$criterion_encoded},{$source_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_fsc_cutoff_curve>
	<!-- pdbx_em_fsc_cutoff_curveKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_fsc_resolution>
      </PDBo:has_pdbx_em_fsc_resolution>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_rapsCategory/VRPTx:pdbx_em_raps">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_raps>
      <PDBo:pdbx_em_raps rdf:about="{$base}/pdbx_em_raps/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_raps>
      </PDBo:has_pdbx_em_raps>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_raps_markerCategory/VRPTx:pdbx_em_raps_marker">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="plot_id_truncated"><xsl:choose><xsl:when test="string-length(@plot_id)&lt;64"><xsl:value-of select="@plot_id"/></xsl:when><xsl:when test="contains(@plot_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@plot_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@plot_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="plot_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($plot_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_raps_marker>
      <PDBo:pdbx_em_raps_marker rdf:about="{$base}/pdbx_em_raps_marker/{$ordinal_encoded},{$plot_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
	<PDBo:reference_to_pdbx_em_raps>
	  <rdf:Description rdf:about="{$base}/pdbx_em_raps/">
	    <PDBo:referenced_by_pdbx_em_raps_marker rdf:resource="{$base}/pdbx_em_raps_marker/{$ordinal_encoded},{$plot_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_raps>
	<!-- pdbx_em_rapsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_raps_marker>
      </PDBo:has_pdbx_em_raps_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_raw_rapsCategory/VRPTx:pdbx_em_raw_raps">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_raw_raps>
      <PDBo:pdbx_em_raw_raps rdf:about="{$base}/pdbx_em_raw_raps/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_raw_raps>
      </PDBo:has_pdbx_em_raw_raps>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_raw_raps_markerCategory/VRPTx:pdbx_em_raw_raps_marker">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="plot_id_truncated"><xsl:choose><xsl:when test="string-length(@plot_id)&lt;64"><xsl:value-of select="@plot_id"/></xsl:when><xsl:when test="contains(@plot_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@plot_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@plot_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="plot_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($plot_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_raw_raps_marker>
      <PDBo:pdbx_em_raw_raps_marker rdf:about="{$base}/pdbx_em_raw_raps_marker/{$ordinal_encoded},{$plot_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
	<PDBo:reference_to_pdbx_em_raw_raps>
	  <rdf:Description rdf:about="{$base}/pdbx_em_raw_raps/">
	    <PDBo:referenced_by_pdbx_em_raw_raps_marker rdf:resource="{$base}/pdbx_em_raw_raps_marker/{$ordinal_encoded},{$plot_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_raw_raps>
	<!-- pdbx_em_raw_rapsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_raw_raps_marker>
      </PDBo:has_pdbx_em_raw_raps_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_validate_map_modelCategory/VRPTx:pdbx_em_validate_map_model">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_validate_map_model>
      <PDBo:pdbx_em_validate_map_model rdf:about="{$base}/pdbx_em_validate_map_model/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_validate_map_model>
      </PDBo:has_pdbx_em_validate_map_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_validate_map_model_entityCategory/VRPTx:pdbx_em_validate_map_model_entity">
      <xsl:variable name="PDB_model_num_truncated"><xsl:choose><xsl:when test="string-length(@PDB_model_num)&lt;64"><xsl:value-of select="@PDB_model_num"/></xsl:when><xsl:when test="contains(@PDB_model_num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@PDB_model_num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@PDB_model_num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="PDB_model_num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($PDB_model_num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="label_asym_id_truncated"><xsl:choose><xsl:when test="string-length(@label_asym_id)&lt;64"><xsl:value-of select="@label_asym_id"/></xsl:when><xsl:when test="contains(@label_asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@label_asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@label_asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="label_asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($label_asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_validate_map_model_entity>
      <PDBo:pdbx_em_validate_map_model_entity rdf:about="{$base}/pdbx_em_validate_map_model_entity/{$PDB_model_num_encoded},{$label_asym_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_validate_map_model_entity>
      </PDBo:has_pdbx_em_validate_map_model_entity>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_validate_map_model_overallCategory/VRPTx:pdbx_em_validate_map_model_overall">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_validate_map_model_overall>
      <PDBo:pdbx_em_validate_map_model_overall rdf:about="{$base}/pdbx_em_validate_map_model_overall/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_em_validate_map_model_overall rdf:resource="{$base}/pdbx_em_validate_map_model_overall/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_15_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_validate_map_model_overall>
      </PDBo:has_pdbx_em_validate_map_model_overall>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_volume_estimateCategory/VRPTx:pdbx_em_volume_estimate">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_volume_estimate>
      <PDBo:pdbx_em_volume_estimate rdf:about="{$base}/pdbx_em_volume_estimate/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_volume_estimate>
      </PDBo:has_pdbx_em_volume_estimate>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_em_volume_estimate_markerCategory/VRPTx:pdbx_em_volume_estimate_marker">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="plot_id_truncated"><xsl:choose><xsl:when test="string-length(@plot_id)&lt;64"><xsl:value-of select="@plot_id"/></xsl:when><xsl:when test="contains(@plot_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@plot_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@plot_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="plot_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($plot_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_em_volume_estimate_marker>
      <PDBo:pdbx_em_volume_estimate_marker rdf:about="{$base}/pdbx_em_volume_estimate_marker/{$ordinal_encoded},{$plot_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@plot_id!=''">
	<PDBo:reference_to_pdbx_em_volume_estimate>
	  <rdf:Description rdf:about="{$base}/pdbx_em_volume_estimate/">
	    <PDBo:referenced_by_pdbx_em_volume_estimate_marker rdf:resource="{$base}/pdbx_em_volume_estimate_marker/{$ordinal_encoded},{$plot_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_em_volume_estimate>
	<!-- pdbx_em_volume_estimateKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_em_volume_estimate_marker>
      </PDBo:has_pdbx_em_volume_estimate_marker>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_assemblyCategory/VRPTx:pdbx_entity_assembly">
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entity_assembly>
      <PDBo:pdbx_entity_assembly rdf:about="{$base}/pdbx_entity_assembly/{$entity_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/">
	    <PDBo:referenced_by_pdbx_entity_assembly rdf:resource="{$base}/pdbx_entity_assembly/{$entity_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:if test="VRPTx:biol_id!=''">
	<PDBo:reference_to_struct_biol>
	  <rdf:Description rdf:about="{$base}/struct_biol/{translate(VRPTx:biol_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_entity_assembly rdf:resource="{$base}/pdbx_entity_assembly/{$entity_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_biol>
	<!-- struct_biolKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_assembly>
      </PDBo:has_pdbx_entity_assembly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_branchCategory/VRPTx:pdbx_entity_branch">
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entity_branch>
      <PDBo:pdbx_entity_branch rdf:about="{$base}/pdbx_entity_branch/{$entity_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/">
	    <PDBo:referenced_by_pdbx_entity_branch rdf:resource="{$base}/pdbx_entity_branch/{$entity_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_branch>
      </PDBo:has_pdbx_entity_branch>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_branch_descriptorCategory/VRPTx:pdbx_entity_branch_descriptor">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entity_branch_descriptor>
      <PDBo:pdbx_entity_branch_descriptor rdf:about="{$base}/pdbx_entity_branch_descriptor/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/{translate(VRPTx:entity_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_entity_branch_descriptor rdf:resource="{$base}/pdbx_entity_branch_descriptor/{$ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_branch_descriptor>
      </PDBo:has_pdbx_entity_branch_descriptor>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_branch_linkCategory/VRPTx:pdbx_entity_branch_link">
      <xsl:variable name="link_id_truncated"><xsl:choose><xsl:when test="string-length(@link_id)&lt;64"><xsl:value-of select="@link_id"/></xsl:when><xsl:when test="contains(@link_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@link_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@link_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="link_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($link_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entity_branch_link>
      <PDBo:pdbx_entity_branch_link rdf:about="{$base}/pdbx_entity_branch_link/{$link_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_branch_link>
      </PDBo:has_pdbx_entity_branch_link>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_branch_listCategory/VRPTx:pdbx_entity_branch_list">
      <xsl:variable name="comp_id_truncated"><xsl:choose><xsl:when test="string-length(@comp_id)&lt;64"><xsl:value-of select="@comp_id"/></xsl:when><xsl:when test="contains(@comp_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@comp_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@comp_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="comp_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($comp_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="num_truncated"><xsl:choose><xsl:when test="string-length(@num)&lt;64"><xsl:value-of select="@num"/></xsl:when><xsl:when test="contains(@num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entity_branch_list>
      <PDBo:pdbx_entity_branch_list rdf:about="{$base}/pdbx_entity_branch_list/{$comp_id_encoded},{$entity_id_encoded},{$num_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/">
	    <PDBo:referenced_by_pdbx_entity_branch_list rdf:resource="{$base}/pdbx_entity_branch_list/{$comp_id_encoded},{$entity_id_encoded},{$num_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_branch_list>
      </PDBo:has_pdbx_entity_branch_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_descriptorCategory/VRPTx:pdbx_entity_descriptor">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entity_descriptor>
      <PDBo:pdbx_entity_descriptor rdf:about="{$base}/pdbx_entity_descriptor/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/{translate(VRPTx:entity_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_entity_descriptor rdf:resource="{$base}/pdbx_entity_descriptor/{$ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_descriptor>
      </PDBo:has_pdbx_entity_descriptor>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_nonpolyCategory/VRPTx:pdbx_entity_nonpoly">
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entity_nonpoly>
      <PDBo:pdbx_entity_nonpoly rdf:about="{$base}/pdbx_entity_nonpoly/{$entity_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/">
	    <PDBo:referenced_by_pdbx_entity_nonpoly rdf:resource="{$base}/pdbx_entity_nonpoly/{$entity_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_nonpoly>
      </PDBo:has_pdbx_entity_nonpoly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entity_poly_comp_link_listCategory/VRPTx:pdbx_entity_poly_comp_link_list">
      <xsl:variable name="link_id_truncated"><xsl:choose><xsl:when test="string-length(@link_id)&lt;64"><xsl:value-of select="@link_id"/></xsl:when><xsl:when test="contains(@link_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@link_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@link_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="link_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($link_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entity_poly_comp_link_list>
      <PDBo:pdbx_entity_poly_comp_link_list rdf:about="{$base}/pdbx_entity_poly_comp_link_list/{$link_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!='' and VRPTx:comp_id_1!='' and VRPTx:entity_comp_num_1!=''">
	<PDBo:reference_to_entity_poly_seq>
	  <rdf:Description rdf:about="{$base}/entity_poly_seq/{translate(VRPTx:entity_id,' ^','__')},{translate(VRPTx:comp_id_1,' ^','__')},{translate(VRPTx:entity_comp_num_1,' ^','__')}">
	    <PDBo:referenced_by_pdbx_entity_poly_comp_link_list rdf:resource="{$base}/pdbx_entity_poly_comp_link_list/{$link_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity_poly_seq>
	<!-- entity_poly_seqKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_poly_comp_link_list>
      </PDBo:has_pdbx_entity_poly_comp_link_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_entry_detailsCategory/VRPTx:pdbx_entry_details">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_entry_details>
      <PDBo:pdbx_entry_details rdf:about="{$base}/pdbx_entry_details/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_entry_details rdf:resource="{$base}/pdbx_entry_details/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_16_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entry_details>
      </PDBo:has_pdbx_entry_details>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_helical_symmetryCategory/VRPTx:pdbx_helical_symmetry">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_helical_symmetry>
      <PDBo:pdbx_helical_symmetry rdf:about="{$base}/pdbx_helical_symmetry/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_helical_symmetry rdf:resource="{$base}/pdbx_helical_symmetry/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_17_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_helical_symmetry>
      </PDBo:has_pdbx_helical_symmetry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_missing_nmr_star_itemCategory/VRPTx:pdbx_missing_nmr_star_item">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="list_id_truncated"><xsl:choose><xsl:when test="string-length(@list_id)&lt;64"><xsl:value-of select="@list_id"/></xsl:when><xsl:when test="contains(@list_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@list_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@list_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="list_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($list_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_missing_nmr_star_item>
      <PDBo:pdbx_missing_nmr_star_item rdf:about="{$base}/pdbx_missing_nmr_star_item/{$id_encoded},{$list_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
	<PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/">
	    <PDBo:referenced_by_pdbx_missing_nmr_star_item rdf:resource="{$base}/pdbx_missing_nmr_star_item/{$id_encoded},{$list_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	<!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_missing_nmr_star_item>
      </PDBo:has_pdbx_missing_nmr_star_item>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_assigned_chem_shift_listCategory/VRPTx:pdbx_nmr_assigned_chem_shift_list">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_assigned_chem_shift_list>
      <PDBo:pdbx_nmr_assigned_chem_shift_list rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_assigned_chem_shift_list>
      </PDBo:has_pdbx_nmr_assigned_chem_shift_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_chem_shift_annotationCategory/VRPTx:pdbx_nmr_chem_shift_annotation">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="list_id_truncated"><xsl:choose><xsl:when test="string-length(@list_id)&lt;64"><xsl:value-of select="@list_id"/></xsl:when><xsl:when test="contains(@list_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@list_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@list_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="list_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($list_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_chem_shift_annotation>
      <PDBo:pdbx_nmr_chem_shift_annotation rdf:about="{$base}/pdbx_nmr_chem_shift_annotation/{$id_encoded},{$list_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
	<PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/">
	    <PDBo:referenced_by_pdbx_nmr_chem_shift_annotation rdf:resource="{$base}/pdbx_nmr_chem_shift_annotation/{$id_encoded},{$list_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	<!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_chem_shift_annotation>
      </PDBo:has_pdbx_nmr_chem_shift_annotation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_chem_shift_completenessCategory/VRPTx:pdbx_nmr_chem_shift_completeness">
      <xsl:variable name="atom_group_truncated"><xsl:choose><xsl:when test="string-length(@atom_group)&lt;64"><xsl:value-of select="@atom_group"/></xsl:when><xsl:when test="contains(@atom_group,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@atom_group,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@atom_group,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="atom_group_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($atom_group_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="atom_type_truncated"><xsl:choose><xsl:when test="string-length(@atom_type)&lt;64"><xsl:value-of select="@atom_type"/></xsl:when><xsl:when test="contains(@atom_type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@atom_type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@atom_type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="atom_type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($atom_type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="list_id_truncated"><xsl:choose><xsl:when test="string-length(@list_id)&lt;64"><xsl:value-of select="@list_id"/></xsl:when><xsl:when test="contains(@list_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@list_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@list_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="list_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($list_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_chem_shift_completeness>
      <PDBo:pdbx_nmr_chem_shift_completeness rdf:about="{$base}/pdbx_nmr_chem_shift_completeness/{$atom_group_encoded},{$atom_type_encoded},{$list_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
	<PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/">
	    <PDBo:referenced_by_pdbx_nmr_chem_shift_completeness rdf:resource="{$base}/pdbx_nmr_chem_shift_completeness/{$atom_group_encoded},{$atom_type_encoded},{$list_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	<!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_chem_shift_completeness>
      </PDBo:has_pdbx_nmr_chem_shift_completeness>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_chem_shift_re_offsetCategory/VRPTx:pdbx_nmr_chem_shift_re_offset">
      <xsl:variable name="atom_type_truncated"><xsl:choose><xsl:when test="string-length(@atom_type)&lt;64"><xsl:value-of select="@atom_type"/></xsl:when><xsl:when test="contains(@atom_type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@atom_type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@atom_type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="atom_type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($atom_type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="list_id_truncated"><xsl:choose><xsl:when test="string-length(@list_id)&lt;64"><xsl:value-of select="@list_id"/></xsl:when><xsl:when test="contains(@list_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@list_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@list_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="list_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($list_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_chem_shift_re_offset>
      <PDBo:pdbx_nmr_chem_shift_re_offset rdf:about="{$base}/pdbx_nmr_chem_shift_re_offset/{$atom_type_encoded},{$list_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
	<PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/">
	    <PDBo:referenced_by_pdbx_nmr_chem_shift_re_offset rdf:resource="{$base}/pdbx_nmr_chem_shift_re_offset/{$atom_type_encoded},{$list_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	<!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_chem_shift_re_offset>
      </PDBo:has_pdbx_nmr_chem_shift_re_offset>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_constraintsCategory/VRPTx:pdbx_nmr_constraints">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_constraints>
      <PDBo:pdbx_nmr_constraints rdf:about="{$base}/pdbx_nmr_constraints/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_nmr_constraints rdf:resource="{$base}/pdbx_nmr_constraints/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_18_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_constraints>
      </PDBo:has_pdbx_nmr_constraints>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_detailsCategory/VRPTx:pdbx_nmr_details">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_details>
      <PDBo:pdbx_nmr_details rdf:about="{$base}/pdbx_nmr_details/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_nmr_details rdf:resource="{$base}/pdbx_nmr_details/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_19_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_details>
      </PDBo:has_pdbx_nmr_details>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violationCategory/VRPTx:pdbx_nmr_dihedral_angle_violation">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_dihedral_angle_violation>
      <PDBo:pdbx_nmr_dihedral_angle_violation rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_dihedral_angle_violation>
      </PDBo:has_pdbx_nmr_dihedral_angle_violation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violation_ensembleCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_ensemble">
      <xsl:variable name="fraction_ensemble_size_truncated"><xsl:choose><xsl:when test="string-length(@fraction_ensemble_size)&lt;64"><xsl:value-of select="@fraction_ensemble_size"/></xsl:when><xsl:when test="contains(@fraction_ensemble_size,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@fraction_ensemble_size,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@fraction_ensemble_size,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="fraction_ensemble_size_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($fraction_ensemble_size_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_dihedral_angle_violation_ensemble>
      <PDBo:pdbx_nmr_dihedral_angle_violation_ensemble rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_ensemble/{$fraction_ensemble_size_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_dihedral_angle_violation_ensemble>
      </PDBo:has_pdbx_nmr_dihedral_angle_violation_ensemble>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violation_modelCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_model">
      <xsl:variable name="PDB_model_num_truncated"><xsl:choose><xsl:when test="string-length(@PDB_model_num)&lt;64"><xsl:value-of select="@PDB_model_num"/></xsl:when><xsl:when test="contains(@PDB_model_num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@PDB_model_num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@PDB_model_num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="PDB_model_num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($PDB_model_num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_dihedral_angle_violation_model>
      <PDBo:pdbx_nmr_dihedral_angle_violation_model rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_model/{$PDB_model_num_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_dihedral_angle_violation_model>
      </PDBo:has_pdbx_nmr_dihedral_angle_violation_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violation_pluralCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_plural">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_dihedral_angle_violation_plural>
      <PDBo:pdbx_nmr_dihedral_angle_violation_plural rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_plural/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_dihedral_angle_violation_plural>
      </PDBo:has_pdbx_nmr_dihedral_angle_violation_plural>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_dihedral_angle_violation_summaryCategory/VRPTx:pdbx_nmr_dihedral_angle_violation_summary">
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_dihedral_angle_violation_summary>
      <PDBo:pdbx_nmr_dihedral_angle_violation_summary rdf:about="{$base}/pdbx_nmr_dihedral_angle_violation_summary/{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_dihedral_angle_violation_summary>
      </PDBo:has_pdbx_nmr_dihedral_angle_violation_summary>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violationCategory/VRPTx:pdbx_nmr_distance_violation">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_distance_violation>
      <PDBo:pdbx_nmr_distance_violation rdf:about="{$base}/pdbx_nmr_distance_violation/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_distance_violation>
      </PDBo:has_pdbx_nmr_distance_violation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violation_ensembleCategory/VRPTx:pdbx_nmr_distance_violation_ensemble">
      <xsl:variable name="fraction_ensemble_size_truncated"><xsl:choose><xsl:when test="string-length(@fraction_ensemble_size)&lt;64"><xsl:value-of select="@fraction_ensemble_size"/></xsl:when><xsl:when test="contains(@fraction_ensemble_size,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@fraction_ensemble_size,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@fraction_ensemble_size,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="fraction_ensemble_size_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($fraction_ensemble_size_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_distance_violation_ensemble>
      <PDBo:pdbx_nmr_distance_violation_ensemble rdf:about="{$base}/pdbx_nmr_distance_violation_ensemble/{$fraction_ensemble_size_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_distance_violation_ensemble>
      </PDBo:has_pdbx_nmr_distance_violation_ensemble>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violation_modelCategory/VRPTx:pdbx_nmr_distance_violation_model">
      <xsl:variable name="PDB_model_num_truncated"><xsl:choose><xsl:when test="string-length(@PDB_model_num)&lt;64"><xsl:value-of select="@PDB_model_num"/></xsl:when><xsl:when test="contains(@PDB_model_num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@PDB_model_num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@PDB_model_num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="PDB_model_num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($PDB_model_num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_distance_violation_model>
      <PDBo:pdbx_nmr_distance_violation_model rdf:about="{$base}/pdbx_nmr_distance_violation_model/{$PDB_model_num_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_distance_violation_model>
      </PDBo:has_pdbx_nmr_distance_violation_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violation_pluralCategory/VRPTx:pdbx_nmr_distance_violation_plural">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_distance_violation_plural>
      <PDBo:pdbx_nmr_distance_violation_plural rdf:about="{$base}/pdbx_nmr_distance_violation_plural/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_distance_violation_plural>
      </PDBo:has_pdbx_nmr_distance_violation_plural>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_distance_violation_summaryCategory/VRPTx:pdbx_nmr_distance_violation_summary">
      <xsl:variable name="subtype_truncated"><xsl:choose><xsl:when test="string-length(@subtype)&lt;64"><xsl:value-of select="@subtype"/></xsl:when><xsl:when test="contains(@subtype,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@subtype,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@subtype,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="subtype_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($subtype_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_distance_violation_summary>
      <PDBo:pdbx_nmr_distance_violation_summary rdf:about="{$base}/pdbx_nmr_distance_violation_summary/{$subtype_encoded},{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_distance_violation_summary>
      </PDBo:has_pdbx_nmr_distance_violation_summary>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_ensembleCategory/VRPTx:pdbx_nmr_ensemble">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_ensemble>
      <PDBo:pdbx_nmr_ensemble rdf:about="{$base}/pdbx_nmr_ensemble/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_nmr_ensemble rdf:resource="{$base}/pdbx_nmr_ensemble/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_20_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_ensemble>
      </PDBo:has_pdbx_nmr_ensemble>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_ensemble_rmsCategory/VRPTx:pdbx_nmr_ensemble_rms">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_ensemble_rms>
      <PDBo:pdbx_nmr_ensemble_rms rdf:about="{$base}/pdbx_nmr_ensemble_rms/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_nmr_ensemble_rms rdf:resource="{$base}/pdbx_nmr_ensemble_rms/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_21_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_ensemble_rms>
      </PDBo:has_pdbx_nmr_ensemble_rms>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_exptlCategory/VRPTx:pdbx_nmr_exptl">
      <xsl:variable name="conditions_id_truncated"><xsl:choose><xsl:when test="string-length(@conditions_id)&lt;64"><xsl:value-of select="@conditions_id"/></xsl:when><xsl:when test="contains(@conditions_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@conditions_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@conditions_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="conditions_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($conditions_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="experiment_id_truncated"><xsl:choose><xsl:when test="string-length(@experiment_id)&lt;64"><xsl:value-of select="@experiment_id"/></xsl:when><xsl:when test="contains(@experiment_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@experiment_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@experiment_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="experiment_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($experiment_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="solution_id_truncated"><xsl:choose><xsl:when test="string-length(@solution_id)&lt;64"><xsl:value-of select="@solution_id"/></xsl:when><xsl:when test="contains(@solution_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@solution_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@solution_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="solution_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($solution_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_exptl>
      <PDBo:pdbx_nmr_exptl rdf:about="{$base}/pdbx_nmr_exptl/{$conditions_id_encoded},{$experiment_id_encoded},{$solution_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_exptl>
      </PDBo:has_pdbx_nmr_exptl>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_exptl_sampleCategory/VRPTx:pdbx_nmr_exptl_sample">
      <xsl:variable name="component_truncated"><xsl:choose><xsl:when test="string-length(@component)&lt;64"><xsl:value-of select="@component"/></xsl:when><xsl:when test="contains(@component,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@component,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@component,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="component_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($component_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="solution_id_truncated"><xsl:choose><xsl:when test="string-length(@solution_id)&lt;64"><xsl:value-of select="@solution_id"/></xsl:when><xsl:when test="contains(@solution_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@solution_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@solution_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="solution_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($solution_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_exptl_sample>
      <PDBo:pdbx_nmr_exptl_sample rdf:about="{$base}/pdbx_nmr_exptl_sample/{$component_encoded},{$solution_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_exptl_sample>
      </PDBo:has_pdbx_nmr_exptl_sample>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_exptl_sample_conditionsCategory/VRPTx:pdbx_nmr_exptl_sample_conditions">
      <xsl:variable name="conditions_id_truncated"><xsl:choose><xsl:when test="string-length(@conditions_id)&lt;64"><xsl:value-of select="@conditions_id"/></xsl:when><xsl:when test="contains(@conditions_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@conditions_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@conditions_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="conditions_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($conditions_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_exptl_sample_conditions>
      <PDBo:pdbx_nmr_exptl_sample_conditions rdf:about="{$base}/pdbx_nmr_exptl_sample_conditions/{$conditions_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_exptl_sample_conditions>
      </PDBo:has_pdbx_nmr_exptl_sample_conditions>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_force_constantsCategory/VRPTx:pdbx_nmr_force_constants">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_force_constants>
      <PDBo:pdbx_nmr_force_constants rdf:about="{$base}/pdbx_nmr_force_constants/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_nmr_force_constants rdf:resource="{$base}/pdbx_nmr_force_constants/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_22_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_force_constants>
      </PDBo:has_pdbx_nmr_force_constants>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_refineCategory/VRPTx:pdbx_nmr_refine">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="software_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@software_ordinal)&lt;64"><xsl:value-of select="@software_ordinal"/></xsl:when><xsl:when test="contains(@software_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@software_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@software_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="software_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($software_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_refine>
      <PDBo:pdbx_nmr_refine rdf:about="{$base}/pdbx_nmr_refine/{$entry_id_encoded},{$software_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_nmr_refine rdf:resource="{$base}/pdbx_nmr_refine/{$entry_id_encoded},{$software_ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_23_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_refine>
      </PDBo:has_pdbx_nmr_refine>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_representativeCategory/VRPTx:pdbx_nmr_representative">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_representative>
      <PDBo:pdbx_nmr_representative rdf:about="{$base}/pdbx_nmr_representative/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_nmr_representative rdf:resource="{$base}/pdbx_nmr_representative/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_24_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_representative>
      </PDBo:has_pdbx_nmr_representative>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_restraint_listCategory/VRPTx:pdbx_nmr_restraint_list">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_restraint_list>
      <PDBo:pdbx_nmr_restraint_list rdf:about="{$base}/pdbx_nmr_restraint_list/{$id_encoded},{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_restraint_list>
      </PDBo:has_pdbx_nmr_restraint_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_restraint_summaryCategory/VRPTx:pdbx_nmr_restraint_summary">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_restraint_summary>
      <PDBo:pdbx_nmr_restraint_summary rdf:about="{$base}/pdbx_nmr_restraint_summary/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_nmr_restraint_summary rdf:resource="{$base}/pdbx_nmr_restraint_summary/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_25_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_restraint_summary>
      </PDBo:has_pdbx_nmr_restraint_summary>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_restraint_violationCategory/VRPTx:pdbx_nmr_restraint_violation">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_restraint_violation>
      <PDBo:pdbx_nmr_restraint_violation rdf:about="{$base}/pdbx_nmr_restraint_violation/{$ordinal_encoded},{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_restraint_violation>
      </PDBo:has_pdbx_nmr_restraint_violation>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_softwareCategory/VRPTx:pdbx_nmr_software">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_software>
      <PDBo:pdbx_nmr_software rdf:about="{$base}/pdbx_nmr_software/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_software>
      </PDBo:has_pdbx_nmr_software>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_spectrometerCategory/VRPTx:pdbx_nmr_spectrometer">
      <xsl:variable name="spectrometer_id_truncated"><xsl:choose><xsl:when test="string-length(@spectrometer_id)&lt;64"><xsl:value-of select="@spectrometer_id"/></xsl:when><xsl:when test="contains(@spectrometer_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@spectrometer_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@spectrometer_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="spectrometer_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($spectrometer_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_spectrometer>
      <PDBo:pdbx_nmr_spectrometer rdf:about="{$base}/pdbx_nmr_spectrometer/{$spectrometer_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_spectrometer>
      </PDBo:has_pdbx_nmr_spectrometer>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_unmapped_chem_shiftCategory/VRPTx:pdbx_nmr_unmapped_chem_shift">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="list_id_truncated"><xsl:choose><xsl:when test="string-length(@list_id)&lt;64"><xsl:value-of select="@list_id"/></xsl:when><xsl:when test="contains(@list_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@list_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@list_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="list_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($list_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_unmapped_chem_shift>
      <PDBo:pdbx_nmr_unmapped_chem_shift rdf:about="{$base}/pdbx_nmr_unmapped_chem_shift/{$id_encoded},{$list_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
	<PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/">
	    <PDBo:referenced_by_pdbx_nmr_unmapped_chem_shift rdf:resource="{$base}/pdbx_nmr_unmapped_chem_shift/{$id_encoded},{$list_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	<!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_unmapped_chem_shift>
      </PDBo:has_pdbx_nmr_unmapped_chem_shift>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nmr_unparsed_chem_shiftCategory/VRPTx:pdbx_nmr_unparsed_chem_shift">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="list_id_truncated"><xsl:choose><xsl:when test="string-length(@list_id)&lt;64"><xsl:value-of select="@list_id"/></xsl:when><xsl:when test="contains(@list_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@list_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@list_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="list_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($list_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nmr_unparsed_chem_shift>
      <PDBo:pdbx_nmr_unparsed_chem_shift rdf:about="{$base}/pdbx_nmr_unparsed_chem_shift/{$id_encoded},{$list_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
	<PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/">
	    <PDBo:referenced_by_pdbx_nmr_unparsed_chem_shift rdf:resource="{$base}/pdbx_nmr_unparsed_chem_shift/{$id_encoded},{$list_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	<!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_unparsed_chem_shift>
      </PDBo:has_pdbx_nmr_unparsed_chem_shift>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_nonpoly_schemeCategory/VRPTx:pdbx_nonpoly_scheme">
      <xsl:variable name="asym_id_truncated"><xsl:choose><xsl:when test="string-length(@asym_id)&lt;64"><xsl:value-of select="@asym_id"/></xsl:when><xsl:when test="contains(@asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="ndb_seq_num_truncated"><xsl:choose><xsl:when test="string-length(@ndb_seq_num)&lt;64"><xsl:value-of select="@ndb_seq_num"/></xsl:when><xsl:when test="contains(@ndb_seq_num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ndb_seq_num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ndb_seq_num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ndb_seq_num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ndb_seq_num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_nonpoly_scheme>
      <PDBo:pdbx_nonpoly_scheme rdf:about="{$base}/pdbx_nonpoly_scheme/{$asym_id_encoded},{$ndb_seq_num_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nonpoly_scheme>
      </PDBo:has_pdbx_nonpoly_scheme>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_percentile_conditionsCategory/VRPTx:pdbx_percentile_conditions">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_percentile_conditions>
      <PDBo:pdbx_percentile_conditions rdf:about="{$base}/pdbx_percentile_conditions/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_percentile_conditions>
      </PDBo:has_pdbx_percentile_conditions>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_percentile_entity_viewCategory/VRPTx:pdbx_percentile_entity_view">
      <xsl:variable name="PDB_model_num_truncated"><xsl:choose><xsl:when test="string-length(@PDB_model_num)&lt;64"><xsl:value-of select="@PDB_model_num"/></xsl:when><xsl:when test="contains(@PDB_model_num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@PDB_model_num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@PDB_model_num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="PDB_model_num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($PDB_model_num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="conditions_id_truncated"><xsl:choose><xsl:when test="string-length(@conditions_id)&lt;64"><xsl:value-of select="@conditions_id"/></xsl:when><xsl:when test="contains(@conditions_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@conditions_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@conditions_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="conditions_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($conditions_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="label_asym_id_truncated"><xsl:choose><xsl:when test="string-length(@label_asym_id)&lt;64"><xsl:value-of select="@label_asym_id"/></xsl:when><xsl:when test="contains(@label_asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@label_asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@label_asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="label_asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($label_asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_percentile_entity_view>
      <PDBo:pdbx_percentile_entity_view rdf:about="{$base}/pdbx_percentile_entity_view/{$PDB_model_num_encoded},{$conditions_id_encoded},{$label_asym_id_encoded},{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@conditions_id!=''">
	<PDBo:reference_to_pdbx_percentile_conditions>
	  <rdf:Description rdf:about="{$base}/pdbx_percentile_conditions/">
	    <PDBo:referenced_by_pdbx_percentile_entity_view rdf:resource="{$base}/pdbx_percentile_entity_view/{$PDB_model_num_encoded},{$conditions_id_encoded},{$label_asym_id_encoded},{$type_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_percentile_conditions>
	<!-- pdbx_percentile_conditionsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_percentile_entity_view>
      </PDBo:has_pdbx_percentile_entity_view>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_percentile_listCategory/VRPTx:pdbx_percentile_list">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_percentile_list>
      <PDBo:pdbx_percentile_list rdf:about="{$base}/pdbx_percentile_list/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_percentile_list rdf:resource="{$base}/pdbx_percentile_list/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_26_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_percentile_list>
      </PDBo:has_pdbx_percentile_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_percentile_viewCategory/VRPTx:pdbx_percentile_view">
      <xsl:variable name="conditions_id_truncated"><xsl:choose><xsl:when test="string-length(@conditions_id)&lt;64"><xsl:value-of select="@conditions_id"/></xsl:when><xsl:when test="contains(@conditions_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@conditions_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@conditions_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="conditions_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($conditions_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_percentile_view>
      <PDBo:pdbx_percentile_view rdf:about="{$base}/pdbx_percentile_view/{$conditions_id_encoded},{$entry_id_encoded},{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_percentile_view rdf:resource="{$base}/pdbx_percentile_view/{$conditions_id_encoded},{$entry_id_encoded},{$type_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_27_0 -->
      </xsl:if>
      <xsl:if test="@conditions_id!=''">
	<PDBo:reference_to_pdbx_percentile_conditions>
	  <rdf:Description rdf:about="{$base}/pdbx_percentile_conditions/">
	    <PDBo:referenced_by_pdbx_percentile_view rdf:resource="{$base}/pdbx_percentile_view/{$conditions_id_encoded},{$entry_id_encoded},{$type_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_percentile_conditions>
	<!-- pdbx_percentile_conditionsKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_percentile_view>
      </PDBo:has_pdbx_percentile_view>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MAD_setCategory/VRPTx:pdbx_phasing_MAD_set">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_phasing_MAD_set>
      <PDBo:pdbx_phasing_MAD_set rdf:about="{$base}/pdbx_phasing_MAD_set/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MAD_set>
      </PDBo:has_pdbx_phasing_MAD_set>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MAD_set_shellCategory/VRPTx:pdbx_phasing_MAD_set_shell">
      <xsl:variable name="d_res_high_truncated"><xsl:choose><xsl:when test="string-length(@d_res_high)&lt;64"><xsl:value-of select="@d_res_high"/></xsl:when><xsl:when test="contains(@d_res_high,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_high,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_high,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_high_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_high_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="d_res_low_truncated"><xsl:choose><xsl:when test="string-length(@d_res_low)&lt;64"><xsl:value-of select="@d_res_low"/></xsl:when><xsl:when test="contains(@d_res_low,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_low,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_low,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_low_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_low_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_phasing_MAD_set_shell>
      <PDBo:pdbx_phasing_MAD_set_shell rdf:about="{$base}/pdbx_phasing_MAD_set_shell/{$d_res_high_encoded},{$d_res_low_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MAD_set_shell>
      </PDBo:has_pdbx_phasing_MAD_set_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MAD_set_siteCategory/VRPTx:pdbx_phasing_MAD_set_site">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_phasing_MAD_set_site>
      <PDBo:pdbx_phasing_MAD_set_site rdf:about="{$base}/pdbx_phasing_MAD_set_site/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MAD_set_site>
      </PDBo:has_pdbx_phasing_MAD_set_site>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MAD_shellCategory/VRPTx:pdbx_phasing_MAD_shell">
      <xsl:variable name="d_res_high_truncated"><xsl:choose><xsl:when test="string-length(@d_res_high)&lt;64"><xsl:value-of select="@d_res_high"/></xsl:when><xsl:when test="contains(@d_res_high,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_high,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_high,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_high_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_high_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="d_res_low_truncated"><xsl:choose><xsl:when test="string-length(@d_res_low)&lt;64"><xsl:value-of select="@d_res_low"/></xsl:when><xsl:when test="contains(@d_res_low,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_low,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_low,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_low_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_low_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_phasing_MAD_shell>
      <PDBo:pdbx_phasing_MAD_shell rdf:about="{$base}/pdbx_phasing_MAD_shell/{$d_res_high_encoded},{$d_res_low_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MAD_shell>
      </PDBo:has_pdbx_phasing_MAD_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_MRCategory/VRPTx:pdbx_phasing_MR">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_phasing_MR>
      <PDBo:pdbx_phasing_MR rdf:about="{$base}/pdbx_phasing_MR/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MR>
      </PDBo:has_pdbx_phasing_MR>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_dmCategory/VRPTx:pdbx_phasing_dm">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_phasing_dm>
      <PDBo:pdbx_phasing_dm rdf:about="{$base}/pdbx_phasing_dm/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_dm>
      </PDBo:has_pdbx_phasing_dm>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_phasing_dm_shellCategory/VRPTx:pdbx_phasing_dm_shell">
      <xsl:variable name="d_res_high_truncated"><xsl:choose><xsl:when test="string-length(@d_res_high)&lt;64"><xsl:value-of select="@d_res_high"/></xsl:when><xsl:when test="contains(@d_res_high,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_high,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_high,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_high_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_high_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="d_res_low_truncated"><xsl:choose><xsl:when test="string-length(@d_res_low)&lt;64"><xsl:value-of select="@d_res_low"/></xsl:when><xsl:when test="contains(@d_res_low,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_low,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_low,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_low_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_low_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_phasing_dm_shell>
      <PDBo:pdbx_phasing_dm_shell rdf:about="{$base}/pdbx_phasing_dm_shell/{$d_res_high_encoded},{$d_res_low_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_dm_shell>
      </PDBo:has_pdbx_phasing_dm_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_point_symmetryCategory/VRPTx:pdbx_point_symmetry">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_point_symmetry>
      <PDBo:pdbx_point_symmetry rdf:about="{$base}/pdbx_point_symmetry/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_point_symmetry rdf:resource="{$base}/pdbx_point_symmetry/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_28_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_point_symmetry>
      </PDBo:has_pdbx_point_symmetry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_poly_seq_schemeCategory/VRPTx:pdbx_poly_seq_scheme">
      <xsl:variable name="asym_id_truncated"><xsl:choose><xsl:when test="string-length(@asym_id)&lt;64"><xsl:value-of select="@asym_id"/></xsl:when><xsl:when test="contains(@asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="mon_id_truncated"><xsl:choose><xsl:when test="string-length(@mon_id)&lt;64"><xsl:value-of select="@mon_id"/></xsl:when><xsl:when test="contains(@mon_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@mon_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@mon_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="mon_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($mon_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="seq_id_truncated"><xsl:choose><xsl:when test="string-length(@seq_id)&lt;64"><xsl:value-of select="@seq_id"/></xsl:when><xsl:when test="contains(@seq_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@seq_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@seq_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="seq_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($seq_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_poly_seq_scheme>
      <PDBo:pdbx_poly_seq_scheme rdf:about="{$base}/pdbx_poly_seq_scheme/{$asym_id_encoded},{$entity_id_encoded},{$mon_id_encoded},{$seq_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!='' and @mon_id!='' and @seq_id!=''">
	<PDBo:reference_to_entity_poly_seq>
	  <rdf:Description rdf:about="{$base}/entity_poly_seq/,,">
	    <PDBo:referenced_by_pdbx_poly_seq_scheme rdf:resource="{$base}/pdbx_poly_seq_scheme/{$asym_id_encoded},{$entity_id_encoded},{$mon_id_encoded},{$seq_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity_poly_seq>
	<!-- entity_poly_seqKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@entity_id!='' and @asym_id!=''">
	<PDBo:reference_to_struct_asym>
	  <rdf:Description rdf:about="{$base}/struct_asym/,">
	    <PDBo:referenced_by_pdbx_poly_seq_scheme rdf:resource="{$base}/pdbx_poly_seq_scheme/{$asym_id_encoded},{$entity_id_encoded},{$mon_id_encoded},{$seq_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_asym>
	<!-- struct_asymKeyref_1_1_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_poly_seq_scheme>
      </PDBo:has_pdbx_poly_seq_scheme>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_re_refinementCategory/VRPTx:pdbx_re_refinement">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_re_refinement>
      <PDBo:pdbx_re_refinement rdf:about="{$base}/pdbx_re_refinement/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_re_refinement>
      </PDBo:has_pdbx_re_refinement>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refineCategory/VRPTx:pdbx_refine">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_refine>
      <PDBo:pdbx_refine rdf:about="{$base}/pdbx_refine/{$entry_id_encoded},{$pdbx_refine_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_refine rdf:resource="{$base}/pdbx_refine/{$entry_id_encoded},{$pdbx_refine_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_29_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine>
      </PDBo:has_pdbx_refine>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refine_componentCategory/VRPTx:pdbx_refine_component">
      <xsl:variable name="label_alt_id_truncated"><xsl:choose><xsl:when test="string-length(@label_alt_id)&lt;64"><xsl:value-of select="@label_alt_id"/></xsl:when><xsl:when test="contains(@label_alt_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@label_alt_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@label_alt_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="label_alt_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($label_alt_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="label_asym_id_truncated"><xsl:choose><xsl:when test="string-length(@label_asym_id)&lt;64"><xsl:value-of select="@label_asym_id"/></xsl:when><xsl:when test="contains(@label_asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@label_asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@label_asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="label_asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($label_asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="label_comp_id_truncated"><xsl:choose><xsl:when test="string-length(@label_comp_id)&lt;64"><xsl:value-of select="@label_comp_id"/></xsl:when><xsl:when test="contains(@label_comp_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@label_comp_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@label_comp_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="label_comp_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($label_comp_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="label_seq_id_truncated"><xsl:choose><xsl:when test="string-length(@label_seq_id)&lt;64"><xsl:value-of select="@label_seq_id"/></xsl:when><xsl:when test="contains(@label_seq_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@label_seq_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@label_seq_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="label_seq_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($label_seq_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_refine_component>
      <PDBo:pdbx_refine_component rdf:about="{$base}/pdbx_refine_component/{$label_alt_id_encoded},{$label_asym_id_encoded},{$label_comp_id_encoded},{$label_seq_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine_component>
      </PDBo:has_pdbx_refine_component>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refine_tlsCategory/VRPTx:pdbx_refine_tls">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_refine_tls>
      <PDBo:pdbx_refine_tls rdf:about="{$base}/pdbx_refine_tls/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine_tls>
      </PDBo:has_pdbx_refine_tls>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refine_tls_groupCategory/VRPTx:pdbx_refine_tls_group">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_refine_tls_group>
      <PDBo:pdbx_refine_tls_group rdf:about="{$base}/pdbx_refine_tls_group/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:refine_tls_id!=''">
	<PDBo:reference_to_pdbx_refine_tls>
	  <rdf:Description rdf:about="{$base}/pdbx_refine_tls/{translate(VRPTx:refine_tls_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_refine_tls_group rdf:resource="{$base}/pdbx_refine_tls_group/{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_refine_tls>
	<!-- pdbx_refine_tlsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine_tls_group>
      </PDBo:has_pdbx_refine_tls_group>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_refln_signal_binningCategory/VRPTx:pdbx_refln_signal_binning">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_refln_signal_binning>
      <PDBo:pdbx_refln_signal_binning rdf:about="{$base}/pdbx_refln_signal_binning/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refln_signal_binning>
      </PDBo:has_pdbx_refln_signal_binning>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_reflns_twinCategory/VRPTx:pdbx_reflns_twin">
      <xsl:variable name="crystal_id_truncated"><xsl:choose><xsl:when test="string-length(@crystal_id)&lt;64"><xsl:value-of select="@crystal_id"/></xsl:when><xsl:when test="contains(@crystal_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@crystal_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@crystal_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="crystal_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($crystal_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="diffrn_id_truncated"><xsl:choose><xsl:when test="string-length(@diffrn_id)&lt;64"><xsl:value-of select="@diffrn_id"/></xsl:when><xsl:when test="contains(@diffrn_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@diffrn_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@diffrn_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="diffrn_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($diffrn_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="operator_truncated"><xsl:choose><xsl:when test="string-length(@operator)&lt;64"><xsl:value-of select="@operator"/></xsl:when><xsl:when test="contains(@operator,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@operator,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@operator,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="operator_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($operator_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_reflns_twin>
      <PDBo:pdbx_reflns_twin rdf:about="{$base}/pdbx_reflns_twin/{$crystal_id_encoded},{$diffrn_id_encoded},{$operator_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reflns_twin>
      </PDBo:has_pdbx_reflns_twin>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_related_exp_data_setCategory/VRPTx:pdbx_related_exp_data_set">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_related_exp_data_set>
      <PDBo:pdbx_related_exp_data_set rdf:about="{$base}/pdbx_related_exp_data_set/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_related_exp_data_set>
      </PDBo:has_pdbx_related_exp_data_set>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_sequence_rangeCategory/VRPTx:pdbx_sequence_range">
      <xsl:variable name="beg_label_alt_id_truncated"><xsl:choose><xsl:when test="string-length(@beg_label_alt_id)&lt;64"><xsl:value-of select="@beg_label_alt_id"/></xsl:when><xsl:when test="contains(@beg_label_alt_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@beg_label_alt_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@beg_label_alt_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="beg_label_alt_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($beg_label_alt_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="beg_label_asym_id_truncated"><xsl:choose><xsl:when test="string-length(@beg_label_asym_id)&lt;64"><xsl:value-of select="@beg_label_asym_id"/></xsl:when><xsl:when test="contains(@beg_label_asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@beg_label_asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@beg_label_asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="beg_label_asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($beg_label_asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="beg_label_comp_id_truncated"><xsl:choose><xsl:when test="string-length(@beg_label_comp_id)&lt;64"><xsl:value-of select="@beg_label_comp_id"/></xsl:when><xsl:when test="contains(@beg_label_comp_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@beg_label_comp_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@beg_label_comp_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="beg_label_comp_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($beg_label_comp_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="beg_label_seq_id_truncated"><xsl:choose><xsl:when test="string-length(@beg_label_seq_id)&lt;64"><xsl:value-of select="@beg_label_seq_id"/></xsl:when><xsl:when test="contains(@beg_label_seq_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@beg_label_seq_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@beg_label_seq_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="beg_label_seq_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($beg_label_seq_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="end_label_alt_id_truncated"><xsl:choose><xsl:when test="string-length(@end_label_alt_id)&lt;64"><xsl:value-of select="@end_label_alt_id"/></xsl:when><xsl:when test="contains(@end_label_alt_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@end_label_alt_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@end_label_alt_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="end_label_alt_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($end_label_alt_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="end_label_asym_id_truncated"><xsl:choose><xsl:when test="string-length(@end_label_asym_id)&lt;64"><xsl:value-of select="@end_label_asym_id"/></xsl:when><xsl:when test="contains(@end_label_asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@end_label_asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@end_label_asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="end_label_asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($end_label_asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="end_label_comp_id_truncated"><xsl:choose><xsl:when test="string-length(@end_label_comp_id)&lt;64"><xsl:value-of select="@end_label_comp_id"/></xsl:when><xsl:when test="contains(@end_label_comp_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@end_label_comp_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@end_label_comp_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="end_label_comp_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($end_label_comp_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="end_label_seq_id_truncated"><xsl:choose><xsl:when test="string-length(@end_label_seq_id)&lt;64"><xsl:value-of select="@end_label_seq_id"/></xsl:when><xsl:when test="contains(@end_label_seq_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@end_label_seq_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@end_label_seq_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="end_label_seq_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($end_label_seq_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="seq_range_id_truncated"><xsl:choose><xsl:when test="string-length(@seq_range_id)&lt;64"><xsl:value-of select="@seq_range_id"/></xsl:when><xsl:when test="contains(@seq_range_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@seq_range_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@seq_range_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="seq_range_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($seq_range_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_sequence_range>
      <PDBo:pdbx_sequence_range rdf:about="{$base}/pdbx_sequence_range/{$beg_label_alt_id_encoded},{$beg_label_asym_id_encoded},{$beg_label_comp_id_encoded},{$beg_label_seq_id_encoded},{$end_label_alt_id_encoded},{$end_label_asym_id_encoded},{$end_label_comp_id_encoded},{$end_label_seq_id_encoded},{$seq_range_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_sequence_range>
      </PDBo:has_pdbx_sequence_range>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_sifts_unp_segmentsCategory/VRPTx:pdbx_sifts_unp_segments">
      <xsl:variable name="asym_id_truncated"><xsl:choose><xsl:when test="string-length(@asym_id)&lt;64"><xsl:value-of select="@asym_id"/></xsl:when><xsl:when test="contains(@asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="instance_id_truncated"><xsl:choose><xsl:when test="string-length(@instance_id)&lt;64"><xsl:value-of select="@instance_id"/></xsl:when><xsl:when test="contains(@instance_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@instance_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@instance_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="instance_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($instance_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="segment_id_truncated"><xsl:choose><xsl:when test="string-length(@segment_id)&lt;64"><xsl:value-of select="@segment_id"/></xsl:when><xsl:when test="contains(@segment_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@segment_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@segment_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="segment_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($segment_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="unp_acc_truncated"><xsl:choose><xsl:when test="string-length(@unp_acc)&lt;64"><xsl:value-of select="@unp_acc"/></xsl:when><xsl:when test="contains(@unp_acc,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@unp_acc,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@unp_acc,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="unp_acc_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($unp_acc_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_sifts_unp_segments>
      <PDBo:pdbx_sifts_unp_segments rdf:about="{$base}/pdbx_sifts_unp_segments/{$asym_id_encoded},{$entity_id_encoded},{$instance_id_encoded},{$segment_id_encoded},{$unp_acc_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
	<PDBo:reference_to_struct_asym>
	  <rdf:Description rdf:about="{$base}/struct_asym/">
	    <PDBo:referenced_by_pdbx_sifts_unp_segments rdf:resource="{$base}/pdbx_sifts_unp_segments/{$asym_id_encoded},{$entity_id_encoded},{$instance_id_encoded},{$segment_id_encoded},{$unp_acc_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_asym>
	<!-- struct_asymKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_sifts_unp_segments>
      </PDBo:has_pdbx_sifts_unp_segments>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_sifts_xref_dbCategory/VRPTx:pdbx_sifts_xref_db">
      <xsl:variable name="asym_id_truncated"><xsl:choose><xsl:when test="string-length(@asym_id)&lt;64"><xsl:value-of select="@asym_id"/></xsl:when><xsl:when test="contains(@asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="seq_id_truncated"><xsl:choose><xsl:when test="string-length(@seq_id)&lt;64"><xsl:value-of select="@seq_id"/></xsl:when><xsl:when test="contains(@seq_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@seq_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@seq_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="seq_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($seq_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="seq_id_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@seq_id_ordinal)&lt;64"><xsl:value-of select="@seq_id_ordinal"/></xsl:when><xsl:when test="contains(@seq_id_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@seq_id_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@seq_id_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="seq_id_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($seq_id_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_sifts_xref_db>
      <PDBo:pdbx_sifts_xref_db rdf:about="{$base}/pdbx_sifts_xref_db/{$asym_id_encoded},{$entity_id_encoded},{$seq_id_encoded},{$seq_id_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
	<PDBo:reference_to_struct_asym>
	  <rdf:Description rdf:about="{$base}/struct_asym/">
	    <PDBo:referenced_by_pdbx_sifts_xref_db rdf:resource="{$base}/pdbx_sifts_xref_db/{$asym_id_encoded},{$entity_id_encoded},{$seq_id_encoded},{$seq_id_ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_asym>
	<!-- struct_asymKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_sifts_xref_db>
      </PDBo:has_pdbx_sifts_xref_db>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_sifts_xref_db_segmentsCategory/VRPTx:pdbx_sifts_xref_db_segments">
      <xsl:variable name="asym_id_truncated"><xsl:choose><xsl:when test="string-length(@asym_id)&lt;64"><xsl:value-of select="@asym_id"/></xsl:when><xsl:when test="contains(@asym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@asym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@asym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="asym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($asym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="entity_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_id)&lt;64"><xsl:value-of select="@entity_id"/></xsl:when><xsl:when test="contains(@entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="instance_id_truncated"><xsl:choose><xsl:when test="string-length(@instance_id)&lt;64"><xsl:value-of select="@instance_id"/></xsl:when><xsl:when test="contains(@instance_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@instance_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@instance_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="instance_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($instance_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="segment_id_truncated"><xsl:choose><xsl:when test="string-length(@segment_id)&lt;64"><xsl:value-of select="@segment_id"/></xsl:when><xsl:when test="contains(@segment_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@segment_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@segment_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="segment_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($segment_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="seq_id_end_truncated"><xsl:choose><xsl:when test="string-length(@seq_id_end)&lt;64"><xsl:value-of select="@seq_id_end"/></xsl:when><xsl:when test="contains(@seq_id_end,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@seq_id_end,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@seq_id_end,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="seq_id_end_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($seq_id_end_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="seq_id_start_truncated"><xsl:choose><xsl:when test="string-length(@seq_id_start)&lt;64"><xsl:value-of select="@seq_id_start"/></xsl:when><xsl:when test="contains(@seq_id_start,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@seq_id_start,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@seq_id_start,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="seq_id_start_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($seq_id_start_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="xref_db_truncated"><xsl:choose><xsl:when test="string-length(@xref_db)&lt;64"><xsl:value-of select="@xref_db"/></xsl:when><xsl:when test="contains(@xref_db,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@xref_db,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@xref_db,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="xref_db_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($xref_db_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="xref_db_acc_truncated"><xsl:choose><xsl:when test="string-length(@xref_db_acc)&lt;64"><xsl:value-of select="@xref_db_acc"/></xsl:when><xsl:when test="contains(@xref_db_acc,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@xref_db_acc,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@xref_db_acc,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="xref_db_acc_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($xref_db_acc_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_sifts_xref_db_segments>
      <PDBo:pdbx_sifts_xref_db_segments rdf:about="{$base}/pdbx_sifts_xref_db_segments/{$asym_id_encoded},{$entity_id_encoded},{$instance_id_encoded},{$segment_id_encoded},{$seq_id_end_encoded},{$seq_id_start_encoded},{$xref_db_encoded},{$xref_db_acc_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
	<PDBo:reference_to_struct_asym>
	  <rdf:Description rdf:about="{$base}/struct_asym/">
	    <PDBo:referenced_by_pdbx_sifts_xref_db_segments rdf:resource="{$base}/pdbx_sifts_xref_db_segments/{$asym_id_encoded},{$entity_id_encoded},{$instance_id_encoded},{$segment_id_encoded},{$seq_id_end_encoded},{$seq_id_start_encoded},{$xref_db_encoded},{$xref_db_acc_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_asym>
	<!-- struct_asymKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_sifts_xref_db_segments>
      </PDBo:has_pdbx_sifts_xref_db_segments>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_soln_scatterCategory/VRPTx:pdbx_soln_scatter">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_soln_scatter>
      <PDBo:pdbx_soln_scatter rdf:about="{$base}/pdbx_soln_scatter/{$entry_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_soln_scatter rdf:resource="{$base}/pdbx_soln_scatter/{$entry_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_30_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_soln_scatter>
      </PDBo:has_pdbx_soln_scatter>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_soln_scatter_modelCategory/VRPTx:pdbx_soln_scatter_model">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="scatter_id_truncated"><xsl:choose><xsl:when test="string-length(@scatter_id)&lt;64"><xsl:value-of select="@scatter_id"/></xsl:when><xsl:when test="contains(@scatter_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@scatter_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@scatter_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="scatter_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($scatter_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_soln_scatter_model>
      <PDBo:pdbx_soln_scatter_model rdf:about="{$base}/pdbx_soln_scatter_model/{$id_encoded},{$scatter_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_soln_scatter_model>
      </PDBo:has_pdbx_soln_scatter_model>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_assemblyCategory/VRPTx:pdbx_struct_assembly">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_assembly>
      <PDBo:pdbx_struct_assembly rdf:about="{$base}/pdbx_struct_assembly/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly>
      </PDBo:has_pdbx_struct_assembly>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_assembly_genCategory/VRPTx:pdbx_struct_assembly_gen">
      <xsl:variable name="assembly_id_truncated"><xsl:choose><xsl:when test="string-length(@assembly_id)&lt;64"><xsl:value-of select="@assembly_id"/></xsl:when><xsl:when test="contains(@assembly_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@assembly_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@assembly_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="assembly_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($assembly_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="asym_id_list_truncated"><xsl:choose><xsl:when test="string-length(@asym_id_list)&lt;64"><xsl:value-of select="@asym_id_list"/></xsl:when><xsl:when test="contains(@asym_id_list,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@asym_id_list,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@asym_id_list,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="asym_id_list_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($asym_id_list_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="oper_expression_truncated"><xsl:choose><xsl:when test="string-length(@oper_expression)&lt;64"><xsl:value-of select="@oper_expression"/></xsl:when><xsl:when test="contains(@oper_expression,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@oper_expression,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@oper_expression,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="oper_expression_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($oper_expression_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_assembly_gen>
      <PDBo:pdbx_struct_assembly_gen rdf:about="{$base}/pdbx_struct_assembly_gen/{$assembly_id_encoded},{$asym_id_list_encoded},{$oper_expression_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@assembly_id!=''">
	<PDBo:reference_to_pdbx_struct_assembly>
	  <rdf:Description rdf:about="{$base}/pdbx_struct_assembly/">
	    <PDBo:referenced_by_pdbx_struct_assembly_gen rdf:resource="{$base}/pdbx_struct_assembly_gen/{$assembly_id_encoded},{$asym_id_list_encoded},{$oper_expression_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_struct_assembly>
	<!-- pdbx_struct_assemblyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_gen>
      </PDBo:has_pdbx_struct_assembly_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_assembly_propCategory/VRPTx:pdbx_struct_assembly_prop">
      <xsl:variable name="biol_id_truncated"><xsl:choose><xsl:when test="string-length(@biol_id)&lt;64"><xsl:value-of select="@biol_id"/></xsl:when><xsl:when test="contains(@biol_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@biol_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@biol_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="biol_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($biol_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_assembly_prop>
      <PDBo:pdbx_struct_assembly_prop rdf:about="{$base}/pdbx_struct_assembly_prop/{$biol_id_encoded},{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_prop>
      </PDBo:has_pdbx_struct_assembly_prop>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_asym_genCategory/VRPTx:pdbx_struct_asym_gen">
      <xsl:variable name="entity_inst_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_inst_id)&lt;64"><xsl:value-of select="@entity_inst_id"/></xsl:when><xsl:when test="contains(@entity_inst_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_inst_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_inst_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_inst_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_inst_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="oper_expression_truncated"><xsl:choose><xsl:when test="string-length(@oper_expression)&lt;64"><xsl:value-of select="@oper_expression"/></xsl:when><xsl:when test="contains(@oper_expression,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@oper_expression,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@oper_expression,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="oper_expression_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($oper_expression_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_asym_gen>
      <PDBo:pdbx_struct_asym_gen rdf:about="{$base}/pdbx_struct_asym_gen/{$entity_inst_id_encoded},{$oper_expression_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_inst_id!=''">
	<PDBo:reference_to_pdbx_struct_entity_inst>
	  <rdf:Description rdf:about="{$base}/pdbx_struct_entity_inst/">
	    <PDBo:referenced_by_pdbx_struct_asym_gen rdf:resource="{$base}/pdbx_struct_asym_gen/{$entity_inst_id_encoded},{$oper_expression_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_struct_entity_inst>
	<!-- pdbx_struct_entity_instKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_asym_gen>
      </PDBo:has_pdbx_struct_asym_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_chem_comp_diagnosticsCategory/VRPTx:pdbx_struct_chem_comp_diagnostics">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_chem_comp_diagnostics>
      <PDBo:pdbx_struct_chem_comp_diagnostics rdf:about="{$base}/pdbx_struct_chem_comp_diagnostics/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_chem_comp_diagnostics>
      </PDBo:has_pdbx_struct_chem_comp_diagnostics>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_conn_angleCategory/VRPTx:pdbx_struct_conn_angle">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_conn_angle>
      <PDBo:pdbx_struct_conn_angle rdf:about="{$base}/pdbx_struct_conn_angle/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_conn_angle>
      </PDBo:has_pdbx_struct_conn_angle>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_entity_instCategory/VRPTx:pdbx_struct_entity_inst">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_entity_inst>
      <PDBo:pdbx_struct_entity_inst rdf:about="{$base}/pdbx_struct_entity_inst/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_entity_inst>
      </PDBo:has_pdbx_struct_entity_inst>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_group_component_rangeCategory/VRPTx:pdbx_struct_group_component_range">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_group_component_range>
      <PDBo:pdbx_struct_group_component_range rdf:about="{$base}/pdbx_struct_group_component_range/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:struct_group_id!=''">
	<PDBo:reference_to_pdbx_struct_group_list>
	  <rdf:Description rdf:about="{$base}/pdbx_struct_group_list/{translate(VRPTx:struct_group_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_struct_group_component_range rdf:resource="{$base}/pdbx_struct_group_component_range/{$ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_struct_group_list>
	<!-- pdbx_struct_group_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_group_component_range>
      </PDBo:has_pdbx_struct_group_component_range>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_group_componentsCategory/VRPTx:pdbx_struct_group_components">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_group_components>
      <PDBo:pdbx_struct_group_components rdf:about="{$base}/pdbx_struct_group_components/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:struct_group_id!=''">
	<PDBo:reference_to_pdbx_struct_group_list>
	  <rdf:Description rdf:about="{$base}/pdbx_struct_group_list/{translate(VRPTx:struct_group_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_struct_group_components rdf:resource="{$base}/pdbx_struct_group_components/{$ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_struct_group_list>
	<!-- pdbx_struct_group_listKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_group_components>
      </PDBo:has_pdbx_struct_group_components>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_group_listCategory/VRPTx:pdbx_struct_group_list">
      <xsl:variable name="struct_group_id_truncated"><xsl:choose><xsl:when test="string-length(@struct_group_id)&lt;64"><xsl:value-of select="@struct_group_id"/></xsl:when><xsl:when test="contains(@struct_group_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@struct_group_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@struct_group_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="struct_group_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($struct_group_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_group_list>
      <PDBo:pdbx_struct_group_list rdf:about="{$base}/pdbx_struct_group_list/{$struct_group_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_group_list>
      </PDBo:has_pdbx_struct_group_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_infoCategory/VRPTx:pdbx_struct_info">
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="value_truncated"><xsl:choose><xsl:when test="string-length(@value)&lt;64"><xsl:value-of select="@value"/></xsl:when><xsl:when test="contains(@value,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@value,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@value,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="value_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($value_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_info>
      <PDBo:pdbx_struct_info rdf:about="{$base}/pdbx_struct_info/{$type_encoded},{$value_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_info>
      </PDBo:has_pdbx_struct_info>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_legacy_oper_listCategory/VRPTx:pdbx_struct_legacy_oper_list">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_legacy_oper_list>
      <PDBo:pdbx_struct_legacy_oper_list rdf:about="{$base}/pdbx_struct_legacy_oper_list/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_legacy_oper_list>
      </PDBo:has_pdbx_struct_legacy_oper_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_mod_residueCategory/VRPTx:pdbx_struct_mod_residue">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_mod_residue>
      <PDBo:pdbx_struct_mod_residue rdf:about="{$base}/pdbx_struct_mod_residue/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_mod_residue>
      </PDBo:has_pdbx_struct_mod_residue>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_msym_genCategory/VRPTx:pdbx_struct_msym_gen">
      <xsl:variable name="entity_inst_id_truncated"><xsl:choose><xsl:when test="string-length(@entity_inst_id)&lt;64"><xsl:value-of select="@entity_inst_id"/></xsl:when><xsl:when test="contains(@entity_inst_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entity_inst_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entity_inst_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entity_inst_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entity_inst_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="msym_id_truncated"><xsl:choose><xsl:when test="string-length(@msym_id)&lt;64"><xsl:value-of select="@msym_id"/></xsl:when><xsl:when test="contains(@msym_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@msym_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@msym_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="msym_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($msym_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="oper_expression_truncated"><xsl:choose><xsl:when test="string-length(@oper_expression)&lt;64"><xsl:value-of select="@oper_expression"/></xsl:when><xsl:when test="contains(@oper_expression,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@oper_expression,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@oper_expression,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="oper_expression_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($oper_expression_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_msym_gen>
      <PDBo:pdbx_struct_msym_gen rdf:about="{$base}/pdbx_struct_msym_gen/{$entity_inst_id_encoded},{$msym_id_encoded},{$oper_expression_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_inst_id!=''">
	<PDBo:reference_to_pdbx_struct_entity_inst>
	  <rdf:Description rdf:about="{$base}/pdbx_struct_entity_inst/">
	    <PDBo:referenced_by_pdbx_struct_msym_gen rdf:resource="{$base}/pdbx_struct_msym_gen/{$entity_inst_id_encoded},{$msym_id_encoded},{$oper_expression_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_struct_entity_inst>
	<!-- pdbx_struct_entity_instKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_msym_gen>
      </PDBo:has_pdbx_struct_msym_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_nmr_ens_clustCategory/VRPTx:pdbx_struct_nmr_ens_clust">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_nmr_ens_clust>
      <PDBo:pdbx_struct_nmr_ens_clust rdf:about="{$base}/pdbx_struct_nmr_ens_clust/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_pdbx_struct_nmr_ens_clust rdf:resource="{$base}/pdbx_struct_nmr_ens_clust/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_31_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_nmr_ens_clust>
      </PDBo:has_pdbx_struct_nmr_ens_clust>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_nmr_ens_clust_genCategory/VRPTx:pdbx_struct_nmr_ens_clust_gen">
      <xsl:variable name="PDB_model_num_truncated"><xsl:choose><xsl:when test="string-length(@PDB_model_num)&lt;64"><xsl:value-of select="@PDB_model_num"/></xsl:when><xsl:when test="contains(@PDB_model_num,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@PDB_model_num,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@PDB_model_num,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="PDB_model_num_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($PDB_model_num_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_nmr_ens_clust_gen>
      <PDBo:pdbx_struct_nmr_ens_clust_gen rdf:about="{$base}/pdbx_struct_nmr_ens_clust_gen/{$PDB_model_num_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_nmr_ens_clust_gen>
      </PDBo:has_pdbx_struct_nmr_ens_clust_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_nmr_ens_domCategory/VRPTx:pdbx_struct_nmr_ens_dom">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_nmr_ens_dom>
      <PDBo:pdbx_struct_nmr_ens_dom rdf:about="{$base}/pdbx_struct_nmr_ens_dom/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_nmr_ens_dom>
      </PDBo:has_pdbx_struct_nmr_ens_dom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_nmr_ens_dom_limCategory/VRPTx:pdbx_struct_nmr_ens_dom_lim">
      <xsl:variable name="component_id_truncated"><xsl:choose><xsl:when test="string-length(@component_id)&lt;64"><xsl:value-of select="@component_id"/></xsl:when><xsl:when test="contains(@component_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@component_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@component_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="component_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($component_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="dom_id_truncated"><xsl:choose><xsl:when test="string-length(@dom_id)&lt;64"><xsl:value-of select="@dom_id"/></xsl:when><xsl:when test="contains(@dom_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@dom_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@dom_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="dom_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($dom_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_nmr_ens_dom_lim>
      <PDBo:pdbx_struct_nmr_ens_dom_lim rdf:about="{$base}/pdbx_struct_nmr_ens_dom_lim/{$component_id_encoded},{$dom_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@dom_id!=''">
	<PDBo:reference_to_pdbx_struct_nmr_ens_dom>
	  <rdf:Description rdf:about="{$base}/pdbx_struct_nmr_ens_dom/">
	    <PDBo:referenced_by_pdbx_struct_nmr_ens_dom_lim rdf:resource="{$base}/pdbx_struct_nmr_ens_dom_lim/{$component_id_encoded},{$dom_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_struct_nmr_ens_dom>
	<!-- pdbx_struct_nmr_ens_domKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_nmr_ens_dom_lim>
      </PDBo:has_pdbx_struct_nmr_ens_dom_lim>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_oper_listCategory/VRPTx:pdbx_struct_oper_list">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_oper_list>
      <PDBo:pdbx_struct_oper_list rdf:about="{$base}/pdbx_struct_oper_list/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_oper_list>
      </PDBo:has_pdbx_struct_oper_list>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_ref_seq_deletionCategory/VRPTx:pdbx_struct_ref_seq_deletion">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_ref_seq_deletion>
      <PDBo:pdbx_struct_ref_seq_deletion rdf:about="{$base}/pdbx_struct_ref_seq_deletion/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ref_seq_deletion>
      </PDBo:has_pdbx_struct_ref_seq_deletion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_ref_seq_insertionCategory/VRPTx:pdbx_struct_ref_seq_insertion">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_ref_seq_insertion>
      <PDBo:pdbx_struct_ref_seq_insertion rdf:about="{$base}/pdbx_struct_ref_seq_insertion/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ref_seq_insertion>
      </PDBo:has_pdbx_struct_ref_seq_insertion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_sheet_hbondCategory/VRPTx:pdbx_struct_sheet_hbond">
      <xsl:variable name="range_id_1_truncated"><xsl:choose><xsl:when test="string-length(@range_id_1)&lt;64"><xsl:value-of select="@range_id_1"/></xsl:when><xsl:when test="contains(@range_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@range_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@range_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="range_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($range_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="range_id_2_truncated"><xsl:choose><xsl:when test="string-length(@range_id_2)&lt;64"><xsl:value-of select="@range_id_2"/></xsl:when><xsl:when test="contains(@range_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@range_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@range_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="range_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($range_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="sheet_id_truncated"><xsl:choose><xsl:when test="string-length(@sheet_id)&lt;64"><xsl:value-of select="@sheet_id"/></xsl:when><xsl:when test="contains(@sheet_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@sheet_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@sheet_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="sheet_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($sheet_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_sheet_hbond>
      <PDBo:pdbx_struct_sheet_hbond rdf:about="{$base}/pdbx_struct_sheet_hbond/{$range_id_1_encoded},{$range_id_2_encoded},{$sheet_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
	<PDBo:reference_to_struct_sheet>
	  <rdf:Description rdf:about="{$base}/struct_sheet/">
	    <PDBo:referenced_by_pdbx_struct_sheet_hbond rdf:resource="{$base}/pdbx_struct_sheet_hbond/{$range_id_1_encoded},{$range_id_2_encoded},{$sheet_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_sheet>
	<!-- struct_sheetKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_sheet_hbond>
      </PDBo:has_pdbx_struct_sheet_hbond>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_struct_special_symmetryCategory/VRPTx:pdbx_struct_special_symmetry">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_struct_special_symmetry>
      <PDBo:pdbx_struct_special_symmetry rdf:about="{$base}/pdbx_struct_special_symmetry/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_special_symmetry>
      </PDBo:has_pdbx_struct_special_symmetry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_unobs_or_zero_occ_atomsCategory/VRPTx:pdbx_unobs_or_zero_occ_atoms">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_unobs_or_zero_occ_atoms>
      <PDBo:pdbx_unobs_or_zero_occ_atoms rdf:about="{$base}/pdbx_unobs_or_zero_occ_atoms/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_unobs_or_zero_occ_atoms>
      </PDBo:has_pdbx_unobs_or_zero_occ_atoms>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_unobs_or_zero_occ_residuesCategory/VRPTx:pdbx_unobs_or_zero_occ_residues">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_unobs_or_zero_occ_residues>
      <PDBo:pdbx_unobs_or_zero_occ_residues rdf:about="{$base}/pdbx_unobs_or_zero_occ_residues/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_unobs_or_zero_occ_residues>
      </PDBo:has_pdbx_unobs_or_zero_occ_residues>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_chiralCategory/VRPTx:pdbx_validate_chiral">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_chiral>
      <PDBo:pdbx_validate_chiral rdf:about="{$base}/pdbx_validate_chiral/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_chiral>
      </PDBo:has_pdbx_validate_chiral>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_close_contactCategory/VRPTx:pdbx_validate_close_contact">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_close_contact>
      <PDBo:pdbx_validate_close_contact rdf:about="{$base}/pdbx_validate_close_contact/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_close_contact>
      </PDBo:has_pdbx_validate_close_contact>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_main_chain_planeCategory/VRPTx:pdbx_validate_main_chain_plane">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_main_chain_plane>
      <PDBo:pdbx_validate_main_chain_plane rdf:about="{$base}/pdbx_validate_main_chain_plane/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_main_chain_plane>
      </PDBo:has_pdbx_validate_main_chain_plane>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_nmr_chem_shiftCategory/VRPTx:pdbx_validate_nmr_chem_shift">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="list_id_truncated"><xsl:choose><xsl:when test="string-length(@list_id)&lt;64"><xsl:value-of select="@list_id"/></xsl:when><xsl:when test="contains(@list_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@list_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@list_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="list_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($list_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_nmr_chem_shift>
      <PDBo:pdbx_validate_nmr_chem_shift rdf:about="{$base}/pdbx_validate_nmr_chem_shift/{$id_encoded},{$list_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@list_id!=''">
	<PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	  <rdf:Description rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/">
	    <PDBo:referenced_by_pdbx_validate_nmr_chem_shift rdf:resource="{$base}/pdbx_validate_nmr_chem_shift/{$id_encoded},{$list_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_nmr_assigned_chem_shift_list>
	<!-- pdbx_nmr_assigned_chem_shift_listKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_nmr_chem_shift>
      </PDBo:has_pdbx_validate_nmr_chem_shift>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_peptide_omegaCategory/VRPTx:pdbx_validate_peptide_omega">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_peptide_omega>
      <PDBo:pdbx_validate_peptide_omega rdf:about="{$base}/pdbx_validate_peptide_omega/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_peptide_omega>
      </PDBo:has_pdbx_validate_peptide_omega>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_planesCategory/VRPTx:pdbx_validate_planes">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_planes>
      <PDBo:pdbx_validate_planes rdf:about="{$base}/pdbx_validate_planes/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_planes>
      </PDBo:has_pdbx_validate_planes>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_planes_atomCategory/VRPTx:pdbx_validate_planes_atom">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_planes_atom>
      <PDBo:pdbx_validate_planes_atom rdf:about="{$base}/pdbx_validate_planes_atom/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:plane_id!=''">
	<PDBo:reference_to_pdbx_validate_planes>
	  <rdf:Description rdf:about="{$base}/pdbx_validate_planes/{translate(VRPTx:plane_id,' ^','__')}">
	    <PDBo:referenced_by_pdbx_validate_planes_atom rdf:resource="{$base}/pdbx_validate_planes_atom/{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_validate_planes>
	<!-- pdbx_validate_planesKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_planes_atom>
      </PDBo:has_pdbx_validate_planes_atom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_polymer_linkageCategory/VRPTx:pdbx_validate_polymer_linkage">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_polymer_linkage>
      <PDBo:pdbx_validate_polymer_linkage rdf:about="{$base}/pdbx_validate_polymer_linkage/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_polymer_linkage>
      </PDBo:has_pdbx_validate_polymer_linkage>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_angleCategory/VRPTx:pdbx_validate_rmsd_angle">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_rmsd_angle>
      <PDBo:pdbx_validate_rmsd_angle rdf:about="{$base}/pdbx_validate_rmsd_angle/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_rmsd_angle>
      </PDBo:has_pdbx_validate_rmsd_angle>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_bondCategory/VRPTx:pdbx_validate_rmsd_bond">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_rmsd_bond>
      <PDBo:pdbx_validate_rmsd_bond rdf:about="{$base}/pdbx_validate_rmsd_bond/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_rmsd_bond>
      </PDBo:has_pdbx_validate_rmsd_bond>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_ringCategory/VRPTx:pdbx_validate_rmsd_ring">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_rmsd_ring>
      <PDBo:pdbx_validate_rmsd_ring rdf:about="{$base}/pdbx_validate_rmsd_ring/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_rmsd_ring>
      </PDBo:has_pdbx_validate_rmsd_ring>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_rings_atomCategory/VRPTx:pdbx_validate_rmsd_rings_atom">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="ring_id_truncated"><xsl:choose><xsl:when test="string-length(@ring_id)&lt;64"><xsl:value-of select="@ring_id"/></xsl:when><xsl:when test="contains(@ring_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ring_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ring_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ring_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ring_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_rmsd_rings_atom>
      <PDBo:pdbx_validate_rmsd_rings_atom rdf:about="{$base}/pdbx_validate_rmsd_rings_atom/{$id_encoded},{$ring_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@ring_id!=''">
	<PDBo:reference_to_pdbx_validate_rmsd_ring>
	  <rdf:Description rdf:about="{$base}/pdbx_validate_rmsd_ring/">
	    <PDBo:referenced_by_pdbx_validate_rmsd_rings_atom rdf:resource="{$base}/pdbx_validate_rmsd_rings_atom/{$id_encoded},{$ring_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_validate_rmsd_ring>
	<!-- pdbx_validate_rmsd_ringKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_rmsd_rings_atom>
      </PDBo:has_pdbx_validate_rmsd_rings_atom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_torsionCategory/VRPTx:pdbx_validate_rmsd_torsion">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_rmsd_torsion>
      <PDBo:pdbx_validate_rmsd_torsion rdf:about="{$base}/pdbx_validate_rmsd_torsion/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_rmsd_torsion>
      </PDBo:has_pdbx_validate_rmsd_torsion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_rmsd_torsions_atomCategory/VRPTx:pdbx_validate_rmsd_torsions_atom">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="torsion_id_truncated"><xsl:choose><xsl:when test="string-length(@torsion_id)&lt;64"><xsl:value-of select="@torsion_id"/></xsl:when><xsl:when test="contains(@torsion_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@torsion_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@torsion_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="torsion_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($torsion_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_rmsd_torsions_atom>
      <PDBo:pdbx_validate_rmsd_torsions_atom rdf:about="{$base}/pdbx_validate_rmsd_torsions_atom/{$id_encoded},{$torsion_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@torsion_id!=''">
	<PDBo:reference_to_pdbx_validate_rmsd_torsion>
	  <rdf:Description rdf:about="{$base}/pdbx_validate_rmsd_torsion/">
	    <PDBo:referenced_by_pdbx_validate_rmsd_torsions_atom rdf:resource="{$base}/pdbx_validate_rmsd_torsions_atom/{$id_encoded},{$torsion_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_pdbx_validate_rmsd_torsion>
	<!-- pdbx_validate_rmsd_torsionKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_rmsd_torsions_atom>
      </PDBo:has_pdbx_validate_rmsd_torsions_atom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_symm_contactCategory/VRPTx:pdbx_validate_symm_contact">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_symm_contact>
      <PDBo:pdbx_validate_symm_contact rdf:about="{$base}/pdbx_validate_symm_contact/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_symm_contact>
      </PDBo:has_pdbx_validate_symm_contact>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validate_torsionCategory/VRPTx:pdbx_validate_torsion">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validate_torsion>
      <PDBo:pdbx_validate_torsion rdf:about="{$base}/pdbx_validate_torsion/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_torsion>
      </PDBo:has_pdbx_validate_torsion>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:pdbx_validation_softwareCategory/VRPTx:pdbx_validation_software">
      <xsl:variable name="ordinal_truncated"><xsl:choose><xsl:when test="string-length(@ordinal)&lt;64"><xsl:value-of select="@ordinal"/></xsl:when><xsl:when test="contains(@ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_pdbx_validation_software>
      <PDBo:pdbx_validation_software rdf:about="{$base}/pdbx_validation_software/{$ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validation_software>
      </PDBo:has_pdbx_validation_software>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasingCategory/VRPTx:phasing">
      <xsl:variable name="method_truncated"><xsl:choose><xsl:when test="string-length(@method)&lt;64"><xsl:value-of select="@method"/></xsl:when><xsl:when test="contains(@method,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@method,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@method,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="method_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($method_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing>
      <PDBo:phasing rdf:about="{$base}/phasing/{$method_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing>
      </PDBo:has_phasing>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MADCategory/VRPTx:phasing_MAD">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MAD>
      <PDBo:phasing_MAD rdf:about="{$base}/phasing_MAD/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_phasing_MAD rdf:resource="{$base}/phasing_MAD/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_32_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MAD>
      </PDBo:has_phasing_MAD>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MAD_clustCategory/VRPTx:phasing_MAD_clust">
      <xsl:variable name="expt_id_truncated"><xsl:choose><xsl:when test="string-length(@expt_id)&lt;64"><xsl:value-of select="@expt_id"/></xsl:when><xsl:when test="contains(@expt_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@expt_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@expt_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="expt_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($expt_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MAD_clust>
      <PDBo:phasing_MAD_clust rdf:about="{$base}/phasing_MAD_clust/{$expt_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
	<PDBo:reference_to_phasing_MAD_expt>
	  <rdf:Description rdf:about="{$base}/phasing_MAD_expt/">
	    <PDBo:referenced_by_phasing_MAD_clust rdf:resource="{$base}/phasing_MAD_clust/{$expt_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_MAD_expt>
	<!-- phasing_MAD_exptKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MAD_clust>
      </PDBo:has_phasing_MAD_clust>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MAD_exptCategory/VRPTx:phasing_MAD_expt">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MAD_expt>
      <PDBo:phasing_MAD_expt rdf:about="{$base}/phasing_MAD_expt/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MAD_expt>
      </PDBo:has_phasing_MAD_expt>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MAD_ratioCategory/VRPTx:phasing_MAD_ratio">
      <xsl:variable name="clust_id_truncated"><xsl:choose><xsl:when test="string-length(@clust_id)&lt;64"><xsl:value-of select="@clust_id"/></xsl:when><xsl:when test="contains(@clust_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@clust_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@clust_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="clust_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($clust_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="expt_id_truncated"><xsl:choose><xsl:when test="string-length(@expt_id)&lt;64"><xsl:value-of select="@expt_id"/></xsl:when><xsl:when test="contains(@expt_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@expt_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@expt_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="expt_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($expt_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="wavelength_1_truncated"><xsl:choose><xsl:when test="string-length(@wavelength_1)&lt;64"><xsl:value-of select="@wavelength_1"/></xsl:when><xsl:when test="contains(@wavelength_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@wavelength_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@wavelength_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="wavelength_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($wavelength_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="wavelength_2_truncated"><xsl:choose><xsl:when test="string-length(@wavelength_2)&lt;64"><xsl:value-of select="@wavelength_2"/></xsl:when><xsl:when test="contains(@wavelength_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@wavelength_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@wavelength_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="wavelength_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($wavelength_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MAD_ratio>
      <PDBo:phasing_MAD_ratio rdf:about="{$base}/phasing_MAD_ratio/{$clust_id_encoded},{$expt_id_encoded},{$wavelength_1_encoded},{$wavelength_2_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
	<PDBo:reference_to_phasing_MAD_expt>
	  <rdf:Description rdf:about="{$base}/phasing_MAD_expt/">
	    <PDBo:referenced_by_phasing_MAD_ratio rdf:resource="{$base}/phasing_MAD_ratio/{$clust_id_encoded},{$expt_id_encoded},{$wavelength_1_encoded},{$wavelength_2_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_MAD_expt>
	<!-- phasing_MAD_exptKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MAD_ratio>
      </PDBo:has_phasing_MAD_ratio>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MAD_setCategory/VRPTx:phasing_MAD_set">
      <xsl:variable name="clust_id_truncated"><xsl:choose><xsl:when test="string-length(@clust_id)&lt;64"><xsl:value-of select="@clust_id"/></xsl:when><xsl:when test="contains(@clust_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@clust_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@clust_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="clust_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($clust_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="expt_id_truncated"><xsl:choose><xsl:when test="string-length(@expt_id)&lt;64"><xsl:value-of select="@expt_id"/></xsl:when><xsl:when test="contains(@expt_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@expt_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@expt_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="expt_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($expt_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="set_id_truncated"><xsl:choose><xsl:when test="string-length(@set_id)&lt;64"><xsl:value-of select="@set_id"/></xsl:when><xsl:when test="contains(@set_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@set_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@set_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="set_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($set_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="wavelength_truncated"><xsl:choose><xsl:when test="string-length(@wavelength)&lt;64"><xsl:value-of select="@wavelength"/></xsl:when><xsl:when test="contains(@wavelength,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@wavelength,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@wavelength,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="wavelength_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($wavelength_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MAD_set>
      <PDBo:phasing_MAD_set rdf:about="{$base}/phasing_MAD_set/{$clust_id_encoded},{$expt_id_encoded},{$set_id_encoded},{$wavelength_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
	<PDBo:reference_to_phasing_MAD_expt>
	  <rdf:Description rdf:about="{$base}/phasing_MAD_expt/">
	    <PDBo:referenced_by_phasing_MAD_set rdf:resource="{$base}/phasing_MAD_set/{$clust_id_encoded},{$expt_id_encoded},{$set_id_encoded},{$wavelength_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_MAD_expt>
	<!-- phasing_MAD_exptKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:if test="@set_id!=''">
	<PDBo:reference_to_phasing_set>
	  <rdf:Description rdf:about="{$base}/phasing_set/">
	    <PDBo:referenced_by_phasing_MAD_set rdf:resource="{$base}/phasing_MAD_set/{$clust_id_encoded},{$expt_id_encoded},{$set_id_encoded},{$wavelength_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_set>
	<!-- phasing_setKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MAD_set>
      </PDBo:has_phasing_MAD_set>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIRCategory/VRPTx:phasing_MIR">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MIR>
      <PDBo:phasing_MIR rdf:about="{$base}/phasing_MIR/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_phasing_MIR rdf:resource="{$base}/phasing_MIR/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_33_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MIR>
      </PDBo:has_phasing_MIR>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_derCategory/VRPTx:phasing_MIR_der">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MIR_der>
      <PDBo:phasing_MIR_der rdf:about="{$base}/phasing_MIR_der/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:der_set_id!=''">
	<PDBo:reference_to_phasing_set>
	  <rdf:Description rdf:about="{$base}/phasing_set/{translate(VRPTx:der_set_id,' ^','__')}">
	    <PDBo:referenced_by_phasing_MIR_der rdf:resource="{$base}/phasing_MIR_der/{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_set>
	<!-- phasing_setKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MIR_der>
      </PDBo:has_phasing_MIR_der>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_der_reflnCategory/VRPTx:phasing_MIR_der_refln">
      <xsl:variable name="der_id_truncated"><xsl:choose><xsl:when test="string-length(@der_id)&lt;64"><xsl:value-of select="@der_id"/></xsl:when><xsl:when test="contains(@der_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@der_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@der_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="der_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($der_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_h_truncated"><xsl:choose><xsl:when test="string-length(@index_h)&lt;64"><xsl:value-of select="@index_h"/></xsl:when><xsl:when test="contains(@index_h,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_h,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_h,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_h_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_h_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_k_truncated"><xsl:choose><xsl:when test="string-length(@index_k)&lt;64"><xsl:value-of select="@index_k"/></xsl:when><xsl:when test="contains(@index_k,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_k,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_k,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_k_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_k_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_l_truncated"><xsl:choose><xsl:when test="string-length(@index_l)&lt;64"><xsl:value-of select="@index_l"/></xsl:when><xsl:when test="contains(@index_l,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_l,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_l,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_l_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_l_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="set_id_truncated"><xsl:choose><xsl:when test="string-length(@set_id)&lt;64"><xsl:value-of select="@set_id"/></xsl:when><xsl:when test="contains(@set_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@set_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@set_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="set_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($set_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MIR_der_refln>
      <PDBo:phasing_MIR_der_refln rdf:about="{$base}/phasing_MIR_der_refln/{$der_id_encoded},{$index_h_encoded},{$index_k_encoded},{$index_l_encoded},{$set_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
	<PDBo:reference_to_phasing_MIR_der>
	  <rdf:Description rdf:about="{$base}/phasing_MIR_der/">
	    <PDBo:referenced_by_phasing_MIR_der_refln rdf:resource="{$base}/phasing_MIR_der_refln/{$der_id_encoded},{$index_h_encoded},{$index_k_encoded},{$index_l_encoded},{$set_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_MIR_der>
	<!-- phasing_MIR_derKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@set_id!=''">
	<PDBo:reference_to_phasing_set>
	  <rdf:Description rdf:about="{$base}/phasing_set/">
	    <PDBo:referenced_by_phasing_MIR_der_refln rdf:resource="{$base}/phasing_MIR_der_refln/{$der_id_encoded},{$index_h_encoded},{$index_k_encoded},{$index_l_encoded},{$set_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_set>
	<!-- phasing_setKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MIR_der_refln>
      </PDBo:has_phasing_MIR_der_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_der_shellCategory/VRPTx:phasing_MIR_der_shell">
      <xsl:variable name="d_res_high_truncated"><xsl:choose><xsl:when test="string-length(@d_res_high)&lt;64"><xsl:value-of select="@d_res_high"/></xsl:when><xsl:when test="contains(@d_res_high,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_high,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_high,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_high_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_high_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="d_res_low_truncated"><xsl:choose><xsl:when test="string-length(@d_res_low)&lt;64"><xsl:value-of select="@d_res_low"/></xsl:when><xsl:when test="contains(@d_res_low,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_low,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_low,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_low_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_low_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="der_id_truncated"><xsl:choose><xsl:when test="string-length(@der_id)&lt;64"><xsl:value-of select="@der_id"/></xsl:when><xsl:when test="contains(@der_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@der_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@der_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="der_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($der_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MIR_der_shell>
      <PDBo:phasing_MIR_der_shell rdf:about="{$base}/phasing_MIR_der_shell/{$d_res_high_encoded},{$d_res_low_encoded},{$der_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
	<PDBo:reference_to_phasing_MIR_der>
	  <rdf:Description rdf:about="{$base}/phasing_MIR_der/">
	    <PDBo:referenced_by_phasing_MIR_der_shell rdf:resource="{$base}/phasing_MIR_der_shell/{$d_res_high_encoded},{$d_res_low_encoded},{$der_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_MIR_der>
	<!-- phasing_MIR_derKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MIR_der_shell>
      </PDBo:has_phasing_MIR_der_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_der_siteCategory/VRPTx:phasing_MIR_der_site">
      <xsl:variable name="der_id_truncated"><xsl:choose><xsl:when test="string-length(@der_id)&lt;64"><xsl:value-of select="@der_id"/></xsl:when><xsl:when test="contains(@der_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@der_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@der_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="der_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($der_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MIR_der_site>
      <PDBo:phasing_MIR_der_site rdf:about="{$base}/phasing_MIR_der_site/{$der_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
	<PDBo:reference_to_phasing_MIR_der>
	  <rdf:Description rdf:about="{$base}/phasing_MIR_der/">
	    <PDBo:referenced_by_phasing_MIR_der_site rdf:resource="{$base}/phasing_MIR_der_site/{$der_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_MIR_der>
	<!-- phasing_MIR_derKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MIR_der_site>
      </PDBo:has_phasing_MIR_der_site>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_MIR_shellCategory/VRPTx:phasing_MIR_shell">
      <xsl:variable name="d_res_high_truncated"><xsl:choose><xsl:when test="string-length(@d_res_high)&lt;64"><xsl:value-of select="@d_res_high"/></xsl:when><xsl:when test="contains(@d_res_high,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_high,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_high,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_high_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_high_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="d_res_low_truncated"><xsl:choose><xsl:when test="string-length(@d_res_low)&lt;64"><xsl:value-of select="@d_res_low"/></xsl:when><xsl:when test="contains(@d_res_low,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_low,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_low,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_low_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_low_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_MIR_shell>
      <PDBo:phasing_MIR_shell rdf:about="{$base}/phasing_MIR_shell/{$d_res_high_encoded},{$d_res_low_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MIR_shell>
      </PDBo:has_phasing_MIR_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_averagingCategory/VRPTx:phasing_averaging">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_averaging>
      <PDBo:phasing_averaging rdf:about="{$base}/phasing_averaging/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_phasing_averaging rdf:resource="{$base}/phasing_averaging/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_34_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_averaging>
      </PDBo:has_phasing_averaging>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_isomorphousCategory/VRPTx:phasing_isomorphous">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_isomorphous>
      <PDBo:phasing_isomorphous rdf:about="{$base}/phasing_isomorphous/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_phasing_isomorphous rdf:resource="{$base}/phasing_isomorphous/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_35_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_isomorphous>
      </PDBo:has_phasing_isomorphous>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_setCategory/VRPTx:phasing_set">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_set>
      <PDBo:phasing_set rdf:about="{$base}/phasing_set/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_set>
      </PDBo:has_phasing_set>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:phasing_set_reflnCategory/VRPTx:phasing_set_refln">
      <xsl:variable name="index_h_truncated"><xsl:choose><xsl:when test="string-length(@index_h)&lt;64"><xsl:value-of select="@index_h"/></xsl:when><xsl:when test="contains(@index_h,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_h,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_h,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_h_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_h_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_k_truncated"><xsl:choose><xsl:when test="string-length(@index_k)&lt;64"><xsl:value-of select="@index_k"/></xsl:when><xsl:when test="contains(@index_k,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_k,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_k,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_k_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_k_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_l_truncated"><xsl:choose><xsl:when test="string-length(@index_l)&lt;64"><xsl:value-of select="@index_l"/></xsl:when><xsl:when test="contains(@index_l,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_l,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_l,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_l_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_l_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="set_id_truncated"><xsl:choose><xsl:when test="string-length(@set_id)&lt;64"><xsl:value-of select="@set_id"/></xsl:when><xsl:when test="contains(@set_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@set_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@set_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="set_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($set_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_phasing_set_refln>
      <PDBo:phasing_set_refln rdf:about="{$base}/phasing_set_refln/{$index_h_encoded},{$index_k_encoded},{$index_l_encoded},{$set_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@set_id!=''">
	<PDBo:reference_to_phasing_set>
	  <rdf:Description rdf:about="{$base}/phasing_set/">
	    <PDBo:referenced_by_phasing_set_refln rdf:resource="{$base}/phasing_set_refln/{$index_h_encoded},{$index_k_encoded},{$index_l_encoded},{$set_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_phasing_set>
	<!-- phasing_setKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_set_refln>
      </PDBo:has_phasing_set_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refineCategory/VRPTx:refine">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine>
      <PDBo:refine rdf:about="{$base}/refine/{$entry_id_encoded},{$pdbx_refine_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_refine rdf:resource="{$base}/refine/{$entry_id_encoded},{$pdbx_refine_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_36_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine>
      </PDBo:has_refine>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_B_isoCategory/VRPTx:refine_B_iso">
      <xsl:variable name="class_truncated"><xsl:choose><xsl:when test="string-length(@class)&lt;64"><xsl:value-of select="@class"/></xsl:when><xsl:when test="contains(@class,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@class,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@class,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="class_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($class_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_B_iso>
      <PDBo:refine_B_iso rdf:about="{$base}/refine_B_iso/{$class_encoded},{$pdbx_refine_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_B_iso>
      </PDBo:has_refine_B_iso>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_analyzeCategory/VRPTx:refine_analyze">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_analyze>
      <PDBo:refine_analyze rdf:about="{$base}/refine_analyze/{$entry_id_encoded},{$pdbx_refine_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_refine_analyze rdf:resource="{$base}/refine_analyze/{$entry_id_encoded},{$pdbx_refine_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_37_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_analyze>
      </PDBo:has_refine_analyze>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_funct_minimizedCategory/VRPTx:refine_funct_minimized">
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_funct_minimized>
      <PDBo:refine_funct_minimized rdf:about="{$base}/refine_funct_minimized/{$pdbx_refine_id_encoded},{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_funct_minimized>
      </PDBo:has_refine_funct_minimized>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_histCategory/VRPTx:refine_hist">
      <xsl:variable name="cycle_id_truncated"><xsl:choose><xsl:when test="string-length(@cycle_id)&lt;64"><xsl:value-of select="@cycle_id"/></xsl:when><xsl:when test="contains(@cycle_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@cycle_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@cycle_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="cycle_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($cycle_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_hist>
      <PDBo:refine_hist rdf:about="{$base}/refine_hist/{$cycle_id_encoded},{$pdbx_refine_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_hist>
      </PDBo:has_refine_hist>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_classCategory/VRPTx:refine_ls_class">
      <xsl:variable name="code_truncated"><xsl:choose><xsl:when test="string-length(@code)&lt;64"><xsl:value-of select="@code"/></xsl:when><xsl:when test="contains(@code,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@code,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@code,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="code_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($code_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_ls_class>
      <PDBo:refine_ls_class rdf:about="{$base}/refine_ls_class/{$code_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_class>
      </PDBo:has_refine_ls_class>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_restrCategory/VRPTx:refine_ls_restr">
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_ls_restr>
      <PDBo:refine_ls_restr rdf:about="{$base}/refine_ls_restr/{$pdbx_refine_id_encoded},{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_restr>
      </PDBo:has_refine_ls_restr>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_restr_ncsCategory/VRPTx:refine_ls_restr_ncs">
      <xsl:variable name="pdbx_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_ordinal)&lt;64"><xsl:value-of select="@pdbx_ordinal"/></xsl:when><xsl:when test="contains(@pdbx_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_ls_restr_ncs>
      <PDBo:refine_ls_restr_ncs rdf:about="{$base}/refine_ls_restr_ncs/{$pdbx_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_restr_ncs>
      </PDBo:has_refine_ls_restr_ncs>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_restr_typeCategory/VRPTx:refine_ls_restr_type">
      <xsl:variable name="type_truncated"><xsl:choose><xsl:when test="string-length(@type)&lt;64"><xsl:value-of select="@type"/></xsl:when><xsl:when test="contains(@type,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@type,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@type,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="type_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($type_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_ls_restr_type>
      <PDBo:refine_ls_restr_type rdf:about="{$base}/refine_ls_restr_type/{$type_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_restr_type>
      </PDBo:has_refine_ls_restr_type>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_ls_shellCategory/VRPTx:refine_ls_shell">
      <xsl:variable name="d_res_high_truncated"><xsl:choose><xsl:when test="string-length(@d_res_high)&lt;64"><xsl:value-of select="@d_res_high"/></xsl:when><xsl:when test="contains(@d_res_high,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@d_res_high,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@d_res_high,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="d_res_high_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($d_res_high_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_ls_shell>
      <PDBo:refine_ls_shell rdf:about="{$base}/refine_ls_shell/{$d_res_high_encoded},{$pdbx_refine_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_shell>
      </PDBo:has_refine_ls_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refine_occupancyCategory/VRPTx:refine_occupancy">
      <xsl:variable name="class_truncated"><xsl:choose><xsl:when test="string-length(@class)&lt;64"><xsl:value-of select="@class"/></xsl:when><xsl:when test="contains(@class,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@class,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@class,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="class_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($class_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_refine_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_refine_id)&lt;64"><xsl:value-of select="@pdbx_refine_id"/></xsl:when><xsl:when test="contains(@pdbx_refine_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_refine_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_refine_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_refine_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_refine_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refine_occupancy>
      <PDBo:refine_occupancy rdf:about="{$base}/refine_occupancy/{$class_encoded},{$pdbx_refine_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_occupancy>
      </PDBo:has_refine_occupancy>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflnCategory/VRPTx:refln">
      <xsl:variable name="index_h_truncated"><xsl:choose><xsl:when test="string-length(@index_h)&lt;64"><xsl:value-of select="@index_h"/></xsl:when><xsl:when test="contains(@index_h,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_h,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_h,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_h_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_h_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_k_truncated"><xsl:choose><xsl:when test="string-length(@index_k)&lt;64"><xsl:value-of select="@index_k"/></xsl:when><xsl:when test="contains(@index_k,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_k,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_k,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_k_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_k_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_l_truncated"><xsl:choose><xsl:when test="string-length(@index_l)&lt;64"><xsl:value-of select="@index_l"/></xsl:when><xsl:when test="contains(@index_l,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_l,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_l,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_l_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_l_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refln>
      <PDBo:refln rdf:about="{$base}/refln/{$index_h_encoded},{$index_k_encoded},{$index_l_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refln>
      </PDBo:has_refln>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:refln_sys_absCategory/VRPTx:refln_sys_abs">
      <xsl:variable name="index_h_truncated"><xsl:choose><xsl:when test="string-length(@index_h)&lt;64"><xsl:value-of select="@index_h"/></xsl:when><xsl:when test="contains(@index_h,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_h,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_h,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_h_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_h_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_k_truncated"><xsl:choose><xsl:when test="string-length(@index_k)&lt;64"><xsl:value-of select="@index_k"/></xsl:when><xsl:when test="contains(@index_k,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_k,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_k,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_k_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_k_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="index_l_truncated"><xsl:choose><xsl:when test="string-length(@index_l)&lt;64"><xsl:value-of select="@index_l"/></xsl:when><xsl:when test="contains(@index_l,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@index_l,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@index_l,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="index_l_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($index_l_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_refln_sys_abs>
      <PDBo:refln_sys_abs rdf:about="{$base}/refln_sys_abs/{$index_h_encoded},{$index_k_encoded},{$index_l_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refln_sys_abs>
      </PDBo:has_refln_sys_abs>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflnsCategory/VRPTx:reflns">
      <xsl:variable name="pdbx_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_ordinal)&lt;64"><xsl:value-of select="@pdbx_ordinal"/></xsl:when><xsl:when test="contains(@pdbx_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_reflns>
      <PDBo:reflns rdf:about="{$base}/reflns/{$pdbx_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/{translate(VRPTx:entry_id,' ^','__')}">
	    <PDBo:referenced_by_reflns rdf:resource="{$base}/reflns/{$pdbx_ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_38_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:reflns>
      </PDBo:has_reflns>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflns_classCategory/VRPTx:reflns_class">
      <xsl:variable name="code_truncated"><xsl:choose><xsl:when test="string-length(@code)&lt;64"><xsl:value-of select="@code"/></xsl:when><xsl:when test="contains(@code,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@code,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@code,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="code_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($code_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_reflns_class>
      <PDBo:reflns_class rdf:about="{$base}/reflns_class/{$code_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:reflns_class>
      </PDBo:has_reflns_class>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflns_scaleCategory/VRPTx:reflns_scale">
      <xsl:variable name="group_code_truncated"><xsl:choose><xsl:when test="string-length(@group_code)&lt;64"><xsl:value-of select="@group_code"/></xsl:when><xsl:when test="contains(@group_code,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@group_code,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@group_code,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="group_code_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($group_code_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_reflns_scale>
      <PDBo:reflns_scale rdf:about="{$base}/reflns_scale/{$group_code_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:reflns_scale>
      </PDBo:has_reflns_scale>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:reflns_shellCategory/VRPTx:reflns_shell">
      <xsl:variable name="pdbx_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_ordinal)&lt;64"><xsl:value-of select="@pdbx_ordinal"/></xsl:when><xsl:when test="contains(@pdbx_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_reflns_shell>
      <PDBo:reflns_shell rdf:about="{$base}/reflns_shell/{$pdbx_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:reflns_shell>
      </PDBo:has_reflns_shell>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:space_groupCategory/VRPTx:space_group">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_space_group>
      <PDBo:space_group rdf:about="{$base}/space_group/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:space_group>
      </PDBo:has_space_group>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:space_group_symopCategory/VRPTx:space_group_symop">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_space_group_symop>
      <PDBo:space_group_symop rdf:about="{$base}/space_group_symop/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:space_group_symop>
      </PDBo:has_space_group_symop>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:structCategory/VRPTx:struct">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct>
      <PDBo:struct rdf:about="{$base}/struct/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_struct rdf:resource="{$base}/struct/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_39_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct>
      </PDBo:has_struct>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_asymCategory/VRPTx:struct_asym">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_asym>
      <PDBo:struct_asym rdf:about="{$base}/struct_asym/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!='' and @id!=''">
	<owl:sameAs>
      <xsl:variable name="VRPTx_entity_id_truncated"><xsl:choose><xsl:when test="string-length(VRPTx:entity_id)&lt;64"><xsl:value-of select="VRPTx:entity_id"/></xsl:when><xsl:when test="contains(VRPTx:entity_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(VRPTx:entity_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(VRPTx:entity_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="VRPTx_entity_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($VRPTx_entity_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
	  <PDBo:struct_asym rdf:about="{$base}/struct_asym/{$VRPTx_entity_id_encoded},{$id_encoded}">
	    <rdfs:label>struct_asymUnique_1</rdfs:label>
	  </PDBo:struct_asym>
	</owl:sameAs>
      </xsl:if>
      <xsl:if test="VRPTx:entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/{translate(VRPTx:entity_id,' ^','__')}">
	    <PDBo:referenced_by_struct_asym rdf:resource="{$base}/struct_asym/{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_asym>
      </PDBo:has_struct_asym>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_biolCategory/VRPTx:struct_biol">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_biol>
      <PDBo:struct_biol rdf:about="{$base}/struct_biol/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_biol>
      </PDBo:has_struct_biol>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_biol_viewCategory/VRPTx:struct_biol_view">
      <xsl:variable name="biol_id_truncated"><xsl:choose><xsl:when test="string-length(@biol_id)&lt;64"><xsl:value-of select="@biol_id"/></xsl:when><xsl:when test="contains(@biol_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@biol_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@biol_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="biol_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($biol_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_biol_view>
      <PDBo:struct_biol_view rdf:about="{$base}/struct_biol_view/{$biol_id_encoded},{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@biol_id!=''">
	<PDBo:reference_to_struct_biol>
	  <rdf:Description rdf:about="{$base}/struct_biol/">
	    <PDBo:referenced_by_struct_biol_view rdf:resource="{$base}/struct_biol_view/{$biol_id_encoded},{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_biol>
	<!-- struct_biolKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_biol_view>
      </PDBo:has_struct_biol_view>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_confCategory/VRPTx:struct_conf">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_conf>
      <PDBo:struct_conf rdf:about="{$base}/struct_conf/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:conf_type_id!=''">
	<PDBo:reference_to_struct_conf_type>
	  <rdf:Description rdf:about="{$base}/struct_conf_type/{translate(VRPTx:conf_type_id,' ^','__')}">
	    <PDBo:referenced_by_struct_conf rdf:resource="{$base}/struct_conf/{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_conf_type>
	<!-- struct_conf_typeKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_conf>
      </PDBo:has_struct_conf>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_conf_typeCategory/VRPTx:struct_conf_type">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_conf_type>
      <PDBo:struct_conf_type rdf:about="{$base}/struct_conf_type/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_conf_type>
      </PDBo:has_struct_conf_type>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_connCategory/VRPTx:struct_conn">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_conn>
      <PDBo:struct_conn rdf:about="{$base}/struct_conn/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_conn>
      </PDBo:has_struct_conn>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_conn_typeCategory/VRPTx:struct_conn_type">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_conn_type>
      <PDBo:struct_conn_type rdf:about="{$base}/struct_conn_type/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_conn_type>
      </PDBo:has_struct_conn_type>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_mon_detailsCategory/VRPTx:struct_mon_details">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_mon_details>
      <PDBo:struct_mon_details rdf:about="{$base}/struct_mon_details/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_struct_mon_details rdf:resource="{$base}/struct_mon_details/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_40_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_mon_details>
      </PDBo:has_struct_mon_details>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_mon_nuclCategory/VRPTx:struct_mon_nucl">
      <xsl:variable name="pdbx_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_id)&lt;64"><xsl:value-of select="@pdbx_id"/></xsl:when><xsl:when test="contains(@pdbx_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_mon_nucl>
      <PDBo:struct_mon_nucl rdf:about="{$base}/struct_mon_nucl/{$pdbx_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_mon_nucl>
      </PDBo:has_struct_mon_nucl>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_mon_protCategory/VRPTx:struct_mon_prot">
      <xsl:variable name="pdbx_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_id)&lt;64"><xsl:value-of select="@pdbx_id"/></xsl:when><xsl:when test="contains(@pdbx_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_mon_prot>
      <PDBo:struct_mon_prot rdf:about="{$base}/struct_mon_prot/{$pdbx_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_mon_prot>
      </PDBo:has_struct_mon_prot>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_mon_prot_cisCategory/VRPTx:struct_mon_prot_cis">
      <xsl:variable name="pdbx_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_id)&lt;64"><xsl:value-of select="@pdbx_id"/></xsl:when><xsl:when test="contains(@pdbx_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_mon_prot_cis>
      <PDBo:struct_mon_prot_cis rdf:about="{$base}/struct_mon_prot_cis/{$pdbx_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_mon_prot_cis>
      </PDBo:has_struct_mon_prot_cis>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_domCategory/VRPTx:struct_ncs_dom">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_ens_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_ens_id)&lt;64"><xsl:value-of select="@pdbx_ens_id"/></xsl:when><xsl:when test="contains(@pdbx_ens_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_ens_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_ens_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_ens_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_ens_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_ncs_dom>
      <PDBo:struct_ncs_dom rdf:about="{$base}/struct_ncs_dom/{$id_encoded},{$pdbx_ens_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@pdbx_ens_id!=''">
	<PDBo:reference_to_struct_ncs_ens>
	  <rdf:Description rdf:about="{$base}/struct_ncs_ens/">
	    <PDBo:referenced_by_struct_ncs_dom rdf:resource="{$base}/struct_ncs_dom/{$id_encoded},{$pdbx_ens_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_ncs_ens>
	<!-- struct_ncs_ensKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_dom>
      </PDBo:has_struct_ncs_dom>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_dom_limCategory/VRPTx:struct_ncs_dom_lim">
      <xsl:variable name="dom_id_truncated"><xsl:choose><xsl:when test="string-length(@dom_id)&lt;64"><xsl:value-of select="@dom_id"/></xsl:when><xsl:when test="contains(@dom_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@dom_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@dom_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="dom_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($dom_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_component_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_component_id)&lt;64"><xsl:value-of select="@pdbx_component_id"/></xsl:when><xsl:when test="contains(@pdbx_component_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_component_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_component_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_component_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_component_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="pdbx_ens_id_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_ens_id)&lt;64"><xsl:value-of select="@pdbx_ens_id"/></xsl:when><xsl:when test="contains(@pdbx_ens_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_ens_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_ens_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_ens_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_ens_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_ncs_dom_lim>
      <PDBo:struct_ncs_dom_lim rdf:about="{$base}/struct_ncs_dom_lim/{$dom_id_encoded},{$pdbx_component_id_encoded},{$pdbx_ens_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@dom_id!='' and @pdbx_ens_id!=''">
	<PDBo:reference_to_struct_ncs_dom>
	  <rdf:Description rdf:about="{$base}/struct_ncs_dom/,">
	    <PDBo:referenced_by_struct_ncs_dom_lim rdf:resource="{$base}/struct_ncs_dom_lim/{$dom_id_encoded},{$pdbx_component_id_encoded},{$pdbx_ens_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_ncs_dom>
	<!-- struct_ncs_domKeyref_1_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_dom_lim>
      </PDBo:has_struct_ncs_dom_lim>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_ensCategory/VRPTx:struct_ncs_ens">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_ncs_ens>
      <PDBo:struct_ncs_ens rdf:about="{$base}/struct_ncs_ens/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_ens>
      </PDBo:has_struct_ncs_ens>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_ens_genCategory/VRPTx:struct_ncs_ens_gen">
      <xsl:variable name="dom_id_1_truncated"><xsl:choose><xsl:when test="string-length(@dom_id_1)&lt;64"><xsl:value-of select="@dom_id_1"/></xsl:when><xsl:when test="contains(@dom_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@dom_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@dom_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="dom_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($dom_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="dom_id_2_truncated"><xsl:choose><xsl:when test="string-length(@dom_id_2)&lt;64"><xsl:value-of select="@dom_id_2"/></xsl:when><xsl:when test="contains(@dom_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@dom_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@dom_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="dom_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($dom_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="ens_id_truncated"><xsl:choose><xsl:when test="string-length(@ens_id)&lt;64"><xsl:value-of select="@ens_id"/></xsl:when><xsl:when test="contains(@ens_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@ens_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@ens_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="ens_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($ens_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="oper_id_truncated"><xsl:choose><xsl:when test="string-length(@oper_id)&lt;64"><xsl:value-of select="@oper_id"/></xsl:when><xsl:when test="contains(@oper_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@oper_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@oper_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="oper_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($oper_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_ncs_ens_gen>
      <PDBo:struct_ncs_ens_gen rdf:about="{$base}/struct_ncs_ens_gen/{$dom_id_1_encoded},{$dom_id_2_encoded},{$ens_id_encoded},{$oper_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@ens_id!=''">
	<PDBo:reference_to_struct_ncs_ens>
	  <rdf:Description rdf:about="{$base}/struct_ncs_ens/">
	    <PDBo:referenced_by_struct_ncs_ens_gen rdf:resource="{$base}/struct_ncs_ens_gen/{$dom_id_1_encoded},{$dom_id_2_encoded},{$ens_id_encoded},{$oper_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_ncs_ens>
	<!-- struct_ncs_ensKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@oper_id!=''">
	<PDBo:reference_to_struct_ncs_oper>
	  <rdf:Description rdf:about="{$base}/struct_ncs_oper/">
	    <PDBo:referenced_by_struct_ncs_ens_gen rdf:resource="{$base}/struct_ncs_ens_gen/{$dom_id_1_encoded},{$dom_id_2_encoded},{$ens_id_encoded},{$oper_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_ncs_oper>
	<!-- struct_ncs_operKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_ens_gen>
      </PDBo:has_struct_ncs_ens_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ncs_operCategory/VRPTx:struct_ncs_oper">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_ncs_oper>
      <PDBo:struct_ncs_oper rdf:about="{$base}/struct_ncs_oper/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_oper>
      </PDBo:has_struct_ncs_oper>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_refCategory/VRPTx:struct_ref">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_ref>
      <PDBo:struct_ref rdf:about="{$base}/struct_ref/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:entity_id!=''">
	<PDBo:reference_to_entity>
	  <rdf:Description rdf:about="{$base}/entity/{translate(VRPTx:entity_id,' ^','__')}">
	    <PDBo:referenced_by_struct_ref rdf:resource="{$base}/struct_ref/{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entity>
	<!-- entityKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ref>
      </PDBo:has_struct_ref>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ref_seqCategory/VRPTx:struct_ref_seq">
      <xsl:variable name="align_id_truncated"><xsl:choose><xsl:when test="string-length(@align_id)&lt;64"><xsl:value-of select="@align_id"/></xsl:when><xsl:when test="contains(@align_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@align_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@align_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="align_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($align_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_ref_seq>
      <PDBo:struct_ref_seq rdf:about="{$base}/struct_ref_seq/{$align_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:ref_id!=''">
	<PDBo:reference_to_struct_ref>
	  <rdf:Description rdf:about="{$base}/struct_ref/{translate(VRPTx:ref_id,' ^','__')}">
	    <PDBo:referenced_by_struct_ref_seq rdf:resource="{$base}/struct_ref_seq/{$align_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_ref>
	<!-- struct_refKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ref_seq>
      </PDBo:has_struct_ref_seq>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_ref_seq_difCategory/VRPTx:struct_ref_seq_dif">
      <xsl:variable name="pdbx_ordinal_truncated"><xsl:choose><xsl:when test="string-length(@pdbx_ordinal)&lt;64"><xsl:value-of select="@pdbx_ordinal"/></xsl:when><xsl:when test="contains(@pdbx_ordinal,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@pdbx_ordinal,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@pdbx_ordinal,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="pdbx_ordinal_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($pdbx_ordinal_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_ref_seq_dif>
      <PDBo:struct_ref_seq_dif rdf:about="{$base}/struct_ref_seq_dif/{$pdbx_ordinal_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:align_id!=''">
	<PDBo:reference_to_struct_ref_seq>
	  <rdf:Description rdf:about="{$base}/struct_ref_seq/{translate(VRPTx:align_id,' ^','__')}">
	    <PDBo:referenced_by_struct_ref_seq_dif rdf:resource="{$base}/struct_ref_seq_dif/{$pdbx_ordinal_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_ref_seq>
	<!-- struct_ref_seqKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ref_seq_dif>
      </PDBo:has_struct_ref_seq_dif>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheetCategory/VRPTx:struct_sheet">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_sheet>
      <PDBo:struct_sheet rdf:about="{$base}/struct_sheet/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_sheet>
      </PDBo:has_struct_sheet>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheet_hbondCategory/VRPTx:struct_sheet_hbond">
      <xsl:variable name="range_id_1_truncated"><xsl:choose><xsl:when test="string-length(@range_id_1)&lt;64"><xsl:value-of select="@range_id_1"/></xsl:when><xsl:when test="contains(@range_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@range_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@range_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="range_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($range_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="range_id_2_truncated"><xsl:choose><xsl:when test="string-length(@range_id_2)&lt;64"><xsl:value-of select="@range_id_2"/></xsl:when><xsl:when test="contains(@range_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@range_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@range_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="range_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($range_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="sheet_id_truncated"><xsl:choose><xsl:when test="string-length(@sheet_id)&lt;64"><xsl:value-of select="@sheet_id"/></xsl:when><xsl:when test="contains(@sheet_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@sheet_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@sheet_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="sheet_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($sheet_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_sheet_hbond>
      <PDBo:struct_sheet_hbond rdf:about="{$base}/struct_sheet_hbond/{$range_id_1_encoded},{$range_id_2_encoded},{$sheet_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
	<PDBo:reference_to_struct_sheet>
	  <rdf:Description rdf:about="{$base}/struct_sheet/">
	    <PDBo:referenced_by_struct_sheet_hbond rdf:resource="{$base}/struct_sheet_hbond/{$range_id_1_encoded},{$range_id_2_encoded},{$sheet_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_sheet>
	<!-- struct_sheetKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_sheet_hbond>
      </PDBo:has_struct_sheet_hbond>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheet_orderCategory/VRPTx:struct_sheet_order">
      <xsl:variable name="range_id_1_truncated"><xsl:choose><xsl:when test="string-length(@range_id_1)&lt;64"><xsl:value-of select="@range_id_1"/></xsl:when><xsl:when test="contains(@range_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@range_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@range_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="range_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($range_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="range_id_2_truncated"><xsl:choose><xsl:when test="string-length(@range_id_2)&lt;64"><xsl:value-of select="@range_id_2"/></xsl:when><xsl:when test="contains(@range_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@range_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@range_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="range_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($range_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="sheet_id_truncated"><xsl:choose><xsl:when test="string-length(@sheet_id)&lt;64"><xsl:value-of select="@sheet_id"/></xsl:when><xsl:when test="contains(@sheet_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@sheet_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@sheet_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="sheet_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($sheet_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_sheet_order>
      <PDBo:struct_sheet_order rdf:about="{$base}/struct_sheet_order/{$range_id_1_encoded},{$range_id_2_encoded},{$sheet_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
	<PDBo:reference_to_struct_sheet>
	  <rdf:Description rdf:about="{$base}/struct_sheet/">
	    <PDBo:referenced_by_struct_sheet_order rdf:resource="{$base}/struct_sheet_order/{$range_id_1_encoded},{$range_id_2_encoded},{$sheet_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_sheet>
	<!-- struct_sheetKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_sheet_order>
      </PDBo:has_struct_sheet_order>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheet_rangeCategory/VRPTx:struct_sheet_range">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="sheet_id_truncated"><xsl:choose><xsl:when test="string-length(@sheet_id)&lt;64"><xsl:value-of select="@sheet_id"/></xsl:when><xsl:when test="contains(@sheet_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@sheet_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@sheet_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="sheet_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($sheet_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_sheet_range>
      <PDBo:struct_sheet_range rdf:about="{$base}/struct_sheet_range/{$id_encoded},{$sheet_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
	<PDBo:reference_to_struct_sheet>
	  <rdf:Description rdf:about="{$base}/struct_sheet/">
	    <PDBo:referenced_by_struct_sheet_range rdf:resource="{$base}/struct_sheet_range/{$id_encoded},{$sheet_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_sheet>
	<!-- struct_sheetKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_sheet_range>
      </PDBo:has_struct_sheet_range>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_sheet_topologyCategory/VRPTx:struct_sheet_topology">
      <xsl:variable name="range_id_1_truncated"><xsl:choose><xsl:when test="string-length(@range_id_1)&lt;64"><xsl:value-of select="@range_id_1"/></xsl:when><xsl:when test="contains(@range_id_1,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@range_id_1,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@range_id_1,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="range_id_1_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($range_id_1_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="range_id_2_truncated"><xsl:choose><xsl:when test="string-length(@range_id_2)&lt;64"><xsl:value-of select="@range_id_2"/></xsl:when><xsl:when test="contains(@range_id_2,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@range_id_2,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@range_id_2,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="range_id_2_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($range_id_2_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="sheet_id_truncated"><xsl:choose><xsl:when test="string-length(@sheet_id)&lt;64"><xsl:value-of select="@sheet_id"/></xsl:when><xsl:when test="contains(@sheet_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@sheet_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@sheet_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="sheet_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($sheet_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_sheet_topology>
      <PDBo:struct_sheet_topology rdf:about="{$base}/struct_sheet_topology/{$range_id_1_encoded},{$range_id_2_encoded},{$sheet_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
	<PDBo:reference_to_struct_sheet>
	  <rdf:Description rdf:about="{$base}/struct_sheet/">
	    <PDBo:referenced_by_struct_sheet_topology rdf:resource="{$base}/struct_sheet_topology/{$range_id_1_encoded},{$range_id_2_encoded},{$sheet_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_sheet>
	<!-- struct_sheetKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_sheet_topology>
      </PDBo:has_struct_sheet_topology>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_siteCategory/VRPTx:struct_site">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_site>
      <PDBo:struct_site rdf:about="{$base}/struct_site/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_site>
      </PDBo:has_struct_site>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_site_genCategory/VRPTx:struct_site_gen">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <xsl:variable name="site_id_truncated"><xsl:choose><xsl:when test="string-length(@site_id)&lt;64"><xsl:value-of select="@site_id"/></xsl:when><xsl:when test="contains(@site_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@site_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@site_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="site_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($site_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_site_gen>
      <PDBo:struct_site_gen rdf:about="{$base}/struct_site_gen/{$id_encoded},{$site_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@site_id!=''">
	<PDBo:reference_to_struct_site>
	  <rdf:Description rdf:about="{$base}/struct_site/">
	    <PDBo:referenced_by_struct_site_gen rdf:resource="{$base}/struct_site_gen/{$id_encoded},{$site_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_site>
	<!-- struct_siteKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_site_gen>
      </PDBo:has_struct_site_gen>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:struct_site_viewCategory/VRPTx:struct_site_view">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_struct_site_view>
      <PDBo:struct_site_view rdf:about="{$base}/struct_site_view/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="VRPTx:site_id!=''">
	<PDBo:reference_to_struct_site>
	  <rdf:Description rdf:about="{$base}/struct_site/{translate(VRPTx:site_id,' ^','__')}">
	    <PDBo:referenced_by_struct_site_view rdf:resource="{$base}/struct_site_view/{$id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_struct_site>
	<!-- struct_siteKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_site_view>
      </PDBo:has_struct_site_view>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:symmetryCategory/VRPTx:symmetry">
      <xsl:variable name="entry_id_truncated"><xsl:choose><xsl:when test="string-length(@entry_id)&lt;64"><xsl:value-of select="@entry_id"/></xsl:when><xsl:when test="contains(@entry_id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@entry_id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@entry_id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="entry_id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($entry_id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_symmetry>
      <PDBo:symmetry rdf:about="{$base}/symmetry/{$entry_id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
	<PDBo:reference_to_entry>
	  <rdf:Description rdf:about="{$base}/entry/">
	    <PDBo:referenced_by_symmetry rdf:resource="{$base}/symmetry/{$entry_id_encoded}"/>
	  </rdf:Description>
	</PDBo:reference_to_entry>
	<!-- entryKeyref_0_0_41_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:symmetry>
      </PDBo:has_symmetry>
  </xsl:template>

  <xsl:template match="VRPTx:datablock/VRPTx:symmetry_equivCategory/VRPTx:symmetry_equiv">
      <xsl:variable name="id_truncated"><xsl:choose><xsl:when test="string-length(@id)&lt;64"><xsl:value-of select="@id"/></xsl:when><xsl:when test="contains(@id,',')"><xsl:call-template name="substring-before-last"><xsl:with-param name="str" select="substring(@id,1,64)"/><xsl:with-param name="substr">,</xsl:with-param></xsl:call-template></xsl:when><xsl:otherwise><xsl:value-of select="substring(@id,1,64)"/></xsl:otherwise></xsl:choose></xsl:variable>
      <xsl:variable name="id_encoded"><xsl:call-template name="url-encode"><xsl:with-param name="str" select="translate(normalize-space($id_truncated),' ^','__')"/></xsl:call-template></xsl:variable>
      <PDBo:has_symmetry_equiv>
      <PDBo:symmetry_equiv rdf:about="{$base}/symmetry_equiv/{$id_encoded}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:symmetry_equiv>
      </PDBo:has_symmetry_equiv>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>
  <xsl:template match="*|text()|@*" mode="linked"/>

</xsl:stylesheet>