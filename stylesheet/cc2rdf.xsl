<?xml version="1.0" encoding="UTF-8"?><xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
  xmlns:PDBo="https://rdf.wwpdb.org/schema/pdbx-v50.owl#"
  xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
  xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
  xmlns:owl="http://www.w3.org/2002/07/owl#"
  xmlns:dc="http://purl.org/dc/elements/1.1/"
  xmlns:dcterms="http://purl.org/dc/terms/"
  xmlns:skos="http://www.w3.org/2004/02/skos/core#"
  xmlns:ext="http://exslt.org/common" exclude-result-prefixes="ext">

  <xsl:output method="xml" indent="yes"/>
  <xsl:strip-space elements="*"/>
  <xsl:variable name="PDBID"><xsl:value-of select="/PDBx:datablock/@datablockName"/></xsl:variable>
  <xsl:variable name="pdbid"><xsl:value-of select="translate($PDBID,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/></xsl:variable>
  <xsl:variable name="base">https://rdf.wwpdb.org/cc/<xsl:value-of select="$PDBID"/></xsl:variable>
  <xsl:variable name="base_lower">https://rdf.wwpdb.org/cc/<xsl:value-of select="$pdbid"/></xsl:variable>
  <xsl:variable name="pdb_link">https://rdf.wwpdb.org/pdb/</xsl:variable>
  <xsl:variable name="chem_comp">https://rdf.wwpdb.org/cc/</xsl:variable>
  <xsl:variable name="pdbj">https://pdbj.org/chemie/summary/</xsl:variable>
  <xsl:variable name="rcsb">https://www3.rcsb.org/ligand/</xsl:variable>
  <xsl:variable name="pdbe">https://www.ebi.ac.uk/pdbe-srv/pdbechem/chemicalCompound/show/</xsl:variable>

  <xsl:variable name="idorg">http://identifiers.org/</xsl:variable>
  <xsl:variable name="doi">https://doi.org/</xsl:variable>
  <xsl:variable name="pubmed">https://www.ncbi.nlm.nih.gov/pubmed/</xsl:variable>
  <xsl:variable name="taxonomy">http://purl.uniprot.org/taxonomy/</xsl:variable>
  <xsl:variable name="genbank">https://www.ncbi.nlm.nih.gov/nuccore/</xsl:variable>
  <xsl:variable name="uniprot">http://purl.uniprot.org/uniprot/</xsl:variable>
  <xsl:variable name="enzyme">http://purl.uniprot.org/enzyme/</xsl:variable>
  <xsl:variable name="go">http://amigo.geneontology.org/amigo/term/GO:/</xsl:variable>

  <xsl:template match="/">
    <rdf:RDF>
      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <!-- level 1 -->
  <xsl:template match="/PDBx:datablock">
    <PDBo:datablock rdf:about="{$base}">
      <dcterms:identifier><xsl:value-of select="$PDBID"/></dcterms:identifier>
      <skos:altLabel><xsl:value-of select="$pdbid"/></skos:altLabel>
      <dc:title><xsl:value-of select="PDBx:chem_compCategory/PDBx:chem_comp/PDBx:name/text()"/></dc:title>
    
      <rdfs:seeAlso rdf:resource="{$pdbj}{$PDBID}"/>
      <rdfs:seeAlso rdf:resource="{$rcsb}{$PDBID}"/>
      <rdfs:seeAlso rdf:resource="{$pdbe}{$PDBID}"/>

      <PDBo:datablockName><xsl:value-of select="@datablockName"/></PDBo:datablockName>
      <xsl:apply-templates select="./*"/>
    </PDBo:datablock>
  </xsl:template>

  <!-- level 2 -->
  <xsl:template match="/PDBx:datablock/*">
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

  <!-- level 4 (PCData) -->
  <xsl:template match="/PDBx:datablock/*/*/*[not(xsi:nil) and text()!='']">
    <xsl:element name="PDBo:{concat(local-name(parent::node()),'.',local-name())}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (attribute) -->
  <xsl:template match="/PDBx:datablock/*/*/@*">
    <xsl:element name="PDBo:{concat(local-name(parent::node()),'.',translate(name(),'@',''))}">
      <xsl:value-of select="."/>
    </xsl:element>
  </xsl:template>

  <!-- level 4 (linked data) -->
  <xsl:template match="PDBx:chem_comp/PDBx:mon_nstd_parent_comp_id[text()!='']" mode="linked">
    <PDBo:link_to_parent_chem_comp rdf:resource="{$chem_comp}{text()}"/>
  </xsl:template>

  <xsl:template match="PDBx:citation/PDBx:pdbx_database_id_DOI[text()!='']" mode="linked">
    <PDBo:link_to_doi rdf:resource="{$doi}{text()}" rdfs:label="doi:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBx:citation/PDBx:pdbx_database_id_PubMed[text()!='']" mode="linked">
    <PDBo:link_to_pubmed rdf:resource="{$pubmed}{text()}" rdfs:label="pubmed:{text()}"/>
    <dcterms:references rdf:resource="{$idorg}pubmed/{text()}" rdfs:label="pubmed:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBx:entity_src_gen/PDBx:pdbx_gene_src_ncbi_taxonomy_id[text()!='']" mode="linked">
    <PDBo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBx:entity_src_gen/PDBx:pdbx_host_org_ncbi_taxonomy_id[text()!='']" mode="linked">
    <PDBo:link_to_taxonomy_host rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBx:entity_src_nat/PDBx:pdbx_ncbi_taxonomy_id[text()!='']" mode="linked">
    <PDBo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBx:entity/PDBx:pdbx_ec[text()!='']" mode="linked">
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
          <PDBo:link_to_enzyme rdf:resource="{$enzyme}{$ec}" rdfs:label="enzyme:{$ec}"/>
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

  <xsl:template match="PDBx:struct_ref/PDBx:pdbx_db_accession[../PDBx:db_name='UNP' and text()!='']" mode="linked">
    <PDBo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBx:struct_ref/PDBx:db_code[../PDBx:db_name='GB' and text()!='']" mode="linked">
    <PDBo:link_to_genbank rdf:resource="{$genbank}{text()}" rdfs:label="genbank:{text()}"/>
    <rdfs:seeAlso rdf:resource="{$idorg}insdc/{text()}" rdfs:label="nuccore:{text()}"/>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_related[@db_name='PDB' and @content_type!='split']/@db_id" mode="linked">
    <PDBo:link_to_pdb rdf:resource="{$pdb_link}{.}"/>
  </xsl:template>

  <xsl:template match="PDBx:pdbx_database_related[@db_name='PDB' and @content_type='split']/@db_id" mode="linked">
    <PDBo:link_to_pdb_split rdf:resource="{$pdb_link}{.}"/>
  </xsl:template>

  <xsl:template match="PDBx:chem_comp/PDBx:pdbx_model_coordinates_db_code" mode="linked">
    <PDBo:link_to_pdb rdf:resource="{$pdb_link}{text()}"/>
  </xsl:template>
  <!-- level-3 templates follow -->
  <xsl:template match="PDBx:datablock/PDBx:atom_siteCategory/PDBx:atom_site">
      <PDBo:has_atom_site>
      <PDBo:atom_site rdf:about="{$base}/atom_site/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:type_symbol!=''">
        <PDBo:reference_to_atom_type>
	  <rdf:Description  rdf:about="{$base}/atom_type/{translate(PDBx:type_symbol,' ^','_')}">
	    <PDBo:referenced_by_atom_site rdf:resource="{$base}/atom_site/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_atom_type>
        <!-- atom_typeKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="PDBx:label_comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(PDBx:label_comp_id,' ^','_')}">
	    <PDBo:referenced_by_atom_site rdf:resource="{$base}/atom_site/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="PDBx:label_entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBx:label_entity_id,' ^','_')}">
	    <PDBo:referenced_by_atom_site rdf:resource="{$base}/atom_site/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="PDBx:label_entity_id!='' and PDBx:label_asym_id!=''">
        <PDBo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(PDBx:label_entity_id,' ^','_')},{translate(PDBx:label_asym_id,' ^','_')}">
	    <PDBo:referenced_by_atom_site rdf:resource="{$base}/atom_site/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_asym>
        <!-- struct_asymKeyref_0_1_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:atom_site>
      </PDBo:has_atom_site>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:atom_site_anisotropCategory/PDBx:atom_site_anisotrop">
      <PDBo:has_atom_site_anisotrop>
      <PDBo:atom_site_anisotrop rdf:about="{$base}/atom_site_anisotrop/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:type_symbol!=''">
        <PDBo:reference_to_atom_type>
	  <rdf:Description  rdf:about="{$base}/atom_type/{translate(PDBx:type_symbol,' ^','_')}">
	    <PDBo:referenced_by_atom_site_anisotrop rdf:resource="{$base}/atom_site_anisotrop/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_atom_type>
        <!-- atom_typeKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:atom_site_anisotrop>
      </PDBo:has_atom_site_anisotrop>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:atom_sitesCategory/PDBx:atom_sites">
      <PDBo:has_atom_sites>
      <PDBo:atom_sites rdf:about="{$base}/atom_sites/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_atom_sites rdf:resource="{$base}/atom_sites/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:atom_sites>
      </PDBo:has_atom_sites>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:atom_sites_altCategory/PDBx:atom_sites_alt">
      <PDBo:has_atom_sites_alt>
      <PDBo:atom_sites_alt rdf:about="{$base}/atom_sites_alt/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:atom_sites_alt>
      </PDBo:has_atom_sites_alt>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:atom_sites_alt_ensCategory/PDBx:atom_sites_alt_ens">
      <PDBo:has_atom_sites_alt_ens>
      <PDBo:atom_sites_alt_ens rdf:about="{$base}/atom_sites_alt_ens/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:atom_sites_alt_ens>
      </PDBo:has_atom_sites_alt_ens>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:atom_sites_alt_genCategory/PDBx:atom_sites_alt_gen">
      <PDBo:has_atom_sites_alt_gen>
      <PDBo:atom_sites_alt_gen rdf:about="{$base}/atom_sites_alt_gen/{translate(@alt_id,' ^','_')},{translate(@ens_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@alt_id!=''">
        <PDBo:reference_to_atom_sites_alt>
	  <rdf:Description  rdf:about="{$base}/atom_sites_alt/{translate(@alt_id,' ^','_')}">
	    <PDBo:referenced_by_atom_sites_alt_gen rdf:resource="{$base}/atom_sites_alt_gen/{translate(@alt_id,' ^','_')},{translate(@ens_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_atom_sites_alt>
        <!-- atom_sites_altKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@ens_id!=''">
        <PDBo:reference_to_atom_sites_alt_ens>
	  <rdf:Description  rdf:about="{$base}/atom_sites_alt_ens/{translate(@ens_id,' ^','_')}">
	    <PDBo:referenced_by_atom_sites_alt_gen rdf:resource="{$base}/atom_sites_alt_gen/{translate(@alt_id,' ^','_')},{translate(@ens_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_atom_sites_alt_ens>
        <!-- atom_sites_alt_ensKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:atom_sites_alt_gen>
      </PDBo:has_atom_sites_alt_gen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:atom_sites_footnoteCategory/PDBx:atom_sites_footnote">
      <PDBo:has_atom_sites_footnote>
      <PDBo:atom_sites_footnote rdf:about="{$base}/atom_sites_footnote/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:atom_sites_footnote>
      </PDBo:has_atom_sites_footnote>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:atom_typeCategory/PDBx:atom_type">
      <PDBo:has_atom_type>
      <PDBo:atom_type rdf:about="{$base}/atom_type/{translate(@symbol,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:atom_type>
      </PDBo:has_atom_type>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:auditCategory/PDBx:audit">
      <PDBo:has_audit>
      <PDBo:audit rdf:about="{$base}/audit/{translate(@revision_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:audit>
      </PDBo:has_audit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:audit_authorCategory/PDBx:audit_author">
      <PDBo:has_audit_author>
      <PDBo:audit_author rdf:about="{$base}/audit_author/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:audit_author>
      </PDBo:has_audit_author>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:audit_conformCategory/PDBx:audit_conform">
      <PDBo:has_audit_conform>
      <PDBo:audit_conform rdf:about="{$base}/audit_conform/{translate(@dict_name,' ^','_')},{translate(@dict_version,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:audit_conform>
      </PDBo:has_audit_conform>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:audit_contact_authorCategory/PDBx:audit_contact_author">
      <PDBo:has_audit_contact_author>
      <PDBo:audit_contact_author rdf:about="{$base}/audit_contact_author/{translate(@name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:audit_contact_author>
      </PDBo:has_audit_contact_author>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:audit_linkCategory/PDBx:audit_link">
      <PDBo:has_audit_link>
      <PDBo:audit_link rdf:about="{$base}/audit_link/{translate(@block_code,' ^','_')},{translate(@block_description,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:audit_link>
      </PDBo:has_audit_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:cellCategory/PDBx:cell">
      <PDBo:has_cell>
      <PDBo:cell rdf:about="{$base}/cell/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_cell rdf:resource="{$base}/cell/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:cell>
      </PDBo:has_cell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:cell_measurementCategory/PDBx:cell_measurement">
      <PDBo:has_cell_measurement>
      <PDBo:cell_measurement rdf:about="{$base}/cell_measurement/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_cell_measurement rdf:resource="{$base}/cell_measurement/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:cell_measurement>
      </PDBo:has_cell_measurement>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:cell_measurement_reflnCategory/PDBx:cell_measurement_refln">
      <PDBo:has_cell_measurement_refln>
      <PDBo:cell_measurement_refln rdf:about="{$base}/cell_measurement_refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:cell_measurement_refln>
      </PDBo:has_cell_measurement_refln>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_compCategory/PDBx:chem_comp">
      <PDBo:has_chem_comp>
      <PDBo:chem_comp rdf:about="{$base}/chem_comp/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp>
      </PDBo:has_chem_comp>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_angleCategory/PDBx:chem_comp_angle">
      <PDBo:has_chem_comp_angle>
      <PDBo:chem_comp_angle rdf:about="{$base}/chem_comp_angle/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@atom_id_3,' ^','_')},{translate(@comp_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@atom_id_1!='' and @comp_id!=''">
        <PDBo:reference_to_chem_comp_atom>
	  <rdf:Description  rdf:about="{$base}/chem_comp_atom/{translate(@atom_id_1,' ^','_')},{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_angle rdf:resource="{$base}/chem_comp_angle/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@atom_id_3,' ^','_')},{translate(@comp_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp_atom>
        <!-- chem_comp_atomKeyref_1_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_angle>
      </PDBo:has_chem_comp_angle>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_atomCategory/PDBx:chem_comp_atom">
      <PDBo:has_chem_comp_atom>
      <PDBo:chem_comp_atom rdf:about="{$base}/chem_comp_atom/{translate(@atom_id,' ^','_')},{translate(@comp_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_atom rdf:resource="{$base}/chem_comp_atom/{translate(@atom_id,' ^','_')},{translate(@comp_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_atom>
      </PDBo:has_chem_comp_atom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_bondCategory/PDBx:chem_comp_bond">
      <PDBo:has_chem_comp_bond>
      <PDBo:chem_comp_bond rdf:about="{$base}/chem_comp_bond/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@comp_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_bond rdf:resource="{$base}/chem_comp_bond/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@comp_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:if test="@atom_id_1!='' and @comp_id!=''">
        <PDBo:reference_to_chem_comp_atom>
	  <rdf:Description  rdf:about="{$base}/chem_comp_atom/{translate(@atom_id_1,' ^','_')},{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_bond rdf:resource="{$base}/chem_comp_bond/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@comp_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp_atom>
        <!-- chem_comp_atomKeyref_1_0_1_0 -->
      </xsl:if>
      <xsl:if test="@atom_id_2!='' and @comp_id!=''">
        <PDBo:reference_to_chem_comp_atom>
	  <rdf:Description  rdf:about="{$base}/chem_comp_atom/{translate(@atom_id_2,' ^','_')},{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_bond rdf:resource="{$base}/chem_comp_bond/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@comp_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp_atom>
        <!-- chem_comp_atomKeyref_1_0_1_1 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_bond>
      </PDBo:has_chem_comp_bond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_chirCategory/PDBx:chem_comp_chir">
      <PDBo:has_chem_comp_chir>
      <PDBo:chem_comp_chir rdf:about="{$base}/chem_comp_chir/{translate(@comp_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_chir rdf:resource="{$base}/chem_comp_chir/{translate(@comp_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_chir>
      </PDBo:has_chem_comp_chir>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_chir_atomCategory/PDBx:chem_comp_chir_atom">
      <PDBo:has_chem_comp_chir_atom>
      <PDBo:chem_comp_chir_atom rdf:about="{$base}/chem_comp_chir_atom/{translate(@atom_id,' ^','_')},{translate(@chir_id,' ^','_')},{translate(@comp_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_chir_atom rdf:resource="{$base}/chem_comp_chir_atom/{translate(@atom_id,' ^','_')},{translate(@chir_id,' ^','_')},{translate(@comp_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_chir_atom>
      </PDBo:has_chem_comp_chir_atom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_linkCategory/PDBx:chem_comp_link">
      <PDBo:has_chem_comp_link>
      <PDBo:chem_comp_link rdf:about="{$base}/chem_comp_link/{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@link_id!=''">
        <PDBo:reference_to_chem_link>
	  <rdf:Description  rdf:about="{$base}/chem_link/{translate(@link_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_link rdf:resource="{$base}/chem_comp_link/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_link>
        <!-- chem_linkKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_link>
      </PDBo:has_chem_comp_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_planeCategory/PDBx:chem_comp_plane">
      <PDBo:has_chem_comp_plane>
      <PDBo:chem_comp_plane rdf:about="{$base}/chem_comp_plane/{translate(@comp_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_plane rdf:resource="{$base}/chem_comp_plane/{translate(@comp_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_plane>
      </PDBo:has_chem_comp_plane>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_plane_atomCategory/PDBx:chem_comp_plane_atom">
      <PDBo:has_chem_comp_plane_atom>
      <PDBo:chem_comp_plane_atom rdf:about="{$base}/chem_comp_plane_atom/{translate(@atom_id,' ^','_')},{translate(@comp_id,' ^','_')},{translate(@plane_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_plane_atom rdf:resource="{$base}/chem_comp_plane_atom/{translate(@atom_id,' ^','_')},{translate(@comp_id,' ^','_')},{translate(@plane_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_plane_atom>
      </PDBo:has_chem_comp_plane_atom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_torCategory/PDBx:chem_comp_tor">
      <PDBo:has_chem_comp_tor>
      <PDBo:chem_comp_tor rdf:about="{$base}/chem_comp_tor/{translate(@comp_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:atom_id_1!='' and @comp_id!=''">
        <PDBo:reference_to_chem_comp_atom>
	  <rdf:Description  rdf:about="{$base}/chem_comp_atom/{translate(PDBx:atom_id_1,' ^','_')},{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_chem_comp_tor rdf:resource="{$base}/chem_comp_tor/{translate(@comp_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp_atom>
        <!-- chem_comp_atomKeyref_1_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_tor>
      </PDBo:has_chem_comp_tor>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_comp_tor_valueCategory/PDBx:chem_comp_tor_value">
      <PDBo:has_chem_comp_tor_value>
      <PDBo:chem_comp_tor_value rdf:about="{$base}/chem_comp_tor_value/{translate(@comp_id,' ^','_')},{translate(@tor_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_comp_tor_value>
      </PDBo:has_chem_comp_tor_value>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_linkCategory/PDBx:chem_link">
      <PDBo:has_chem_link>
      <PDBo:chem_link rdf:about="{$base}/chem_link/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link>
      </PDBo:has_chem_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_link_angleCategory/PDBx:chem_link_angle">
      <PDBo:has_chem_link_angle>
      <PDBo:chem_link_angle rdf:about="{$base}/chem_link_angle/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@atom_id_3,' ^','_')},{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@link_id!=''">
        <PDBo:reference_to_chem_link>
	  <rdf:Description  rdf:about="{$base}/chem_link/{translate(@link_id,' ^','_')}">
	    <PDBo:referenced_by_chem_link_angle rdf:resource="{$base}/chem_link_angle/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@atom_id_3,' ^','_')},{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_link>
        <!-- chem_linkKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link_angle>
      </PDBo:has_chem_link_angle>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_link_bondCategory/PDBx:chem_link_bond">
      <PDBo:has_chem_link_bond>
      <PDBo:chem_link_bond rdf:about="{$base}/chem_link_bond/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@link_id!=''">
        <PDBo:reference_to_chem_link>
	  <rdf:Description  rdf:about="{$base}/chem_link/{translate(@link_id,' ^','_')}">
	    <PDBo:referenced_by_chem_link_bond rdf:resource="{$base}/chem_link_bond/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_link>
        <!-- chem_linkKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link_bond>
      </PDBo:has_chem_link_bond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_link_chirCategory/PDBx:chem_link_chir">
      <PDBo:has_chem_link_chir>
      <PDBo:chem_link_chir rdf:about="{$base}/chem_link_chir/{translate(@id,' ^','_')},{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@link_id!=''">
        <PDBo:reference_to_chem_link>
	  <rdf:Description  rdf:about="{$base}/chem_link/{translate(@link_id,' ^','_')}">
	    <PDBo:referenced_by_chem_link_chir rdf:resource="{$base}/chem_link_chir/{translate(@id,' ^','_')},{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_link>
        <!-- chem_linkKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link_chir>
      </PDBo:has_chem_link_chir>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_link_chir_atomCategory/PDBx:chem_link_chir_atom">
      <PDBo:has_chem_link_chir_atom>
      <PDBo:chem_link_chir_atom rdf:about="{$base}/chem_link_chir_atom/{translate(@atom_id,' ^','_')},{translate(@chir_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link_chir_atom>
      </PDBo:has_chem_link_chir_atom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_link_planeCategory/PDBx:chem_link_plane">
      <PDBo:has_chem_link_plane>
      <PDBo:chem_link_plane rdf:about="{$base}/chem_link_plane/{translate(@id,' ^','_')},{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@link_id!=''">
        <PDBo:reference_to_chem_link>
	  <rdf:Description  rdf:about="{$base}/chem_link/{translate(@link_id,' ^','_')}">
	    <PDBo:referenced_by_chem_link_plane rdf:resource="{$base}/chem_link_plane/{translate(@id,' ^','_')},{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_link>
        <!-- chem_linkKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link_plane>
      </PDBo:has_chem_link_plane>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_link_plane_atomCategory/PDBx:chem_link_plane_atom">
      <PDBo:has_chem_link_plane_atom>
      <PDBo:chem_link_plane_atom rdf:about="{$base}/chem_link_plane_atom/{translate(@atom_id,' ^','_')},{translate(@plane_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link_plane_atom>
      </PDBo:has_chem_link_plane_atom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_link_torCategory/PDBx:chem_link_tor">
      <PDBo:has_chem_link_tor>
      <PDBo:chem_link_tor rdf:about="{$base}/chem_link_tor/{translate(@id,' ^','_')},{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@link_id!=''">
        <PDBo:reference_to_chem_link>
	  <rdf:Description  rdf:about="{$base}/chem_link/{translate(@link_id,' ^','_')}">
	    <PDBo:referenced_by_chem_link_tor rdf:resource="{$base}/chem_link_tor/{translate(@id,' ^','_')},{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_link>
        <!-- chem_linkKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link_tor>
      </PDBo:has_chem_link_tor>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chem_link_tor_valueCategory/PDBx:chem_link_tor_value">
      <PDBo:has_chem_link_tor_value>
      <PDBo:chem_link_tor_value rdf:about="{$base}/chem_link_tor_value/{translate(@tor_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chem_link_tor_value>
      </PDBo:has_chem_link_tor_value>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chemicalCategory/PDBx:chemical">
      <PDBo:has_chemical>
      <PDBo:chemical rdf:about="{$base}/chemical/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_chemical rdf:resource="{$base}/chemical/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chemical>
      </PDBo:has_chemical>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chemical_conn_atomCategory/PDBx:chemical_conn_atom">
      <PDBo:has_chemical_conn_atom>
      <PDBo:chemical_conn_atom rdf:about="{$base}/chemical_conn_atom/{translate(@number,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:type_symbol!=''">
        <PDBo:reference_to_atom_type>
	  <rdf:Description  rdf:about="{$base}/atom_type/{translate(PDBx:type_symbol,' ^','_')}">
	    <PDBo:referenced_by_chemical_conn_atom rdf:resource="{$base}/chemical_conn_atom/{translate(@number,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_atom_type>
        <!-- atom_typeKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chemical_conn_atom>
      </PDBo:has_chemical_conn_atom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chemical_conn_bondCategory/PDBx:chemical_conn_bond">
      <PDBo:has_chemical_conn_bond>
      <PDBo:chemical_conn_bond rdf:about="{$base}/chemical_conn_bond/{translate(@atom_1,' ^','_')},{translate(@atom_2,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@atom_1!=''">
        <PDBo:reference_to_chemical_conn_atom>
	  <rdf:Description  rdf:about="{$base}/chemical_conn_atom/{translate(@atom_1,' ^','_')}">
	    <PDBo:referenced_by_chemical_conn_bond rdf:resource="{$base}/chemical_conn_bond/{translate(@atom_1,' ^','_')},{translate(@atom_2,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chemical_conn_atom>
        <!-- chemical_conn_atomKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@atom_2!=''">
        <PDBo:reference_to_chemical_conn_atom>
	  <rdf:Description  rdf:about="{$base}/chemical_conn_atom/{translate(@atom_2,' ^','_')}">
	    <PDBo:referenced_by_chemical_conn_bond rdf:resource="{$base}/chemical_conn_bond/{translate(@atom_1,' ^','_')},{translate(@atom_2,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chemical_conn_atom>
        <!-- chemical_conn_atomKeyref_0_0_0_1 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chemical_conn_bond>
      </PDBo:has_chemical_conn_bond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:chemical_formulaCategory/PDBx:chemical_formula">
      <PDBo:has_chemical_formula>
      <PDBo:chemical_formula rdf:about="{$base}/chemical_formula/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_chemical_formula rdf:resource="{$base}/chemical_formula/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:chemical_formula>
      </PDBo:has_chemical_formula>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:citationCategory/PDBx:citation">
      <PDBo:has_citation>
      <PDBo:citation rdf:about="{$base}/citation/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:citation>
      </PDBo:has_citation>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:citation_authorCategory/PDBx:citation_author">
      <PDBo:has_citation_author>
      <PDBo:citation_author rdf:about="{$base}/citation_author/{translate(@citation_id,' ^','_')},{translate(@name,' ^','_')},{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@citation_id!=''">
        <PDBo:reference_to_citation>
	  <rdf:Description  rdf:about="{$base}/citation/{translate(@citation_id,' ^','_')}">
	    <PDBo:referenced_by_citation_author rdf:resource="{$base}/citation_author/{translate(@citation_id,' ^','_')},{translate(@name,' ^','_')},{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_citation>
        <!-- citationKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:citation_author>
      </PDBo:has_citation_author>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:citation_editorCategory/PDBx:citation_editor">
      <PDBo:has_citation_editor>
      <PDBo:citation_editor rdf:about="{$base}/citation_editor/{translate(@citation_id,' ^','_')},{translate(@name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@citation_id!=''">
        <PDBo:reference_to_citation>
	  <rdf:Description  rdf:about="{$base}/citation/{translate(@citation_id,' ^','_')}">
	    <PDBo:referenced_by_citation_editor rdf:resource="{$base}/citation_editor/{translate(@citation_id,' ^','_')},{translate(@name,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_citation>
        <!-- citationKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:citation_editor>
      </PDBo:has_citation_editor>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:computingCategory/PDBx:computing">
      <PDBo:has_computing>
      <PDBo:computing rdf:about="{$base}/computing/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_computing rdf:resource="{$base}/computing/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:computing>
      </PDBo:has_computing>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:databaseCategory/PDBx:database">
      <PDBo:has_database>
      <PDBo:database rdf:about="{$base}/database/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_database rdf:resource="{$base}/database/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:database>
      </PDBo:has_database>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:database_2Category/PDBx:database_2">
      <PDBo:has_database_2>
      <PDBo:database_2 rdf:about="{$base}/database_2/{translate(@database_code,' ^','_')},{translate(@database_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:database_2>
      </PDBo:has_database_2>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:database_PDB_caveatCategory/PDBx:database_PDB_caveat">
      <PDBo:has_database_PDB_caveat>
      <PDBo:database_PDB_caveat rdf:about="{$base}/database_PDB_caveat/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:database_PDB_caveat>
      </PDBo:has_database_PDB_caveat>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:database_PDB_matrixCategory/PDBx:database_PDB_matrix">
      <PDBo:has_database_PDB_matrix>
      <PDBo:database_PDB_matrix rdf:about="{$base}/database_PDB_matrix/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_database_PDB_matrix rdf:resource="{$base}/database_PDB_matrix/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:database_PDB_matrix>
      </PDBo:has_database_PDB_matrix>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:database_PDB_remarkCategory/PDBx:database_PDB_remark">
      <PDBo:has_database_PDB_remark>
      <PDBo:database_PDB_remark rdf:about="{$base}/database_PDB_remark/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:database_PDB_remark>
      </PDBo:has_database_PDB_remark>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:database_PDB_revCategory/PDBx:database_PDB_rev">
      <PDBo:has_database_PDB_rev>
      <PDBo:database_PDB_rev rdf:about="{$base}/database_PDB_rev/{translate(@num,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:database_PDB_rev>
      </PDBo:has_database_PDB_rev>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:database_PDB_rev_recordCategory/PDBx:database_PDB_rev_record">
      <PDBo:has_database_PDB_rev_record>
      <PDBo:database_PDB_rev_record rdf:about="{$base}/database_PDB_rev_record/{translate(@rev_num,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@rev_num!=''">
        <PDBo:reference_to_database_PDB_rev>
	  <rdf:Description  rdf:about="{$base}/database_PDB_rev/{translate(@rev_num,' ^','_')}">
	    <PDBo:referenced_by_database_PDB_rev_record rdf:resource="{$base}/database_PDB_rev_record/{translate(@rev_num,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_database_PDB_rev>
        <!-- database_PDB_revKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:database_PDB_rev_record>
      </PDBo:has_database_PDB_rev_record>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:database_PDB_tvectCategory/PDBx:database_PDB_tvect">
      <PDBo:has_database_PDB_tvect>
      <PDBo:database_PDB_tvect rdf:about="{$base}/database_PDB_tvect/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:database_PDB_tvect>
      </PDBo:has_database_PDB_tvect>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:diffrnCategory/PDBx:diffrn">
      <PDBo:has_diffrn>
      <PDBo:diffrn rdf:about="{$base}/diffrn/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:crystal_id!=''">
        <PDBo:reference_to_exptl_crystal>
	  <rdf:Description  rdf:about="{$base}/exptl_crystal/{translate(PDBx:crystal_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn rdf:resource="{$base}/diffrn/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_exptl_crystal>
        <!-- exptl_crystalKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn>
      </PDBo:has_diffrn>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:diffrn_attenuatorCategory/PDBx:diffrn_attenuator">
      <PDBo:has_diffrn_attenuator>
      <PDBo:diffrn_attenuator rdf:about="{$base}/diffrn_attenuator/{translate(@code,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_attenuator>
      </PDBo:has_diffrn_attenuator>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:diffrn_detectorCategory/PDBx:diffrn_detector">
      <PDBo:has_diffrn_detector>
      <PDBo:diffrn_detector rdf:about="{$base}/diffrn_detector/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_detector rdf:resource="{$base}/diffrn_detector/{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_measurementCategory/PDBx:diffrn_measurement">
      <PDBo:has_diffrn_measurement>
      <PDBo:diffrn_measurement rdf:about="{$base}/diffrn_measurement/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_measurement rdf:resource="{$base}/diffrn_measurement/{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_orient_matrixCategory/PDBx:diffrn_orient_matrix">
      <PDBo:has_diffrn_orient_matrix>
      <PDBo:diffrn_orient_matrix rdf:about="{$base}/diffrn_orient_matrix/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_orient_matrix rdf:resource="{$base}/diffrn_orient_matrix/{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_orient_reflnCategory/PDBx:diffrn_orient_refln">
      <PDBo:has_diffrn_orient_refln>
      <PDBo:diffrn_orient_refln rdf:about="{$base}/diffrn_orient_refln/{translate(@diffrn_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_orient_refln rdf:resource="{$base}/diffrn_orient_refln/{translate(@diffrn_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_radiationCategory/PDBx:diffrn_radiation">
      <PDBo:has_diffrn_radiation>
      <PDBo:diffrn_radiation rdf:about="{$base}/diffrn_radiation/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_radiation rdf:resource="{$base}/diffrn_radiation/{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_radiation_wavelengthCategory/PDBx:diffrn_radiation_wavelength">
      <PDBo:has_diffrn_radiation_wavelength>
      <PDBo:diffrn_radiation_wavelength rdf:about="{$base}/diffrn_radiation_wavelength/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_radiation_wavelength>
      </PDBo:has_diffrn_radiation_wavelength>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:diffrn_reflnCategory/PDBx:diffrn_refln">
      <PDBo:has_diffrn_refln>
      <PDBo:diffrn_refln rdf:about="{$base}/diffrn_refln/{translate(@diffrn_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_refln rdf:resource="{$base}/diffrn_refln/{translate(@diffrn_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_reflnsCategory/PDBx:diffrn_reflns">
      <PDBo:has_diffrn_reflns>
      <PDBo:diffrn_reflns rdf:about="{$base}/diffrn_reflns/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_reflns rdf:resource="{$base}/diffrn_reflns/{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_reflns_classCategory/PDBx:diffrn_reflns_class">
      <PDBo:has_diffrn_reflns_class>
      <PDBo:diffrn_reflns_class rdf:about="{$base}/diffrn_reflns_class/{translate(@code,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_reflns_class>
      </PDBo:has_diffrn_reflns_class>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:diffrn_scale_groupCategory/PDBx:diffrn_scale_group">
      <PDBo:has_diffrn_scale_group>
      <PDBo:diffrn_scale_group rdf:about="{$base}/diffrn_scale_group/{translate(@code,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:diffrn_scale_group>
      </PDBo:has_diffrn_scale_group>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:diffrn_sourceCategory/PDBx:diffrn_source">
      <PDBo:has_diffrn_source>
      <PDBo:diffrn_source rdf:about="{$base}/diffrn_source/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_source rdf:resource="{$base}/diffrn_source/{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_standard_reflnCategory/PDBx:diffrn_standard_refln">
      <PDBo:has_diffrn_standard_refln>
      <PDBo:diffrn_standard_refln rdf:about="{$base}/diffrn_standard_refln/{translate(@code,' ^','_')},{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_standard_refln rdf:resource="{$base}/diffrn_standard_refln/{translate(@code,' ^','_')},{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:diffrn_standardsCategory/PDBx:diffrn_standards">
      <PDBo:has_diffrn_standards>
      <PDBo:diffrn_standards rdf:about="{$base}/diffrn_standards/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_diffrn_standards rdf:resource="{$base}/diffrn_standards/{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_2d_crystal_entityCategory/PDBx:em_2d_crystal_entity">
      <PDBo:has_em_2d_crystal_entity>
      <PDBo:em_2d_crystal_entity rdf:about="{$base}/em_2d_crystal_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_2d_crystal_entity>
      </PDBo:has_em_2d_crystal_entity>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_2d_projection_selectionCategory/PDBx:em_2d_projection_selection">
      <PDBo:has_em_2d_projection_selection>
      <PDBo:em_2d_projection_selection rdf:about="{$base}/em_2d_projection_selection/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_2d_projection_selection rdf:resource="{$base}/em_2d_projection_selection/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_2d_projection_selection>
      </PDBo:has_em_2d_projection_selection>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_3d_crystal_entityCategory/PDBx:em_3d_crystal_entity">
      <PDBo:has_em_3d_crystal_entity>
      <PDBo:em_3d_crystal_entity rdf:about="{$base}/em_3d_crystal_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_3d_crystal_entity>
      </PDBo:has_em_3d_crystal_entity>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_3d_fittingCategory/PDBx:em_3d_fitting">
      <PDBo:has_em_3d_fitting>
      <PDBo:em_3d_fitting rdf:about="{$base}/em_3d_fitting/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_3d_fitting rdf:resource="{$base}/em_3d_fitting/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_3d_fitting>
      </PDBo:has_em_3d_fitting>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_3d_fitting_listCategory/PDBx:em_3d_fitting_list">
      <PDBo:has_em_3d_fitting_list>
      <PDBo:em_3d_fitting_list rdf:about="{$base}/em_3d_fitting_list/{translate(@_3d_fitting_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_3d_fitting_list>
      </PDBo:has_em_3d_fitting_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_3d_reconstructionCategory/PDBx:em_3d_reconstruction">
      <PDBo:has_em_3d_reconstruction>
      <PDBo:em_3d_reconstruction rdf:about="{$base}/em_3d_reconstruction/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBx:entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_3d_reconstruction rdf:resource="{$base}/em_3d_reconstruction/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_3d_reconstruction>
      </PDBo:has_em_3d_reconstruction>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_adminCategory/PDBx:em_admin">
      <PDBo:has_em_admin>
      <PDBo:em_admin rdf:about="{$base}/em_admin/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_admin rdf:resource="{$base}/em_admin/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_admin>
      </PDBo:has_em_admin>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_assemblyCategory/PDBx:em_assembly">
      <PDBo:has_em_assembly>
      <PDBo:em_assembly rdf:about="{$base}/em_assembly/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_assembly rdf:resource="{$base}/em_assembly/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_12_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_assembly>
      </PDBo:has_em_assembly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_author_listCategory/PDBx:em_author_list">
      <PDBo:has_em_author_list>
      <PDBo:em_author_list rdf:about="{$base}/em_author_list/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_author_list>
      </PDBo:has_em_author_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_bufferCategory/PDBx:em_buffer">
      <PDBo:has_em_buffer>
      <PDBo:em_buffer rdf:about="{$base}/em_buffer/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_buffer>
      </PDBo:has_em_buffer>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_buffer_componentCategory/PDBx:em_buffer_component">
      <PDBo:has_em_buffer_component>
      <PDBo:em_buffer_component rdf:about="{$base}/em_buffer_component/{translate(@buffer_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_buffer_component>
      </PDBo:has_em_buffer_component>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_crystal_formationCategory/PDBx:em_crystal_formation">
      <PDBo:has_em_crystal_formation>
      <PDBo:em_crystal_formation rdf:about="{$base}/em_crystal_formation/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_crystal_formation>
      </PDBo:has_em_crystal_formation>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_ctf_correctionCategory/PDBx:em_ctf_correction">
      <PDBo:has_em_ctf_correction>
      <PDBo:em_ctf_correction rdf:about="{$base}/em_ctf_correction/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_ctf_correction>
      </PDBo:has_em_ctf_correction>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_db_referenceCategory/PDBx:em_db_reference">
      <PDBo:has_em_db_reference>
      <PDBo:em_db_reference rdf:about="{$base}/em_db_reference/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_db_reference>
      </PDBo:has_em_db_reference>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_db_reference_auxiliaryCategory/PDBx:em_db_reference_auxiliary">
      <PDBo:has_em_db_reference_auxiliary>
      <PDBo:em_db_reference_auxiliary rdf:about="{$base}/em_db_reference_auxiliary/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_db_reference_auxiliary>
      </PDBo:has_em_db_reference_auxiliary>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_depositor_infoCategory/PDBx:em_depositor_info">
      <PDBo:has_em_depositor_info>
      <PDBo:em_depositor_info rdf:about="{$base}/em_depositor_info/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_depositor_info rdf:resource="{$base}/em_depositor_info/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_13_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_depositor_info>
      </PDBo:has_em_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_depuiCategory/PDBx:em_depui">
      <PDBo:has_em_depui>
      <PDBo:em_depui rdf:about="{$base}/em_depui/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_depui>
      </PDBo:has_em_depui>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_detectorCategory/PDBx:em_detector">
      <PDBo:has_em_detector>
      <PDBo:em_detector rdf:about="{$base}/em_detector/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_detector rdf:resource="{$base}/em_detector/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_14_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_detector>
      </PDBo:has_em_detector>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_diffractionCategory/PDBx:em_diffraction">
      <PDBo:has_em_diffraction>
      <PDBo:em_diffraction rdf:about="{$base}/em_diffraction/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_diffraction>
      </PDBo:has_em_diffraction>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_diffraction_shellCategory/PDBx:em_diffraction_shell">
      <PDBo:has_em_diffraction_shell>
      <PDBo:em_diffraction_shell rdf:about="{$base}/em_diffraction_shell/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_diffraction_shell>
      </PDBo:has_em_diffraction_shell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_diffraction_statsCategory/PDBx:em_diffraction_stats">
      <PDBo:has_em_diffraction_stats>
      <PDBo:em_diffraction_stats rdf:about="{$base}/em_diffraction_stats/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_diffraction_stats>
      </PDBo:has_em_diffraction_stats>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_embeddingCategory/PDBx:em_embedding">
      <PDBo:has_em_embedding>
      <PDBo:em_embedding rdf:about="{$base}/em_embedding/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_embedding>
      </PDBo:has_em_embedding>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_entity_assemblyCategory/PDBx:em_entity_assembly">
      <PDBo:has_em_entity_assembly>
      <PDBo:em_entity_assembly rdf:about="{$base}/em_entity_assembly/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_entity_assembly>
      </PDBo:has_em_entity_assembly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_entity_assembly_molwtCategory/PDBx:em_entity_assembly_molwt">
      <PDBo:has_em_entity_assembly_molwt>
      <PDBo:em_entity_assembly_molwt rdf:about="{$base}/em_entity_assembly_molwt/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBo:referenced_by_em_entity_assembly_molwt rdf:resource="{$base}/em_entity_assembly_molwt/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_entity_assembly_naturalsourceCategory/PDBx:em_entity_assembly_naturalsource">
      <PDBo:has_em_entity_assembly_naturalsource>
      <PDBo:em_entity_assembly_naturalsource rdf:about="{$base}/em_entity_assembly_naturalsource/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBo:referenced_by_em_entity_assembly_naturalsource rdf:resource="{$base}/em_entity_assembly_naturalsource/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_entity_assembly_recombinantCategory/PDBx:em_entity_assembly_recombinant">
      <PDBo:has_em_entity_assembly_recombinant>
      <PDBo:em_entity_assembly_recombinant rdf:about="{$base}/em_entity_assembly_recombinant/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBo:referenced_by_em_entity_assembly_recombinant rdf:resource="{$base}/em_entity_assembly_recombinant/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_entity_assembly_syntheticCategory/PDBx:em_entity_assembly_synthetic">
      <PDBo:has_em_entity_assembly_synthetic>
      <PDBo:em_entity_assembly_synthetic rdf:about="{$base}/em_entity_assembly_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBo:referenced_by_em_entity_assembly_synthetic rdf:resource="{$base}/em_entity_assembly_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_euler_angle_assignmentCategory/PDBx:em_euler_angle_assignment">
      <PDBo:has_em_euler_angle_assignment>
      <PDBo:em_euler_angle_assignment rdf:about="{$base}/em_euler_angle_assignment/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_euler_angle_assignment>
      </PDBo:has_em_euler_angle_assignment>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_experimentCategory/PDBx:em_experiment">
      <PDBo:has_em_experiment>
      <PDBo:em_experiment rdf:about="{$base}/em_experiment/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_experiment rdf:resource="{$base}/em_experiment/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_15_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_experiment>
      </PDBo:has_em_experiment>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_fiducial_markersCategory/PDBx:em_fiducial_markers">
      <PDBo:has_em_fiducial_markers>
      <PDBo:em_fiducial_markers rdf:about="{$base}/em_fiducial_markers/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:em_tomography_specimen_id!=''">
        <PDBo:reference_to_em_tomography_specimen>
	  <rdf:Description  rdf:about="{$base}/em_tomography_specimen/{translate(PDBx:em_tomography_specimen_id,' ^','_')}">
	    <PDBo:referenced_by_em_fiducial_markers rdf:resource="{$base}/em_fiducial_markers/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_em_tomography_specimen>
        <!-- em_tomography_specimenKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_fiducial_markers>
      </PDBo:has_em_fiducial_markers>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_figure_depositor_infoCategory/PDBx:em_figure_depositor_info">
      <PDBo:has_em_figure_depositor_info>
      <PDBo:em_figure_depositor_info rdf:about="{$base}/em_figure_depositor_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_figure_depositor_info>
      </PDBo:has_em_figure_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_final_classificationCategory/PDBx:em_final_classification">
      <PDBo:has_em_final_classification>
      <PDBo:em_final_classification rdf:about="{$base}/em_final_classification/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_final_classification>
      </PDBo:has_em_final_classification>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_focused_ion_beamCategory/PDBx:em_focused_ion_beam">
      <PDBo:has_em_focused_ion_beam>
      <PDBo:em_focused_ion_beam rdf:about="{$base}/em_focused_ion_beam/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:em_tomography_specimen_id!=''">
        <PDBo:reference_to_em_tomography_specimen>
	  <rdf:Description  rdf:about="{$base}/em_tomography_specimen/{translate(PDBx:em_tomography_specimen_id,' ^','_')}">
	    <PDBo:referenced_by_em_focused_ion_beam rdf:resource="{$base}/em_focused_ion_beam/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_em_tomography_specimen>
        <!-- em_tomography_specimenKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_focused_ion_beam>
      </PDBo:has_em_focused_ion_beam>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_fsc_curveCategory/PDBx:em_fsc_curve">
      <PDBo:has_em_fsc_curve>
      <PDBo:em_fsc_curve rdf:about="{$base}/em_fsc_curve/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_fsc_curve>
      </PDBo:has_em_fsc_curve>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_grid_pretreatmentCategory/PDBx:em_grid_pretreatment">
      <PDBo:has_em_grid_pretreatment>
      <PDBo:em_grid_pretreatment rdf:about="{$base}/em_grid_pretreatment/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_grid_pretreatment>
      </PDBo:has_em_grid_pretreatment>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_helical_entityCategory/PDBx:em_helical_entity">
      <PDBo:has_em_helical_entity>
      <PDBo:em_helical_entity rdf:about="{$base}/em_helical_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_helical_entity>
      </PDBo:has_em_helical_entity>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_high_pressure_freezingCategory/PDBx:em_high_pressure_freezing">
      <PDBo:has_em_high_pressure_freezing>
      <PDBo:em_high_pressure_freezing rdf:about="{$base}/em_high_pressure_freezing/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:em_tomography_specimen_id!=''">
        <PDBo:reference_to_em_tomography_specimen>
	  <rdf:Description  rdf:about="{$base}/em_tomography_specimen/{translate(PDBx:em_tomography_specimen_id,' ^','_')}">
	    <PDBo:referenced_by_em_high_pressure_freezing rdf:resource="{$base}/em_high_pressure_freezing/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_em_tomography_specimen>
        <!-- em_tomography_specimenKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_high_pressure_freezing>
      </PDBo:has_em_high_pressure_freezing>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_image_processingCategory/PDBx:em_image_processing">
      <PDBo:has_em_image_processing>
      <PDBo:em_image_processing rdf:about="{$base}/em_image_processing/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_image_processing>
      </PDBo:has_em_image_processing>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_image_recordingCategory/PDBx:em_image_recording">
      <PDBo:has_em_image_recording>
      <PDBo:em_image_recording rdf:about="{$base}/em_image_recording/{translate(@id,' ^','_')},{translate(@imaging_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_image_recording>
      </PDBo:has_em_image_recording>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_image_scansCategory/PDBx:em_image_scans">
      <PDBo:has_em_image_scans>
      <PDBo:em_image_scans rdf:about="{$base}/em_image_scans/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBx:entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_image_scans rdf:resource="{$base}/em_image_scans/{translate(@id,' ^','_')},{translate(@image_recording_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_16_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_image_scans>
      </PDBo:has_em_image_scans>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_imagingCategory/PDBx:em_imaging">
      <PDBo:has_em_imaging>
      <PDBo:em_imaging rdf:about="{$base}/em_imaging/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_imaging rdf:resource="{$base}/em_imaging/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_17_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_imaging>
      </PDBo:has_em_imaging>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_imaging_opticsCategory/PDBx:em_imaging_optics">
      <PDBo:has_em_imaging_optics>
      <PDBo:em_imaging_optics rdf:about="{$base}/em_imaging_optics/{translate(@id,' ^','_')},{translate(@imaging_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_imaging_optics>
      </PDBo:has_em_imaging_optics>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_interpret_figureCategory/PDBx:em_interpret_figure">
      <PDBo:has_em_interpret_figure>
      <PDBo:em_interpret_figure rdf:about="{$base}/em_interpret_figure/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_interpret_figure>
      </PDBo:has_em_interpret_figure>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_layer_linesCategory/PDBx:em_layer_lines">
      <PDBo:has_em_layer_lines>
      <PDBo:em_layer_lines rdf:about="{$base}/em_layer_lines/{translate(@experiment_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_layer_lines>
      </PDBo:has_em_layer_lines>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_layer_lines_depositor_infoCategory/PDBx:em_layer_lines_depositor_info">
      <PDBo:has_em_layer_lines_depositor_info>
      <PDBo:em_layer_lines_depositor_info rdf:about="{$base}/em_layer_lines_depositor_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_layer_lines_depositor_info>
      </PDBo:has_em_layer_lines_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_mapCategory/PDBx:em_map">
      <PDBo:has_em_map>
      <PDBo:em_map rdf:about="{$base}/em_map/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_map rdf:resource="{$base}/em_map/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_18_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_map>
      </PDBo:has_em_map>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_map_depositor_infoCategory/PDBx:em_map_depositor_info">
      <PDBo:has_em_map_depositor_info>
      <PDBo:em_map_depositor_info rdf:about="{$base}/em_map_depositor_info/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_map_depositor_info rdf:resource="{$base}/em_map_depositor_info/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_19_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_map_depositor_info>
      </PDBo:has_em_map_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_mask_depositor_infoCategory/PDBx:em_mask_depositor_info">
      <PDBo:has_em_mask_depositor_info>
      <PDBo:em_mask_depositor_info rdf:about="{$base}/em_mask_depositor_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_mask_depositor_info>
      </PDBo:has_em_mask_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_obsoleteCategory/PDBx:em_obsolete">
      <PDBo:has_em_obsolete>
      <PDBo:em_obsolete rdf:about="{$base}/em_obsolete/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_obsolete>
      </PDBo:has_em_obsolete>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_particle_selectionCategory/PDBx:em_particle_selection">
      <PDBo:has_em_particle_selection>
      <PDBo:em_particle_selection rdf:about="{$base}/em_particle_selection/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_particle_selection>
      </PDBo:has_em_particle_selection>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_sample_preparationCategory/PDBx:em_sample_preparation">
      <PDBo:has_em_sample_preparation>
      <PDBo:em_sample_preparation rdf:about="{$base}/em_sample_preparation/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_sample_preparation rdf:resource="{$base}/em_sample_preparation/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_20_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_sample_preparation>
      </PDBo:has_em_sample_preparation>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_sample_supportCategory/PDBx:em_sample_support">
      <PDBo:has_em_sample_support>
      <PDBo:em_sample_support rdf:about="{$base}/em_sample_support/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_sample_support>
      </PDBo:has_em_sample_support>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_shadowingCategory/PDBx:em_shadowing">
      <PDBo:has_em_shadowing>
      <PDBo:em_shadowing rdf:about="{$base}/em_shadowing/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_shadowing>
      </PDBo:has_em_shadowing>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_single_particle_entityCategory/PDBx:em_single_particle_entity">
      <PDBo:has_em_single_particle_entity>
      <PDBo:em_single_particle_entity rdf:about="{$base}/em_single_particle_entity/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_single_particle_entity>
      </PDBo:has_em_single_particle_entity>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_softwareCategory/PDBx:em_software">
      <PDBo:has_em_software>
      <PDBo:em_software rdf:about="{$base}/em_software/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_software>
      </PDBo:has_em_software>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_specimenCategory/PDBx:em_specimen">
      <PDBo:has_em_specimen>
      <PDBo:em_specimen rdf:about="{$base}/em_specimen/{translate(@experiment_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_specimen>
      </PDBo:has_em_specimen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_stainingCategory/PDBx:em_staining">
      <PDBo:has_em_staining>
      <PDBo:em_staining rdf:about="{$base}/em_staining/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_staining>
      </PDBo:has_em_staining>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_start_modelCategory/PDBx:em_start_model">
      <PDBo:has_em_start_model>
      <PDBo:em_start_model rdf:about="{$base}/em_start_model/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_start_model>
      </PDBo:has_em_start_model>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_structure_factorsCategory/PDBx:em_structure_factors">
      <PDBo:has_em_structure_factors>
      <PDBo:em_structure_factors rdf:about="{$base}/em_structure_factors/{translate(@experiment_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_structure_factors>
      </PDBo:has_em_structure_factors>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_structure_factors_depositor_infoCategory/PDBx:em_structure_factors_depositor_info">
      <PDBo:has_em_structure_factors_depositor_info>
      <PDBo:em_structure_factors_depositor_info rdf:about="{$base}/em_structure_factors_depositor_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_structure_factors_depositor_info>
      </PDBo:has_em_structure_factors_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_supersedeCategory/PDBx:em_supersede">
      <PDBo:has_em_supersede>
      <PDBo:em_supersede rdf:about="{$base}/em_supersede/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_supersede>
      </PDBo:has_em_supersede>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_support_filmCategory/PDBx:em_support_film">
      <PDBo:has_em_support_film>
      <PDBo:em_support_film rdf:about="{$base}/em_support_film/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_support_film>
      </PDBo:has_em_support_film>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_tomographyCategory/PDBx:em_tomography">
      <PDBo:has_em_tomography>
      <PDBo:em_tomography rdf:about="{$base}/em_tomography/{translate(@id,' ^','_')},{translate(@imaging_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_tomography>
      </PDBo:has_em_tomography>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_tomography_specimenCategory/PDBx:em_tomography_specimen">
      <PDBo:has_em_tomography_specimen>
      <PDBo:em_tomography_specimen rdf:about="{$base}/em_tomography_specimen/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_tomography_specimen>
      </PDBo:has_em_tomography_specimen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_ultramicrotomyCategory/PDBx:em_ultramicrotomy">
      <PDBo:has_em_ultramicrotomy>
      <PDBo:em_ultramicrotomy rdf:about="{$base}/em_ultramicrotomy/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:em_tomography_specimen_id!=''">
        <PDBo:reference_to_em_tomography_specimen>
	  <rdf:Description  rdf:about="{$base}/em_tomography_specimen/{translate(PDBx:em_tomography_specimen_id,' ^','_')}">
	    <PDBo:referenced_by_em_ultramicrotomy rdf:resource="{$base}/em_ultramicrotomy/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_em_tomography_specimen>
        <!-- em_tomography_specimenKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_ultramicrotomy>
      </PDBo:has_em_ultramicrotomy>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_virus_entityCategory/PDBx:em_virus_entity">
      <PDBo:has_em_virus_entity>
      <PDBo:em_virus_entity rdf:about="{$base}/em_virus_entity/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBo:referenced_by_em_virus_entity rdf:resource="{$base}/em_virus_entity/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_virus_natural_hostCategory/PDBx:em_virus_natural_host">
      <PDBo:has_em_virus_natural_host>
      <PDBo:em_virus_natural_host rdf:about="{$base}/em_virus_natural_host/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBo:referenced_by_em_virus_natural_host rdf:resource="{$base}/em_virus_natural_host/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_virus_shellCategory/PDBx:em_virus_shell">
      <PDBo:has_em_virus_shell>
      <PDBo:em_virus_shell rdf:about="{$base}/em_virus_shell/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBo:referenced_by_em_virus_shell rdf:resource="{$base}/em_virus_shell/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_virus_syntheticCategory/PDBx:em_virus_synthetic">
      <PDBo:has_em_virus_synthetic>
      <PDBo:em_virus_synthetic rdf:about="{$base}/em_virus_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_assembly_id!=''">
        <PDBo:reference_to_em_entity_assembly>
	  <rdf:Description  rdf:about="{$base}/em_entity_assembly/{translate(@entity_assembly_id,' ^','_')}">
	    <PDBo:referenced_by_em_virus_synthetic rdf:resource="{$base}/em_virus_synthetic/{translate(@entity_assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:em_vitrificationCategory/PDBx:em_vitrification">
      <PDBo:has_em_vitrification>
      <PDBo:em_vitrification rdf:about="{$base}/em_vitrification/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBx:entry_id,' ^','_')}">
	    <PDBo:referenced_by_em_vitrification rdf:resource="{$base}/em_vitrification/{translate(@id,' ^','_')},{translate(@specimen_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_21_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_vitrification>
      </PDBo:has_em_vitrification>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:em_volume_selectionCategory/PDBx:em_volume_selection">
      <PDBo:has_em_volume_selection>
      <PDBo:em_volume_selection rdf:about="{$base}/em_volume_selection/{translate(@id,' ^','_')},{translate(@image_processing_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:em_volume_selection>
      </PDBo:has_em_volume_selection>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entityCategory/PDBx:entity">
      <PDBo:has_entity>
      <PDBo:entity rdf:about="{$base}/entity/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity>
      </PDBo:has_entity>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entity_keywordsCategory/PDBx:entity_keywords">
      <PDBo:has_entity_keywords>
      <PDBo:entity_keywords rdf:about="{$base}/entity_keywords/{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_entity_keywords rdf:resource="{$base}/entity_keywords/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_keywords>
      </PDBo:has_entity_keywords>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entity_linkCategory/PDBx:entity_link">
      <PDBo:has_entity_link>
      <PDBo:entity_link rdf:about="{$base}/entity_link/{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@link_id!=''">
        <PDBo:reference_to_chem_link>
	  <rdf:Description  rdf:about="{$base}/chem_link/{translate(@link_id,' ^','_')}">
	    <PDBo:referenced_by_entity_link rdf:resource="{$base}/entity_link/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_link>
        <!-- chem_linkKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:if test="PDBx:entity_id_1!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBx:entity_id_1,' ^','_')}">
	    <PDBo:referenced_by_entity_link rdf:resource="{$base}/entity_link/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:if test="PDBx:entity_id_2!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBx:entity_id_2,' ^','_')}">
	    <PDBo:referenced_by_entity_link rdf:resource="{$base}/entity_link/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_2_1 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_link>
      </PDBo:has_entity_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entity_name_comCategory/PDBx:entity_name_com">
      <PDBo:has_entity_name_com>
      <PDBo:entity_name_com rdf:about="{$base}/entity_name_com/{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_entity_name_com rdf:resource="{$base}/entity_name_com/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_name_com>
      </PDBo:has_entity_name_com>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entity_name_sysCategory/PDBx:entity_name_sys">
      <PDBo:has_entity_name_sys>
      <PDBo:entity_name_sys rdf:about="{$base}/entity_name_sys/{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_entity_name_sys rdf:resource="{$base}/entity_name_sys/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_name_sys>
      </PDBo:has_entity_name_sys>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entity_polyCategory/PDBx:entity_poly">
      <PDBo:has_entity_poly>
      <PDBo:entity_poly rdf:about="{$base}/entity_poly/{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_entity_poly rdf:resource="{$base}/entity_poly/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_poly>
      </PDBo:has_entity_poly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entity_src_genCategory/PDBx:entity_src_gen">
      <PDBo:has_entity_src_gen>
      <PDBo:entity_src_gen rdf:about="{$base}/entity_src_gen/{translate(@entity_id,' ^','_')},{translate(@pdbx_src_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_entity_src_gen rdf:resource="{$base}/entity_src_gen/{translate(@entity_id,' ^','_')},{translate(@pdbx_src_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_src_gen>
      </PDBo:has_entity_src_gen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entity_src_natCategory/PDBx:entity_src_nat">
      <PDBo:has_entity_src_nat>
      <PDBo:entity_src_nat rdf:about="{$base}/entity_src_nat/{translate(@entity_id,' ^','_')},{translate(@pdbx_src_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_entity_src_nat rdf:resource="{$base}/entity_src_nat/{translate(@entity_id,' ^','_')},{translate(@pdbx_src_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_7_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entity_src_nat>
      </PDBo:has_entity_src_nat>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entryCategory/PDBx:entry">
      <PDBo:has_entry>
      <PDBo:entry rdf:about="{$base}/entry/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entry>
      </PDBo:has_entry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:entry_linkCategory/PDBx:entry_link">
      <PDBo:has_entry_link>
      <PDBo:entry_link rdf:about="{$base}/entry_link/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_entry_link rdf:resource="{$base}/entry_link/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_22_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:entry_link>
      </PDBo:has_entry_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:exptlCategory/PDBx:exptl">
      <PDBo:has_exptl>
      <PDBo:exptl rdf:about="{$base}/exptl/{translate(@entry_id,' ^','_')},{translate(@method,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_exptl rdf:resource="{$base}/exptl/{translate(@entry_id,' ^','_')},{translate(@method,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_23_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:exptl>
      </PDBo:has_exptl>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:exptl_crystalCategory/PDBx:exptl_crystal">
      <PDBo:has_exptl_crystal>
      <PDBo:exptl_crystal rdf:about="{$base}/exptl_crystal/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:exptl_crystal>
      </PDBo:has_exptl_crystal>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:exptl_crystal_faceCategory/PDBx:exptl_crystal_face">
      <PDBo:has_exptl_crystal_face>
      <PDBo:exptl_crystal_face rdf:about="{$base}/exptl_crystal_face/{translate(@crystal_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@crystal_id!=''">
        <PDBo:reference_to_exptl_crystal>
	  <rdf:Description  rdf:about="{$base}/exptl_crystal/{translate(@crystal_id,' ^','_')}">
	    <PDBo:referenced_by_exptl_crystal_face rdf:resource="{$base}/exptl_crystal_face/{translate(@crystal_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_exptl_crystal>
        <!-- exptl_crystalKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:exptl_crystal_face>
      </PDBo:has_exptl_crystal_face>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:exptl_crystal_growCategory/PDBx:exptl_crystal_grow">
      <PDBo:has_exptl_crystal_grow>
      <PDBo:exptl_crystal_grow rdf:about="{$base}/exptl_crystal_grow/{translate(@crystal_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@crystal_id!=''">
        <PDBo:reference_to_exptl_crystal>
	  <rdf:Description  rdf:about="{$base}/exptl_crystal/{translate(@crystal_id,' ^','_')}">
	    <PDBo:referenced_by_exptl_crystal_grow rdf:resource="{$base}/exptl_crystal_grow/{translate(@crystal_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_exptl_crystal>
        <!-- exptl_crystalKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:exptl_crystal_grow>
      </PDBo:has_exptl_crystal_grow>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:exptl_crystal_grow_compCategory/PDBx:exptl_crystal_grow_comp">
      <PDBo:has_exptl_crystal_grow_comp>
      <PDBo:exptl_crystal_grow_comp rdf:about="{$base}/exptl_crystal_grow_comp/{translate(@crystal_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@crystal_id!=''">
        <PDBo:reference_to_exptl_crystal>
	  <rdf:Description  rdf:about="{$base}/exptl_crystal/{translate(@crystal_id,' ^','_')}">
	    <PDBo:referenced_by_exptl_crystal_grow_comp rdf:resource="{$base}/exptl_crystal_grow_comp/{translate(@crystal_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_exptl_crystal>
        <!-- exptl_crystalKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:exptl_crystal_grow_comp>
      </PDBo:has_exptl_crystal_grow_comp>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:geomCategory/PDBx:geom">
      <PDBo:has_geom>
      <PDBo:geom rdf:about="{$base}/geom/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_geom rdf:resource="{$base}/geom/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_24_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:geom>
      </PDBo:has_geom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:geom_angleCategory/PDBx:geom_angle">
      <PDBo:has_geom_angle>
      <PDBo:geom_angle rdf:about="{$base}/geom_angle/{translate(@atom_site_id_1,' ^','_')},{translate(@atom_site_id_2,' ^','_')},{translate(@atom_site_id_3,' ^','_')},{translate(@site_symmetry_1,' ^','_')},{translate(@site_symmetry_2,' ^','_')},{translate(@site_symmetry_3,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:geom_angle>
      </PDBo:has_geom_angle>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:geom_bondCategory/PDBx:geom_bond">
      <PDBo:has_geom_bond>
      <PDBo:geom_bond rdf:about="{$base}/geom_bond/{translate(@atom_site_id_1,' ^','_')},{translate(@atom_site_id_2,' ^','_')},{translate(@site_symmetry_1,' ^','_')},{translate(@site_symmetry_2,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:geom_bond>
      </PDBo:has_geom_bond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:geom_contactCategory/PDBx:geom_contact">
      <PDBo:has_geom_contact>
      <PDBo:geom_contact rdf:about="{$base}/geom_contact/{translate(@atom_site_id_1,' ^','_')},{translate(@atom_site_id_2,' ^','_')},{translate(@site_symmetry_1,' ^','_')},{translate(@site_symmetry_2,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:geom_contact>
      </PDBo:has_geom_contact>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:geom_hbondCategory/PDBx:geom_hbond">
      <PDBo:has_geom_hbond>
      <PDBo:geom_hbond rdf:about="{$base}/geom_hbond/{translate(@atom_site_id_A,' ^','_')},{translate(@atom_site_id_D,' ^','_')},{translate(@atom_site_id_H,' ^','_')},{translate(@site_symmetry_A,' ^','_')},{translate(@site_symmetry_D,' ^','_')},{translate(@site_symmetry_H,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:geom_hbond>
      </PDBo:has_geom_hbond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:geom_torsionCategory/PDBx:geom_torsion">
      <PDBo:has_geom_torsion>
      <PDBo:geom_torsion rdf:about="{$base}/geom_torsion/{translate(@atom_site_id_1,' ^','_')},{translate(@atom_site_id_2,' ^','_')},{translate(@atom_site_id_3,' ^','_')},{translate(@atom_site_id_4,' ^','_')},{translate(@site_symmetry_1,' ^','_')},{translate(@site_symmetry_2,' ^','_')},{translate(@site_symmetry_3,' ^','_')},{translate(@site_symmetry_4,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:geom_torsion>
      </PDBo:has_geom_torsion>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:journalCategory/PDBx:journal">
      <PDBo:has_journal>
      <PDBo:journal rdf:about="{$base}/journal/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_journal rdf:resource="{$base}/journal/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_25_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:journal>
      </PDBo:has_journal>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:journal_indexCategory/PDBx:journal_index">
      <PDBo:has_journal_index>
      <PDBo:journal_index rdf:about="{$base}/journal_index/{translate(@term,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:journal_index>
      </PDBo:has_journal_index>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:ndb_original_ndb_coordinatesCategory/PDBx:ndb_original_ndb_coordinates">
      <PDBo:has_ndb_original_ndb_coordinates>
      <PDBo:ndb_original_ndb_coordinates rdf:about="{$base}/ndb_original_ndb_coordinates/{translate(@coord_section,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:ndb_original_ndb_coordinates>
      </PDBo:has_ndb_original_ndb_coordinates>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:ndb_struct_conf_naCategory/PDBx:ndb_struct_conf_na">
      <PDBo:has_ndb_struct_conf_na>
      <PDBo:ndb_struct_conf_na rdf:about="{$base}/ndb_struct_conf_na/{translate(@entry_id,' ^','_')},{translate(@feature,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_ndb_struct_conf_na rdf:resource="{$base}/ndb_struct_conf_na/{translate(@entry_id,' ^','_')},{translate(@feature,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_26_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:ndb_struct_conf_na>
      </PDBo:has_ndb_struct_conf_na>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:ndb_struct_feature_naCategory/PDBx:ndb_struct_feature_na">
      <PDBo:has_ndb_struct_feature_na>
      <PDBo:ndb_struct_feature_na rdf:about="{$base}/ndb_struct_feature_na/{translate(@entry_id,' ^','_')},{translate(@feature,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_ndb_struct_feature_na rdf:resource="{$base}/ndb_struct_feature_na/{translate(@entry_id,' ^','_')},{translate(@feature,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_27_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:ndb_struct_feature_na>
      </PDBo:has_ndb_struct_feature_na>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:ndb_struct_na_base_pairCategory/PDBx:ndb_struct_na_base_pair">
      <PDBo:has_ndb_struct_na_base_pair>
      <PDBo:ndb_struct_na_base_pair rdf:about="{$base}/ndb_struct_na_base_pair/{translate(@i_label_asym_id,' ^','_')},{translate(@i_label_comp_id,' ^','_')},{translate(@i_label_seq_id,' ^','_')},{translate(@i_symmetry,' ^','_')},{translate(@j_label_asym_id,' ^','_')},{translate(@j_label_comp_id,' ^','_')},{translate(@j_label_seq_id,' ^','_')},{translate(@j_symmetry,' ^','_')},{translate(@model_number,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:ndb_struct_na_base_pair>
      </PDBo:has_ndb_struct_na_base_pair>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:ndb_struct_na_base_pair_stepCategory/PDBx:ndb_struct_na_base_pair_step">
      <PDBo:has_ndb_struct_na_base_pair_step>
      <PDBo:ndb_struct_na_base_pair_step rdf:about="{$base}/ndb_struct_na_base_pair_step/{translate(@i_label_asym_id_1,' ^','_')},{translate(@i_label_asym_id_2,' ^','_')},{translate(@i_label_comp_id_1,' ^','_')},{translate(@i_label_comp_id_2,' ^','_')},{translate(@i_label_seq_id_1,' ^','_')},{translate(@i_label_seq_id_2,' ^','_')},{translate(@i_symmetry_1,' ^','_')},{translate(@i_symmetry_2,' ^','_')},{translate(@j_label_asym_id_1,' ^','_')},{translate(@j_label_asym_id_2,' ^','_')},{translate(@j_label_comp_id_1,' ^','_')},{translate(@j_label_comp_id_2,' ^','_')},{translate(@j_label_seq_id_1,' ^','_')},{translate(@j_label_seq_id_2,' ^','_')},{translate(@j_symmetry_1,' ^','_')},{translate(@j_symmetry_2,' ^','_')},{translate(@model_number,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:ndb_struct_na_base_pair_step>
      </PDBo:has_ndb_struct_na_base_pair_step>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_SG_projectCategory/PDBx:pdbx_SG_project">
      <PDBo:has_pdbx_SG_project>
      <PDBo:pdbx_SG_project rdf:about="{$base}/pdbx_SG_project/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_SG_project>
      </PDBo:has_pdbx_SG_project>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_atlasCategory/PDBx:pdbx_atlas">
      <PDBo:has_pdbx_atlas>
      <PDBo:pdbx_atlas rdf:about="{$base}/pdbx_atlas/{translate(@entry_id,' ^','_')},{translate(@page_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_atlas rdf:resource="{$base}/pdbx_atlas/{translate(@entry_id,' ^','_')},{translate(@page_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_28_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_atlas>
      </PDBo:has_pdbx_atlas>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_atom_site_aniso_tlsCategory/PDBx:pdbx_atom_site_aniso_tls">
      <PDBo:has_pdbx_atom_site_aniso_tls>
      <PDBo:pdbx_atom_site_aniso_tls rdf:about="{$base}/pdbx_atom_site_aniso_tls/{translate(@id,' ^','_')},{translate(@tls_group_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:label_alt_id!=''">
        <PDBo:reference_to_atom_sites_alt>
	  <rdf:Description  rdf:about="{$base}/atom_sites_alt/{translate(PDBx:label_alt_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_atom_site_aniso_tls rdf:resource="{$base}/pdbx_atom_site_aniso_tls/{translate(@id,' ^','_')},{translate(@tls_group_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_atom_sites_alt>
        <!-- atom_sites_altKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@tls_group_id!=''">
        <PDBo:reference_to_pdbx_refine_tls>
	  <rdf:Description  rdf:about="{$base}/pdbx_refine_tls/{translate(@tls_group_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_atom_site_aniso_tls rdf:resource="{$base}/pdbx_atom_site_aniso_tls/{translate(@id,' ^','_')},{translate(@tls_group_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_refine_tls>
        <!-- pdbx_refine_tlsKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_atom_site_aniso_tls>
      </PDBo:has_pdbx_atom_site_aniso_tls>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_auditCategory/PDBx:pdbx_audit">
      <PDBo:has_pdbx_audit>
      <PDBo:pdbx_audit rdf:about="{$base}/pdbx_audit/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:current_version!=''">
        <PDBo:reference_to_audit>
	  <rdf:Description  rdf:about="{$base}/audit/{translate(PDBx:current_version,' ^','_')}">
	    <PDBo:referenced_by_pdbx_audit rdf:resource="{$base}/pdbx_audit/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_audit>
        <!-- auditKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_audit rdf:resource="{$base}/pdbx_audit/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_29_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit>
      </PDBo:has_pdbx_audit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_authorCategory/PDBx:pdbx_audit_author">
      <PDBo:has_pdbx_audit_author>
      <PDBo:pdbx_audit_author rdf:about="{$base}/pdbx_audit_author/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_author>
      </PDBo:has_pdbx_audit_author>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_conformCategory/PDBx:pdbx_audit_conform">
      <PDBo:has_pdbx_audit_conform>
      <PDBo:pdbx_audit_conform rdf:about="{$base}/pdbx_audit_conform/{translate(@dict_name,' ^','_')},{translate(@dict_version,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_conform>
      </PDBo:has_pdbx_audit_conform>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_conform_extensionCategory/PDBx:pdbx_audit_conform_extension">
      <PDBo:has_pdbx_audit_conform_extension>
      <PDBo:pdbx_audit_conform_extension rdf:about="{$base}/pdbx_audit_conform_extension/{translate(@extension_dict_name,' ^','_')},{translate(@extension_dict_version,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_conform_extension>
      </PDBo:has_pdbx_audit_conform_extension>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_revision_categoryCategory/PDBx:pdbx_audit_revision_category">
      <PDBo:has_pdbx_audit_revision_category>
      <PDBo:pdbx_audit_revision_category rdf:about="{$base}/pdbx_audit_revision_category/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <PDBo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <PDBo:referenced_by_pdbx_audit_revision_category rdf:resource="{$base}/pdbx_audit_revision_category/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_revision_detailsCategory/PDBx:pdbx_audit_revision_details">
      <PDBo:has_pdbx_audit_revision_details>
      <PDBo:pdbx_audit_revision_details rdf:about="{$base}/pdbx_audit_revision_details/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <PDBo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <PDBo:referenced_by_pdbx_audit_revision_details rdf:resource="{$base}/pdbx_audit_revision_details/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_revision_groupCategory/PDBx:pdbx_audit_revision_group">
      <PDBo:has_pdbx_audit_revision_group>
      <PDBo:pdbx_audit_revision_group rdf:about="{$base}/pdbx_audit_revision_group/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <PDBo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <PDBo:referenced_by_pdbx_audit_revision_group rdf:resource="{$base}/pdbx_audit_revision_group/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_revision_historyCategory/PDBx:pdbx_audit_revision_history">
      <PDBo:has_pdbx_audit_revision_history>
      <PDBo:pdbx_audit_revision_history rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_revision_history>
      </PDBo:has_pdbx_audit_revision_history>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_revision_itemCategory/PDBx:pdbx_audit_revision_item">
      <PDBo:has_pdbx_audit_revision_item>
      <PDBo:pdbx_audit_revision_item rdf:about="{$base}/pdbx_audit_revision_item/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@data_content_type!='' and @revision_ordinal!=''">
        <PDBo:reference_to_pdbx_audit_revision_history>
	  <rdf:Description  rdf:about="{$base}/pdbx_audit_revision_history/{translate(@data_content_type,' ^','_')},{translate(@revision_ordinal,' ^','_')}">
	    <PDBo:referenced_by_pdbx_audit_revision_item rdf:resource="{$base}/pdbx_audit_revision_item/{translate(@data_content_type,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@revision_ordinal,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_audit_supportCategory/PDBx:pdbx_audit_support">
      <PDBo:has_pdbx_audit_support>
      <PDBo:pdbx_audit_support rdf:about="{$base}/pdbx_audit_support/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_audit_support>
      </PDBo:has_pdbx_audit_support>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_bond_distance_limitsCategory/PDBx:pdbx_bond_distance_limits">
      <PDBo:has_pdbx_bond_distance_limits>
      <PDBo:pdbx_bond_distance_limits rdf:about="{$base}/pdbx_bond_distance_limits/{translate(@atom_type_1,' ^','_')},{translate(@atom_type_2,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_bond_distance_limits>
      </PDBo:has_pdbx_bond_distance_limits>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_branch_schemeCategory/PDBx:pdbx_branch_scheme">
      <PDBo:has_pdbx_branch_scheme>
      <PDBo:pdbx_branch_scheme rdf:about="{$base}/pdbx_branch_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_branch_scheme rdf:resource="{$base}/pdbx_branch_scheme/{translate(@asym_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_branch_scheme>
      </PDBo:has_pdbx_branch_scheme>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_bufferCategory/PDBx:pdbx_buffer">
      <PDBo:has_pdbx_buffer>
      <PDBo:pdbx_buffer rdf:about="{$base}/pdbx_buffer/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_buffer>
      </PDBo:has_pdbx_buffer>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_buffer_componentsCategory/PDBx:pdbx_buffer_components">
      <PDBo:has_pdbx_buffer_components>
      <PDBo:pdbx_buffer_components rdf:about="{$base}/pdbx_buffer_components/{translate(@buffer_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@buffer_id!=''">
        <PDBo:reference_to_pdbx_buffer>
	  <rdf:Description  rdf:about="{$base}/pdbx_buffer/{translate(@buffer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_buffer_components rdf:resource="{$base}/pdbx_buffer_components/{translate(@buffer_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_buffer>
        <!-- pdbx_bufferKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_buffer_components>
      </PDBo:has_pdbx_buffer_components>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_atom_editCategory/PDBx:pdbx_chem_comp_atom_edit">
      <PDBo:has_pdbx_chem_comp_atom_edit>
      <PDBo:pdbx_chem_comp_atom_edit rdf:about="{$base}/pdbx_chem_comp_atom_edit/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:comp_id!=''">
        <PDBo:reference_to_pdbx_chem_comp_import>
	  <rdf:Description  rdf:about="{$base}/pdbx_chem_comp_import/{translate(PDBx:comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_atom_edit rdf:resource="{$base}/pdbx_chem_comp_atom_edit/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_chem_comp_import>
        <!-- pdbx_chem_comp_importKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_atom_edit>
      </PDBo:has_pdbx_chem_comp_atom_edit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_atom_featureCategory/PDBx:pdbx_chem_comp_atom_feature">
      <PDBo:has_pdbx_chem_comp_atom_feature>
      <PDBo:pdbx_chem_comp_atom_feature rdf:about="{$base}/pdbx_chem_comp_atom_feature/{translate(@atom_id,' ^','_')},{translate(@comp_id,' ^','_')},{translate(@feature_type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@atom_id!='' and @comp_id!=''">
        <PDBo:reference_to_chem_comp_atom>
	  <rdf:Description  rdf:about="{$base}/chem_comp_atom/{translate(@atom_id,' ^','_')},{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_atom_feature rdf:resource="{$base}/pdbx_chem_comp_atom_feature/{translate(@atom_id,' ^','_')},{translate(@comp_id,' ^','_')},{translate(@feature_type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp_atom>
        <!-- chem_comp_atomKeyref_1_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_atom_feature>
      </PDBo:has_pdbx_chem_comp_atom_feature>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_atom_relatedCategory/PDBx:pdbx_chem_comp_atom_related">
      <PDBo:has_pdbx_chem_comp_atom_related>
      <PDBo:pdbx_chem_comp_atom_related rdf:about="{$base}/pdbx_chem_comp_atom_related/{translate(@comp_id,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@related_comp_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_atom_related rdf:resource="{$base}/pdbx_chem_comp_atom_related/{translate(@comp_id,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@related_comp_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_8_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_atom_related>
      </PDBo:has_pdbx_chem_comp_atom_related>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_auditCategory/PDBx:pdbx_chem_comp_audit">
      <PDBo:has_pdbx_chem_comp_audit>
      <PDBo:pdbx_chem_comp_audit rdf:about="{$base}/pdbx_chem_comp_audit/{translate(@action_type,' ^','_')},{translate(@comp_id,' ^','_')},{translate(@date,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_audit rdf:resource="{$base}/pdbx_chem_comp_audit/{translate(@action_type,' ^','_')},{translate(@comp_id,' ^','_')},{translate(@date,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_audit>
      </PDBo:has_pdbx_chem_comp_audit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_bond_editCategory/PDBx:pdbx_chem_comp_bond_edit">
      <PDBo:has_pdbx_chem_comp_bond_edit>
      <PDBo:pdbx_chem_comp_bond_edit rdf:about="{$base}/pdbx_chem_comp_bond_edit/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@comp_id,' ^','_')},{translate(@edit_op,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_pdbx_chem_comp_import>
	  <rdf:Description  rdf:about="{$base}/pdbx_chem_comp_import/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_bond_edit rdf:resource="{$base}/pdbx_chem_comp_bond_edit/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@comp_id,' ^','_')},{translate(@edit_op,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_chem_comp_import>
        <!-- pdbx_chem_comp_importKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_bond_edit>
      </PDBo:has_pdbx_chem_comp_bond_edit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_depositor_infoCategory/PDBx:pdbx_chem_comp_depositor_info">
      <PDBo:has_pdbx_chem_comp_depositor_info>
      <PDBo:pdbx_chem_comp_depositor_info rdf:about="{$base}/pdbx_chem_comp_depositor_info/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_depositor_info>
      </PDBo:has_pdbx_chem_comp_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_descriptorCategory/PDBx:pdbx_chem_comp_descriptor">
      <PDBo:has_pdbx_chem_comp_descriptor>
      <PDBo:pdbx_chem_comp_descriptor rdf:about="{$base}/pdbx_chem_comp_descriptor/{translate(@comp_id,' ^','_')},{translate(@program,' ^','_')},{translate(@program_version,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_descriptor rdf:resource="{$base}/pdbx_chem_comp_descriptor/{translate(@comp_id,' ^','_')},{translate(@program,' ^','_')},{translate(@program_version,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_descriptor>
      </PDBo:has_pdbx_chem_comp_descriptor>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_featureCategory/PDBx:pdbx_chem_comp_feature">
      <PDBo:has_pdbx_chem_comp_feature>
      <PDBo:pdbx_chem_comp_feature rdf:about="{$base}/pdbx_chem_comp_feature/{translate(@comp_id,' ^','_')},{translate(@source,' ^','_')},{translate(@type,' ^','_')},{translate(@value,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_feature rdf:resource="{$base}/pdbx_chem_comp_feature/{translate(@comp_id,' ^','_')},{translate(@source,' ^','_')},{translate(@type,' ^','_')},{translate(@value,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_feature>
      </PDBo:has_pdbx_chem_comp_feature>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_identifierCategory/PDBx:pdbx_chem_comp_identifier">
      <PDBo:has_pdbx_chem_comp_identifier>
      <PDBo:pdbx_chem_comp_identifier rdf:about="{$base}/pdbx_chem_comp_identifier/{translate(@comp_id,' ^','_')},{translate(@program,' ^','_')},{translate(@program_version,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_identifier rdf:resource="{$base}/pdbx_chem_comp_identifier/{translate(@comp_id,' ^','_')},{translate(@program,' ^','_')},{translate(@program_version,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_12_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_identifier>
      </PDBo:has_pdbx_chem_comp_identifier>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_importCategory/PDBx:pdbx_chem_comp_import">
      <PDBo:has_pdbx_chem_comp_import>
      <PDBo:pdbx_chem_comp_import rdf:about="{$base}/pdbx_chem_comp_import/{translate(@comp_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_import rdf:resource="{$base}/pdbx_chem_comp_import/{translate(@comp_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_13_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_import>
      </PDBo:has_pdbx_chem_comp_import>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_instance_depositor_infoCategory/PDBx:pdbx_chem_comp_instance_depositor_info">
      <PDBo:has_pdbx_chem_comp_instance_depositor_info>
      <PDBo:pdbx_chem_comp_instance_depositor_info rdf:about="{$base}/pdbx_chem_comp_instance_depositor_info/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_instance_depositor_info>
      </PDBo:has_pdbx_chem_comp_instance_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_modelCategory/PDBx:pdbx_chem_comp_model">
      <PDBo:has_pdbx_chem_comp_model>
      <PDBo:pdbx_chem_comp_model rdf:about="{$base}/pdbx_chem_comp_model/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_model>
      </PDBo:has_pdbx_chem_comp_model>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_model_atomCategory/PDBx:pdbx_chem_comp_model_atom">
      <PDBo:has_pdbx_chem_comp_model_atom>
      <PDBo:pdbx_chem_comp_model_atom rdf:about="{$base}/pdbx_chem_comp_model_atom/{translate(@atom_id,' ^','_')},{translate(@model_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@model_id!=''">
        <PDBo:reference_to_pdbx_chem_comp_model>
	  <rdf:Description  rdf:about="{$base}/pdbx_chem_comp_model/{translate(@model_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_model_atom rdf:resource="{$base}/pdbx_chem_comp_model_atom/{translate(@atom_id,' ^','_')},{translate(@model_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_chem_comp_model>
        <!-- pdbx_chem_comp_modelKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_model_atom>
      </PDBo:has_pdbx_chem_comp_model_atom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_model_auditCategory/PDBx:pdbx_chem_comp_model_audit">
      <PDBo:has_pdbx_chem_comp_model_audit>
      <PDBo:pdbx_chem_comp_model_audit rdf:about="{$base}/pdbx_chem_comp_model_audit/{translate(@action_type,' ^','_')},{translate(@date,' ^','_')},{translate(@model_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_model_audit>
      </PDBo:has_pdbx_chem_comp_model_audit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_model_bondCategory/PDBx:pdbx_chem_comp_model_bond">
      <PDBo:has_pdbx_chem_comp_model_bond>
      <PDBo:pdbx_chem_comp_model_bond rdf:about="{$base}/pdbx_chem_comp_model_bond/{translate(@atom_id_1,' ^','_')},{translate(@atom_id_2,' ^','_')},{translate(@model_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_model_bond>
      </PDBo:has_pdbx_chem_comp_model_bond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_model_descriptorCategory/PDBx:pdbx_chem_comp_model_descriptor">
      <PDBo:has_pdbx_chem_comp_model_descriptor>
      <PDBo:pdbx_chem_comp_model_descriptor rdf:about="{$base}/pdbx_chem_comp_model_descriptor/{translate(@model_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@model_id!=''">
        <PDBo:reference_to_pdbx_chem_comp_model>
	  <rdf:Description  rdf:about="{$base}/pdbx_chem_comp_model/{translate(@model_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_model_descriptor rdf:resource="{$base}/pdbx_chem_comp_model_descriptor/{translate(@model_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_chem_comp_model>
        <!-- pdbx_chem_comp_modelKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_model_descriptor>
      </PDBo:has_pdbx_chem_comp_model_descriptor>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_model_featureCategory/PDBx:pdbx_chem_comp_model_feature">
      <PDBo:has_pdbx_chem_comp_model_feature>
      <PDBo:pdbx_chem_comp_model_feature rdf:about="{$base}/pdbx_chem_comp_model_feature/{translate(@feature_name,' ^','_')},{translate(@model_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@model_id!=''">
        <PDBo:reference_to_pdbx_chem_comp_model>
	  <rdf:Description  rdf:about="{$base}/pdbx_chem_comp_model/{translate(@model_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_model_feature rdf:resource="{$base}/pdbx_chem_comp_model_feature/{translate(@feature_name,' ^','_')},{translate(@model_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_chem_comp_model>
        <!-- pdbx_chem_comp_modelKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_model_feature>
      </PDBo:has_pdbx_chem_comp_model_feature>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_model_referenceCategory/PDBx:pdbx_chem_comp_model_reference">
      <PDBo:has_pdbx_chem_comp_model_reference>
      <PDBo:pdbx_chem_comp_model_reference rdf:about="{$base}/pdbx_chem_comp_model_reference/{translate(@db_code,' ^','_')},{translate(@db_name,' ^','_')},{translate(@model_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@model_id!=''">
        <PDBo:reference_to_pdbx_chem_comp_model>
	  <rdf:Description  rdf:about="{$base}/pdbx_chem_comp_model/{translate(@model_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_model_reference rdf:resource="{$base}/pdbx_chem_comp_model_reference/{translate(@db_code,' ^','_')},{translate(@db_name,' ^','_')},{translate(@model_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_chem_comp_model>
        <!-- pdbx_chem_comp_modelKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_model_reference>
      </PDBo:has_pdbx_chem_comp_model_reference>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_nonstandardCategory/PDBx:pdbx_chem_comp_nonstandard">
      <PDBo:has_pdbx_chem_comp_nonstandard>
      <PDBo:pdbx_chem_comp_nonstandard rdf:about="{$base}/pdbx_chem_comp_nonstandard/{translate(@comp_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_nonstandard rdf:resource="{$base}/pdbx_chem_comp_nonstandard/{translate(@comp_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_14_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_nonstandard>
      </PDBo:has_pdbx_chem_comp_nonstandard>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_relatedCategory/PDBx:pdbx_chem_comp_related">
      <PDBo:has_pdbx_chem_comp_related>
      <PDBo:pdbx_chem_comp_related rdf:about="{$base}/pdbx_chem_comp_related/{translate(@comp_id,' ^','_')},{translate(@related_comp_id,' ^','_')},{translate(@relationship_type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_related rdf:resource="{$base}/pdbx_chem_comp_related/{translate(@comp_id,' ^','_')},{translate(@related_comp_id,' ^','_')},{translate(@relationship_type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_15_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_related>
      </PDBo:has_pdbx_chem_comp_related>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_subcomponent_entity_listCategory/PDBx:pdbx_chem_comp_subcomponent_entity_list">
      <PDBo:has_pdbx_chem_comp_subcomponent_entity_list>
      <PDBo:pdbx_chem_comp_subcomponent_entity_list rdf:about="{$base}/pdbx_chem_comp_subcomponent_entity_list/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:parent_comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(PDBx:parent_comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_subcomponent_entity_list rdf:resource="{$base}/pdbx_chem_comp_subcomponent_entity_list/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_16_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_subcomponent_entity_list>
      </PDBo:has_pdbx_chem_comp_subcomponent_entity_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_subcomponent_struct_connCategory/PDBx:pdbx_chem_comp_subcomponent_struct_conn">
      <PDBo:has_pdbx_chem_comp_subcomponent_struct_conn>
      <PDBo:pdbx_chem_comp_subcomponent_struct_conn rdf:about="{$base}/pdbx_chem_comp_subcomponent_struct_conn/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_subcomponent_struct_conn>
      </PDBo:has_pdbx_chem_comp_subcomponent_struct_conn>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_synonymsCategory/PDBx:pdbx_chem_comp_synonyms">
      <PDBo:has_pdbx_chem_comp_synonyms>
      <PDBo:pdbx_chem_comp_synonyms rdf:about="{$base}/pdbx_chem_comp_synonyms/{translate(@comp_id,' ^','_')},{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_chem_comp_synonyms rdf:resource="{$base}/pdbx_chem_comp_synonyms/{translate(@comp_id,' ^','_')},{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_17_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_synonyms>
      </PDBo:has_pdbx_chem_comp_synonyms>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_chem_comp_upload_depositor_infoCategory/PDBx:pdbx_chem_comp_upload_depositor_info">
      <PDBo:has_pdbx_chem_comp_upload_depositor_info>
      <PDBo:pdbx_chem_comp_upload_depositor_info rdf:about="{$base}/pdbx_chem_comp_upload_depositor_info/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_chem_comp_upload_depositor_info>
      </PDBo:has_pdbx_chem_comp_upload_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_columninfoCategory/PDBx:pdbx_columninfo">
      <PDBo:has_pdbx_columninfo>
      <PDBo:pdbx_columninfo rdf:about="{$base}/pdbx_columninfo/{translate(@columnname,' ^','_')},{translate(@tablename,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_columninfo>
      </PDBo:has_pdbx_columninfo>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_connectCategory/PDBx:pdbx_connect">
      <PDBo:has_pdbx_connect>
      <PDBo:pdbx_connect rdf:about="{$base}/pdbx_connect/{translate(@res_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_connect>
      </PDBo:has_pdbx_connect>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_connect_atomCategory/PDBx:pdbx_connect_atom">
      <PDBo:has_pdbx_connect_atom>
      <PDBo:pdbx_connect_atom rdf:about="{$base}/pdbx_connect_atom/{translate(@atom_name,' ^','_')},{translate(@connect_to,' ^','_')},{translate(@res_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_connect_atom>
      </PDBo:has_pdbx_connect_atom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_connect_modificationCategory/PDBx:pdbx_connect_modification">
      <PDBo:has_pdbx_connect_modification>
      <PDBo:pdbx_connect_modification rdf:about="{$base}/pdbx_connect_modification/{translate(@res_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_connect_modification>
      </PDBo:has_pdbx_connect_modification>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_connect_typeCategory/PDBx:pdbx_connect_type">
      <PDBo:has_pdbx_connect_type>
      <PDBo:pdbx_connect_type rdf:about="{$base}/pdbx_connect_type/{translate(@res_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_connect_type>
      </PDBo:has_pdbx_connect_type>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_constructCategory/PDBx:pdbx_construct">
      <PDBo:has_pdbx_construct>
      <PDBo:pdbx_construct rdf:about="{$base}/pdbx_construct/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBx:entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_construct rdf:resource="{$base}/pdbx_construct/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_30_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_construct>
      </PDBo:has_pdbx_construct>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_construct_featureCategory/PDBx:pdbx_construct_feature">
      <PDBo:has_pdbx_construct_feature>
      <PDBo:pdbx_construct_feature rdf:about="{$base}/pdbx_construct_feature/{translate(@construct_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBx:entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_construct_feature rdf:resource="{$base}/pdbx_construct_feature/{translate(@construct_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_31_0 -->
      </xsl:if>
      <xsl:if test="@construct_id!=''">
        <PDBo:reference_to_pdbx_construct>
	  <rdf:Description  rdf:about="{$base}/pdbx_construct/{translate(@construct_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_construct_feature rdf:resource="{$base}/pdbx_construct_feature/{translate(@construct_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_construct>
        <!-- pdbx_constructKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_construct_feature>
      </PDBo:has_pdbx_construct_feature>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_contact_authorCategory/PDBx:pdbx_contact_author">
      <PDBo:has_pdbx_contact_author>
      <PDBo:pdbx_contact_author rdf:about="{$base}/pdbx_contact_author/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_contact_author>
      </PDBo:has_pdbx_contact_author>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_coordCategory/PDBx:pdbx_coord">
      <PDBo:has_pdbx_coord>
      <PDBo:pdbx_coord rdf:about="{$base}/pdbx_coord/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_coord rdf:resource="{$base}/pdbx_coord/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_32_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_coord>
      </PDBo:has_pdbx_coord>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_coordinate_modelCategory/PDBx:pdbx_coordinate_model">
      <PDBo:has_pdbx_coordinate_model>
      <PDBo:pdbx_coordinate_model rdf:about="{$base}/pdbx_coordinate_model/{translate(@asym_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
        <PDBo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_coordinate_model rdf:resource="{$base}/pdbx_coordinate_model/{translate(@asym_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_asym>
        <!-- struct_asymKeyref_1_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_coordinate_model>
      </PDBo:has_pdbx_coordinate_model>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_crystal_alignmentCategory/PDBx:pdbx_crystal_alignment">
      <PDBo:has_pdbx_crystal_alignment>
      <PDBo:pdbx_crystal_alignment rdf:about="{$base}/pdbx_crystal_alignment/{translate(@crystal_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_crystal_alignment>
      </PDBo:has_pdbx_crystal_alignment>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_data_processing_cellCategory/PDBx:pdbx_data_processing_cell">
      <PDBo:has_pdbx_data_processing_cell>
      <PDBo:pdbx_data_processing_cell rdf:about="{$base}/pdbx_data_processing_cell/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_data_processing_cell rdf:resource="{$base}/pdbx_data_processing_cell/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_33_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_data_processing_cell>
      </PDBo:has_pdbx_data_processing_cell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_data_processing_detectorCategory/PDBx:pdbx_data_processing_detector">
      <PDBo:has_pdbx_data_processing_detector>
      <PDBo:pdbx_data_processing_detector rdf:about="{$base}/pdbx_data_processing_detector/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_data_processing_detector rdf:resource="{$base}/pdbx_data_processing_detector/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_34_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_data_processing_detector>
      </PDBo:has_pdbx_data_processing_detector>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_data_processing_reflnsCategory/PDBx:pdbx_data_processing_reflns">
      <PDBo:has_pdbx_data_processing_reflns>
      <PDBo:pdbx_data_processing_reflns rdf:about="{$base}/pdbx_data_processing_reflns/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_data_processing_reflns rdf:resource="{$base}/pdbx_data_processing_reflns/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_35_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_data_processing_reflns>
      </PDBo:has_pdbx_data_processing_reflns>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_data_processing_statusCategory/PDBx:pdbx_data_processing_status">
      <PDBo:has_pdbx_data_processing_status>
      <PDBo:pdbx_data_processing_status rdf:about="{$base}/pdbx_data_processing_status/{translate(@status,' ^','_')},{translate(@task_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_data_processing_status>
      </PDBo:has_pdbx_data_processing_status>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_PDB_masterCategory/PDBx:pdbx_database_PDB_master">
      <PDBo:has_pdbx_database_PDB_master>
      <PDBo:pdbx_database_PDB_master rdf:about="{$base}/pdbx_database_PDB_master/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_database_PDB_master rdf:resource="{$base}/pdbx_database_PDB_master/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_36_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_PDB_master>
      </PDBo:has_pdbx_database_PDB_master>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_PDB_obs_sprCategory/PDBx:pdbx_database_PDB_obs_spr">
      <PDBo:has_pdbx_database_PDB_obs_spr>
      <PDBo:pdbx_database_PDB_obs_spr rdf:about="{$base}/pdbx_database_PDB_obs_spr/{translate(@pdb_id,' ^','_')},{translate(@replace_pdb_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_PDB_obs_spr>
      </PDBo:has_pdbx_database_PDB_obs_spr>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_doiCategory/PDBx:pdbx_database_doi">
      <PDBo:has_pdbx_database_doi>
      <PDBo:pdbx_database_doi rdf:about="{$base}/pdbx_database_doi/{translate(@db_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_doi>
      </PDBo:has_pdbx_database_doi>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_messageCategory/PDBx:pdbx_database_message">
      <PDBo:has_pdbx_database_message>
      <PDBo:pdbx_database_message rdf:about="{$base}/pdbx_database_message/{translate(@entry_id,' ^','_')},{translate(@message_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_database_message rdf:resource="{$base}/pdbx_database_message/{translate(@entry_id,' ^','_')},{translate(@message_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_37_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_message>
      </PDBo:has_pdbx_database_message>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_pdb_omitCategory/PDBx:pdbx_database_pdb_omit">
      <PDBo:has_pdbx_database_pdb_omit>
      <PDBo:pdbx_database_pdb_omit rdf:about="{$base}/pdbx_database_pdb_omit/{translate(@entry_id,' ^','_')},{translate(@record_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_pdb_omit>
      </PDBo:has_pdbx_database_pdb_omit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_procCategory/PDBx:pdbx_database_proc">
      <PDBo:has_pdbx_database_proc>
      <PDBo:pdbx_database_proc rdf:about="{$base}/pdbx_database_proc/{translate(@cycle_id,' ^','_')},{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_database_proc rdf:resource="{$base}/pdbx_database_proc/{translate(@cycle_id,' ^','_')},{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_38_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_proc>
      </PDBo:has_pdbx_database_proc>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_relatedCategory/PDBx:pdbx_database_related">
      <PDBo:has_pdbx_database_related>
      <PDBo:pdbx_database_related rdf:about="{$base}/pdbx_database_related/{translate(@content_type,' ^','_')},{translate(@db_id,' ^','_')},{translate(@db_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_related>
      </PDBo:has_pdbx_database_related>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_remarkCategory/PDBx:pdbx_database_remark">
      <PDBo:has_pdbx_database_remark>
      <PDBo:pdbx_database_remark rdf:about="{$base}/pdbx_database_remark/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_remark>
      </PDBo:has_pdbx_database_remark>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_statusCategory/PDBx:pdbx_database_status">
      <PDBo:has_pdbx_database_status>
      <PDBo:pdbx_database_status rdf:about="{$base}/pdbx_database_status/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_database_status rdf:resource="{$base}/pdbx_database_status/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_39_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_status>
      </PDBo:has_pdbx_database_status>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_database_status_historyCategory/PDBx:pdbx_database_status_history">
      <PDBo:has_pdbx_database_status_history>
      <PDBo:pdbx_database_status_history rdf:about="{$base}/pdbx_database_status_history/{translate(@entry_id,' ^','_')},{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_database_status_history rdf:resource="{$base}/pdbx_database_status_history/{translate(@entry_id,' ^','_')},{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_40_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_database_status_history>
      </PDBo:has_pdbx_database_status_history>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_dbrefCategory/PDBx:pdbx_dbref">
      <PDBo:has_pdbx_dbref>
      <PDBo:pdbx_dbref rdf:about="{$base}/pdbx_dbref/{translate(@begin_res_number,' ^','_')},{translate(@chain_id,' ^','_')},{translate(@database_name,' ^','_')},{translate(@end_res_number,' ^','_')},{translate(@pdb_id_code,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dbref>
      </PDBo:has_pdbx_dbref>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_dcc_densityCategory/PDBx:pdbx_dcc_density">
      <PDBo:has_pdbx_dcc_density>
      <PDBo:pdbx_dcc_density rdf:about="{$base}/pdbx_dcc_density/{translate(@pdbid,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_density>
      </PDBo:has_pdbx_dcc_density>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_dcc_density_corrCategory/PDBx:pdbx_dcc_density_corr">
      <PDBo:has_pdbx_dcc_density_corr>
      <PDBo:pdbx_dcc_density_corr rdf:about="{$base}/pdbx_dcc_density_corr/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_density_corr>
      </PDBo:has_pdbx_dcc_density_corr>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_dcc_geometryCategory/PDBx:pdbx_dcc_geometry">
      <PDBo:has_pdbx_dcc_geometry>
      <PDBo:pdbx_dcc_geometry rdf:about="{$base}/pdbx_dcc_geometry/{translate(@pdbid,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_geometry>
      </PDBo:has_pdbx_dcc_geometry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_dcc_mapCategory/PDBx:pdbx_dcc_map">
      <PDBo:has_pdbx_dcc_map>
      <PDBo:pdbx_dcc_map rdf:about="{$base}/pdbx_dcc_map/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_map>
      </PDBo:has_pdbx_dcc_map>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_dcc_mapmanCategory/PDBx:pdbx_dcc_mapman">
      <PDBo:has_pdbx_dcc_mapman>
      <PDBo:pdbx_dcc_mapman rdf:about="{$base}/pdbx_dcc_mapman/{translate(@pdbid,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_mapman>
      </PDBo:has_pdbx_dcc_mapman>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_dcc_rscc_mapmanCategory/PDBx:pdbx_dcc_rscc_mapman">
      <PDBo:has_pdbx_dcc_rscc_mapman>
      <PDBo:pdbx_dcc_rscc_mapman rdf:about="{$base}/pdbx_dcc_rscc_mapman/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_rscc_mapman>
      </PDBo:has_pdbx_dcc_rscc_mapman>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_dcc_rscc_mapman_overallCategory/PDBx:pdbx_dcc_rscc_mapman_overall">
      <PDBo:has_pdbx_dcc_rscc_mapman_overall>
      <PDBo:pdbx_dcc_rscc_mapman_overall rdf:about="{$base}/pdbx_dcc_rscc_mapman_overall/{translate(@pdbid,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_dcc_rscc_mapman_overall>
      </PDBo:has_pdbx_dcc_rscc_mapman_overall>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_deposit_groupCategory/PDBx:pdbx_deposit_group">
      <PDBo:has_pdbx_deposit_group>
      <PDBo:pdbx_deposit_group rdf:about="{$base}/pdbx_deposit_group/{translate(@group_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_deposit_group>
      </PDBo:has_pdbx_deposit_group>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_deposit_group_indexCategory/PDBx:pdbx_deposit_group_index">
      <PDBo:has_pdbx_deposit_group_index>
      <PDBo:pdbx_deposit_group_index rdf:about="{$base}/pdbx_deposit_group_index/{translate(@group_id,' ^','_')},{translate(@ordinal_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@group_id!=''">
        <PDBo:reference_to_pdbx_deposit_group>
	  <rdf:Description  rdf:about="{$base}/pdbx_deposit_group/{translate(@group_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_deposit_group_index rdf:resource="{$base}/pdbx_deposit_group_index/{translate(@group_id,' ^','_')},{translate(@ordinal_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_deposit_group>
        <!-- pdbx_deposit_groupKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_deposit_group_index>
      </PDBo:has_pdbx_deposit_group_index>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_deposition_message_file_referenceCategory/PDBx:pdbx_deposition_message_file_reference">
      <PDBo:has_pdbx_deposition_message_file_reference>
      <PDBo:pdbx_deposition_message_file_reference rdf:about="{$base}/pdbx_deposition_message_file_reference/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_deposition_message_file_reference>
      </PDBo:has_pdbx_deposition_message_file_reference>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_deposition_message_infoCategory/PDBx:pdbx_deposition_message_info">
      <PDBo:has_pdbx_deposition_message_info>
      <PDBo:pdbx_deposition_message_info rdf:about="{$base}/pdbx_deposition_message_info/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_deposition_message_info>
      </PDBo:has_pdbx_deposition_message_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_depui_entity_featuresCategory/PDBx:pdbx_depui_entity_features">
      <PDBo:has_pdbx_depui_entity_features>
      <PDBo:pdbx_depui_entity_features rdf:about="{$base}/pdbx_depui_entity_features/{translate(@dep_dataset_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_depui_entity_features>
      </PDBo:has_pdbx_depui_entity_features>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_depui_entity_status_flagsCategory/PDBx:pdbx_depui_entity_status_flags">
      <PDBo:has_pdbx_depui_entity_status_flags>
      <PDBo:pdbx_depui_entity_status_flags rdf:about="{$base}/pdbx_depui_entity_status_flags/{translate(@dep_dataset_id,' ^','_')},{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_depui_entity_status_flags>
      </PDBo:has_pdbx_depui_entity_status_flags>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_depui_entry_detailsCategory/PDBx:pdbx_depui_entry_details">
      <PDBo:has_pdbx_depui_entry_details>
      <PDBo:pdbx_depui_entry_details rdf:about="{$base}/pdbx_depui_entry_details/{translate(@dep_dataset_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_depui_entry_details>
      </PDBo:has_pdbx_depui_entry_details>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_depui_status_flagsCategory/PDBx:pdbx_depui_status_flags">
      <PDBo:has_pdbx_depui_status_flags>
      <PDBo:pdbx_depui_status_flags rdf:about="{$base}/pdbx_depui_status_flags/{translate(@dep_dataset_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_depui_status_flags>
      </PDBo:has_pdbx_depui_status_flags>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_depui_uploadCategory/PDBx:pdbx_depui_upload">
      <PDBo:has_pdbx_depui_upload>
      <PDBo:pdbx_depui_upload rdf:about="{$base}/pdbx_depui_upload/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_depui_upload>
      </PDBo:has_pdbx_depui_upload>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_depui_validation_status_flagsCategory/PDBx:pdbx_depui_validation_status_flags">
      <PDBo:has_pdbx_depui_validation_status_flags>
      <PDBo:pdbx_depui_validation_status_flags rdf:about="{$base}/pdbx_depui_validation_status_flags/{translate(@dep_dataset_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_depui_validation_status_flags>
      </PDBo:has_pdbx_depui_validation_status_flags>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_diffrn_reflns_shellCategory/PDBx:pdbx_diffrn_reflns_shell">
      <PDBo:has_pdbx_diffrn_reflns_shell>
      <PDBo:pdbx_diffrn_reflns_shell rdf:about="{$base}/pdbx_diffrn_reflns_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_diffrn_reflns_shell rdf:resource="{$base}/pdbx_diffrn_reflns_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@diffrn_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_distant_solvent_atomsCategory/PDBx:pdbx_distant_solvent_atoms">
      <PDBo:has_pdbx_distant_solvent_atoms>
      <PDBo:pdbx_distant_solvent_atoms rdf:about="{$base}/pdbx_distant_solvent_atoms/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:auth_comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(PDBx:auth_comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_distant_solvent_atoms rdf:resource="{$base}/pdbx_distant_solvent_atoms/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_18_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_distant_solvent_atoms>
      </PDBo:has_pdbx_distant_solvent_atoms>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_domainCategory/PDBx:pdbx_domain">
      <PDBo:has_pdbx_domain>
      <PDBo:pdbx_domain rdf:about="{$base}/pdbx_domain/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_domain>
      </PDBo:has_pdbx_domain>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_domain_rangeCategory/PDBx:pdbx_domain_range">
      <PDBo:has_pdbx_domain_range>
      <PDBo:pdbx_domain_range rdf:about="{$base}/pdbx_domain_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@domain_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@domain_id!=''">
        <PDBo:reference_to_pdbx_domain>
	  <rdf:Description  rdf:about="{$base}/pdbx_domain/{translate(@domain_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_domain_range rdf:resource="{$base}/pdbx_domain_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@domain_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_drug_infoCategory/PDBx:pdbx_drug_info">
      <PDBo:has_pdbx_drug_info>
      <PDBo:pdbx_drug_info rdf:about="{$base}/pdbx_drug_info/{translate(@id,' ^','_')},{translate(@name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_drug_info>
      </PDBo:has_pdbx_drug_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_assemblyCategory/PDBx:pdbx_entity_assembly">
      <PDBo:has_pdbx_entity_assembly>
      <PDBo:pdbx_entity_assembly rdf:about="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_assembly rdf:resource="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_9_0 -->
      </xsl:if>
      <xsl:if test="PDBx:biol_id!=''">
        <PDBo:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(PDBx:biol_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_assembly rdf:resource="{$base}/pdbx_entity_assembly/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_branchCategory/PDBx:pdbx_entity_branch">
      <PDBo:has_pdbx_entity_branch>
      <PDBo:pdbx_entity_branch rdf:about="{$base}/pdbx_entity_branch/{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_branch rdf:resource="{$base}/pdbx_entity_branch/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_10_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_branch>
      </PDBo:has_pdbx_entity_branch>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_branch_descriptorCategory/PDBx:pdbx_entity_branch_descriptor">
      <PDBo:has_pdbx_entity_branch_descriptor>
      <PDBo:pdbx_entity_branch_descriptor rdf:about="{$base}/pdbx_entity_branch_descriptor/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBx:entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_branch_descriptor rdf:resource="{$base}/pdbx_entity_branch_descriptor/{translate(@ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_branch_descriptor>
      </PDBo:has_pdbx_entity_branch_descriptor>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_branch_linkCategory/PDBx:pdbx_entity_branch_link">
      <PDBo:has_pdbx_entity_branch_link>
      <PDBo:pdbx_entity_branch_link rdf:about="{$base}/pdbx_entity_branch_link/{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:atom_id_1!='' and PDBx:leaving_atom_id_1!=''">
        <PDBo:reference_to_chem_comp_atom>
	  <rdf:Description  rdf:about="{$base}/chem_comp_atom/{translate(PDBx:atom_id_1,' ^','_')},{translate(PDBx:leaving_atom_id_1,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_branch_link rdf:resource="{$base}/pdbx_entity_branch_link/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp_atom>
        <!-- chem_comp_atomKeyref_3_0_0_0 -->
      </xsl:if>
      <xsl:if test="PDBx:atom_id_2!='' and PDBx:leaving_atom_id_2!=''">
        <PDBo:reference_to_chem_comp_atom>
	  <rdf:Description  rdf:about="{$base}/chem_comp_atom/{translate(PDBx:atom_id_2,' ^','_')},{translate(PDBx:leaving_atom_id_2,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_branch_link rdf:resource="{$base}/pdbx_entity_branch_link/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp_atom>
        <!-- chem_comp_atomKeyref_3_0_0_1 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_branch_link>
      </PDBo:has_pdbx_entity_branch_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_branch_listCategory/PDBx:pdbx_entity_branch_list">
      <PDBo:has_pdbx_entity_branch_list>
      <PDBo:pdbx_entity_branch_list rdf:about="{$base}/pdbx_entity_branch_list/{translate(@comp_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@num,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(@comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_branch_list rdf:resource="{$base}/pdbx_entity_branch_list/{translate(@comp_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_19_0 -->
      </xsl:if>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_branch_list rdf:resource="{$base}/pdbx_entity_branch_list/{translate(@comp_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@num,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_12_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_branch_list>
      </PDBo:has_pdbx_entity_branch_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_func_bind_modeCategory/PDBx:pdbx_entity_func_bind_mode">
      <PDBo:has_pdbx_entity_func_bind_mode>
      <PDBo:pdbx_entity_func_bind_mode rdf:about="{$base}/pdbx_entity_func_bind_mode/{translate(@domain_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_func_bind_mode rdf:resource="{$base}/pdbx_entity_func_bind_mode/{translate(@domain_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_13_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_func_bind_mode>
      </PDBo:has_pdbx_entity_func_bind_mode>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_func_enzymeCategory/PDBx:pdbx_entity_func_enzyme">
      <PDBo:has_pdbx_entity_func_enzyme>
      <PDBo:pdbx_entity_func_enzyme rdf:about="{$base}/pdbx_entity_func_enzyme/{translate(@bind_mode_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_func_enzyme>
      </PDBo:has_pdbx_entity_func_enzyme>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_func_otherCategory/PDBx:pdbx_entity_func_other">
      <PDBo:has_pdbx_entity_func_other>
      <PDBo:pdbx_entity_func_other rdf:about="{$base}/pdbx_entity_func_other/{translate(@bind_mode_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_func_other>
      </PDBo:has_pdbx_entity_func_other>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_func_regulatoryCategory/PDBx:pdbx_entity_func_regulatory">
      <PDBo:has_pdbx_entity_func_regulatory>
      <PDBo:pdbx_entity_func_regulatory rdf:about="{$base}/pdbx_entity_func_regulatory/{translate(@bind_mode_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_func_regulatory>
      </PDBo:has_pdbx_entity_func_regulatory>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_func_structuralCategory/PDBx:pdbx_entity_func_structural">
      <PDBo:has_pdbx_entity_func_structural>
      <PDBo:pdbx_entity_func_structural rdf:about="{$base}/pdbx_entity_func_structural/{translate(@bind_mode_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_func_structural>
      </PDBo:has_pdbx_entity_func_structural>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_instance_featureCategory/PDBx:pdbx_entity_instance_feature">
      <PDBo:has_pdbx_entity_instance_feature>
      <PDBo:pdbx_entity_instance_feature rdf:about="{$base}/pdbx_entity_instance_feature/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_instance_feature>
      </PDBo:has_pdbx_entity_instance_feature>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_nameCategory/PDBx:pdbx_entity_name">
      <PDBo:has_pdbx_entity_name>
      <PDBo:pdbx_entity_name rdf:about="{$base}/pdbx_entity_name/{translate(@entity_id,' ^','_')},{translate(@name,' ^','_')},{translate(@name_type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_name rdf:resource="{$base}/pdbx_entity_name/{translate(@entity_id,' ^','_')},{translate(@name,' ^','_')},{translate(@name_type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_14_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_name>
      </PDBo:has_pdbx_entity_name>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_name_instanceCategory/PDBx:pdbx_entity_name_instance">
      <PDBo:has_pdbx_entity_name_instance>
      <PDBo:pdbx_entity_name_instance rdf:about="{$base}/pdbx_entity_name_instance/{translate(@entity_id,' ^','_')},{translate(@name,' ^','_')},{translate(@pdb_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_name_instance>
      </PDBo:has_pdbx_entity_name_instance>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_name_taxonomyCategory/PDBx:pdbx_entity_name_taxonomy">
      <PDBo:has_pdbx_entity_name_taxonomy>
      <PDBo:pdbx_entity_name_taxonomy rdf:about="{$base}/pdbx_entity_name_taxonomy/{translate(@id,' ^','_')},{translate(@name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_name_taxonomy>
      </PDBo:has_pdbx_entity_name_taxonomy>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_name_taxonomy_treeCategory/PDBx:pdbx_entity_name_taxonomy_tree">
      <PDBo:has_pdbx_entity_name_taxonomy_tree>
      <PDBo:pdbx_entity_name_taxonomy_tree rdf:about="{$base}/pdbx_entity_name_taxonomy_tree/{translate(@id,' ^','_')},{translate(@parent_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_name_taxonomy_tree>
      </PDBo:has_pdbx_entity_name_taxonomy_tree>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_nonpolyCategory/PDBx:pdbx_entity_nonpoly">
      <PDBo:has_pdbx_entity_nonpoly>
      <PDBo:pdbx_entity_nonpoly rdf:about="{$base}/pdbx_entity_nonpoly/{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_nonpoly rdf:resource="{$base}/pdbx_entity_nonpoly/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_15_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_nonpoly>
      </PDBo:has_pdbx_entity_nonpoly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_poly_comp_link_listCategory/PDBx:pdbx_entity_poly_comp_link_list">
      <PDBo:has_pdbx_entity_poly_comp_link_list>
      <PDBo:pdbx_entity_poly_comp_link_list rdf:about="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entity_id!='' and PDBx:comp_id_1!='' and PDBx:entity_comp_num_1!=''">
        <PDBo:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(PDBx:entity_id,' ^','_')},{translate(PDBx:comp_id_1,' ^','_')},{translate(PDBx:entity_comp_num_1,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_poly_comp_link_list rdf:resource="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="PDBx:entity_id!='' and PDBx:comp_id_1!='' and PDBx:entity_comp_num_1!=''">
        <PDBo:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(PDBx:entity_id,' ^','_')},{translate(PDBx:comp_id_1,' ^','_')},{translate(PDBx:entity_comp_num_1,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_poly_comp_link_list rdf:resource="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_2_0_0_0 -->
      </xsl:if>
      <xsl:if test="PDBx:entity_id!='' and PDBx:comp_id_1!='' and PDBx:entity_comp_num_1!=''">
        <PDBo:reference_to_entity_poly_seq>
	  <rdf:Description  rdf:about="{$base}/entity_poly_seq/{translate(PDBx:entity_id,' ^','_')},{translate(PDBx:comp_id_1,' ^','_')},{translate(PDBx:entity_comp_num_1,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_poly_comp_link_list rdf:resource="{$base}/pdbx_entity_poly_comp_link_list/{translate(@link_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity_poly_seq>
        <!-- entity_poly_seqKeyref_4_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_poly_comp_link_list>
      </PDBo:has_pdbx_entity_poly_comp_link_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_poly_domainCategory/PDBx:pdbx_entity_poly_domain">
      <PDBo:has_pdbx_entity_poly_domain>
      <PDBo:pdbx_entity_poly_domain rdf:about="{$base}/pdbx_entity_poly_domain/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_poly_domain rdf:resource="{$base}/pdbx_entity_poly_domain/{translate(@entity_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_16_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_poly_domain>
      </PDBo:has_pdbx_entity_poly_domain>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_poly_na_nonstandardCategory/PDBx:pdbx_entity_poly_na_nonstandard">
      <PDBo:has_pdbx_entity_poly_na_nonstandard>
      <PDBo:pdbx_entity_poly_na_nonstandard rdf:about="{$base}/pdbx_entity_poly_na_nonstandard/{translate(@entity_id,' ^','_')},{translate(@feature,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_poly_na_nonstandard rdf:resource="{$base}/pdbx_entity_poly_na_nonstandard/{translate(@entity_id,' ^','_')},{translate(@feature,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_17_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_poly_na_nonstandard>
      </PDBo:has_pdbx_entity_poly_na_nonstandard>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_poly_na_typeCategory/PDBx:pdbx_entity_poly_na_type">
      <PDBo:has_pdbx_entity_poly_na_type>
      <PDBo:pdbx_entity_poly_na_type rdf:about="{$base}/pdbx_entity_poly_na_type/{translate(@entity_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_poly_na_type rdf:resource="{$base}/pdbx_entity_poly_na_type/{translate(@entity_id,' ^','_')},{translate(@type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_18_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_poly_na_type>
      </PDBo:has_pdbx_entity_poly_na_type>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_poly_protein_classCategory/PDBx:pdbx_entity_poly_protein_class">
      <PDBo:has_pdbx_entity_poly_protein_class>
      <PDBo:pdbx_entity_poly_protein_class rdf:about="{$base}/pdbx_entity_poly_protein_class/{translate(@class,' ^','_')},{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_poly_protein_class rdf:resource="{$base}/pdbx_entity_poly_protein_class/{translate(@class,' ^','_')},{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_19_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_poly_protein_class>
      </PDBo:has_pdbx_entity_poly_protein_class>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_prod_protocolCategory/PDBx:pdbx_entity_prod_protocol">
      <PDBo:has_pdbx_entity_prod_protocol>
      <PDBo:pdbx_entity_prod_protocol rdf:about="{$base}/pdbx_entity_prod_protocol/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@protocol_type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_prod_protocol rdf:resource="{$base}/pdbx_entity_prod_protocol/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@protocol_type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_20_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_prod_protocol rdf:resource="{$base}/pdbx_entity_prod_protocol/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@protocol_type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_41_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_prod_protocol>
      </PDBo:has_pdbx_entity_prod_protocol>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_characterCategory/PDBx:pdbx_entity_src_gen_character">
      <PDBo:has_pdbx_entity_src_gen_character>
      <PDBo:pdbx_entity_src_gen_character rdf:about="{$base}/pdbx_entity_src_gen_character/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_character rdf:resource="{$base}/pdbx_entity_src_gen_character/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_21_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_character rdf:resource="{$base}/pdbx_entity_src_gen_character/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_42_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_character>
      </PDBo:has_pdbx_entity_src_gen_character>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_chromCategory/PDBx:pdbx_entity_src_gen_chrom">
      <PDBo:has_pdbx_entity_src_gen_chrom>
      <PDBo:pdbx_entity_src_gen_chrom rdf:about="{$base}/pdbx_entity_src_gen_chrom/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_chrom rdf:resource="{$base}/pdbx_entity_src_gen_chrom/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_22_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_chrom rdf:resource="{$base}/pdbx_entity_src_gen_chrom/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_43_0 -->
      </xsl:if>
      <xsl:if test="PDBx:elution_buffer_id!=''">
        <PDBo:reference_to_pdbx_buffer>
	  <rdf:Description  rdf:about="{$base}/pdbx_buffer/{translate(PDBx:elution_buffer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_chrom rdf:resource="{$base}/pdbx_entity_src_gen_chrom/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_buffer>
        <!-- pdbx_bufferKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="PDBx:equilibration_buffer_id!=''">
        <PDBo:reference_to_pdbx_buffer>
	  <rdf:Description  rdf:about="{$base}/pdbx_buffer/{translate(PDBx:equilibration_buffer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_chrom rdf:resource="{$base}/pdbx_entity_src_gen_chrom/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_buffer>
        <!-- pdbx_bufferKeyref_0_0_1_1 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_chrom>
      </PDBo:has_pdbx_entity_src_gen_chrom>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_cloneCategory/PDBx:pdbx_entity_src_gen_clone">
      <PDBo:has_pdbx_entity_src_gen_clone>
      <PDBo:pdbx_entity_src_gen_clone rdf:about="{$base}/pdbx_entity_src_gen_clone/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_clone rdf:resource="{$base}/pdbx_entity_src_gen_clone/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_23_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_clone rdf:resource="{$base}/pdbx_entity_src_gen_clone/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_44_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_clone>
      </PDBo:has_pdbx_entity_src_gen_clone>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_clone_ligationCategory/PDBx:pdbx_entity_src_gen_clone_ligation">
      <PDBo:has_pdbx_entity_src_gen_clone_ligation>
      <PDBo:pdbx_entity_src_gen_clone_ligation rdf:about="{$base}/pdbx_entity_src_gen_clone_ligation/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!='' and @entry_id!='' and @step_id!=''">
        <PDBo:reference_to_pdbx_entity_src_gen_clone>
	  <rdf:Description  rdf:about="{$base}/pdbx_entity_src_gen_clone/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_clone_ligation rdf:resource="{$base}/pdbx_entity_src_gen_clone_ligation/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_entity_src_gen_clone>
        <!-- pdbx_entity_src_gen_cloneKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_clone_ligation>
      </PDBo:has_pdbx_entity_src_gen_clone_ligation>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_clone_recombinationCategory/PDBx:pdbx_entity_src_gen_clone_recombination">
      <PDBo:has_pdbx_entity_src_gen_clone_recombination>
      <PDBo:pdbx_entity_src_gen_clone_recombination rdf:about="{$base}/pdbx_entity_src_gen_clone_recombination/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!='' and @entry_id!='' and @step_id!=''">
        <PDBo:reference_to_pdbx_entity_src_gen_clone>
	  <rdf:Description  rdf:about="{$base}/pdbx_entity_src_gen_clone/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_clone_recombination rdf:resource="{$base}/pdbx_entity_src_gen_clone_recombination/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_entity_src_gen_clone>
        <!-- pdbx_entity_src_gen_cloneKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_clone_recombination>
      </PDBo:has_pdbx_entity_src_gen_clone_recombination>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_depositor_infoCategory/PDBx:pdbx_entity_src_gen_depositor_info">
      <PDBo:has_pdbx_entity_src_gen_depositor_info>
      <PDBo:pdbx_entity_src_gen_depositor_info rdf:about="{$base}/pdbx_entity_src_gen_depositor_info/{translate(@src_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_depositor_info>
      </PDBo:has_pdbx_entity_src_gen_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_expressCategory/PDBx:pdbx_entity_src_gen_express">
      <PDBo:has_pdbx_entity_src_gen_express>
      <PDBo:pdbx_entity_src_gen_express rdf:about="{$base}/pdbx_entity_src_gen_express/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_express rdf:resource="{$base}/pdbx_entity_src_gen_express/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_24_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_express rdf:resource="{$base}/pdbx_entity_src_gen_express/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_45_0 -->
      </xsl:if>
      <xsl:if test="PDBx:plasmid_id!=''">
        <PDBo:reference_to_pdbx_construct>
	  <rdf:Description  rdf:about="{$base}/pdbx_construct/{translate(PDBx:plasmid_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_express rdf:resource="{$base}/pdbx_entity_src_gen_express/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_construct>
        <!-- pdbx_constructKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_express>
      </PDBo:has_pdbx_entity_src_gen_express>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_express_timepointCategory/PDBx:pdbx_entity_src_gen_express_timepoint">
      <PDBo:has_pdbx_entity_src_gen_express_timepoint>
      <PDBo:pdbx_entity_src_gen_express_timepoint rdf:about="{$base}/pdbx_entity_src_gen_express_timepoint/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@serial,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!='' and @entry_id!='' and @step_id!=''">
        <PDBo:reference_to_pdbx_entity_src_gen_express>
	  <rdf:Description  rdf:about="{$base}/pdbx_entity_src_gen_express/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_express_timepoint rdf:resource="{$base}/pdbx_entity_src_gen_express_timepoint/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@serial,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_entity_src_gen_express>
        <!-- pdbx_entity_src_gen_expressKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_express_timepoint>
      </PDBo:has_pdbx_entity_src_gen_express_timepoint>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_fractCategory/PDBx:pdbx_entity_src_gen_fract">
      <PDBo:has_pdbx_entity_src_gen_fract>
      <PDBo:pdbx_entity_src_gen_fract rdf:about="{$base}/pdbx_entity_src_gen_fract/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_fract rdf:resource="{$base}/pdbx_entity_src_gen_fract/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_25_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_fract rdf:resource="{$base}/pdbx_entity_src_gen_fract/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_46_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_fract>
      </PDBo:has_pdbx_entity_src_gen_fract>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_lysisCategory/PDBx:pdbx_entity_src_gen_lysis">
      <PDBo:has_pdbx_entity_src_gen_lysis>
      <PDBo:pdbx_entity_src_gen_lysis rdf:about="{$base}/pdbx_entity_src_gen_lysis/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_lysis rdf:resource="{$base}/pdbx_entity_src_gen_lysis/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_26_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_lysis rdf:resource="{$base}/pdbx_entity_src_gen_lysis/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_47_0 -->
      </xsl:if>
      <xsl:if test="PDBx:buffer_id!=''">
        <PDBo:reference_to_pdbx_buffer>
	  <rdf:Description  rdf:about="{$base}/pdbx_buffer/{translate(PDBx:buffer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_lysis rdf:resource="{$base}/pdbx_entity_src_gen_lysis/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_buffer>
        <!-- pdbx_bufferKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_lysis>
      </PDBo:has_pdbx_entity_src_gen_lysis>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_prod_digestCategory/PDBx:pdbx_entity_src_gen_prod_digest">
      <PDBo:has_pdbx_entity_src_gen_prod_digest>
      <PDBo:pdbx_entity_src_gen_prod_digest rdf:about="{$base}/pdbx_entity_src_gen_prod_digest/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_digest rdf:resource="{$base}/pdbx_entity_src_gen_prod_digest/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_27_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_digest rdf:resource="{$base}/pdbx_entity_src_gen_prod_digest/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_48_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_prod_digest>
      </PDBo:has_pdbx_entity_src_gen_prod_digest>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_prod_otherCategory/PDBx:pdbx_entity_src_gen_prod_other">
      <PDBo:has_pdbx_entity_src_gen_prod_other>
      <PDBo:pdbx_entity_src_gen_prod_other rdf:about="{$base}/pdbx_entity_src_gen_prod_other/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_other rdf:resource="{$base}/pdbx_entity_src_gen_prod_other/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_28_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_other rdf:resource="{$base}/pdbx_entity_src_gen_prod_other/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_49_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_prod_other>
      </PDBo:has_pdbx_entity_src_gen_prod_other>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_prod_other_parameterCategory/PDBx:pdbx_entity_src_gen_prod_other_parameter">
      <PDBo:has_pdbx_entity_src_gen_prod_other_parameter>
      <PDBo:pdbx_entity_src_gen_prod_other_parameter rdf:about="{$base}/pdbx_entity_src_gen_prod_other_parameter/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@parameter,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!='' and @entry_id!='' and @step_id!=''">
        <PDBo:reference_to_pdbx_entity_src_gen_prod_other>
	  <rdf:Description  rdf:about="{$base}/pdbx_entity_src_gen_prod_other/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_other_parameter rdf:resource="{$base}/pdbx_entity_src_gen_prod_other_parameter/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@parameter,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_entity_src_gen_prod_other>
        <!-- pdbx_entity_src_gen_prod_otherKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_prod_other_parameter>
      </PDBo:has_pdbx_entity_src_gen_prod_other_parameter>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_prod_pcrCategory/PDBx:pdbx_entity_src_gen_prod_pcr">
      <PDBo:has_pdbx_entity_src_gen_prod_pcr>
      <PDBo:pdbx_entity_src_gen_prod_pcr rdf:about="{$base}/pdbx_entity_src_gen_prod_pcr/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_pcr rdf:resource="{$base}/pdbx_entity_src_gen_prod_pcr/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_29_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_pcr rdf:resource="{$base}/pdbx_entity_src_gen_prod_pcr/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_50_0 -->
      </xsl:if>
      <xsl:if test="PDBx:forward_primer_id!=''">
        <PDBo:reference_to_pdbx_construct>
	  <rdf:Description  rdf:about="{$base}/pdbx_construct/{translate(PDBx:forward_primer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_pcr rdf:resource="{$base}/pdbx_entity_src_gen_prod_pcr/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_construct>
        <!-- pdbx_constructKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:if test="PDBx:reverse_primer_id!=''">
        <PDBo:reference_to_pdbx_construct>
	  <rdf:Description  rdf:about="{$base}/pdbx_construct/{translate(PDBx:reverse_primer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_prod_pcr rdf:resource="{$base}/pdbx_entity_src_gen_prod_pcr/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_construct>
        <!-- pdbx_constructKeyref_0_0_2_1 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_prod_pcr>
      </PDBo:has_pdbx_entity_src_gen_prod_pcr>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_proteolysisCategory/PDBx:pdbx_entity_src_gen_proteolysis">
      <PDBo:has_pdbx_entity_src_gen_proteolysis>
      <PDBo:pdbx_entity_src_gen_proteolysis rdf:about="{$base}/pdbx_entity_src_gen_proteolysis/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_proteolysis rdf:resource="{$base}/pdbx_entity_src_gen_proteolysis/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_30_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_proteolysis rdf:resource="{$base}/pdbx_entity_src_gen_proteolysis/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_51_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_proteolysis>
      </PDBo:has_pdbx_entity_src_gen_proteolysis>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_pureCategory/PDBx:pdbx_entity_src_gen_pure">
      <PDBo:has_pdbx_entity_src_gen_pure>
      <PDBo:pdbx_entity_src_gen_pure rdf:about="{$base}/pdbx_entity_src_gen_pure/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_pure rdf:resource="{$base}/pdbx_entity_src_gen_pure/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_31_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_pure rdf:resource="{$base}/pdbx_entity_src_gen_pure/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_52_0 -->
      </xsl:if>
      <xsl:if test="PDBx:storage_buffer_id!=''">
        <PDBo:reference_to_pdbx_buffer>
	  <rdf:Description  rdf:about="{$base}/pdbx_buffer/{translate(PDBx:storage_buffer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_pure rdf:resource="{$base}/pdbx_entity_src_gen_pure/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_buffer>
        <!-- pdbx_bufferKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_pure>
      </PDBo:has_pdbx_entity_src_gen_pure>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_gen_refoldCategory/PDBx:pdbx_entity_src_gen_refold">
      <PDBo:has_pdbx_entity_src_gen_refold>
      <PDBo:pdbx_entity_src_gen_refold rdf:about="{$base}/pdbx_entity_src_gen_refold/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_refold rdf:resource="{$base}/pdbx_entity_src_gen_refold/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_32_0 -->
      </xsl:if>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_refold rdf:resource="{$base}/pdbx_entity_src_gen_refold/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_53_0 -->
      </xsl:if>
      <xsl:if test="PDBx:denature_buffer_id!=''">
        <PDBo:reference_to_pdbx_buffer>
	  <rdf:Description  rdf:about="{$base}/pdbx_buffer/{translate(PDBx:denature_buffer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_refold rdf:resource="{$base}/pdbx_entity_src_gen_refold/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_buffer>
        <!-- pdbx_bufferKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:if test="PDBx:refold_buffer_id!=''">
        <PDBo:reference_to_pdbx_buffer>
	  <rdf:Description  rdf:about="{$base}/pdbx_buffer/{translate(PDBx:refold_buffer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_refold rdf:resource="{$base}/pdbx_entity_src_gen_refold/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_buffer>
        <!-- pdbx_bufferKeyref_0_0_4_1 -->
      </xsl:if>
      <xsl:if test="PDBx:storage_buffer_id!=''">
        <PDBo:reference_to_pdbx_buffer>
	  <rdf:Description  rdf:about="{$base}/pdbx_buffer/{translate(PDBx:storage_buffer_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_gen_refold rdf:resource="{$base}/pdbx_entity_src_gen_refold/{translate(@entity_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@step_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_buffer>
        <!-- pdbx_bufferKeyref_0_0_4_2 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_gen_refold>
      </PDBo:has_pdbx_entity_src_gen_refold>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entity_src_synCategory/PDBx:pdbx_entity_src_syn">
      <PDBo:has_pdbx_entity_src_syn>
      <PDBo:pdbx_entity_src_syn rdf:about="{$base}/pdbx_entity_src_syn/{translate(@entity_id,' ^','_')},{translate(@pdbx_src_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entity_src_syn rdf:resource="{$base}/pdbx_entity_src_syn/{translate(@entity_id,' ^','_')},{translate(@pdbx_src_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_33_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entity_src_syn>
      </PDBo:has_pdbx_entity_src_syn>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_entry_detailsCategory/PDBx:pdbx_entry_details">
      <PDBo:has_pdbx_entry_details>
      <PDBo:pdbx_entry_details rdf:about="{$base}/pdbx_entry_details/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_entry_details rdf:resource="{$base}/pdbx_entry_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_54_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_entry_details>
      </PDBo:has_pdbx_entry_details>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_exptl_crystal_cryo_treatmentCategory/PDBx:pdbx_exptl_crystal_cryo_treatment">
      <PDBo:has_pdbx_exptl_crystal_cryo_treatment>
      <PDBo:pdbx_exptl_crystal_cryo_treatment rdf:about="{$base}/pdbx_exptl_crystal_cryo_treatment/{translate(@crystal_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@crystal_id!=''">
        <PDBo:reference_to_exptl_crystal>
	  <rdf:Description  rdf:about="{$base}/exptl_crystal/{translate(@crystal_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_exptl_crystal_cryo_treatment rdf:resource="{$base}/pdbx_exptl_crystal_cryo_treatment/{translate(@crystal_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_exptl_crystal>
        <!-- exptl_crystalKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_exptl_crystal_cryo_treatment>
      </PDBo:has_pdbx_exptl_crystal_cryo_treatment>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_exptl_crystal_grow_compCategory/PDBx:pdbx_exptl_crystal_grow_comp">
      <PDBo:has_pdbx_exptl_crystal_grow_comp>
      <PDBo:pdbx_exptl_crystal_grow_comp rdf:about="{$base}/pdbx_exptl_crystal_grow_comp/{translate(@comp_id,' ^','_')},{translate(@crystal_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@crystal_id!=''">
        <PDBo:reference_to_exptl_crystal>
	  <rdf:Description  rdf:about="{$base}/exptl_crystal/{translate(@crystal_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_exptl_crystal_grow_comp rdf:resource="{$base}/pdbx_exptl_crystal_grow_comp/{translate(@comp_id,' ^','_')},{translate(@crystal_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_exptl_crystal>
        <!-- exptl_crystalKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_exptl_crystal_grow_comp>
      </PDBo:has_pdbx_exptl_crystal_grow_comp>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_exptl_crystal_grow_solCategory/PDBx:pdbx_exptl_crystal_grow_sol">
      <PDBo:has_pdbx_exptl_crystal_grow_sol>
      <PDBo:pdbx_exptl_crystal_grow_sol rdf:about="{$base}/pdbx_exptl_crystal_grow_sol/{translate(@crystal_id,' ^','_')},{translate(@sol_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@crystal_id!=''">
        <PDBo:reference_to_exptl_crystal>
	  <rdf:Description  rdf:about="{$base}/exptl_crystal/{translate(@crystal_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_exptl_crystal_grow_sol rdf:resource="{$base}/pdbx_exptl_crystal_grow_sol/{translate(@crystal_id,' ^','_')},{translate(@sol_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_exptl_crystal>
        <!-- exptl_crystalKeyref_0_0_6_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_exptl_crystal_grow_sol>
      </PDBo:has_pdbx_exptl_crystal_grow_sol>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_exptl_pdCategory/PDBx:pdbx_exptl_pd">
      <PDBo:has_pdbx_exptl_pd>
      <PDBo:pdbx_exptl_pd rdf:about="{$base}/pdbx_exptl_pd/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_exptl_pd rdf:resource="{$base}/pdbx_exptl_pd/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_55_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_exptl_pd>
      </PDBo:has_pdbx_exptl_pd>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_family_group_indexCategory/PDBx:pdbx_family_group_index">
      <PDBo:has_pdbx_family_group_index>
      <PDBo:pdbx_family_group_index rdf:about="{$base}/pdbx_family_group_index/{translate(@family_prd_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_family_group_index>
      </PDBo:has_pdbx_family_group_index>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_family_prd_auditCategory/PDBx:pdbx_family_prd_audit">
      <PDBo:has_pdbx_family_prd_audit>
      <PDBo:pdbx_family_prd_audit rdf:about="{$base}/pdbx_family_prd_audit/{translate(@action_type,' ^','_')},{translate(@date,' ^','_')},{translate(@family_prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@family_prd_id!=''">
        <PDBo:reference_to_pdbx_reference_molecule_family>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_molecule_family/{translate(@family_prd_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_family_prd_audit rdf:resource="{$base}/pdbx_family_prd_audit/{translate(@action_type,' ^','_')},{translate(@date,' ^','_')},{translate(@family_prd_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_molecule_family>
        <!-- pdbx_reference_molecule_familyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_family_prd_audit>
      </PDBo:has_pdbx_family_prd_audit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_feature_assemblyCategory/PDBx:pdbx_feature_assembly">
      <PDBo:has_pdbx_feature_assembly>
      <PDBo:pdbx_feature_assembly rdf:about="{$base}/pdbx_feature_assembly/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:assembly_id!=''">
        <PDBo:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(PDBx:assembly_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_feature_assembly rdf:resource="{$base}/pdbx_feature_assembly/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_feature_assembly>
      </PDBo:has_pdbx_feature_assembly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_feature_domainCategory/PDBx:pdbx_feature_domain">
      <PDBo:has_pdbx_feature_domain>
      <PDBo:pdbx_feature_domain rdf:about="{$base}/pdbx_feature_domain/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:domain_id!=''">
        <PDBo:reference_to_pdbx_domain>
	  <rdf:Description  rdf:about="{$base}/pdbx_domain/{translate(PDBx:domain_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_feature_domain rdf:resource="{$base}/pdbx_feature_domain/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_domain>
        <!-- pdbx_domainKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_feature_domain>
      </PDBo:has_pdbx_feature_domain>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_feature_entryCategory/PDBx:pdbx_feature_entry">
      <PDBo:has_pdbx_feature_entry>
      <PDBo:pdbx_feature_entry rdf:about="{$base}/pdbx_feature_entry/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_feature_entry>
      </PDBo:has_pdbx_feature_entry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_feature_monomerCategory/PDBx:pdbx_feature_monomer">
      <PDBo:has_pdbx_feature_monomer>
      <PDBo:pdbx_feature_monomer rdf:about="{$base}/pdbx_feature_monomer/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_feature_monomer>
      </PDBo:has_pdbx_feature_monomer>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_feature_sequence_rangeCategory/PDBx:pdbx_feature_sequence_range">
      <PDBo:has_pdbx_feature_sequence_range>
      <PDBo:pdbx_feature_sequence_range rdf:about="{$base}/pdbx_feature_sequence_range/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_feature_sequence_range>
      </PDBo:has_pdbx_feature_sequence_range>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_helical_symmetryCategory/PDBx:pdbx_helical_symmetry">
      <PDBo:has_pdbx_helical_symmetry>
      <PDBo:pdbx_helical_symmetry rdf:about="{$base}/pdbx_helical_symmetry/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_helical_symmetry rdf:resource="{$base}/pdbx_helical_symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_56_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_helical_symmetry>
      </PDBo:has_pdbx_helical_symmetry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_helical_symmetry_depositor_infoCategory/PDBx:pdbx_helical_symmetry_depositor_info">
      <PDBo:has_pdbx_helical_symmetry_depositor_info>
      <PDBo:pdbx_helical_symmetry_depositor_info rdf:about="{$base}/pdbx_helical_symmetry_depositor_info/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_helical_symmetry_depositor_info rdf:resource="{$base}/pdbx_helical_symmetry_depositor_info/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_57_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_helical_symmetry_depositor_info>
      </PDBo:has_pdbx_helical_symmetry_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_hybridCategory/PDBx:pdbx_hybrid">
      <PDBo:has_pdbx_hybrid>
      <PDBo:pdbx_hybrid rdf:about="{$base}/pdbx_hybrid/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_hybrid>
      </PDBo:has_pdbx_hybrid>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_inhibitor_infoCategory/PDBx:pdbx_inhibitor_info">
      <PDBo:has_pdbx_inhibitor_info>
      <PDBo:pdbx_inhibitor_info rdf:about="{$base}/pdbx_inhibitor_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_inhibitor_info>
      </PDBo:has_pdbx_inhibitor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_ion_infoCategory/PDBx:pdbx_ion_info">
      <PDBo:has_pdbx_ion_info>
      <PDBo:pdbx_ion_info rdf:about="{$base}/pdbx_ion_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_ion_info>
      </PDBo:has_pdbx_ion_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_linked_entityCategory/PDBx:pdbx_linked_entity">
      <PDBo:has_pdbx_linked_entity>
      <PDBo:pdbx_linked_entity rdf:about="{$base}/pdbx_linked_entity/{translate(@linked_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_linked_entity>
      </PDBo:has_pdbx_linked_entity>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_linked_entity_instance_listCategory/PDBx:pdbx_linked_entity_instance_list">
      <PDBo:has_pdbx_linked_entity_instance_list>
      <PDBo:pdbx_linked_entity_instance_list rdf:about="{$base}/pdbx_linked_entity_instance_list/{translate(@asym_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@linked_entity_id!=''">
        <PDBo:reference_to_pdbx_linked_entity>
	  <rdf:Description  rdf:about="{$base}/pdbx_linked_entity/{translate(@linked_entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_linked_entity_instance_list rdf:resource="{$base}/pdbx_linked_entity_instance_list/{translate(@asym_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_linked_entity>
        <!-- pdbx_linked_entityKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@asym_id!=''">
        <PDBo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_linked_entity_instance_list rdf:resource="{$base}/pdbx_linked_entity_instance_list/{translate(@asym_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_asym>
        <!-- struct_asymKeyref_1_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_linked_entity_instance_list>
      </PDBo:has_pdbx_linked_entity_instance_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_linked_entity_link_listCategory/PDBx:pdbx_linked_entity_link_list">
      <PDBo:has_pdbx_linked_entity_link_list>
      <PDBo:pdbx_linked_entity_link_list rdf:about="{$base}/pdbx_linked_entity_link_list/{translate(@link_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:component_1!='' and PDBx:entity_id_1!='' and @linked_entity_id!=''">
        <PDBo:reference_to_pdbx_linked_entity_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_linked_entity_list/{translate(PDBx:component_1,' ^','_')},{translate(PDBx:entity_id_1,' ^','_')},{translate(@linked_entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_linked_entity_link_list rdf:resource="{$base}/pdbx_linked_entity_link_list/{translate(@link_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_linked_entity_list>
        <!-- pdbx_linked_entity_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_linked_entity_link_list>
      </PDBo:has_pdbx_linked_entity_link_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_linked_entity_listCategory/PDBx:pdbx_linked_entity_list">
      <PDBo:has_pdbx_linked_entity_list>
      <PDBo:pdbx_linked_entity_list rdf:about="{$base}/pdbx_linked_entity_list/{translate(@component_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_linked_entity_list rdf:resource="{$base}/pdbx_linked_entity_list/{translate(@component_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_34_0 -->
      </xsl:if>
      <xsl:if test="@linked_entity_id!=''">
        <PDBo:reference_to_pdbx_linked_entity>
	  <rdf:Description  rdf:about="{$base}/pdbx_linked_entity/{translate(@linked_entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_linked_entity_list rdf:resource="{$base}/pdbx_linked_entity_list/{translate(@component_id,' ^','_')},{translate(@entity_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_linked_entity>
        <!-- pdbx_linked_entityKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_linked_entity_list>
      </PDBo:has_pdbx_linked_entity_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_missing_atom_nonpolyCategory/PDBx:pdbx_missing_atom_nonpoly">
      <PDBo:has_pdbx_missing_atom_nonpoly>
      <PDBo:pdbx_missing_atom_nonpoly rdf:about="{$base}/pdbx_missing_atom_nonpoly/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_missing_atom_nonpoly>
      </PDBo:has_pdbx_missing_atom_nonpoly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_missing_atom_polyCategory/PDBx:pdbx_missing_atom_poly">
      <PDBo:has_pdbx_missing_atom_poly>
      <PDBo:pdbx_missing_atom_poly rdf:about="{$base}/pdbx_missing_atom_poly/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_missing_atom_poly>
      </PDBo:has_pdbx_missing_atom_poly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_missing_residue_listCategory/PDBx:pdbx_missing_residue_list">
      <PDBo:has_pdbx_missing_residue_list>
      <PDBo:pdbx_missing_residue_list rdf:about="{$base}/pdbx_missing_residue_list/{translate(@pdb_chain_id,' ^','_')},{translate(@pdb_residue_name,' ^','_')},{translate(@pdb_residue_number,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_missing_residue_list>
      </PDBo:has_pdbx_missing_residue_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_moleculeCategory/PDBx:pdbx_molecule">
      <PDBo:has_pdbx_molecule>
      <PDBo:pdbx_molecule rdf:about="{$base}/pdbx_molecule/{translate(@asym_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
        <PDBo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_molecule rdf:resource="{$base}/pdbx_molecule/{translate(@asym_id,' ^','_')},{translate(@instance_id,' ^','_')},{translate(@prd_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_asym>
        <!-- struct_asymKeyref_1_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_molecule>
      </PDBo:has_pdbx_molecule>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_molecule_featuresCategory/PDBx:pdbx_molecule_features">
      <PDBo:has_pdbx_molecule_features>
      <PDBo:pdbx_molecule_features rdf:about="{$base}/pdbx_molecule_features/{translate(@prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_molecule_features>
      </PDBo:has_pdbx_molecule_features>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_molecule_features_depositor_infoCategory/PDBx:pdbx_molecule_features_depositor_info">
      <PDBo:has_pdbx_molecule_features_depositor_info>
      <PDBo:pdbx_molecule_features_depositor_info rdf:about="{$base}/pdbx_molecule_features_depositor_info/{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_molecule_features_depositor_info>
      </PDBo:has_pdbx_molecule_features_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_na_strand_infoCategory/PDBx:pdbx_na_strand_info">
      <PDBo:has_pdbx_na_strand_info>
      <PDBo:pdbx_na_strand_info rdf:about="{$base}/pdbx_na_strand_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_na_strand_info>
      </PDBo:has_pdbx_na_strand_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_na_struct_keywdsCategory/PDBx:pdbx_na_struct_keywds">
      <PDBo:has_pdbx_na_struct_keywds>
      <PDBo:pdbx_na_struct_keywds rdf:about="{$base}/pdbx_na_struct_keywds/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_na_struct_keywds rdf:resource="{$base}/pdbx_na_struct_keywds/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_58_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_na_struct_keywds>
      </PDBo:has_pdbx_na_struct_keywds>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_assigned_chem_shift_listCategory/PDBx:pdbx_nmr_assigned_chem_shift_list">
      <PDBo:has_pdbx_nmr_assigned_chem_shift_list>
      <PDBo:pdbx_nmr_assigned_chem_shift_list rdf:about="{$base}/pdbx_nmr_assigned_chem_shift_list/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_assigned_chem_shift_list>
      </PDBo:has_pdbx_nmr_assigned_chem_shift_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_chem_shift_experimentCategory/PDBx:pdbx_nmr_chem_shift_experiment">
      <PDBo:has_pdbx_nmr_chem_shift_experiment>
      <PDBo:pdbx_nmr_chem_shift_experiment rdf:about="{$base}/pdbx_nmr_chem_shift_experiment/{translate(@assigned_chem_shift_list_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@experiment_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_chem_shift_experiment>
      </PDBo:has_pdbx_nmr_chem_shift_experiment>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_chem_shift_refCategory/PDBx:pdbx_nmr_chem_shift_ref">
      <PDBo:has_pdbx_nmr_chem_shift_ref>
      <PDBo:pdbx_nmr_chem_shift_ref rdf:about="{$base}/pdbx_nmr_chem_shift_ref/{translate(@atom_isotope_number,' ^','_')},{translate(@atom_type,' ^','_')},{translate(@chem_shift_reference_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@mol_common_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_chem_shift_ref>
      </PDBo:has_pdbx_nmr_chem_shift_ref>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_chem_shift_referenceCategory/PDBx:pdbx_nmr_chem_shift_reference">
      <PDBo:has_pdbx_nmr_chem_shift_reference>
      <PDBo:pdbx_nmr_chem_shift_reference rdf:about="{$base}/pdbx_nmr_chem_shift_reference/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_chem_shift_reference>
      </PDBo:has_pdbx_nmr_chem_shift_reference>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_chem_shift_softwareCategory/PDBx:pdbx_nmr_chem_shift_software">
      <PDBo:has_pdbx_nmr_chem_shift_software>
      <PDBo:pdbx_nmr_chem_shift_software rdf:about="{$base}/pdbx_nmr_chem_shift_software/{translate(@assigned_chem_shift_list_id,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@software_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_chem_shift_software>
      </PDBo:has_pdbx_nmr_chem_shift_software>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_computingCategory/PDBx:pdbx_nmr_computing">
      <PDBo:has_pdbx_nmr_computing>
      <PDBo:pdbx_nmr_computing rdf:about="{$base}/pdbx_nmr_computing/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_nmr_computing rdf:resource="{$base}/pdbx_nmr_computing/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_59_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_computing>
      </PDBo:has_pdbx_nmr_computing>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_constraint_fileCategory/PDBx:pdbx_nmr_constraint_file">
      <PDBo:has_pdbx_nmr_constraint_file>
      <PDBo:pdbx_nmr_constraint_file rdf:about="{$base}/pdbx_nmr_constraint_file/{translate(@constraint_filename,' ^','_')},{translate(@constraint_subtype,' ^','_')},{translate(@constraint_type,' ^','_')},{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_constraint_file>
      </PDBo:has_pdbx_nmr_constraint_file>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_constraintsCategory/PDBx:pdbx_nmr_constraints">
      <PDBo:has_pdbx_nmr_constraints>
      <PDBo:pdbx_nmr_constraints rdf:about="{$base}/pdbx_nmr_constraints/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_nmr_constraints rdf:resource="{$base}/pdbx_nmr_constraints/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_60_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_constraints>
      </PDBo:has_pdbx_nmr_constraints>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_detailsCategory/PDBx:pdbx_nmr_details">
      <PDBo:has_pdbx_nmr_details>
      <PDBo:pdbx_nmr_details rdf:about="{$base}/pdbx_nmr_details/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_nmr_details rdf:resource="{$base}/pdbx_nmr_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_61_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_details>
      </PDBo:has_pdbx_nmr_details>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_ensembleCategory/PDBx:pdbx_nmr_ensemble">
      <PDBo:has_pdbx_nmr_ensemble>
      <PDBo:pdbx_nmr_ensemble rdf:about="{$base}/pdbx_nmr_ensemble/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_nmr_ensemble rdf:resource="{$base}/pdbx_nmr_ensemble/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_62_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_ensemble>
      </PDBo:has_pdbx_nmr_ensemble>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_ensemble_rmsCategory/PDBx:pdbx_nmr_ensemble_rms">
      <PDBo:has_pdbx_nmr_ensemble_rms>
      <PDBo:pdbx_nmr_ensemble_rms rdf:about="{$base}/pdbx_nmr_ensemble_rms/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_nmr_ensemble_rms rdf:resource="{$base}/pdbx_nmr_ensemble_rms/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_63_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_ensemble_rms>
      </PDBo:has_pdbx_nmr_ensemble_rms>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_exptlCategory/PDBx:pdbx_nmr_exptl">
      <PDBo:has_pdbx_nmr_exptl>
      <PDBo:pdbx_nmr_exptl rdf:about="{$base}/pdbx_nmr_exptl/{translate(@conditions_id,' ^','_')},{translate(@experiment_id,' ^','_')},{translate(@solution_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_exptl>
      </PDBo:has_pdbx_nmr_exptl>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_exptl_sampleCategory/PDBx:pdbx_nmr_exptl_sample">
      <PDBo:has_pdbx_nmr_exptl_sample>
      <PDBo:pdbx_nmr_exptl_sample rdf:about="{$base}/pdbx_nmr_exptl_sample/{translate(@component,' ^','_')},{translate(@solution_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_exptl_sample>
      </PDBo:has_pdbx_nmr_exptl_sample>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_exptl_sample_conditionsCategory/PDBx:pdbx_nmr_exptl_sample_conditions">
      <PDBo:has_pdbx_nmr_exptl_sample_conditions>
      <PDBo:pdbx_nmr_exptl_sample_conditions rdf:about="{$base}/pdbx_nmr_exptl_sample_conditions/{translate(@conditions_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_exptl_sample_conditions>
      </PDBo:has_pdbx_nmr_exptl_sample_conditions>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_force_constantsCategory/PDBx:pdbx_nmr_force_constants">
      <PDBo:has_pdbx_nmr_force_constants>
      <PDBo:pdbx_nmr_force_constants rdf:about="{$base}/pdbx_nmr_force_constants/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_nmr_force_constants rdf:resource="{$base}/pdbx_nmr_force_constants/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_64_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_force_constants>
      </PDBo:has_pdbx_nmr_force_constants>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_refineCategory/PDBx:pdbx_nmr_refine">
      <PDBo:has_pdbx_nmr_refine>
      <PDBo:pdbx_nmr_refine rdf:about="{$base}/pdbx_nmr_refine/{translate(@entry_id,' ^','_')},{translate(@software_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_nmr_refine rdf:resource="{$base}/pdbx_nmr_refine/{translate(@entry_id,' ^','_')},{translate(@software_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_65_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_refine>
      </PDBo:has_pdbx_nmr_refine>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_representativeCategory/PDBx:pdbx_nmr_representative">
      <PDBo:has_pdbx_nmr_representative>
      <PDBo:pdbx_nmr_representative rdf:about="{$base}/pdbx_nmr_representative/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_nmr_representative rdf:resource="{$base}/pdbx_nmr_representative/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_66_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_representative>
      </PDBo:has_pdbx_nmr_representative>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_sample_detailsCategory/PDBx:pdbx_nmr_sample_details">
      <PDBo:has_pdbx_nmr_sample_details>
      <PDBo:pdbx_nmr_sample_details rdf:about="{$base}/pdbx_nmr_sample_details/{translate(@solution_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_sample_details>
      </PDBo:has_pdbx_nmr_sample_details>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_softwareCategory/PDBx:pdbx_nmr_software">
      <PDBo:has_pdbx_nmr_software>
      <PDBo:pdbx_nmr_software rdf:about="{$base}/pdbx_nmr_software/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_software>
      </PDBo:has_pdbx_nmr_software>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_software_taskCategory/PDBx:pdbx_nmr_software_task">
      <PDBo:has_pdbx_nmr_software_task>
      <PDBo:pdbx_nmr_software_task rdf:about="{$base}/pdbx_nmr_software_task/{translate(@entry_id,' ^','_')},{translate(@software_ordinal,' ^','_')},{translate(@task,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_software_task>
      </PDBo:has_pdbx_nmr_software_task>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_spectral_dimCategory/PDBx:pdbx_nmr_spectral_dim">
      <PDBo:has_pdbx_nmr_spectral_dim>
      <PDBo:pdbx_nmr_spectral_dim rdf:about="{$base}/pdbx_nmr_spectral_dim/{translate(@atom_type,' ^','_')},{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')},{translate(@spectral_peak_list_id,' ^','_')},{translate(@spectral_region,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_spectral_dim>
      </PDBo:has_pdbx_nmr_spectral_dim>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_spectral_peak_listCategory/PDBx:pdbx_nmr_spectral_peak_list">
      <PDBo:has_pdbx_nmr_spectral_peak_list>
      <PDBo:pdbx_nmr_spectral_peak_list rdf:about="{$base}/pdbx_nmr_spectral_peak_list/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_spectral_peak_list>
      </PDBo:has_pdbx_nmr_spectral_peak_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_spectral_peak_softwareCategory/PDBx:pdbx_nmr_spectral_peak_software">
      <PDBo:has_pdbx_nmr_spectral_peak_software>
      <PDBo:pdbx_nmr_spectral_peak_software rdf:about="{$base}/pdbx_nmr_spectral_peak_software/{translate(@entry_id,' ^','_')},{translate(@software_id,' ^','_')},{translate(@spectral_peak_list_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_spectral_peak_software>
      </PDBo:has_pdbx_nmr_spectral_peak_software>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_spectrometerCategory/PDBx:pdbx_nmr_spectrometer">
      <PDBo:has_pdbx_nmr_spectrometer>
      <PDBo:pdbx_nmr_spectrometer rdf:about="{$base}/pdbx_nmr_spectrometer/{translate(@spectrometer_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_spectrometer>
      </PDBo:has_pdbx_nmr_spectrometer>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_systematic_chem_shift_offsetCategory/PDBx:pdbx_nmr_systematic_chem_shift_offset">
      <PDBo:has_pdbx_nmr_systematic_chem_shift_offset>
      <PDBo:pdbx_nmr_systematic_chem_shift_offset rdf:about="{$base}/pdbx_nmr_systematic_chem_shift_offset/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_systematic_chem_shift_offset>
      </PDBo:has_pdbx_nmr_systematic_chem_shift_offset>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nmr_uploadCategory/PDBx:pdbx_nmr_upload">
      <PDBo:has_pdbx_nmr_upload>
      <PDBo:pdbx_nmr_upload rdf:about="{$base}/pdbx_nmr_upload/{translate(@data_file_id,' ^','_')},{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nmr_upload>
      </PDBo:has_pdbx_nmr_upload>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_nonstandard_listCategory/PDBx:pdbx_nonstandard_list">
      <PDBo:has_pdbx_nonstandard_list>
      <PDBo:pdbx_nonstandard_list rdf:about="{$base}/pdbx_nonstandard_list/{translate(@id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@label_seq_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_nonstandard_list>
      </PDBo:has_pdbx_nonstandard_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_pdb_compndCategory/PDBx:pdbx_pdb_compnd">
      <PDBo:has_pdbx_pdb_compnd>
      <PDBo:pdbx_pdb_compnd rdf:about="{$base}/pdbx_pdb_compnd/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_pdb_compnd>
      </PDBo:has_pdbx_pdb_compnd>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_pdb_sourceCategory/PDBx:pdbx_pdb_source">
      <PDBo:has_pdbx_pdb_source>
      <PDBo:pdbx_pdb_source rdf:about="{$base}/pdbx_pdb_source/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_pdb_source>
      </PDBo:has_pdbx_pdb_source>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_phasing_MAD_setCategory/PDBx:pdbx_phasing_MAD_set">
      <PDBo:has_pdbx_phasing_MAD_set>
      <PDBo:pdbx_phasing_MAD_set rdf:about="{$base}/pdbx_phasing_MAD_set/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MAD_set>
      </PDBo:has_pdbx_phasing_MAD_set>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_phasing_MAD_set_shellCategory/PDBx:pdbx_phasing_MAD_set_shell">
      <PDBo:has_pdbx_phasing_MAD_set_shell>
      <PDBo:pdbx_phasing_MAD_set_shell rdf:about="{$base}/pdbx_phasing_MAD_set_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MAD_set_shell>
      </PDBo:has_pdbx_phasing_MAD_set_shell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_phasing_MAD_set_siteCategory/PDBx:pdbx_phasing_MAD_set_site">
      <PDBo:has_pdbx_phasing_MAD_set_site>
      <PDBo:pdbx_phasing_MAD_set_site rdf:about="{$base}/pdbx_phasing_MAD_set_site/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MAD_set_site>
      </PDBo:has_pdbx_phasing_MAD_set_site>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_phasing_MAD_shellCategory/PDBx:pdbx_phasing_MAD_shell">
      <PDBo:has_pdbx_phasing_MAD_shell>
      <PDBo:pdbx_phasing_MAD_shell rdf:about="{$base}/pdbx_phasing_MAD_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MAD_shell>
      </PDBo:has_pdbx_phasing_MAD_shell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_phasing_MRCategory/PDBx:pdbx_phasing_MR">
      <PDBo:has_pdbx_phasing_MR>
      <PDBo:pdbx_phasing_MR rdf:about="{$base}/pdbx_phasing_MR/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_MR>
      </PDBo:has_pdbx_phasing_MR>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_phasing_dmCategory/PDBx:pdbx_phasing_dm">
      <PDBo:has_pdbx_phasing_dm>
      <PDBo:pdbx_phasing_dm rdf:about="{$base}/pdbx_phasing_dm/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_dm>
      </PDBo:has_pdbx_phasing_dm>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_phasing_dm_shellCategory/PDBx:pdbx_phasing_dm_shell">
      <PDBo:has_pdbx_phasing_dm_shell>
      <PDBo:pdbx_phasing_dm_shell rdf:about="{$base}/pdbx_phasing_dm_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_phasing_dm_shell>
      </PDBo:has_pdbx_phasing_dm_shell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_point_symmetryCategory/PDBx:pdbx_point_symmetry">
      <PDBo:has_pdbx_point_symmetry>
      <PDBo:pdbx_point_symmetry rdf:about="{$base}/pdbx_point_symmetry/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_point_symmetry rdf:resource="{$base}/pdbx_point_symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_67_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_point_symmetry>
      </PDBo:has_pdbx_point_symmetry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_point_symmetry_depositor_infoCategory/PDBx:pdbx_point_symmetry_depositor_info">
      <PDBo:has_pdbx_point_symmetry_depositor_info>
      <PDBo:pdbx_point_symmetry_depositor_info rdf:about="{$base}/pdbx_point_symmetry_depositor_info/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_point_symmetry_depositor_info rdf:resource="{$base}/pdbx_point_symmetry_depositor_info/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_68_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_point_symmetry_depositor_info>
      </PDBo:has_pdbx_point_symmetry_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_post_process_detailsCategory/PDBx:pdbx_post_process_details">
      <PDBo:has_pdbx_post_process_details>
      <PDBo:pdbx_post_process_details rdf:about="{$base}/pdbx_post_process_details/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_post_process_details rdf:resource="{$base}/pdbx_post_process_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_69_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_post_process_details>
      </PDBo:has_pdbx_post_process_details>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_post_process_statusCategory/PDBx:pdbx_post_process_status">
      <PDBo:has_pdbx_post_process_status>
      <PDBo:pdbx_post_process_status rdf:about="{$base}/pdbx_post_process_status/{translate(@cycle_id,' ^','_')},{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_post_process_status rdf:resource="{$base}/pdbx_post_process_status/{translate(@cycle_id,' ^','_')},{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_70_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_post_process_status>
      </PDBo:has_pdbx_post_process_status>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_prd_auditCategory/PDBx:pdbx_prd_audit">
      <PDBo:has_pdbx_prd_audit>
      <PDBo:pdbx_prd_audit rdf:about="{$base}/pdbx_prd_audit/{translate(@action_type,' ^','_')},{translate(@date,' ^','_')},{translate(@prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@prd_id!=''">
        <PDBo:reference_to_pdbx_reference_molecule>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_molecule/{translate(@prd_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_prd_audit rdf:resource="{$base}/pdbx_prd_audit/{translate(@action_type,' ^','_')},{translate(@date,' ^','_')},{translate(@prd_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_molecule>
        <!-- pdbx_reference_moleculeKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_prd_audit>
      </PDBo:has_pdbx_prd_audit>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_prerelease_seqCategory/PDBx:pdbx_prerelease_seq">
      <PDBo:has_pdbx_prerelease_seq>
      <PDBo:pdbx_prerelease_seq rdf:about="{$base}/pdbx_prerelease_seq/{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(@entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_prerelease_seq rdf:resource="{$base}/pdbx_prerelease_seq/{translate(@entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_35_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_prerelease_seq>
      </PDBo:has_pdbx_prerelease_seq>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_protein_infoCategory/PDBx:pdbx_protein_info">
      <PDBo:has_pdbx_protein_info>
      <PDBo:pdbx_protein_info rdf:about="{$base}/pdbx_protein_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_protein_info>
      </PDBo:has_pdbx_protein_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_re_refinementCategory/PDBx:pdbx_re_refinement">
      <PDBo:has_pdbx_re_refinement>
      <PDBo:pdbx_re_refinement rdf:about="{$base}/pdbx_re_refinement/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_re_refinement>
      </PDBo:has_pdbx_re_refinement>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_linkCategory/PDBx:pdbx_reference_entity_link">
      <PDBo:has_pdbx_reference_entity_link>
      <PDBo:pdbx_reference_entity_link rdf:about="{$base}/pdbx_reference_entity_link/{translate(@link_id,' ^','_')},{translate(@prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_link>
      </PDBo:has_pdbx_reference_entity_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_listCategory/PDBx:pdbx_reference_entity_list">
      <PDBo:has_pdbx_reference_entity_list>
      <PDBo:pdbx_reference_entity_list rdf:about="{$base}/pdbx_reference_entity_list/{translate(@component_id,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@prd_id!=''">
        <PDBo:reference_to_pdbx_reference_molecule>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_molecule/{translate(@prd_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_entity_list rdf:resource="{$base}/pdbx_reference_entity_list/{translate(@component_id,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_molecule>
        <!-- pdbx_reference_moleculeKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_list>
      </PDBo:has_pdbx_reference_entity_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_nonpolyCategory/PDBx:pdbx_reference_entity_nonpoly">
      <PDBo:has_pdbx_reference_entity_nonpoly>
      <PDBo:pdbx_reference_entity_nonpoly rdf:about="{$base}/pdbx_reference_entity_nonpoly/{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_nonpoly>
      </PDBo:has_pdbx_reference_entity_nonpoly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_polyCategory/PDBx:pdbx_reference_entity_poly">
      <PDBo:has_pdbx_reference_entity_poly>
      <PDBo:pdbx_reference_entity_poly rdf:about="{$base}/pdbx_reference_entity_poly/{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_poly>
      </PDBo:has_pdbx_reference_entity_poly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_poly_linkCategory/PDBx:pdbx_reference_entity_poly_link">
      <PDBo:has_pdbx_reference_entity_poly_link>
      <PDBo:pdbx_reference_entity_poly_link rdf:about="{$base}/pdbx_reference_entity_poly_link/{translate(@component_id,' ^','_')},{translate(@link_id,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@component_id!='' and @prd_id!='' and @ref_entity_id!=''">
        <PDBo:reference_to_pdbx_reference_entity_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_entity_list/{translate(@component_id,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_entity_poly_link rdf:resource="{$base}/pdbx_reference_entity_poly_link/{translate(@component_id,' ^','_')},{translate(@link_id,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_entity_list>
        <!-- pdbx_reference_entity_listKeyref_3_0_0_0 -->
      </xsl:if>
      <xsl:if test="@prd_id!='' and @ref_entity_id!=''">
        <PDBo:reference_to_pdbx_reference_entity_poly>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_entity_poly/{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_entity_poly_link rdf:resource="{$base}/pdbx_reference_entity_poly_link/{translate(@component_id,' ^','_')},{translate(@link_id,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_entity_poly>
        <!-- pdbx_reference_entity_polyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_poly_link>
      </PDBo:has_pdbx_reference_entity_poly_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_poly_seqCategory/PDBx:pdbx_reference_entity_poly_seq">
      <PDBo:has_pdbx_reference_entity_poly_seq>
      <PDBo:pdbx_reference_entity_poly_seq rdf:about="{$base}/pdbx_reference_entity_poly_seq/{translate(@hetero,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@prd_id!='' and @ref_entity_id!=''">
        <PDBo:reference_to_pdbx_reference_entity_poly>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_entity_poly/{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_entity_poly_seq rdf:resource="{$base}/pdbx_reference_entity_poly_seq/{translate(@hetero,' ^','_')},{translate(@mon_id,' ^','_')},{translate(@num,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_entity_poly>
        <!-- pdbx_reference_entity_polyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_poly_seq>
      </PDBo:has_pdbx_reference_entity_poly_seq>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_sequenceCategory/PDBx:pdbx_reference_entity_sequence">
      <PDBo:has_pdbx_reference_entity_sequence>
      <PDBo:pdbx_reference_entity_sequence rdf:about="{$base}/pdbx_reference_entity_sequence/{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_sequence>
      </PDBo:has_pdbx_reference_entity_sequence>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_src_natCategory/PDBx:pdbx_reference_entity_src_nat">
      <PDBo:has_pdbx_reference_entity_src_nat>
      <PDBo:pdbx_reference_entity_src_nat rdf:about="{$base}/pdbx_reference_entity_src_nat/{translate(@ordinal,' ^','_')},{translate(@prd_id,' ^','_')},{translate(@ref_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_src_nat>
      </PDBo:has_pdbx_reference_entity_src_nat>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_entity_subcomponentsCategory/PDBx:pdbx_reference_entity_subcomponents">
      <PDBo:has_pdbx_reference_entity_subcomponents>
      <PDBo:pdbx_reference_entity_subcomponents rdf:about="{$base}/pdbx_reference_entity_subcomponents/{translate(@prd_id,' ^','_')},{translate(@seq,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@prd_id!=''">
        <PDBo:reference_to_pdbx_reference_molecule>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_molecule/{translate(@prd_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_entity_subcomponents rdf:resource="{$base}/pdbx_reference_entity_subcomponents/{translate(@prd_id,' ^','_')},{translate(@seq,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_molecule>
        <!-- pdbx_reference_moleculeKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_entity_subcomponents>
      </PDBo:has_pdbx_reference_entity_subcomponents>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_linked_entityCategory/PDBx:pdbx_reference_linked_entity">
      <PDBo:has_pdbx_reference_linked_entity>
      <PDBo:pdbx_reference_linked_entity rdf:about="{$base}/pdbx_reference_linked_entity/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_linked_entity>
      </PDBo:has_pdbx_reference_linked_entity>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_linked_entity_comp_linkCategory/PDBx:pdbx_reference_linked_entity_comp_link">
      <PDBo:has_pdbx_reference_linked_entity_comp_link>
      <PDBo:pdbx_reference_linked_entity_comp_link rdf:about="{$base}/pdbx_reference_linked_entity_comp_link/{translate(@link_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@linked_entity_id!='' and PDBx:list_id_1!=''">
        <PDBo:reference_to_pdbx_reference_linked_entity_comp_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_linked_entity_comp_list/{translate(@linked_entity_id,' ^','_')},{translate(PDBx:list_id_1,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_linked_entity_comp_link rdf:resource="{$base}/pdbx_reference_linked_entity_comp_link/{translate(@link_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_linked_entity_comp_list>
        <!-- pdbx_reference_linked_entity_comp_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@linked_entity_id!='' and PDBx:list_id_1!=''">
        <PDBo:reference_to_pdbx_reference_linked_entity_comp_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_linked_entity_comp_list/{translate(@linked_entity_id,' ^','_')},{translate(PDBx:list_id_1,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_linked_entity_comp_link rdf:resource="{$base}/pdbx_reference_linked_entity_comp_link/{translate(@link_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_linked_entity_comp_list>
        <!-- pdbx_reference_linked_entity_comp_listKeyref_2_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_linked_entity_comp_link>
      </PDBo:has_pdbx_reference_linked_entity_comp_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_linked_entity_comp_listCategory/PDBx:pdbx_reference_linked_entity_comp_list">
      <PDBo:has_pdbx_reference_linked_entity_comp_list>
      <PDBo:pdbx_reference_linked_entity_comp_list rdf:about="{$base}/pdbx_reference_linked_entity_comp_list/{translate(@linked_entity_id,' ^','_')},{translate(@list_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@linked_entity_id!=''">
        <PDBo:reference_to_pdbx_reference_linked_entity>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_linked_entity/{translate(@linked_entity_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_linked_entity_comp_list rdf:resource="{$base}/pdbx_reference_linked_entity_comp_list/{translate(@linked_entity_id,' ^','_')},{translate(@list_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_linked_entity>
        <!-- pdbx_reference_linked_entityKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_linked_entity_comp_list>
      </PDBo:has_pdbx_reference_linked_entity_comp_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_linked_entity_linkCategory/PDBx:pdbx_reference_linked_entity_link">
      <PDBo:has_pdbx_reference_linked_entity_link>
      <PDBo:pdbx_reference_linked_entity_link rdf:about="{$base}/pdbx_reference_linked_entity_link/{translate(@link_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@linked_entity_id!='' and PDBx:from_list_id!=''">
        <PDBo:reference_to_pdbx_reference_linked_entity_comp_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_linked_entity_comp_list/{translate(@linked_entity_id,' ^','_')},{translate(PDBx:from_list_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_linked_entity_link rdf:resource="{$base}/pdbx_reference_linked_entity_link/{translate(@link_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_linked_entity_comp_list>
        <!-- pdbx_reference_linked_entity_comp_listKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@linked_entity_id!='' and PDBx:from_list_id!=''">
        <PDBo:reference_to_pdbx_reference_linked_entity_comp_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_linked_entity_comp_list/{translate(@linked_entity_id,' ^','_')},{translate(PDBx:from_list_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_linked_entity_link rdf:resource="{$base}/pdbx_reference_linked_entity_link/{translate(@link_id,' ^','_')},{translate(@linked_entity_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_linked_entity_comp_list>
        <!-- pdbx_reference_linked_entity_comp_listKeyref_2_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_linked_entity_link>
      </PDBo:has_pdbx_reference_linked_entity_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_moleculeCategory/PDBx:pdbx_reference_molecule">
      <PDBo:has_pdbx_reference_molecule>
      <PDBo:pdbx_reference_molecule rdf:about="{$base}/pdbx_reference_molecule/{translate(@prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_molecule>
      </PDBo:has_pdbx_reference_molecule>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_molecule_annotationCategory/PDBx:pdbx_reference_molecule_annotation">
      <PDBo:has_pdbx_reference_molecule_annotation>
      <PDBo:pdbx_reference_molecule_annotation rdf:about="{$base}/pdbx_reference_molecule_annotation/{translate(@family_prd_id,' ^','_')},{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_molecule_annotation>
      </PDBo:has_pdbx_reference_molecule_annotation>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_molecule_detailsCategory/PDBx:pdbx_reference_molecule_details">
      <PDBo:has_pdbx_reference_molecule_details>
      <PDBo:pdbx_reference_molecule_details rdf:about="{$base}/pdbx_reference_molecule_details/{translate(@family_prd_id,' ^','_')},{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_molecule_details>
      </PDBo:has_pdbx_reference_molecule_details>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_molecule_familyCategory/PDBx:pdbx_reference_molecule_family">
      <PDBo:has_pdbx_reference_molecule_family>
      <PDBo:pdbx_reference_molecule_family rdf:about="{$base}/pdbx_reference_molecule_family/{translate(@family_prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_molecule_family>
      </PDBo:has_pdbx_reference_molecule_family>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_molecule_featuresCategory/PDBx:pdbx_reference_molecule_features">
      <PDBo:has_pdbx_reference_molecule_features>
      <PDBo:pdbx_reference_molecule_features rdf:about="{$base}/pdbx_reference_molecule_features/{translate(@family_prd_id,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@family_prd_id!='' and @prd_id!=''">
        <PDBo:reference_to_pdbx_reference_molecule_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_molecule_list/{translate(@family_prd_id,' ^','_')},{translate(@prd_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_molecule_features rdf:resource="{$base}/pdbx_reference_molecule_features/{translate(@family_prd_id,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@prd_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_molecule_list>
        <!-- pdbx_reference_molecule_listKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_molecule_features>
      </PDBo:has_pdbx_reference_molecule_features>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_molecule_listCategory/PDBx:pdbx_reference_molecule_list">
      <PDBo:has_pdbx_reference_molecule_list>
      <PDBo:pdbx_reference_molecule_list rdf:about="{$base}/pdbx_reference_molecule_list/{translate(@family_prd_id,' ^','_')},{translate(@prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@family_prd_id!=''">
        <PDBo:reference_to_pdbx_reference_molecule_family>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_molecule_family/{translate(@family_prd_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_molecule_list rdf:resource="{$base}/pdbx_reference_molecule_list/{translate(@family_prd_id,' ^','_')},{translate(@prd_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_molecule_family>
        <!-- pdbx_reference_molecule_familyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_molecule_list>
      </PDBo:has_pdbx_reference_molecule_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_molecule_related_structuresCategory/PDBx:pdbx_reference_molecule_related_structures">
      <PDBo:has_pdbx_reference_molecule_related_structures>
      <PDBo:pdbx_reference_molecule_related_structures rdf:about="{$base}/pdbx_reference_molecule_related_structures/{translate(@family_prd_id,' ^','_')},{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_molecule_related_structures>
      </PDBo:has_pdbx_reference_molecule_related_structures>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_molecule_synonymsCategory/PDBx:pdbx_reference_molecule_synonyms">
      <PDBo:has_pdbx_reference_molecule_synonyms>
      <PDBo:pdbx_reference_molecule_synonyms rdf:about="{$base}/pdbx_reference_molecule_synonyms/{translate(@family_prd_id,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@prd_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@family_prd_id!='' and @prd_id!=''">
        <PDBo:reference_to_pdbx_reference_molecule_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_reference_molecule_list/{translate(@family_prd_id,' ^','_')},{translate(@prd_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_reference_molecule_synonyms rdf:resource="{$base}/pdbx_reference_molecule_synonyms/{translate(@family_prd_id,' ^','_')},{translate(@ordinal,' ^','_')},{translate(@prd_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_reference_molecule_list>
        <!-- pdbx_reference_molecule_listKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_molecule_synonyms>
      </PDBo:has_pdbx_reference_molecule_synonyms>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reference_publication_listCategory/PDBx:pdbx_reference_publication_list">
      <PDBo:has_pdbx_reference_publication_list>
      <PDBo:pdbx_reference_publication_list rdf:about="{$base}/pdbx_reference_publication_list/{translate(@publication_abbrev,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reference_publication_list>
      </PDBo:has_pdbx_reference_publication_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_refineCategory/PDBx:pdbx_refine">
      <PDBo:has_pdbx_refine>
      <PDBo:pdbx_refine rdf:about="{$base}/pdbx_refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_refine rdf:resource="{$base}/pdbx_refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_71_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine>
      </PDBo:has_pdbx_refine>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_refine_aux_fileCategory/PDBx:pdbx_refine_aux_file">
      <PDBo:has_pdbx_refine_aux_file>
      <PDBo:pdbx_refine_aux_file rdf:about="{$base}/pdbx_refine_aux_file/{translate(@pdbx_refine_id,' ^','_')},{translate(@serial_no,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine_aux_file>
      </PDBo:has_pdbx_refine_aux_file>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_refine_componentCategory/PDBx:pdbx_refine_component">
      <PDBo:has_pdbx_refine_component>
      <PDBo:pdbx_refine_component rdf:about="{$base}/pdbx_refine_component/{translate(@label_alt_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@label_comp_id,' ^','_')},{translate(@label_seq_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine_component>
      </PDBo:has_pdbx_refine_component>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_refine_ls_restr_ncsCategory/PDBx:pdbx_refine_ls_restr_ncs">
      <PDBo:has_pdbx_refine_ls_restr_ncs>
      <PDBo:pdbx_refine_ls_restr_ncs rdf:about="{$base}/pdbx_refine_ls_restr_ncs/{translate(@dom_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine_ls_restr_ncs>
      </PDBo:has_pdbx_refine_ls_restr_ncs>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_refine_tlsCategory/PDBx:pdbx_refine_tls">
      <PDBo:has_pdbx_refine_tls>
      <PDBo:pdbx_refine_tls rdf:about="{$base}/pdbx_refine_tls/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine_tls>
      </PDBo:has_pdbx_refine_tls>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_refine_tls_groupCategory/PDBx:pdbx_refine_tls_group">
      <PDBo:has_pdbx_refine_tls_group>
      <PDBo:pdbx_refine_tls_group rdf:about="{$base}/pdbx_refine_tls_group/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:refine_tls_id!=''">
        <PDBo:reference_to_pdbx_refine_tls>
	  <rdf:Description  rdf:about="{$base}/pdbx_refine_tls/{translate(PDBx:refine_tls_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_refine_tls_group rdf:resource="{$base}/pdbx_refine_tls_group/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_refine_tls>
        <!-- pdbx_refine_tlsKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refine_tls_group>
      </PDBo:has_pdbx_refine_tls_group>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_refln_signal_binningCategory/PDBx:pdbx_refln_signal_binning">
      <PDBo:has_pdbx_refln_signal_binning>
      <PDBo:pdbx_refln_signal_binning rdf:about="{$base}/pdbx_refln_signal_binning/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_refln_signal_binning>
      </PDBo:has_pdbx_refln_signal_binning>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_reflns_twinCategory/PDBx:pdbx_reflns_twin">
      <PDBo:has_pdbx_reflns_twin>
      <PDBo:pdbx_reflns_twin rdf:about="{$base}/pdbx_reflns_twin/{translate(@crystal_id,' ^','_')},{translate(@diffrn_id,' ^','_')},{translate(@operator,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_reflns_twin>
      </PDBo:has_pdbx_reflns_twin>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_related_exp_data_setCategory/PDBx:pdbx_related_exp_data_set">
      <PDBo:has_pdbx_related_exp_data_set>
      <PDBo:pdbx_related_exp_data_set rdf:about="{$base}/pdbx_related_exp_data_set/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_related_exp_data_set>
      </PDBo:has_pdbx_related_exp_data_set>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_remediation_atom_site_mappingCategory/PDBx:pdbx_remediation_atom_site_mapping">
      <PDBo:has_pdbx_remediation_atom_site_mapping>
      <PDBo:pdbx_remediation_atom_site_mapping rdf:about="{$base}/pdbx_remediation_atom_site_mapping/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_remediation_atom_site_mapping>
      </PDBo:has_pdbx_remediation_atom_site_mapping>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_rmch_outlierCategory/PDBx:pdbx_rmch_outlier">
      <PDBo:has_pdbx_rmch_outlier>
      <PDBo:pdbx_rmch_outlier rdf:about="{$base}/pdbx_rmch_outlier/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_rmch_outlier>
      </PDBo:has_pdbx_rmch_outlier>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_rms_devs_cov_by_monomerCategory/PDBx:pdbx_rms_devs_cov_by_monomer">
      <PDBo:has_pdbx_rms_devs_cov_by_monomer>
      <PDBo:pdbx_rms_devs_cov_by_monomer rdf:about="{$base}/pdbx_rms_devs_cov_by_monomer/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_rms_devs_cov_by_monomer>
      </PDBo:has_pdbx_rms_devs_cov_by_monomer>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_rms_devs_covalentCategory/PDBx:pdbx_rms_devs_covalent">
      <PDBo:has_pdbx_rms_devs_covalent>
      <PDBo:pdbx_rms_devs_covalent rdf:about="{$base}/pdbx_rms_devs_covalent/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_rms_devs_covalent rdf:resource="{$base}/pdbx_rms_devs_covalent/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_72_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_rms_devs_covalent>
      </PDBo:has_pdbx_rms_devs_covalent>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_robot_systemCategory/PDBx:pdbx_robot_system">
      <PDBo:has_pdbx_robot_system>
      <PDBo:pdbx_robot_system rdf:about="{$base}/pdbx_robot_system/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_robot_system>
      </PDBo:has_pdbx_robot_system>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_seq_map_depositor_infoCategory/PDBx:pdbx_seq_map_depositor_info">
      <PDBo:has_pdbx_seq_map_depositor_info>
      <PDBo:pdbx_seq_map_depositor_info rdf:about="{$base}/pdbx_seq_map_depositor_info/{translate(@auth_asym_id,' ^','_')},{translate(@entity_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_seq_map_depositor_info>
      </PDBo:has_pdbx_seq_map_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_sequence_annotationCategory/PDBx:pdbx_sequence_annotation">
      <PDBo:has_pdbx_sequence_annotation>
      <PDBo:pdbx_sequence_annotation rdf:about="{$base}/pdbx_sequence_annotation/{translate(@pdb_chain_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_sequence_annotation>
      </PDBo:has_pdbx_sequence_annotation>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_sequence_patternCategory/PDBx:pdbx_sequence_pattern">
      <PDBo:has_pdbx_sequence_pattern>
      <PDBo:pdbx_sequence_pattern rdf:about="{$base}/pdbx_sequence_pattern/{translate(@label_asym_id,' ^','_')},{translate(@sequence_pattern,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_sequence_pattern>
      </PDBo:has_pdbx_sequence_pattern>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_sequence_rangeCategory/PDBx:pdbx_sequence_range">
      <PDBo:has_pdbx_sequence_range>
      <PDBo:pdbx_sequence_range rdf:about="{$base}/pdbx_sequence_range/{translate(@beg_label_alt_id,' ^','_')},{translate(@beg_label_asym_id,' ^','_')},{translate(@beg_label_comp_id,' ^','_')},{translate(@beg_label_seq_id,' ^','_')},{translate(@end_label_alt_id,' ^','_')},{translate(@end_label_asym_id,' ^','_')},{translate(@end_label_comp_id,' ^','_')},{translate(@end_label_seq_id,' ^','_')},{translate(@seq_range_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_sequence_range>
      </PDBo:has_pdbx_sequence_range>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_serial_crystallography_data_reductionCategory/PDBx:pdbx_serial_crystallography_data_reduction">
      <PDBo:has_pdbx_serial_crystallography_data_reduction>
      <PDBo:pdbx_serial_crystallography_data_reduction rdf:about="{$base}/pdbx_serial_crystallography_data_reduction/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_serial_crystallography_data_reduction rdf:resource="{$base}/pdbx_serial_crystallography_data_reduction/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_11_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_serial_crystallography_data_reduction>
      </PDBo:has_pdbx_serial_crystallography_data_reduction>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_serial_crystallography_measurementCategory/PDBx:pdbx_serial_crystallography_measurement">
      <PDBo:has_pdbx_serial_crystallography_measurement>
      <PDBo:pdbx_serial_crystallography_measurement rdf:about="{$base}/pdbx_serial_crystallography_measurement/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_serial_crystallography_measurement rdf:resource="{$base}/pdbx_serial_crystallography_measurement/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_12_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_serial_crystallography_measurement>
      </PDBo:has_pdbx_serial_crystallography_measurement>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_serial_crystallography_sample_deliveryCategory/PDBx:pdbx_serial_crystallography_sample_delivery">
      <PDBo:has_pdbx_serial_crystallography_sample_delivery>
      <PDBo:pdbx_serial_crystallography_sample_delivery rdf:about="{$base}/pdbx_serial_crystallography_sample_delivery/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_serial_crystallography_sample_delivery rdf:resource="{$base}/pdbx_serial_crystallography_sample_delivery/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_13_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_serial_crystallography_sample_delivery>
      </PDBo:has_pdbx_serial_crystallography_sample_delivery>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_serial_crystallography_sample_delivery_fixed_targetCategory/PDBx:pdbx_serial_crystallography_sample_delivery_fixed_target">
      <PDBo:has_pdbx_serial_crystallography_sample_delivery_fixed_target>
      <PDBo:pdbx_serial_crystallography_sample_delivery_fixed_target rdf:about="{$base}/pdbx_serial_crystallography_sample_delivery_fixed_target/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_serial_crystallography_sample_delivery_fixed_target rdf:resource="{$base}/pdbx_serial_crystallography_sample_delivery_fixed_target/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_14_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_serial_crystallography_sample_delivery_fixed_target>
      </PDBo:has_pdbx_serial_crystallography_sample_delivery_fixed_target>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_serial_crystallography_sample_delivery_injectionCategory/PDBx:pdbx_serial_crystallography_sample_delivery_injection">
      <PDBo:has_pdbx_serial_crystallography_sample_delivery_injection>
      <PDBo:pdbx_serial_crystallography_sample_delivery_injection rdf:about="{$base}/pdbx_serial_crystallography_sample_delivery_injection/{translate(@diffrn_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@diffrn_id!=''">
        <PDBo:reference_to_diffrn>
	  <rdf:Description  rdf:about="{$base}/diffrn/{translate(@diffrn_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_serial_crystallography_sample_delivery_injection rdf:resource="{$base}/pdbx_serial_crystallography_sample_delivery_injection/{translate(@diffrn_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_diffrn>
        <!-- diffrnKeyref_0_0_15_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_serial_crystallography_sample_delivery_injection>
      </PDBo:has_pdbx_serial_crystallography_sample_delivery_injection>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_soln_scatterCategory/PDBx:pdbx_soln_scatter">
      <PDBo:has_pdbx_soln_scatter>
      <PDBo:pdbx_soln_scatter rdf:about="{$base}/pdbx_soln_scatter/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_soln_scatter rdf:resource="{$base}/pdbx_soln_scatter/{translate(@entry_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_73_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_soln_scatter>
      </PDBo:has_pdbx_soln_scatter>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_soln_scatter_modelCategory/PDBx:pdbx_soln_scatter_model">
      <PDBo:has_pdbx_soln_scatter_model>
      <PDBo:pdbx_soln_scatter_model rdf:about="{$base}/pdbx_soln_scatter_model/{translate(@id,' ^','_')},{translate(@scatter_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_soln_scatter_model>
      </PDBo:has_pdbx_soln_scatter_model>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_solvent_atom_site_mappingCategory/PDBx:pdbx_solvent_atom_site_mapping">
      <PDBo:has_pdbx_solvent_atom_site_mapping>
      <PDBo:pdbx_solvent_atom_site_mapping rdf:about="{$base}/pdbx_solvent_atom_site_mapping/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_solvent_atom_site_mapping>
      </PDBo:has_pdbx_solvent_atom_site_mapping>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_solvent_infoCategory/PDBx:pdbx_solvent_info">
      <PDBo:has_pdbx_solvent_info>
      <PDBo:pdbx_solvent_info rdf:about="{$base}/pdbx_solvent_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_solvent_info>
      </PDBo:has_pdbx_solvent_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_sourceCategory/PDBx:pdbx_source">
      <PDBo:has_pdbx_source>
      <PDBo:pdbx_source rdf:about="{$base}/pdbx_source/{translate(@src_method,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_source>
      </PDBo:has_pdbx_source>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_stereochemistryCategory/PDBx:pdbx_stereochemistry">
      <PDBo:has_pdbx_stereochemistry>
      <PDBo:pdbx_stereochemistry rdf:about="{$base}/pdbx_stereochemistry/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_stereochemistry>
      </PDBo:has_pdbx_stereochemistry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assemblyCategory/PDBx:pdbx_struct_assembly">
      <PDBo:has_pdbx_struct_assembly>
      <PDBo:pdbx_struct_assembly rdf:about="{$base}/pdbx_struct_assembly/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly>
      </PDBo:has_pdbx_struct_assembly>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assembly_auth_classificationCategory/PDBx:pdbx_struct_assembly_auth_classification">
      <PDBo:has_pdbx_struct_assembly_auth_classification>
      <PDBo:pdbx_struct_assembly_auth_classification rdf:about="{$base}/pdbx_struct_assembly_auth_classification/{translate(@assembly_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@assembly_id!=''">
        <PDBo:reference_to_pdbx_struct_assembly>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_assembly/{translate(@assembly_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_assembly_auth_classification rdf:resource="{$base}/pdbx_struct_assembly_auth_classification/{translate(@assembly_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_struct_assembly>
        <!-- pdbx_struct_assemblyKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_auth_classification>
      </PDBo:has_pdbx_struct_assembly_auth_classification>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assembly_auth_evidenceCategory/PDBx:pdbx_struct_assembly_auth_evidence">
      <PDBo:has_pdbx_struct_assembly_auth_evidence>
      <PDBo:pdbx_struct_assembly_auth_evidence rdf:about="{$base}/pdbx_struct_assembly_auth_evidence/{translate(@assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@assembly_id!=''">
        <PDBo:reference_to_pdbx_struct_assembly>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_assembly/{translate(@assembly_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_assembly_auth_evidence rdf:resource="{$base}/pdbx_struct_assembly_auth_evidence/{translate(@assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_struct_assembly>
        <!-- pdbx_struct_assemblyKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_auth_evidence>
      </PDBo:has_pdbx_struct_assembly_auth_evidence>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assembly_auth_evidence_depositor_infoCategory/PDBx:pdbx_struct_assembly_auth_evidence_depositor_info">
      <PDBo:has_pdbx_struct_assembly_auth_evidence_depositor_info>
      <PDBo:pdbx_struct_assembly_auth_evidence_depositor_info rdf:about="{$base}/pdbx_struct_assembly_auth_evidence_depositor_info/{translate(@assembly_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@assembly_id!=''">
        <PDBo:reference_to_pdbx_struct_assembly_depositor_info>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_assembly_depositor_info/{translate(@assembly_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_assembly_auth_evidence_depositor_info rdf:resource="{$base}/pdbx_struct_assembly_auth_evidence_depositor_info/{translate(@assembly_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_struct_assembly_depositor_info>
        <!-- pdbx_struct_assembly_depositor_infoKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_auth_evidence_depositor_info>
      </PDBo:has_pdbx_struct_assembly_auth_evidence_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assembly_depositor_infoCategory/PDBx:pdbx_struct_assembly_depositor_info">
      <PDBo:has_pdbx_struct_assembly_depositor_info>
      <PDBo:pdbx_struct_assembly_depositor_info rdf:about="{$base}/pdbx_struct_assembly_depositor_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_depositor_info>
      </PDBo:has_pdbx_struct_assembly_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assembly_genCategory/PDBx:pdbx_struct_assembly_gen">
      <PDBo:has_pdbx_struct_assembly_gen>
      <PDBo:pdbx_struct_assembly_gen rdf:about="{$base}/pdbx_struct_assembly_gen/{translate(@assembly_id,' ^','_')},{translate(@asym_id_list,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@assembly_id!=''">
        <PDBo:reference_to_pdbx_struct_assembly>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_assembly/{translate(@assembly_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_assembly_gen rdf:resource="{$base}/pdbx_struct_assembly_gen/{translate(@assembly_id,' ^','_')},{translate(@asym_id_list,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_struct_assembly>
        <!-- pdbx_struct_assemblyKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_gen>
      </PDBo:has_pdbx_struct_assembly_gen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assembly_gen_depositor_infoCategory/PDBx:pdbx_struct_assembly_gen_depositor_info">
      <PDBo:has_pdbx_struct_assembly_gen_depositor_info>
      <PDBo:pdbx_struct_assembly_gen_depositor_info rdf:about="{$base}/pdbx_struct_assembly_gen_depositor_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:assembly_id!=''">
        <PDBo:reference_to_pdbx_struct_assembly_depositor_info>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_assembly_depositor_info/{translate(PDBx:assembly_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_assembly_gen_depositor_info rdf:resource="{$base}/pdbx_struct_assembly_gen_depositor_info/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_struct_assembly_depositor_info>
        <!-- pdbx_struct_assembly_depositor_infoKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_gen_depositor_info>
      </PDBo:has_pdbx_struct_assembly_gen_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assembly_propCategory/PDBx:pdbx_struct_assembly_prop">
      <PDBo:has_pdbx_struct_assembly_prop>
      <PDBo:pdbx_struct_assembly_prop rdf:about="{$base}/pdbx_struct_assembly_prop/{translate(@biol_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_prop>
      </PDBo:has_pdbx_struct_assembly_prop>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_assembly_prop_depositor_infoCategory/PDBx:pdbx_struct_assembly_prop_depositor_info">
      <PDBo:has_pdbx_struct_assembly_prop_depositor_info>
      <PDBo:pdbx_struct_assembly_prop_depositor_info rdf:about="{$base}/pdbx_struct_assembly_prop_depositor_info/{translate(@biol_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_assembly_prop_depositor_info>
      </PDBo:has_pdbx_struct_assembly_prop_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_asym_genCategory/PDBx:pdbx_struct_asym_gen">
      <PDBo:has_pdbx_struct_asym_gen>
      <PDBo:pdbx_struct_asym_gen rdf:about="{$base}/pdbx_struct_asym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_inst_id!=''">
        <PDBo:reference_to_pdbx_struct_entity_inst>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@entity_inst_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_asym_gen rdf:resource="{$base}/pdbx_struct_asym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_biol_funcCategory/PDBx:pdbx_struct_biol_func">
      <PDBo:has_pdbx_struct_biol_func>
      <PDBo:pdbx_struct_biol_func rdf:about="{$base}/pdbx_struct_biol_func/{translate(@biol_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@biol_id!=''">
        <PDBo:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(@biol_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_biol_func rdf:resource="{$base}/pdbx_struct_biol_func/{translate(@biol_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_biol_func>
      </PDBo:has_pdbx_struct_biol_func>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_chem_comp_diagnosticsCategory/PDBx:pdbx_struct_chem_comp_diagnostics">
      <PDBo:has_pdbx_struct_chem_comp_diagnostics>
      <PDBo:pdbx_struct_chem_comp_diagnostics rdf:about="{$base}/pdbx_struct_chem_comp_diagnostics/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_chem_comp_diagnostics>
      </PDBo:has_pdbx_struct_chem_comp_diagnostics>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_chem_comp_featureCategory/PDBx:pdbx_struct_chem_comp_feature">
      <PDBo:has_pdbx_struct_chem_comp_feature>
      <PDBo:pdbx_struct_chem_comp_feature rdf:about="{$base}/pdbx_struct_chem_comp_feature/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_chem_comp_feature>
      </PDBo:has_pdbx_struct_chem_comp_feature>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_conn_angleCategory/PDBx:pdbx_struct_conn_angle">
      <PDBo:has_pdbx_struct_conn_angle>
      <PDBo:pdbx_struct_conn_angle rdf:about="{$base}/pdbx_struct_conn_angle/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_conn_angle>
      </PDBo:has_pdbx_struct_conn_angle>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_entity_instCategory/PDBx:pdbx_struct_entity_inst">
      <PDBo:has_pdbx_struct_entity_inst>
      <PDBo:pdbx_struct_entity_inst rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_entity_inst>
      </PDBo:has_pdbx_struct_entity_inst>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_group_component_rangeCategory/PDBx:pdbx_struct_group_component_range">
      <PDBo:has_pdbx_struct_group_component_range>
      <PDBo:pdbx_struct_group_component_range rdf:about="{$base}/pdbx_struct_group_component_range/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:struct_group_id!=''">
        <PDBo:reference_to_pdbx_struct_group_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_group_list/{translate(PDBx:struct_group_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_group_component_range rdf:resource="{$base}/pdbx_struct_group_component_range/{translate(@ordinal,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_group_componentsCategory/PDBx:pdbx_struct_group_components">
      <PDBo:has_pdbx_struct_group_components>
      <PDBo:pdbx_struct_group_components rdf:about="{$base}/pdbx_struct_group_components/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:struct_group_id!=''">
        <PDBo:reference_to_pdbx_struct_group_list>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_group_list/{translate(PDBx:struct_group_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_group_components rdf:resource="{$base}/pdbx_struct_group_components/{translate(@ordinal,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_group_listCategory/PDBx:pdbx_struct_group_list">
      <PDBo:has_pdbx_struct_group_list>
      <PDBo:pdbx_struct_group_list rdf:about="{$base}/pdbx_struct_group_list/{translate(@struct_group_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_group_list>
      </PDBo:has_pdbx_struct_group_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_infoCategory/PDBx:pdbx_struct_info">
      <PDBo:has_pdbx_struct_info>
      <PDBo:pdbx_struct_info rdf:about="{$base}/pdbx_struct_info/{translate(@type,' ^','_')},{translate(@value,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_info>
      </PDBo:has_pdbx_struct_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_legacy_oper_listCategory/PDBx:pdbx_struct_legacy_oper_list">
      <PDBo:has_pdbx_struct_legacy_oper_list>
      <PDBo:pdbx_struct_legacy_oper_list rdf:about="{$base}/pdbx_struct_legacy_oper_list/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_legacy_oper_list>
      </PDBo:has_pdbx_struct_legacy_oper_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_linkCategory/PDBx:pdbx_struct_link">
      <PDBo:has_pdbx_struct_link>
      <PDBo:pdbx_struct_link rdf:about="{$base}/pdbx_struct_link/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_link>
      </PDBo:has_pdbx_struct_link>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_mod_residueCategory/PDBx:pdbx_struct_mod_residue">
      <PDBo:has_pdbx_struct_mod_residue>
      <PDBo:pdbx_struct_mod_residue rdf:about="{$base}/pdbx_struct_mod_residue/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_mod_residue>
      </PDBo:has_pdbx_struct_mod_residue>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_msym_genCategory/PDBx:pdbx_struct_msym_gen">
      <PDBo:has_pdbx_struct_msym_gen>
      <PDBo:pdbx_struct_msym_gen rdf:about="{$base}/pdbx_struct_msym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@msym_id,' ^','_')},{translate(@oper_expression,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entity_inst_id!=''">
        <PDBo:reference_to_pdbx_struct_entity_inst>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_entity_inst/{translate(@entity_inst_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_msym_gen rdf:resource="{$base}/pdbx_struct_msym_gen/{translate(@entity_inst_id,' ^','_')},{translate(@msym_id,' ^','_')},{translate(@oper_expression,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_ncs_virus_genCategory/PDBx:pdbx_struct_ncs_virus_gen">
      <PDBo:has_pdbx_struct_ncs_virus_gen>
      <PDBo:pdbx_struct_ncs_virus_gen rdf:about="{$base}/pdbx_struct_ncs_virus_gen/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:asym_id!=''">
        <PDBo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(PDBx:asym_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_ncs_virus_gen rdf:resource="{$base}/pdbx_struct_ncs_virus_gen/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_asym>
        <!-- struct_asymKeyref_1_0_3_0 -->
      </xsl:if>
      <xsl:if test="PDBx:oper_id!=''">
        <PDBo:reference_to_struct_ncs_oper>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_oper/{translate(PDBx:oper_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_ncs_virus_gen rdf:resource="{$base}/pdbx_struct_ncs_virus_gen/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_ncs_oper>
        <!-- struct_ncs_operKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ncs_virus_gen>
      </PDBo:has_pdbx_struct_ncs_virus_gen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_oper_listCategory/PDBx:pdbx_struct_oper_list">
      <PDBo:has_pdbx_struct_oper_list>
      <PDBo:pdbx_struct_oper_list rdf:about="{$base}/pdbx_struct_oper_list/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_oper_list>
      </PDBo:has_pdbx_struct_oper_list>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_oper_list_depositor_infoCategory/PDBx:pdbx_struct_oper_list_depositor_info">
      <PDBo:has_pdbx_struct_oper_list_depositor_info>
      <PDBo:pdbx_struct_oper_list_depositor_info rdf:about="{$base}/pdbx_struct_oper_list_depositor_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_oper_list_depositor_info>
      </PDBo:has_pdbx_struct_oper_list_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_pack_genCategory/PDBx:pdbx_struct_pack_gen">
      <PDBo:has_pdbx_struct_pack_gen>
      <PDBo:pdbx_struct_pack_gen rdf:about="{$base}/pdbx_struct_pack_gen/{translate(@asym_id,' ^','_')},{translate(@id,' ^','_')},{translate(@symmetry,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_pack_gen>
      </PDBo:has_pdbx_struct_pack_gen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_ref_seq_deletionCategory/PDBx:pdbx_struct_ref_seq_deletion">
      <PDBo:has_pdbx_struct_ref_seq_deletion>
      <PDBo:pdbx_struct_ref_seq_deletion rdf:about="{$base}/pdbx_struct_ref_seq_deletion/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ref_seq_deletion>
      </PDBo:has_pdbx_struct_ref_seq_deletion>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_ref_seq_depositor_infoCategory/PDBx:pdbx_struct_ref_seq_depositor_info">
      <PDBo:has_pdbx_struct_ref_seq_depositor_info>
      <PDBo:pdbx_struct_ref_seq_depositor_info rdf:about="{$base}/pdbx_struct_ref_seq_depositor_info/{translate(@ref_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ref_seq_depositor_info>
      </PDBo:has_pdbx_struct_ref_seq_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_ref_seq_dif_depositor_infoCategory/PDBx:pdbx_struct_ref_seq_dif_depositor_info">
      <PDBo:has_pdbx_struct_ref_seq_dif_depositor_info>
      <PDBo:pdbx_struct_ref_seq_dif_depositor_info rdf:about="{$base}/pdbx_struct_ref_seq_dif_depositor_info/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ref_seq_dif_depositor_info>
      </PDBo:has_pdbx_struct_ref_seq_dif_depositor_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_ref_seq_featureCategory/PDBx:pdbx_struct_ref_seq_feature">
      <PDBo:has_pdbx_struct_ref_seq_feature>
      <PDBo:pdbx_struct_ref_seq_feature rdf:about="{$base}/pdbx_struct_ref_seq_feature/{translate(@feature_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ref_seq_feature>
      </PDBo:has_pdbx_struct_ref_seq_feature>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_ref_seq_feature_propCategory/PDBx:pdbx_struct_ref_seq_feature_prop">
      <PDBo:has_pdbx_struct_ref_seq_feature_prop>
      <PDBo:pdbx_struct_ref_seq_feature_prop rdf:about="{$base}/pdbx_struct_ref_seq_feature_prop/{translate(@feature_id,' ^','_')},{translate(@property_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@feature_id!=''">
        <PDBo:reference_to_pdbx_struct_ref_seq_feature>
	  <rdf:Description  rdf:about="{$base}/pdbx_struct_ref_seq_feature/{translate(@feature_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_ref_seq_feature_prop rdf:resource="{$base}/pdbx_struct_ref_seq_feature_prop/{translate(@feature_id,' ^','_')},{translate(@property_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_struct_ref_seq_feature>
        <!-- pdbx_struct_ref_seq_featureKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ref_seq_feature_prop>
      </PDBo:has_pdbx_struct_ref_seq_feature_prop>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_ref_seq_insertionCategory/PDBx:pdbx_struct_ref_seq_insertion">
      <PDBo:has_pdbx_struct_ref_seq_insertion>
      <PDBo:pdbx_struct_ref_seq_insertion rdf:about="{$base}/pdbx_struct_ref_seq_insertion/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_ref_seq_insertion>
      </PDBo:has_pdbx_struct_ref_seq_insertion>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_sheet_hbondCategory/PDBx:pdbx_struct_sheet_hbond">
      <PDBo:has_pdbx_struct_sheet_hbond>
      <PDBo:pdbx_struct_sheet_hbond rdf:about="{$base}/pdbx_struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_sheet_hbond rdf:resource="{$base}/pdbx_struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_struct_special_symmetryCategory/PDBx:pdbx_struct_special_symmetry">
      <PDBo:has_pdbx_struct_special_symmetry>
      <PDBo:pdbx_struct_special_symmetry rdf:about="{$base}/pdbx_struct_special_symmetry/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:auth_comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(PDBx:auth_comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_struct_special_symmetry rdf:resource="{$base}/pdbx_struct_special_symmetry/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_2_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_struct_special_symmetry>
      </PDBo:has_pdbx_struct_special_symmetry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_sugar_phosphate_geometryCategory/PDBx:pdbx_sugar_phosphate_geometry">
      <PDBo:has_pdbx_sugar_phosphate_geometry>
      <PDBo:pdbx_sugar_phosphate_geometry rdf:about="{$base}/pdbx_sugar_phosphate_geometry/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_sugar_phosphate_geometry>
      </PDBo:has_pdbx_sugar_phosphate_geometry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_summary_flagsCategory/PDBx:pdbx_summary_flags">
      <PDBo:has_pdbx_summary_flags>
      <PDBo:pdbx_summary_flags rdf:about="{$base}/pdbx_summary_flags/{translate(@entry_id,' ^','_')},{translate(@flag_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_summary_flags rdf:resource="{$base}/pdbx_summary_flags/{translate(@entry_id,' ^','_')},{translate(@flag_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_74_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_summary_flags>
      </PDBo:has_pdbx_summary_flags>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_supporting_exp_data_setCategory/PDBx:pdbx_supporting_exp_data_set">
      <PDBo:has_pdbx_supporting_exp_data_set>
      <PDBo:pdbx_supporting_exp_data_set rdf:about="{$base}/pdbx_supporting_exp_data_set/{translate(@ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_supporting_exp_data_set>
      </PDBo:has_pdbx_supporting_exp_data_set>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_tableinfoCategory/PDBx:pdbx_tableinfo">
      <PDBo:has_pdbx_tableinfo>
      <PDBo:pdbx_tableinfo rdf:about="{$base}/pdbx_tableinfo/{translate(@tablename,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_tableinfo>
      </PDBo:has_pdbx_tableinfo>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_trna_infoCategory/PDBx:pdbx_trna_info">
      <PDBo:has_pdbx_trna_info>
      <PDBo:pdbx_trna_info rdf:about="{$base}/pdbx_trna_info/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_trna_info>
      </PDBo:has_pdbx_trna_info>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_unobs_or_zero_occ_atomsCategory/PDBx:pdbx_unobs_or_zero_occ_atoms">
      <PDBo:has_pdbx_unobs_or_zero_occ_atoms>
      <PDBo:pdbx_unobs_or_zero_occ_atoms rdf:about="{$base}/pdbx_unobs_or_zero_occ_atoms/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:auth_comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(PDBx:auth_comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_unobs_or_zero_occ_atoms rdf:resource="{$base}/pdbx_unobs_or_zero_occ_atoms/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_20_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_unobs_or_zero_occ_atoms>
      </PDBo:has_pdbx_unobs_or_zero_occ_atoms>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_unobs_or_zero_occ_residuesCategory/PDBx:pdbx_unobs_or_zero_occ_residues">
      <PDBo:has_pdbx_unobs_or_zero_occ_residues>
      <PDBo:pdbx_unobs_or_zero_occ_residues rdf:about="{$base}/pdbx_unobs_or_zero_occ_residues/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:auth_comp_id!=''">
        <PDBo:reference_to_chem_comp>
	  <rdf:Description  rdf:about="{$base}/chem_comp/{translate(PDBx:auth_comp_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_unobs_or_zero_occ_residues rdf:resource="{$base}/pdbx_unobs_or_zero_occ_residues/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_chem_comp>
        <!-- chem_compKeyref_0_0_21_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_unobs_or_zero_occ_residues>
      </PDBo:has_pdbx_unobs_or_zero_occ_residues>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_unpairCategory/PDBx:pdbx_unpair">
      <PDBo:has_pdbx_unpair>
      <PDBo:pdbx_unpair rdf:about="{$base}/pdbx_unpair/{translate(@chain_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_unpair>
      </PDBo:has_pdbx_unpair>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_val_angleCategory/PDBx:pdbx_val_angle">
      <PDBo:has_pdbx_val_angle>
      <PDBo:pdbx_val_angle rdf:about="{$base}/pdbx_val_angle/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_val_angle>
      </PDBo:has_pdbx_val_angle>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_val_bondCategory/PDBx:pdbx_val_bond">
      <PDBo:has_pdbx_val_bond>
      <PDBo:pdbx_val_bond rdf:about="{$base}/pdbx_val_bond/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_val_bond>
      </PDBo:has_pdbx_val_bond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_val_chiralCategory/PDBx:pdbx_val_chiral">
      <PDBo:has_pdbx_val_chiral>
      <PDBo:pdbx_val_chiral rdf:about="{$base}/pdbx_val_chiral/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_val_chiral>
      </PDBo:has_pdbx_val_chiral>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_val_contactCategory/PDBx:pdbx_val_contact">
      <PDBo:has_pdbx_val_contact>
      <PDBo:pdbx_val_contact rdf:about="{$base}/pdbx_val_contact/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_val_contact>
      </PDBo:has_pdbx_val_contact>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_val_sym_contactCategory/PDBx:pdbx_val_sym_contact">
      <PDBo:has_pdbx_val_sym_contact>
      <PDBo:pdbx_val_sym_contact rdf:about="{$base}/pdbx_val_sym_contact/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_val_sym_contact>
      </PDBo:has_pdbx_val_sym_contact>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_chiralCategory/PDBx:pdbx_validate_chiral">
      <PDBo:has_pdbx_validate_chiral>
      <PDBo:pdbx_validate_chiral rdf:about="{$base}/pdbx_validate_chiral/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_chiral>
      </PDBo:has_pdbx_validate_chiral>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_close_contactCategory/PDBx:pdbx_validate_close_contact">
      <PDBo:has_pdbx_validate_close_contact>
      <PDBo:pdbx_validate_close_contact rdf:about="{$base}/pdbx_validate_close_contact/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_close_contact>
      </PDBo:has_pdbx_validate_close_contact>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_main_chain_planeCategory/PDBx:pdbx_validate_main_chain_plane">
      <PDBo:has_pdbx_validate_main_chain_plane>
      <PDBo:pdbx_validate_main_chain_plane rdf:about="{$base}/pdbx_validate_main_chain_plane/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_main_chain_plane>
      </PDBo:has_pdbx_validate_main_chain_plane>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_peptide_omegaCategory/PDBx:pdbx_validate_peptide_omega">
      <PDBo:has_pdbx_validate_peptide_omega>
      <PDBo:pdbx_validate_peptide_omega rdf:about="{$base}/pdbx_validate_peptide_omega/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_peptide_omega>
      </PDBo:has_pdbx_validate_peptide_omega>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_planesCategory/PDBx:pdbx_validate_planes">
      <PDBo:has_pdbx_validate_planes>
      <PDBo:pdbx_validate_planes rdf:about="{$base}/pdbx_validate_planes/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_planes>
      </PDBo:has_pdbx_validate_planes>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_planes_atomCategory/PDBx:pdbx_validate_planes_atom">
      <PDBo:has_pdbx_validate_planes_atom>
      <PDBo:pdbx_validate_planes_atom rdf:about="{$base}/pdbx_validate_planes_atom/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:plane_id!=''">
        <PDBo:reference_to_pdbx_validate_planes>
	  <rdf:Description  rdf:about="{$base}/pdbx_validate_planes/{translate(PDBx:plane_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_validate_planes_atom rdf:resource="{$base}/pdbx_validate_planes_atom/{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_polymer_linkageCategory/PDBx:pdbx_validate_polymer_linkage">
      <PDBo:has_pdbx_validate_polymer_linkage>
      <PDBo:pdbx_validate_polymer_linkage rdf:about="{$base}/pdbx_validate_polymer_linkage/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_polymer_linkage>
      </PDBo:has_pdbx_validate_polymer_linkage>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_rmsd_angleCategory/PDBx:pdbx_validate_rmsd_angle">
      <PDBo:has_pdbx_validate_rmsd_angle>
      <PDBo:pdbx_validate_rmsd_angle rdf:about="{$base}/pdbx_validate_rmsd_angle/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_rmsd_angle>
      </PDBo:has_pdbx_validate_rmsd_angle>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_rmsd_bondCategory/PDBx:pdbx_validate_rmsd_bond">
      <PDBo:has_pdbx_validate_rmsd_bond>
      <PDBo:pdbx_validate_rmsd_bond rdf:about="{$base}/pdbx_validate_rmsd_bond/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_rmsd_bond>
      </PDBo:has_pdbx_validate_rmsd_bond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_symm_contactCategory/PDBx:pdbx_validate_symm_contact">
      <PDBo:has_pdbx_validate_symm_contact>
      <PDBo:pdbx_validate_symm_contact rdf:about="{$base}/pdbx_validate_symm_contact/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_symm_contact>
      </PDBo:has_pdbx_validate_symm_contact>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_validate_torsionCategory/PDBx:pdbx_validate_torsion">
      <PDBo:has_pdbx_validate_torsion>
      <PDBo:pdbx_validate_torsion rdf:about="{$base}/pdbx_validate_torsion/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_validate_torsion>
      </PDBo:has_pdbx_validate_torsion>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_versionCategory/PDBx:pdbx_version">
      <PDBo:has_pdbx_version>
      <PDBo:pdbx_version rdf:about="{$base}/pdbx_version/{translate(@entry_id,' ^','_')},{translate(@major_version,' ^','_')},{translate(@minor_version,' ^','_')},{translate(@revision_type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_version rdf:resource="{$base}/pdbx_version/{translate(@entry_id,' ^','_')},{translate(@major_version,' ^','_')},{translate(@minor_version,' ^','_')},{translate(@revision_type,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_75_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_version>
      </PDBo:has_pdbx_version>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_view_categoryCategory/PDBx:pdbx_view_category">
      <PDBo:has_pdbx_view_category>
      <PDBo:pdbx_view_category rdf:about="{$base}/pdbx_view_category/{translate(@category_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:view_group_id!=''">
        <PDBo:reference_to_pdbx_view_category_group>
	  <rdf:Description  rdf:about="{$base}/pdbx_view_category_group/{translate(PDBx:view_group_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_view_category rdf:resource="{$base}/pdbx_view_category/{translate(@category_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_view_category_group>
        <!-- pdbx_view_category_groupKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_view_category>
      </PDBo:has_pdbx_view_category>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_view_category_groupCategory/PDBx:pdbx_view_category_group">
      <PDBo:has_pdbx_view_category_group>
      <PDBo:pdbx_view_category_group rdf:about="{$base}/pdbx_view_category_group/{translate(@view_group_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_view_category_group>
      </PDBo:has_pdbx_view_category_group>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_view_itemCategory/PDBx:pdbx_view_item">
      <PDBo:has_pdbx_view_item>
      <PDBo:pdbx_view_item rdf:about="{$base}/pdbx_view_item/{translate(@item_name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:category_id!=''">
        <PDBo:reference_to_pdbx_view_category>
	  <rdf:Description  rdf:about="{$base}/pdbx_view_category/{translate(PDBx:category_id,' ^','_')}">
	    <PDBo:referenced_by_pdbx_view_item rdf:resource="{$base}/pdbx_view_item/{translate(@item_name,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_pdbx_view_category>
        <!-- pdbx_view_categoryKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_view_item>
      </PDBo:has_pdbx_view_item>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_virtual_angleCategory/PDBx:pdbx_virtual_angle">
      <PDBo:has_pdbx_virtual_angle>
      <PDBo:pdbx_virtual_angle rdf:about="{$base}/pdbx_virtual_angle/{translate(@atom_site_id_1,' ^','_')},{translate(@atom_site_id_2,' ^','_')},{translate(@atom_site_id_3,' ^','_')},{translate(@model_id,' ^','_')},{translate(@site_symmetry_1,' ^','_')},{translate(@site_symmetry_2,' ^','_')},{translate(@site_symmetry_3,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_virtual_angle>
      </PDBo:has_pdbx_virtual_angle>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_virtual_bondCategory/PDBx:pdbx_virtual_bond">
      <PDBo:has_pdbx_virtual_bond>
      <PDBo:pdbx_virtual_bond rdf:about="{$base}/pdbx_virtual_bond/{translate(@atom_site_id_1,' ^','_')},{translate(@atom_site_id_2,' ^','_')},{translate(@model_id,' ^','_')},{translate(@site_symmetry_1,' ^','_')},{translate(@site_symmetry_2,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_virtual_bond>
      </PDBo:has_pdbx_virtual_bond>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_virtual_torsionCategory/PDBx:pdbx_virtual_torsion">
      <PDBo:has_pdbx_virtual_torsion>
      <PDBo:pdbx_virtual_torsion rdf:about="{$base}/pdbx_virtual_torsion/{translate(@atom_site_id_1,' ^','_')},{translate(@atom_site_id_2,' ^','_')},{translate(@atom_site_id_3,' ^','_')},{translate(@atom_site_id_4,' ^','_')},{translate(@model_id,' ^','_')},{translate(@site_symmetry_1,' ^','_')},{translate(@site_symmetry_2,' ^','_')},{translate(@site_symmetry_3,' ^','_')},{translate(@site_symmetry_4,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_virtual_torsion>
      </PDBo:has_pdbx_virtual_torsion>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:pdbx_xplor_fileCategory/PDBx:pdbx_xplor_file">
      <PDBo:has_pdbx_xplor_file>
      <PDBo:pdbx_xplor_file rdf:about="{$base}/pdbx_xplor_file/{translate(@pdbx_refine_id,' ^','_')},{translate(@serial_no,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:pdbx_xplor_file>
      </PDBo:has_pdbx_xplor_file>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasingCategory/PDBx:phasing">
      <PDBo:has_phasing>
      <PDBo:phasing rdf:about="{$base}/phasing/{translate(@method,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing>
      </PDBo:has_phasing>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasing_MADCategory/PDBx:phasing_MAD">
      <PDBo:has_phasing_MAD>
      <PDBo:phasing_MAD rdf:about="{$base}/phasing_MAD/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MAD rdf:resource="{$base}/phasing_MAD/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_76_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MAD>
      </PDBo:has_phasing_MAD>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasing_MAD_clustCategory/PDBx:phasing_MAD_clust">
      <PDBo:has_phasing_MAD_clust>
      <PDBo:phasing_MAD_clust rdf:about="{$base}/phasing_MAD_clust/{translate(@expt_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <PDBo:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MAD_clust rdf:resource="{$base}/phasing_MAD_clust/{translate(@expt_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:phasing_MAD_exptCategory/PDBx:phasing_MAD_expt">
      <PDBo:has_phasing_MAD_expt>
      <PDBo:phasing_MAD_expt rdf:about="{$base}/phasing_MAD_expt/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MAD_expt>
      </PDBo:has_phasing_MAD_expt>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasing_MAD_ratioCategory/PDBx:phasing_MAD_ratio">
      <PDBo:has_phasing_MAD_ratio>
      <PDBo:phasing_MAD_ratio rdf:about="{$base}/phasing_MAD_ratio/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@wavelength_1,' ^','_')},{translate(@wavelength_2,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <PDBo:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MAD_ratio rdf:resource="{$base}/phasing_MAD_ratio/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@wavelength_1,' ^','_')},{translate(@wavelength_2,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:phasing_MAD_setCategory/PDBx:phasing_MAD_set">
      <PDBo:has_phasing_MAD_set>
      <PDBo:phasing_MAD_set rdf:about="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@expt_id!=''">
        <PDBo:reference_to_phasing_MAD_expt>
	  <rdf:Description  rdf:about="{$base}/phasing_MAD_expt/{translate(@expt_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MAD_set rdf:resource="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_phasing_MAD_expt>
        <!-- phasing_MAD_exptKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:if test="@set_id!=''">
        <PDBo:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MAD_set rdf:resource="{$base}/phasing_MAD_set/{translate(@clust_id,' ^','_')},{translate(@expt_id,' ^','_')},{translate(@set_id,' ^','_')},{translate(@wavelength,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:phasing_MIRCategory/PDBx:phasing_MIR">
      <PDBo:has_phasing_MIR>
      <PDBo:phasing_MIR rdf:about="{$base}/phasing_MIR/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MIR rdf:resource="{$base}/phasing_MIR/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_77_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MIR>
      </PDBo:has_phasing_MIR>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasing_MIR_derCategory/PDBx:phasing_MIR_der">
      <PDBo:has_phasing_MIR_der>
      <PDBo:phasing_MIR_der rdf:about="{$base}/phasing_MIR_der/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:der_set_id!=''">
        <PDBo:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(PDBx:der_set_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MIR_der rdf:resource="{$base}/phasing_MIR_der/{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:phasing_MIR_der_reflnCategory/PDBx:phasing_MIR_der_refln">
      <PDBo:has_phasing_MIR_der_refln>
      <PDBo:phasing_MIR_der_refln rdf:about="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <PDBo:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MIR_der_refln rdf:resource="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_phasing_MIR_der>
        <!-- phasing_MIR_derKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:if test="@set_id!=''">
        <PDBo:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MIR_der_refln rdf:resource="{$base}/phasing_MIR_der_refln/{translate(@der_id,' ^','_')},{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:phasing_MIR_der_shellCategory/PDBx:phasing_MIR_der_shell">
      <PDBo:has_phasing_MIR_der_shell>
      <PDBo:phasing_MIR_der_shell rdf:about="{$base}/phasing_MIR_der_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@der_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <PDBo:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MIR_der_shell rdf:resource="{$base}/phasing_MIR_der_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')},{translate(@der_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:phasing_MIR_der_siteCategory/PDBx:phasing_MIR_der_site">
      <PDBo:has_phasing_MIR_der_site>
      <PDBo:phasing_MIR_der_site rdf:about="{$base}/phasing_MIR_der_site/{translate(@der_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@der_id!=''">
        <PDBo:reference_to_phasing_MIR_der>
	  <rdf:Description  rdf:about="{$base}/phasing_MIR_der/{translate(@der_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_MIR_der_site rdf:resource="{$base}/phasing_MIR_der_site/{translate(@der_id,' ^','_')},{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:phasing_MIR_shellCategory/PDBx:phasing_MIR_shell">
      <PDBo:has_phasing_MIR_shell>
      <PDBo:phasing_MIR_shell rdf:about="{$base}/phasing_MIR_shell/{translate(@d_res_high,' ^','_')},{translate(@d_res_low,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_MIR_shell>
      </PDBo:has_phasing_MIR_shell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasing_averagingCategory/PDBx:phasing_averaging">
      <PDBo:has_phasing_averaging>
      <PDBo:phasing_averaging rdf:about="{$base}/phasing_averaging/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_averaging rdf:resource="{$base}/phasing_averaging/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_78_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_averaging>
      </PDBo:has_phasing_averaging>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasing_isomorphousCategory/PDBx:phasing_isomorphous">
      <PDBo:has_phasing_isomorphous>
      <PDBo:phasing_isomorphous rdf:about="{$base}/phasing_isomorphous/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_isomorphous rdf:resource="{$base}/phasing_isomorphous/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_79_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_isomorphous>
      </PDBo:has_phasing_isomorphous>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasing_setCategory/PDBx:phasing_set">
      <PDBo:has_phasing_set>
      <PDBo:phasing_set rdf:about="{$base}/phasing_set/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:phasing_set>
      </PDBo:has_phasing_set>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:phasing_set_reflnCategory/PDBx:phasing_set_refln">
      <PDBo:has_phasing_set_refln>
      <PDBo:phasing_set_refln rdf:about="{$base}/phasing_set_refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@set_id!=''">
        <PDBo:reference_to_phasing_set>
	  <rdf:Description  rdf:about="{$base}/phasing_set/{translate(@set_id,' ^','_')}">
	    <PDBo:referenced_by_phasing_set_refln rdf:resource="{$base}/phasing_set_refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')},{translate(@set_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:publCategory/PDBx:publ">
      <PDBo:has_publ>
      <PDBo:publ rdf:about="{$base}/publ/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_publ rdf:resource="{$base}/publ/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_80_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:publ>
      </PDBo:has_publ>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:publ_authorCategory/PDBx:publ_author">
      <PDBo:has_publ_author>
      <PDBo:publ_author rdf:about="{$base}/publ_author/{translate(@name,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:publ_author>
      </PDBo:has_publ_author>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:publ_bodyCategory/PDBx:publ_body">
      <PDBo:has_publ_body>
      <PDBo:publ_body rdf:about="{$base}/publ_body/{translate(@element,' ^','_')},{translate(@label,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:publ_body>
      </PDBo:has_publ_body>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:publ_manuscript_inclCategory/PDBx:publ_manuscript_incl">
      <PDBo:has_publ_manuscript_incl>
      <PDBo:publ_manuscript_incl rdf:about="{$base}/publ_manuscript_incl/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_publ_manuscript_incl rdf:resource="{$base}/publ_manuscript_incl/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_81_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:publ_manuscript_incl>
      </PDBo:has_publ_manuscript_incl>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refineCategory/PDBx:refine">
      <PDBo:has_refine>
      <PDBo:refine rdf:about="{$base}/refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_refine rdf:resource="{$base}/refine/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_82_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine>
      </PDBo:has_refine>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_B_isoCategory/PDBx:refine_B_iso">
      <PDBo:has_refine_B_iso>
      <PDBo:refine_B_iso rdf:about="{$base}/refine_B_iso/{translate(@class,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_B_iso>
      </PDBo:has_refine_B_iso>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_analyzeCategory/PDBx:refine_analyze">
      <PDBo:has_refine_analyze>
      <PDBo:refine_analyze rdf:about="{$base}/refine_analyze/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_refine_analyze rdf:resource="{$base}/refine_analyze/{translate(@entry_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_83_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_analyze>
      </PDBo:has_refine_analyze>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_funct_minimizedCategory/PDBx:refine_funct_minimized">
      <PDBo:has_refine_funct_minimized>
      <PDBo:refine_funct_minimized rdf:about="{$base}/refine_funct_minimized/{translate(@pdbx_refine_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_funct_minimized>
      </PDBo:has_refine_funct_minimized>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_histCategory/PDBx:refine_hist">
      <PDBo:has_refine_hist>
      <PDBo:refine_hist rdf:about="{$base}/refine_hist/{translate(@cycle_id,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_hist>
      </PDBo:has_refine_hist>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_ls_classCategory/PDBx:refine_ls_class">
      <PDBo:has_refine_ls_class>
      <PDBo:refine_ls_class rdf:about="{$base}/refine_ls_class/{translate(@code,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_class>
      </PDBo:has_refine_ls_class>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_ls_restrCategory/PDBx:refine_ls_restr">
      <PDBo:has_refine_ls_restr>
      <PDBo:refine_ls_restr rdf:about="{$base}/refine_ls_restr/{translate(@pdbx_refine_id,' ^','_')},{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_restr>
      </PDBo:has_refine_ls_restr>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_ls_restr_ncsCategory/PDBx:refine_ls_restr_ncs">
      <PDBo:has_refine_ls_restr_ncs>
      <PDBo:refine_ls_restr_ncs rdf:about="{$base}/refine_ls_restr_ncs/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_restr_ncs>
      </PDBo:has_refine_ls_restr_ncs>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_ls_restr_typeCategory/PDBx:refine_ls_restr_type">
      <PDBo:has_refine_ls_restr_type>
      <PDBo:refine_ls_restr_type rdf:about="{$base}/refine_ls_restr_type/{translate(@type,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_restr_type>
      </PDBo:has_refine_ls_restr_type>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_ls_shellCategory/PDBx:refine_ls_shell">
      <PDBo:has_refine_ls_shell>
      <PDBo:refine_ls_shell rdf:about="{$base}/refine_ls_shell/{translate(@d_res_high,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_ls_shell>
      </PDBo:has_refine_ls_shell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refine_occupancyCategory/PDBx:refine_occupancy">
      <PDBo:has_refine_occupancy>
      <PDBo:refine_occupancy rdf:about="{$base}/refine_occupancy/{translate(@class,' ^','_')},{translate(@pdbx_refine_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refine_occupancy>
      </PDBo:has_refine_occupancy>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:reflnCategory/PDBx:refln">
      <PDBo:has_refln>
      <PDBo:refln rdf:about="{$base}/refln/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refln>
      </PDBo:has_refln>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:refln_sys_absCategory/PDBx:refln_sys_abs">
      <PDBo:has_refln_sys_abs>
      <PDBo:refln_sys_abs rdf:about="{$base}/refln_sys_abs/{translate(@index_h,' ^','_')},{translate(@index_k,' ^','_')},{translate(@index_l,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:refln_sys_abs>
      </PDBo:has_refln_sys_abs>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:reflnsCategory/PDBx:reflns">
      <PDBo:has_reflns>
      <PDBo:reflns rdf:about="{$base}/reflns/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(PDBx:entry_id,' ^','_')}">
	    <PDBo:referenced_by_reflns rdf:resource="{$base}/reflns/{translate(@pdbx_ordinal,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_84_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:reflns>
      </PDBo:has_reflns>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:reflns_classCategory/PDBx:reflns_class">
      <PDBo:has_reflns_class>
      <PDBo:reflns_class rdf:about="{$base}/reflns_class/{translate(@code,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:reflns_class>
      </PDBo:has_reflns_class>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:reflns_scaleCategory/PDBx:reflns_scale">
      <PDBo:has_reflns_scale>
      <PDBo:reflns_scale rdf:about="{$base}/reflns_scale/{translate(@group_code,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:reflns_scale>
      </PDBo:has_reflns_scale>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:reflns_shellCategory/PDBx:reflns_shell">
      <PDBo:has_reflns_shell>
      <PDBo:reflns_shell rdf:about="{$base}/reflns_shell/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:reflns_shell>
      </PDBo:has_reflns_shell>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:softwareCategory/PDBx:software">
      <PDBo:has_software>
      <PDBo:software rdf:about="{$base}/software/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:software>
      </PDBo:has_software>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:space_groupCategory/PDBx:space_group">
      <PDBo:has_space_group>
      <PDBo:space_group rdf:about="{$base}/space_group/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:space_group>
      </PDBo:has_space_group>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:space_group_symopCategory/PDBx:space_group_symop">
      <PDBo:has_space_group_symop>
      <PDBo:space_group_symop rdf:about="{$base}/space_group_symop/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:space_group_symop>
      </PDBo:has_space_group_symop>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:structCategory/PDBx:struct">
      <PDBo:has_struct>
      <PDBo:struct rdf:about="{$base}/struct/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_struct rdf:resource="{$base}/struct/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_85_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct>
      </PDBo:has_struct>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_asymCategory/PDBx:struct_asym">
      <PDBo:has_struct_asym>
      <PDBo:struct_asym rdf:about="{$base}/struct_asym/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entity_id!='' and @id!=''">
        <owl:sameAs>
          <PDBo:struct_asym rdf:about="{$base}/struct_asym/{translate(PDBx:entity_id,' ^','_')},{translate(@id,' ^','_')}">
            <rdfs:label>struct_asymUnique_1</rdfs:label>
          </PDBo:struct_asym>
        </owl:sameAs>
      </xsl:if>
      <xsl:if test="PDBx:entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBx:entity_id,' ^','_')}">
	    <PDBo:referenced_by_struct_asym rdf:resource="{$base}/struct_asym/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_36_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_asym>
      </PDBo:has_struct_asym>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_biolCategory/PDBx:struct_biol">
      <PDBo:has_struct_biol>
      <PDBo:struct_biol rdf:about="{$base}/struct_biol/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_biol>
      </PDBo:has_struct_biol>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_biol_genCategory/PDBx:struct_biol_gen">
      <PDBo:has_struct_biol_gen>
      <PDBo:struct_biol_gen rdf:about="{$base}/struct_biol_gen/{translate(@asym_id,' ^','_')},{translate(@biol_id,' ^','_')},{translate(@symmetry,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@asym_id!=''">
        <PDBo:reference_to_struct_asym>
	  <rdf:Description  rdf:about="{$base}/struct_asym/{translate(@asym_id,' ^','_')}">
	    <PDBo:referenced_by_struct_biol_gen rdf:resource="{$base}/struct_biol_gen/{translate(@asym_id,' ^','_')},{translate(@biol_id,' ^','_')},{translate(@symmetry,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_asym>
        <!-- struct_asymKeyref_1_0_4_0 -->
      </xsl:if>
      <xsl:if test="@biol_id!=''">
        <PDBo:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(@biol_id,' ^','_')}">
	    <PDBo:referenced_by_struct_biol_gen rdf:resource="{$base}/struct_biol_gen/{translate(@asym_id,' ^','_')},{translate(@biol_id,' ^','_')},{translate(@symmetry,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_3_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_biol_gen>
      </PDBo:has_struct_biol_gen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_biol_keywordsCategory/PDBx:struct_biol_keywords">
      <PDBo:has_struct_biol_keywords>
      <PDBo:struct_biol_keywords rdf:about="{$base}/struct_biol_keywords/{translate(@biol_id,' ^','_')},{translate(@text,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@biol_id!=''">
        <PDBo:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(@biol_id,' ^','_')}">
	    <PDBo:referenced_by_struct_biol_keywords rdf:resource="{$base}/struct_biol_keywords/{translate(@biol_id,' ^','_')},{translate(@text,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_4_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_biol_keywords>
      </PDBo:has_struct_biol_keywords>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_biol_viewCategory/PDBx:struct_biol_view">
      <PDBo:has_struct_biol_view>
      <PDBo:struct_biol_view rdf:about="{$base}/struct_biol_view/{translate(@biol_id,' ^','_')},{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@biol_id!=''">
        <PDBo:reference_to_struct_biol>
	  <rdf:Description  rdf:about="{$base}/struct_biol/{translate(@biol_id,' ^','_')}">
	    <PDBo:referenced_by_struct_biol_view rdf:resource="{$base}/struct_biol_view/{translate(@biol_id,' ^','_')},{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_biol>
        <!-- struct_biolKeyref_0_0_5_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_biol_view>
      </PDBo:has_struct_biol_view>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_confCategory/PDBx:struct_conf">
      <PDBo:has_struct_conf>
      <PDBo:struct_conf rdf:about="{$base}/struct_conf/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:conf_type_id!=''">
        <PDBo:reference_to_struct_conf_type>
	  <rdf:Description  rdf:about="{$base}/struct_conf_type/{translate(PDBx:conf_type_id,' ^','_')}">
	    <PDBo:referenced_by_struct_conf rdf:resource="{$base}/struct_conf/{translate(@id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_conf_typeCategory/PDBx:struct_conf_type">
      <PDBo:has_struct_conf_type>
      <PDBo:struct_conf_type rdf:about="{$base}/struct_conf_type/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_conf_type>
      </PDBo:has_struct_conf_type>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_connCategory/PDBx:struct_conn">
      <PDBo:has_struct_conn>
      <PDBo:struct_conn rdf:about="{$base}/struct_conn/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:conn_type_id!=''">
        <PDBo:reference_to_struct_conn_type>
	  <rdf:Description  rdf:about="{$base}/struct_conn_type/{translate(PDBx:conn_type_id,' ^','_')}">
	    <PDBo:referenced_by_struct_conn rdf:resource="{$base}/struct_conn/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_conn_type>
        <!-- struct_conn_typeKeyref_0_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_conn>
      </PDBo:has_struct_conn>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_conn_typeCategory/PDBx:struct_conn_type">
      <PDBo:has_struct_conn_type>
      <PDBo:struct_conn_type rdf:about="{$base}/struct_conn_type/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_conn_type>
      </PDBo:has_struct_conn_type>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_keywordsCategory/PDBx:struct_keywords">
      <PDBo:has_struct_keywords>
      <PDBo:struct_keywords rdf:about="{$base}/struct_keywords/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_struct_keywords rdf:resource="{$base}/struct_keywords/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_86_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_keywords>
      </PDBo:has_struct_keywords>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_mon_detailsCategory/PDBx:struct_mon_details">
      <PDBo:has_struct_mon_details>
      <PDBo:struct_mon_details rdf:about="{$base}/struct_mon_details/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_struct_mon_details rdf:resource="{$base}/struct_mon_details/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_87_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_mon_details>
      </PDBo:has_struct_mon_details>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_mon_nuclCategory/PDBx:struct_mon_nucl">
      <PDBo:has_struct_mon_nucl>
      <PDBo:struct_mon_nucl rdf:about="{$base}/struct_mon_nucl/{translate(@label_alt_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@label_comp_id,' ^','_')},{translate(@label_seq_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_mon_nucl>
      </PDBo:has_struct_mon_nucl>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_mon_protCategory/PDBx:struct_mon_prot">
      <PDBo:has_struct_mon_prot>
      <PDBo:struct_mon_prot rdf:about="{$base}/struct_mon_prot/{translate(@label_alt_id,' ^','_')},{translate(@label_asym_id,' ^','_')},{translate(@label_comp_id,' ^','_')},{translate(@label_seq_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_mon_prot>
      </PDBo:has_struct_mon_prot>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_mon_prot_cisCategory/PDBx:struct_mon_prot_cis">
      <PDBo:has_struct_mon_prot_cis>
      <PDBo:struct_mon_prot_cis rdf:about="{$base}/struct_mon_prot_cis/{translate(@pdbx_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_mon_prot_cis>
      </PDBo:has_struct_mon_prot_cis>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_ncs_domCategory/PDBx:struct_ncs_dom">
      <PDBo:has_struct_ncs_dom>
      <PDBo:struct_ncs_dom rdf:about="{$base}/struct_ncs_dom/{translate(@id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@pdbx_ens_id!=''">
        <PDBo:reference_to_struct_ncs_ens>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_ens/{translate(@pdbx_ens_id,' ^','_')}">
	    <PDBo:referenced_by_struct_ncs_dom rdf:resource="{$base}/struct_ncs_dom/{translate(@id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_ncs_dom_limCategory/PDBx:struct_ncs_dom_lim">
      <PDBo:has_struct_ncs_dom_lim>
      <PDBo:struct_ncs_dom_lim rdf:about="{$base}/struct_ncs_dom_lim/{translate(@dom_id,' ^','_')},{translate(@pdbx_component_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@dom_id!='' and @pdbx_ens_id!=''">
        <PDBo:reference_to_struct_ncs_dom>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_dom/{translate(@dom_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}">
	    <PDBo:referenced_by_struct_ncs_dom_lim rdf:resource="{$base}/struct_ncs_dom_lim/{translate(@dom_id,' ^','_')},{translate(@pdbx_component_id,' ^','_')},{translate(@pdbx_ens_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_ncs_dom>
        <!-- struct_ncs_domKeyref_2_0_0_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_dom_lim>
      </PDBo:has_struct_ncs_dom_lim>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_ncs_ensCategory/PDBx:struct_ncs_ens">
      <PDBo:has_struct_ncs_ens>
      <PDBo:struct_ncs_ens rdf:about="{$base}/struct_ncs_ens/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_ens>
      </PDBo:has_struct_ncs_ens>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_ncs_ens_genCategory/PDBx:struct_ncs_ens_gen">
      <PDBo:has_struct_ncs_ens_gen>
      <PDBo:struct_ncs_ens_gen rdf:about="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@ens_id!=''">
        <PDBo:reference_to_struct_ncs_ens>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_ens/{translate(@ens_id,' ^','_')}">
	    <PDBo:referenced_by_struct_ncs_ens_gen rdf:resource="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_ncs_ens>
        <!-- struct_ncs_ensKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:if test="@oper_id!=''">
        <PDBo:reference_to_struct_ncs_oper>
	  <rdf:Description  rdf:about="{$base}/struct_ncs_oper/{translate(@oper_id,' ^','_')}">
	    <PDBo:referenced_by_struct_ncs_ens_gen rdf:resource="{$base}/struct_ncs_ens_gen/{translate(@dom_id_1,' ^','_')},{translate(@dom_id_2,' ^','_')},{translate(@ens_id,' ^','_')},{translate(@oper_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_ncs_oper>
        <!-- struct_ncs_operKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_ens_gen>
      </PDBo:has_struct_ncs_ens_gen>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_ncs_operCategory/PDBx:struct_ncs_oper">
      <PDBo:has_struct_ncs_oper>
      <PDBo:struct_ncs_oper rdf:about="{$base}/struct_ncs_oper/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ncs_oper>
      </PDBo:has_struct_ncs_oper>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_refCategory/PDBx:struct_ref">
      <PDBo:has_struct_ref>
      <PDBo:struct_ref rdf:about="{$base}/struct_ref/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:entity_id!=''">
        <PDBo:reference_to_entity>
	  <rdf:Description  rdf:about="{$base}/entity/{translate(PDBx:entity_id,' ^','_')}">
	    <PDBo:referenced_by_struct_ref rdf:resource="{$base}/struct_ref/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entity>
        <!-- entityKeyref_0_0_37_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_ref>
      </PDBo:has_struct_ref>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_ref_seqCategory/PDBx:struct_ref_seq">
      <PDBo:has_struct_ref_seq>
      <PDBo:struct_ref_seq rdf:about="{$base}/struct_ref_seq/{translate(@align_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:ref_id!=''">
        <PDBo:reference_to_struct_ref>
	  <rdf:Description  rdf:about="{$base}/struct_ref/{translate(PDBx:ref_id,' ^','_')}">
	    <PDBo:referenced_by_struct_ref_seq rdf:resource="{$base}/struct_ref_seq/{translate(@align_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_ref_seq_difCategory/PDBx:struct_ref_seq_dif">
      <PDBo:has_struct_ref_seq_dif>
      <PDBo:struct_ref_seq_dif rdf:about="{$base}/struct_ref_seq_dif/{translate(@pdbx_ordinal,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:align_id!=''">
        <PDBo:reference_to_struct_ref_seq>
	  <rdf:Description  rdf:about="{$base}/struct_ref_seq/{translate(PDBx:align_id,' ^','_')}">
	    <PDBo:referenced_by_struct_ref_seq_dif rdf:resource="{$base}/struct_ref_seq_dif/{translate(@pdbx_ordinal,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_sheetCategory/PDBx:struct_sheet">
      <PDBo:has_struct_sheet>
      <PDBo:struct_sheet rdf:about="{$base}/struct_sheet/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_sheet>
      </PDBo:has_struct_sheet>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_sheet_hbondCategory/PDBx:struct_sheet_hbond">
      <PDBo:has_struct_sheet_hbond>
      <PDBo:struct_sheet_hbond rdf:about="{$base}/struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBo:referenced_by_struct_sheet_hbond rdf:resource="{$base}/struct_sheet_hbond/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_sheet_orderCategory/PDBx:struct_sheet_order">
      <PDBo:has_struct_sheet_order>
      <PDBo:struct_sheet_order rdf:about="{$base}/struct_sheet_order/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBo:referenced_by_struct_sheet_order rdf:resource="{$base}/struct_sheet_order/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_sheet_rangeCategory/PDBx:struct_sheet_range">
      <PDBo:has_struct_sheet_range>
      <PDBo:struct_sheet_range rdf:about="{$base}/struct_sheet_range/{translate(@id,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBo:referenced_by_struct_sheet_range rdf:resource="{$base}/struct_sheet_range/{translate(@id,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_sheet_topologyCategory/PDBx:struct_sheet_topology">
      <PDBo:has_struct_sheet_topology>
      <PDBo:struct_sheet_topology rdf:about="{$base}/struct_sheet_topology/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@sheet_id!=''">
        <PDBo:reference_to_struct_sheet>
	  <rdf:Description  rdf:about="{$base}/struct_sheet/{translate(@sheet_id,' ^','_')}">
	    <PDBo:referenced_by_struct_sheet_topology rdf:resource="{$base}/struct_sheet_topology/{translate(@range_id_1,' ^','_')},{translate(@range_id_2,' ^','_')},{translate(@sheet_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_siteCategory/PDBx:struct_site">
      <PDBo:has_struct_site>
      <PDBo:struct_site rdf:about="{$base}/struct_site/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_site>
      </PDBo:has_struct_site>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_site_genCategory/PDBx:struct_site_gen">
      <PDBo:has_struct_site_gen>
      <PDBo:struct_site_gen rdf:about="{$base}/struct_site_gen/{translate(@id,' ^','_')},{translate(@site_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@site_id!=''">
        <PDBo:reference_to_struct_site>
	  <rdf:Description  rdf:about="{$base}/struct_site/{translate(@site_id,' ^','_')}">
	    <PDBo:referenced_by_struct_site_gen rdf:resource="{$base}/struct_site_gen/{translate(@id,' ^','_')},{translate(@site_id,' ^','_')}"/>
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

  <xsl:template match="PDBx:datablock/PDBx:struct_site_keywordsCategory/PDBx:struct_site_keywords">
      <PDBo:has_struct_site_keywords>
      <PDBo:struct_site_keywords rdf:about="{$base}/struct_site_keywords/{translate(@site_id,' ^','_')},{translate(@text,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@site_id!=''">
        <PDBo:reference_to_struct_site>
	  <rdf:Description  rdf:about="{$base}/struct_site/{translate(@site_id,' ^','_')}">
	    <PDBo:referenced_by_struct_site_keywords rdf:resource="{$base}/struct_site_keywords/{translate(@site_id,' ^','_')},{translate(@text,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_site>
        <!-- struct_siteKeyref_0_0_1_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_site_keywords>
      </PDBo:has_struct_site_keywords>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:struct_site_viewCategory/PDBx:struct_site_view">
      <PDBo:has_struct_site_view>
      <PDBo:struct_site_view rdf:about="{$base}/struct_site_view/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="PDBx:site_id!=''">
        <PDBo:reference_to_struct_site>
	  <rdf:Description  rdf:about="{$base}/struct_site/{translate(PDBx:site_id,' ^','_')}">
	    <PDBo:referenced_by_struct_site_view rdf:resource="{$base}/struct_site_view/{translate(@id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_struct_site>
        <!-- struct_siteKeyref_0_0_2_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:struct_site_view>
      </PDBo:has_struct_site_view>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:symmetryCategory/PDBx:symmetry">
      <PDBo:has_symmetry>
      <PDBo:symmetry rdf:about="{$base}/symmetry/{translate(@entry_id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:if test="@entry_id!=''">
        <PDBo:reference_to_entry>
	  <rdf:Description  rdf:about="{$base}/entry/{translate(@entry_id,' ^','_')}">
	    <PDBo:referenced_by_symmetry rdf:resource="{$base}/symmetry/{translate(@entry_id,' ^','_')}"/>
	  </rdf:Description>
        </PDBo:reference_to_entry>
        <!-- entryKeyref_0_0_88_0 -->
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:symmetry>
      </PDBo:has_symmetry>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:symmetry_equivCategory/PDBx:symmetry_equiv">
      <PDBo:has_symmetry_equiv>
      <PDBo:symmetry_equiv rdf:about="{$base}/symmetry_equiv/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:symmetry_equiv>
      </PDBo:has_symmetry_equiv>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:valence_paramCategory/PDBx:valence_param">
      <PDBo:has_valence_param>
      <PDBo:valence_param rdf:about="{$base}/valence_param/{translate(@atom_1,' ^','_')},{translate(@atom_1_valence,' ^','_')},{translate(@atom_2,' ^','_')},{translate(@atom_2_valence,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:valence_param>
      </PDBo:has_valence_param>
  </xsl:template>

  <xsl:template match="PDBx:datablock/PDBx:valence_refCategory/PDBx:valence_ref">
      <PDBo:has_valence_ref>
      <PDBo:valence_ref rdf:about="{$base}/valence_ref/{translate(@id,' ^','_')}">
      <PDBo:of_datablock rdf:resource="{$base}"/>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="@*" mode="linked"/>
      <xsl:apply-templates/>
      <xsl:apply-templates mode="linked"/>
      </PDBo:valence_ref>
      </PDBo:has_valence_ref>
  </xsl:template>

  <xsl:template match="*[@xsi:nil='true']"/>
  <xsl:template match="*|text()|@*"/>
  <xsl:template match="*|text()|@*" mode="linked"/>

</xsl:stylesheet>