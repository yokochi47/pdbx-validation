<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE rdf:RDF [
  <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
  <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
  <!ENTITY owl "http://www.w3.org/2002/07/owl#">
]>
<xsl2:stylesheet
   version="2.0"
   xmlns:xsl2="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsd="http://www.w3.org/2001/XMLSchema">

  <xsl2:output method="xml" indent="yes"/>
  <xsl2:strip-space elements="*"/>
  <xsl2:template match="/">
    <xsl2:text disable-output-escaping="yes">&lt;xsl:stylesheet
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
  xmlns:ext="http://exslt.org/common" exclude-result-prefixes="VRPTx ext"&gt;
</xsl2:text>
    <xsl2:apply-templates/>
    <xsl2:text disable-output-escaping="yes">
&lt;/xsl:stylesheet&gt;</xsl2:text>
  </xsl2:template>

  <xsl2:template match="/xsd:schema">
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:param name="wurcs2glytoucan" select="'https://raw.githubusercontent.com/yokochi47/pdbx-validation/master/wurcs2glytoucan/glytoucan.xml'" required="no"/&gt;
  &lt;xsl:param name="glytoucan" select="document($wurcs2glytoucan)"/&gt;

  &lt;xsl:output method="xml" indent="yes"/&gt;
  &lt;xsl:strip-space elements="*"/&gt;

  &lt;xsl:variable name="PDBID"&gt;&lt;xsl:value-of select="/VRPTx:datablock/VRPTx:entryCategory/VRPTx:entry/@id"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdbid"&gt;&lt;xsl:value-of select="translate($PDBID,'ABCDEFGHIJKLMNOPQRSTUVWXYZ','abcdefghijklmnopqrstuvwxyz')"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdb_doi"&gt;&lt;xsl:value-of select="concat('10.2210/pdb',$pdbid,'/pdb')"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="base"&gt;https://rdf.wwpdb.org/pdb-validation/&lt;xsl:value-of select="$PDBID"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="base_lower"&gt;https://rdf.wwpdb.org/pdb/&lt;xsl:value-of select="$pdbid"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdb_link"&gt;https://rdf.wwpdb.org/pdb/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="bmrb_link"&gt;https://bmrbpub.pdbj.org/rdf/bmr&lt;/xsl:variable&gt;
  &lt;xsl:variable name="chem_comp"&gt;https://rdf.wwpdb.org/cc/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="prd"&gt;https://rdf.wwpdb.org/prd/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdbj"&gt;https://pdbj.org/pdb/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="rcsb"&gt;https://www.rcsb.org/pdb/explore.do?structureId=&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdbe"&gt;https://www.ebi.ac.uk/pdbe/entry/pdb/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdbml"&gt;ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdbml_noatom"&gt;ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML-noatom/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdbml_extatom"&gt;ftp://ftp.wwpdb.org/pub/pdb/data/structures/all/XML-extatom/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="vrpt"&gt;ftp://ftp.wwpdb.org/pub/pdb/validation_reports/&lt;xsl:value-of select="substring($pdbid,2,2)"/&gt;/&lt;xsl:value-of select="$pdbid"/&gt;/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="idorg"&gt;http://identifiers.org/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="doi"&gt;https://doi.org/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pubmed"&gt;https://www.ncbi.nlm.nih.gov/pubmed/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="taxonomy"&gt;http://purl.uniprot.org/taxonomy/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="uniprot"&gt;http://purl.uniprot.org/uniprot/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="genbank"&gt;https://www.ncbi.nlm.nih.gov/nuccore/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="embl"&gt;https://www.ncbi.nlm.nih.gov/nuccore/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pir"&gt;https://www.ncbi.nlm.nih.gov/nuccore/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="refseq"&gt;https://www.ncbi.nlm.nih.gov/protein/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="norine"&gt;https://bioinfo.lifl.fr/norine/result.jsp?ID=&lt;/xsl:variable&gt;
  &lt;xsl:variable name="enzyme"&gt;http://purl.uniprot.org/enzyme/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="go"&gt;http://amigo.geneontology.org/amigo/term/GO:&lt;/xsl:variable&gt;
  &lt;xsl:variable name="interpro"&gt;https://www.ebi.ac.uk/interpro/entry/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pfam"&gt;http://pfam.xfam.org/family/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="cath"&gt;http://www.cathdb.info/cathnode/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="scop"&gt;http://scop.berkeley.edu/sunid=&lt;/xsl:variable&gt;
  &lt;xsl:variable name="ensembl"&gt;https://www.ensembl.org/id/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="glycoinfo"&gt;http://rdf.glycoinfo.org/glycan/&lt;/xsl:variable&gt;

  &lt;xsl:template match="/"&gt;
    &lt;rdf:RDF&gt;
      &lt;xsl:apply-templates/&gt;
    &lt;/rdf:RDF&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 1 --&gt;
  &lt;xsl:template match="/VRPTx:datablock"&gt;
    &lt;VRPTo:datablock rdf:about="{$base}"&gt;
      &lt;dcterms:identifier&gt;&lt;xsl:value-of select="$PDBID"/&gt;&lt;/dcterms:identifier&gt;
      &lt;skos:altLabel&gt;&lt;xsl:value-of select="$pdbid"/&gt;&lt;/skos:altLabel&gt;
      &lt;dc:title&gt;&lt;xsl:value-of select="VRPTx:structCategory/VRPTx:struct/VRPTx:title/text()"/&gt;&lt;/dc:title&gt;
      &lt;VRPTo:link_to_pdb_src rdf:resource="{$pdb_link}{$pdbid}"/&gt;
      &lt;VRPTo:link_to_pdbml rdf:resource="{$pdbml}{$pdbid}.xml.gz"/&gt;
      &lt;VRPTo:link_to_pdbml_noatom rdf:resource="{$pdbml_noatom}{$pdbid}-noatom.xml.gz"/&gt;
      &lt;VRPTo:link_to_pdbml_extatom rdf:resource="{$pdbml_extatom}{$pdbid}-extatom.xml.gz"/&gt;
      &lt;VRPTo:link_to_xml_vrpt rdf:resource="{$vrpt}{$pdbid}_validation.xml.gz"/&gt;
      &lt;VRPTo:link_to_doi rdf:resource="{$doi}{$pdb_doi}" rdfs:label="doi:{$pdb_doi}"/&gt;
      &lt;!-- VRPTo:link_to_pdbml_vrpt rdf:resource="{$vrpt}{$pdbid}-validation-full.xml.gz"/ --&gt;
      &lt;!-- VRPTo:link_to_pdbml_vrpt_alt rdf:resource="{$vrpt}{$pdbid}-validation-alt.xml.gz"/ --&gt;
      &lt;owl:sameAs rdf:resource="{$base_lower}"/&gt;
      &lt;rdfs:seeAlso rdf:resource="{$pdbj}{$PDBID}"/&gt;
      &lt;rdfs:seeAlso rdf:resource="{$rcsb}{$PDBID}"/&gt;
      &lt;rdfs:seeAlso rdf:resource="{$pdbe}{$PDBID}"/&gt;

      &lt;VRPTo:datablockName&gt;&lt;xsl:value-of select="@datablockName"/&gt;&lt;/VRPTo:datablockName&gt;
      &lt;xsl:apply-templates select="./*"/&gt;
    &lt;/VRPTo:datablock&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 2 --&gt;
  &lt;xsl:template match="/VRPTx:datablock/*"&gt;
    &lt;xsl:element name="VRPTo:has_{local-name(.)}"&gt;
      &lt;xsl:element name="VRPTo:{local-name(.)}"&gt;
        &lt;xsl:attribute name="rdf:about"&gt;
          &lt;xsl:value-of select="concat($base,'/',local-name(.))"/&gt;
        &lt;/xsl:attribute&gt;
        &lt;xsl:apply-templates&gt;
          &lt;xsl:with-param name="base" select="$base"/&gt;
        &lt;/xsl:apply-templates&gt;
      &lt;/xsl:element&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 4 (PCData) --&gt;
  &lt;xsl:template match="/VRPTx:datablock/*/*/*[not(xsi:nil) and text()!='']"&gt;
    &lt;xsl:element name="VRPTo:{concat(local-name(parent::node()),'.',local-name())}"&gt;
      &lt;xsl:value-of select="."/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 4 (attribute) --&gt;
  &lt;xsl:template match="/VRPTx:datablock/*/*/@*"&gt;
    &lt;xsl:element name="VRPTo:{concat(local-name(parent::node()),'.',translate(name(),'@',''))}"&gt;
      &lt;xsl:value-of select="."/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 4 (linked data) --&gt;
  &lt;xsl:template match="VRPTx:chem_comp/@id" mode="linked"&gt;
    &lt;VRPTo:link_to_chem_comp rdf:resource="{$chem_comp}{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_molecule/@prd_id" mode="linked"&gt;
    &lt;VRPTo:link_to_prd rdf:resource="{$prd}{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_molecule_features/@prd_id" mode="linked"&gt;
    &lt;VRPTo:link_to_prd rdf:resource="{$prd}{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_linked_entity/VRPTx:prd_id[text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_prd rdf:resource="{$prd}{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:citation/VRPTx:pdbx_database_id_DOI[text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_doi rdf:resource="{$doi}{text()}" rdfs:label="doi:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:citation/VRPTx:pdbx_database_id_PubMed[text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_pubmed rdf:resource="{$pubmed}{text()}" rdfs:label="pubmed:{text()}"/&gt;
    &lt;dcterms:references rdf:resource="{$idorg}pubmed/{text()}" rdfs:label="pubmed:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:entity_src_gen/VRPTx:pdbx_gene_src_ncbi_taxonomy_id[text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:entity_src_gen/VRPTx:pdbx_host_org_ncbi_taxonomy_id[text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_taxonomy_host rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:entity_src_nat/VRPTx:pdbx_ncbi_taxonomy_id[text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:entity/VRPTx:pdbx_ec[text()!='']" mode="linked"&gt;
    &lt;xsl:variable name="ec_norm"&gt;&lt;xsl:value-of select="normalize-space(text())"/&gt;&lt;/xsl:variable&gt;
    &lt;xsl:if test="$ec_norm!=''"&gt;
      &lt;xsl:variable name="ec_list"&gt;
        &lt;xsl:call-template name="tokenize"&gt;
          &lt;xsl:with-param name="string" select="$ec_norm"/&gt;
          &lt;xsl:with-param name="delimiter"&gt;,&lt;/xsl:with-param&gt;
        &lt;/xsl:call-template&gt;
      &lt;/xsl:variable&gt;
      &lt;xsl:for-each select="ext:node-set($ec_list)/token"&gt;
        &lt;xsl:variable name="ec"&gt;&lt;xsl:value-of select="normalize-space(text())"/&gt;&lt;/xsl:variable&gt;
        &lt;xsl:if test="string-length($ec)!=0"&gt;
          &lt;VRPTo:link_to_enzyme rdf:resource="{$enzyme}{$ec}" rdfs:label="enzyme:{$ec}"/&gt;
          &lt;rdfs:seeAlso rdf:resource="{$idorg}ec-code/{$ec}" rdfs:label="ec-code:{$ec}"/&gt;
        &lt;/xsl:if&gt;
      &lt;/xsl:for-each&gt;
    &lt;/xsl:if&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template name="tokenize"&gt;
    &lt;xsl:param name="string"/&gt;
    &lt;xsl:param name="delimiter"/&gt;
    &lt;xsl:choose&gt;
      &lt;xsl:when test="$delimiter and contains($string,$delimiter)"&gt;
        &lt;token&gt;
          &lt;xsl:value-of select="substring-before($string,$delimiter)"/&gt;
        &lt;/token&gt;
        &lt;xsl:call-template name="tokenize"&gt;
          &lt;xsl:with-param name="string" select="substring-after($string,$delimiter)"/&gt;
          &lt;xsl:with-param name="delimiter" select="$delimiter"/&gt;
        &lt;/xsl:call-template&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:otherwise&gt;
        &lt;token&gt;
          &lt;xsl:value-of select="$string"/&gt;
        &lt;/token&gt;
      &lt;/xsl:otherwise&gt;
    &lt;/xsl:choose&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:pdbx_db_accession[../VRPTx:db_name='UNP' and text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:db_code[(../VRPTx:db_name='GB' or ../VRPTx:db_name='GB ' or ../VRPTx:db_name='gb' or ../VRPTx:db_name='TPG') and text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_genbank rdf:resource="{$genbank}{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:db_code[(../VRPTx:db_name='EMBL' or ../VRPTx:db_name='GENP') and text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_embl rdf:resource="{$embl}{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='TREMBL' and string-length(text())=6 and contains(substring(text(),0,1),'OPQ') and contains(substring(text(),1,1),'0123456789')]" mode="linked"&gt;
    &lt;VRPTo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='TREMBL' and text()!='' and not(string-length(text())=6 and contains(substring(text(),0,1),'OPQ') and contains(substring(text(),1,1),'0123456789'))]" mode="linked"&gt;
    &lt;VRPTo:link_to_embl rdf:resource="{$embl}{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='PIR' and text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_pir rdf:resource="{$pir}{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='REF' and text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_refseq rdf:resource="{$refseq}{text()}" rdfs:label="refseq:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}refseq/{text()}" rdfs:label="refseq:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='PRF' and text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_sequence_db rdf:resource="{$pir}{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}ncbiprotein/{text()}" rdfs:label="ncbiprotein:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:struct_ref/VRPTx:db_code[../VRPTx:db_name='NOR' and text()!='']" mode="linked"&gt;
    &lt;VRPTo:link_to_norine rdf:resource="{$norine}{text()}" rdfs:label="norine:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}norine/{text()}" rdfs:label="norine:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_sifts_unp_segments[@unp_acc!='']/@unp_acc" mode="linked"&gt;
    &lt;VRPTo:link_to_uniprot rdf:resource="{$uniprot}{.}" rdfs:label="uniprot:{.}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}uniprot/{.}" rdfs:label="uniprot:{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='GO' and @xref_db_acc!='']/@xref_db_acc" mode="linked"&gt;
    &lt;VRPTo:link_to_go rdf:resource="{$go}{.}" rdfs:label="go:{.}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}go/GO:{.}" rdfs:label="go:{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='InterPro' and @xref_db_acc!='']/@xref_db_acc" mode="linked"&gt;
    &lt;VRPTo:link_to_interpro rdf:resource="{$interpro}{.}" rdfs:label="interpro:{.}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}interpro/{.}" rdfs:label="interpro:{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='Pfam' and @xref_db_acc!='']/@xref_db_acc" mode="linked"&gt;
    &lt;VRPTo:link_to_pfam rdf:resource="{$pfam}{.}" rdfs:label="pfam:{.}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}pfam/{.}" rdfs:label="pfam:{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='CATH' and @xref_db_acc!='']/@xref_db_acc" mode="linked"&gt;
    &lt;VRPTo:link_to_cath rdf:resource="{$cath}{.}" rdfs:label="cath:{.}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}cath/{.}" rdfs:label="cath:{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[(@xref_db='SCOP' or @xref_db='SCOP2' or @xref_db='SCOP2B') and @xref_db_acc!='']/@xref_db_acc" mode="linked"&gt;
    &lt;VRPTo:link_to_scop rdf:resource="{$scop}{.}" rdfs:label="scop:{.}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}scop/{.}" rdfs:label="scop:{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_sifts_xref_db_segments[@xref_db='Ensembl' and @xref_db_acc!='']/@xref_db_acc" mode="linked"&gt;
    &lt;VRPTo:link_to_ensembl rdf:resource="{$ensembl}{.}" rdfs:label="ensembl:{.}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}ensembl/{.}" rdfs:label="ensembl:{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_entity_branch_descriptor/VRPTx:descriptor[../VRPTx:type='WURCS' and text()!='']" mode="linked"&gt;
    &lt;xsl:variable name="wurcs_id">&lt;xsl:value-of select="text()"/&gt;&lt;/xsl:variable&gt;
    &lt;xsl:for-each select="$glytoucan/catalog/wurcs[@id=$wurcs_id]"&gt;
      &lt;xsl:if test="text()!=''"&gt;
        &lt;VRPTo:link_to_glycoinfo rdf:resource="{$glycoinfo}{text()}" rdfs:label="glytoucan:{text()}"/&gt;
        &lt;rdfs:seeAlso rdf:resource="{$idorg}glytoucan/{text()}" rdfs:label="glytoucan:{text()}"/&gt;
      &lt;/xsl:if&gt;
    &lt;/xsl:for-each&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_database_related[@db_name='PDB' and @content_type!='split']/@db_id" mode="linked"&gt;
    &lt;VRPTo:link_to_pdb rdf:resource="{$pdb_link}{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_database_related[@db_name='PDB' and @content_type='split']/@db_id" mode="linked"&gt;
    &lt;VRPTo:link_to_pdb_split rdf:resource="{$pdb_link}{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:chem_comp/VRPTx:pdbx_model_coordinates_db_code" mode="linked"&gt;
    &lt;VRPTo:link_to_pdb rdf:resource="{$pdb_link}{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="VRPTx:pdbx_database_related[@db_name='BMRB']/@db_id" mode="linked"&gt;
    &lt;VRPTo:link_to_bmrb rdf:resource="{$bmrb_link}{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level-3 templates follow --&gt;</xsl2:text>
    <xsl2:call-template name="key_category"/>
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:template match="*[@xsi:nil='true']"/&gt;
  &lt;xsl:template match="*|text()|@*"/&gt;
  &lt;xsl:template match="*|text()|@*" mode="linked"/&gt;
</xsl2:text>

  </xsl2:template>

  <xsl2:template name="check_fields">
    <xsl2:param name="field"/><xsl2:value-of select="$field/@xpath"/>!=''<xsl2:if test="$field/following-sibling::node()[1]/@xpath!=''"><xsl2:text> and </xsl2:text><xsl2:call-template name="check_fields"><xsl2:with-param name="field" select="$field/following-sibling::node()[1]"/></xsl2:call-template></xsl2:if>
  </xsl2:template>

  <xsl2:template name="concat_fields">
    <xsl2:param name="selector"/><xsl2:param name="field"/>{translate(<xsl2:value-of select="$field/@xpath"/>,' ^','_')}<xsl2:if test="$field/following-sibling::node()[1]/@xpath!=''"><xsl2:text>,</xsl2:text><xsl2:call-template name="concat_fields"><xsl2:with-param name="selector" select="$selector"/><xsl2:with-param name="field" select="$field/following-sibling::node()[1]"/></xsl2:call-template></xsl2:if>
  </xsl2:template>

  <xsl2:template name="concat_fields2">
    <xsl2:param name="field1"/><xsl2:param name="selector2"/><xsl2:param name="field2"/>{translate(<xsl2:value-of select="$field1/@xpath"/>,' ^','_')}<xsl2:if test="$field1/following-sibling::node()[1]/@xpath!=''"><xsl2:text>,</xsl2:text><xsl2:call-template name="concat_fields2"><xsl2:with-param name="field1" select="$field1/following-sibling::node()[1]"/><xsl2:with-param name="selector2" select="$selector2"/><xsl2:with-param name="field2" select="$field2/following-sibling::node()[1]"/></xsl2:call-template></xsl2:if>
  </xsl2:template>

  <xsl2:template name="key_category">
    <xsl2:for-each select="/xsd:schema/xsd:element[@name='datablock']/xsd:key">
      <!-- <xsl2:call-template name="key_items"/> -->
      <!-- removing bulky categories -->
      <xsl2:choose>
	<xsl2:when test="./xsd:selector/@xpath='VRPTx:atom_siteCategory/VRPTx:atom_site'"/>
	<!--
	<xsl2:when test="./xsd:selector/@xpath='VRPTx:entity_poly_seqCategory/VRPTx:entity_poly_seq'"/>
	<xsl2:when test="./xsd:selector/@xpath='VRPTx:pdbx_poly_seq_schemeCategory/VRPTx:pdbx_poly_seq_scheme'"/>
	<xsl2:when test="./xsd:selector/@xpath='VRPTx:pdbx_nonpoly_schemeCategory/VRPTx:pdbx_nonpoly_scheme'"/>
	-->
	<xsl2:otherwise>
	  <xsl2:call-template name="key_items"/>
	</xsl2:otherwise>
      </xsl2:choose>
    </xsl2:for-each>
  </xsl2:template>

  <xsl2:template name="key_items">
    <xsl2:variable name="key" select="@name"/>
    <xsl2:variable name="name" select="substring-after(xsd:selector/@xpath,'/VRPTx:')"/>
    <xsl2:variable name="docpath">VRPTx:datablock/VRPTx:<xsl2:value-of select="$name"/>Category/VRPTx:<xsl2:value-of select="$name"/></xsl2:variable>
    <xsl2:variable name="resource"><xsl2:value-of select="$name"/>/<xsl2:call-template name="concat_fields">
	<xsl2:with-param name="selector" select="$name"/>
	<xsl2:with-param name="field" select="xsd:field[1]"/></xsl2:call-template></xsl2:variable>
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:template match=&quot;</xsl2:text><xsl2:value-of select="$docpath"/><xsl2:text disable-output-escaping="yes">&quot;&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
      &lt;</xsl2:text>VRPTo:has_<xsl2:value-of select='$name'/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
      &lt;</xsl2:text>VRPTo:<xsl2:value-of select='$name'/> rdf:about="{$base}/<xsl2:value-of select='$resource'/>"<xsl2:text disable-output-escaping="yes">&gt;
      &lt;VRPTo:of_datablock rdf:resource="{$base}"/&gt;</xsl2:text>
    <xsl2:call-template name="category_unique">
      <xsl2:with-param name="name" select="$name"/>
      <xsl2:with-param name="original" select="$resource"/>
    </xsl2:call-template>
    <xsl2:call-template name="category_keyref">
      <xsl2:with-param name="name" select="$name"/>
      <xsl2:with-param name="pathname" select="$resource"/>
    </xsl2:call-template>
    <xsl2:text disable-output-escaping="yes">
      &lt;xsl:apply-templates select="@*"/&gt;
      &lt;xsl:apply-templates select="@*" mode="linked"/&gt;
      &lt;xsl:apply-templates/&gt;
      &lt;xsl:apply-templates mode="linked"/&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
      &lt;</xsl2:text>/VRPTo:<xsl2:value-of select='$name'/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
      &lt;</xsl2:text>/VRPTo:has_<xsl2:value-of select='$name'/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
  &lt;/xsl:template&gt;
</xsl2:text>
  </xsl2:template>

  <xsl2:template name="category_unique">
    <xsl2:param name="name"/>
    <xsl2:param name="original"/>
    <xsl2:variable name="xpath">VRPTx:<xsl2:value-of select="$name"/>Category/VRPTx:<xsl2:value-of select="$name"/></xsl2:variable>
    <xsl2:for-each select="/xsd:schema/xsd:element[@name='datablock']/xsd:unique[xsd:selector/@xpath=$xpath]|/xsd:schema/xsd:element[@name='datablock']/xsd:key[xsd:selector/@xpath=$xpath]">
      <xsl2:variable name="resource"><xsl2:value-of select="$name"/>/<xsl2:call-template name="concat_fields">
	  <xsl2:with-param name="selector" select="substring-after(xsd:selector/@xpath,'/VRPTx:')"/>
	  <xsl2:with-param name="field" select="xsd:field[1]"/></xsl2:call-template></xsl2:variable>
      <!-- don't want duplicate key -->
      <xsl2:if test="$original!=$resource">
	<xsl2:variable name="check"><xsl2:call-template name="check_fields"><xsl2:with-param name="field" select="xsd:field[1]"/></xsl2:call-template></xsl2:variable>
	<xsl2:text disable-output-escaping="yes">
      &lt;xsl:if test=</xsl2:text>"<xsl2:value-of select='$check'/>"<xsl2:text disable-output-escaping='yes'>&gt;
        &lt;owl:sameAs&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
          &lt;</xsl2:text>VRPTo:<xsl2:value-of select="$name"/> rdf:about="{$base}/<xsl2:value-of select='$resource'/>"<xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
            &lt;rdfs:label&gt;</xsl2:text>
	<xsl2:value-of select="@name"/>
	<xsl2:text disable-output-escaping="yes">&lt;/rdfs:label&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
          &lt;</xsl2:text>/VRPTo:<xsl2:value-of select="$name"/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
        &lt;/owl:sameAs&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
      &lt;/xsl:if&gt;</xsl2:text>
      </xsl2:if>
    </xsl2:for-each>
  </xsl2:template>

  <xsl2:template name="category_keyref">
    <xsl2:param name="name"/>
    <xsl2:param name="pathname"/>
    <xsl2:variable name="xpath">VRPTx:<xsl2:value-of select="$name"/>Category/VRPTx:<xsl2:value-of select="$name"/></xsl2:variable>
    <xsl2:for-each select="/xsd:schema/xsd:element[@name='datablock']/xsd:keyref[xsd:selector/@xpath=$xpath]">
      <xsl2:variable name="refering" select="."/>
      <xsl2:variable name="keyname" select="substring-after($refering/@refer,':')"/>
      <xsl2:variable name="refer" select="../xsd:key[@name=$keyname] | ../xsd:unique[@name=$keyname]"/>
      <xsl2:variable name="refname" select="replace($refer/xsd:selector/@xpath,'.*/VRPTx:','')"/>
	<xsl2:variable name="resource"><xsl2:value-of select="$refname"/>/<xsl2:call-template name="concat_fields2">
	    <xsl2:with-param name="field1" select="$refering/xsd:field[1]"/>
	    <xsl2:with-param name="selector2" select="substring-after($refer/xsd:selector/@xpath,'/')"/>
	    <xsl2:with-param name="field2" select="$refer/xsd:field[1]"/></xsl2:call-template></xsl2:variable>
        <xsl2:variable name="check"><xsl2:call-template name="check_fields"><xsl2:with-param name="field" select="$refering/xsd:field[1]"/></xsl2:call-template></xsl2:variable>
	<xsl2:text disable-output-escaping="yes">
      &lt;xsl:if test=</xsl2:text>"<xsl2:value-of select='$check'/>"<xsl2:text disable-output-escaping='yes'>&gt;
        &lt;</xsl2:text>VRPTo:reference_to_<xsl2:value-of select="$refname"/><xsl2:text disable-output-escaping="yes">&gt;
	  &lt;</xsl2:text>rdf:Description  rdf:about="{$base}/<xsl2:value-of select='$resource'/>"<xsl2:text disable-output-escaping="yes">&gt;
	    &lt;</xsl2:text>VRPTo:referenced_by_<xsl2:value-of select="$name"/> rdf:resource="{$base}/<xsl2:value-of select='$pathname'/>"<xsl2:text disable-output-escaping="yes">/&gt;
	  &lt;</xsl2:text>/rdf:Description<xsl2:text disable-output-escaping="yes">&gt;
        &lt;</xsl2:text>/VRPTo:reference_to_<xsl2:value-of select="$refname"/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
        &lt;!-- </xsl2:text>
	<xsl2:value-of select="@name"/>
	<xsl2:text disable-output-escaping="yes"> --&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
      &lt;/xsl:if&gt;</xsl2:text>
    </xsl2:for-each>
  </xsl2:template>
  <xsl2:template match="*|text()|@*"/>
</xsl2:stylesheet>
