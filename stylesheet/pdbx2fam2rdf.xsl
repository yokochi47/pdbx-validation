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

  <xsl2:output method="xml" encoding="UTF-8" indent="yes"/>
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
  xmlns:PDBx="http://pdbml.pdb.org/schema/pdbx-v50.xsd"
  xmlns:PDBo="http://rdf.wwpdb.org/schema/pdbx-v50.owl#"
  xmlns:ext="http://exslt.org/common" exclude-result-prefixes="PDBx ext"&gt;
</xsl2:text>
    <xsl2:apply-templates/>
    <xsl2:text disable-output-escaping="yes">
&lt;/xsl:stylesheet&gt;</xsl2:text>
  </xsl2:template>

  <xsl2:template match="/xsd:schema">
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:output method="xml" encoding="UTF-8" indent="yes"/&gt;
  &lt;xsl:strip-space elements="*"/&gt;
  &lt;xsl:variable name="FAM_ID"&gt;&lt;xsl:value-of select="/PDBx:datablock/@datablockName"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="base"&gt;http://rdf.wwpdb.org/fam/&lt;xsl:value-of select="$FAM_ID"/&gt;&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdb_link"&gt;http://rdf.wwpdb.org/pdb/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="chem_comp"&gt;http://rdf.wwpdb.org/cc/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="prd"&gt;http://rdf.wwpdb.org/prd/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdbj"&gt;http://pdbj.org/bird/summary/&lt;/xsl:variable&gt;
<!-- TODO
  &lt;xsl:variable name="rcsb"&gt;http://www.rcsb.org/ligand/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pdbe"&gt;http://www.ebi.ac.uk/pdbe-srv/pdbechem/chemicalCompound/show/&lt;/xsl:variable&gt;
-->
  &lt;xsl:variable name="idorg"&gt;http://identifiers.org/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="doi"&gt;http://doi.org/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pubmed"&gt;http://rdf.ncbi.nlm.nih.gov/pubmed/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="taxonomy"&gt;http://purl.uniprot.org/taxonomy/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="enzyme"&gt;http://purl.uniprot.org/enzyme/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="uniprot"&gt;http://purl.uniprot.org/uniprot/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="norine"&gt;http://bioinfo.lifl.fr/norine/result.jsp?ID=&lt;/xsl:variable&gt;
  &lt;xsl:variable name="kegg_comp"&gt;http://www.kegg.jp/entry/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="kegg_drug"&gt;http://www.kegg.jp/entry/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="nadb"&gt;http://www.nih.go.jp/~jun/NADB/show.cgi/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="nadb1"&gt;http://www.antibiotics.or.jp/journal/database/data-1.HTM#&lt;/xsl:variable&gt;
  &lt;xsl:variable name="nadb2"&gt;http://www.antibiotics.or.jp/journal/database/data-2.htm#&lt;/xsl:variable&gt;
  &lt;xsl:variable name="nadb3"&gt;http://www.antibiotics.or.jp/journal/database/data-3.htm#&lt;/xsl:variable&gt;
  &lt;xsl:variable name="nadb4"&gt;http://www.antibiotics.or.jp/journal/database/data-4.htm#&lt;/xsl:variable&gt;
  &lt;xsl:variable name="nadb5"&gt;http://www.antibiotics.or.jp/journal/database/data-5.htm#&lt;/xsl:variable&gt;
  &lt;xsl:variable name="ccdc_num"&gt;http://www.ccdc.cam.ac.uk/structures/search?pid=ccdc:&lt;/xsl:variable&gt;
  &lt;xsl:variable name="ccdc_id"&gt;http://www.ccdc.cam.ac.uk/structures/search?ccdcid=&lt;/xsl:variable&gt;
  &lt;xsl:variable name="pubchem.substance"&gt;http://rdf.ncbi.nlm.nih.gov/pubchem/substance/SID&lt;/xsl:variable&gt;
  &lt;xsl:variable name="chemspider"&gt;http://www.chemspider.com/Chemical-Structure.&lt;/xsl:variable&gt;
  &lt;xsl:variable name="cas"&gt;http://commonchemistry.cas.org/detail?ref=&lt;/xsl:variable&gt;
  &lt;xsl:variable name="chebi"&gt;http://purl.obolibrary.org/obo/CHEBI_&lt;/xsl:variable&gt;
  &lt;xsl:variable name="mesh"&gt;http://id.nlm.nih.gov/mesh/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="chemidplus"&gt;http://chem.nlm.nih.gov/chemidplus/rn/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="chembl"&gt;http://www.ebi.ac.uk/chembl/entity/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="bindingdb"&gt;http://www.bindingdb.org/bind/chemsearch/marvin/MolStructure.jsp?monomerid=&lt;/xsl:variable&gt;
  &lt;xsl:variable name="drugbank"&gt;http://www.drugbank.ca/drugs/&lt;/xsl:variable&gt;
  &lt;xsl:variable name="chemdb"&gt;http://cdb.ics.uci.edu/cgibin/ChemicalDetailWeb.py?chemical_id=&lt;/xsl:variable&gt;

  &lt;xsl:template match="/"&gt;
    &lt;rdf:RDF&gt;
      &lt;xsl:apply-templates/&gt;
    &lt;/rdf:RDF&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 1 --&gt;
  &lt;xsl:template match="/PDBx:datablock"&gt;
    &lt;PDBo:datablock rdf:about="{$base}"&gt;
      &lt;dcterms:identifier&gt;&lt;xsl:value-of select="$FAM_ID"/&gt;&lt;/dcterms:identifier&gt;
      &lt;dc:title&gt;&lt;xsl:value-of select="PDBx:pdbx_reference_molecule_familyCategory/PDBx:pdbx_reference_molecule_family/PDBx:name/text()"/&gt;&lt;/dc:title&gt;
      &lt;rdfs:seeAlso rdf:resource="{$pdbj}{$FAM_ID}"/&gt;
<!-- TODO
      &lt;rdfs:seeAlso rdf:resource="{$rcsb}{$FAM_ID}"/&gt;
      &lt;rdfs:seeAlso rdf:resource="{$pdbe}{$FAM_ID}"/&gt;
-->

      &lt;PDBo:datablockName&gt;&lt;xsl:value-of select="@datablockName"/&gt;&lt;/PDBo:datablockName&gt;
      &lt;xsl:apply-templates select="./*"/&gt;
    &lt;/PDBo:datablock&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 2 --&gt;
  &lt;xsl:template match="/PDBx:datablock/*"&gt;
    &lt;xsl:element name="PDBo:has_{local-name(.)}"&gt;
      &lt;xsl:element name="PDBo:{local-name(.)}"&gt;
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
  &lt;xsl:template match="/PDBx:datablock/*/*/*[not(xsi:nil) and text()!='']"&gt;
    &lt;xsl:element name="PDBo:{concat(local-name(parent::node()),'.',local-name())}"&gt;
      &lt;xsl:value-of select="."/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 4 (attribute) --&gt;
  &lt;xsl:template match="/PDBx:datablock/*/*/@*"&gt;
    &lt;xsl:element name="PDBo:{concat(local-name(parent::node()),'.',translate(name(),'@',''))}"&gt;
      &lt;xsl:value-of select="."/&gt;
    &lt;/xsl:element&gt;
  &lt;/xsl:template&gt;

  &lt;!-- level 4 (linked data) --&gt;
  &lt;xsl:template match="PDBx:chem_comp/PDBx:mon_nstd_parent_comp_id[text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_parent_chem_comp rdf:resource="{$chem_comp}{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_list/@prd_id" mode="linked"&gt;
    &lt;PDBo:link_to_prd rdf:resource="{$prd}{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_poly_seq/PDBx:parent_mon_id[text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_parent_chem_comp rdf:resource="{$chem_comp}{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_poly_seq/@mon_id" mode="linked"&gt;
    &lt;PDBo:link_to_chem_comp rdf:resource="{$chem_comp}{.}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:citation/PDBx:pdbx_database_id_DOI[text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_doi rdf:resource="{$doi}{text()}" rdfs:label="doi:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:citation/PDBx:pdbx_database_id_PubMed[text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_pubmed rdf:resource="{$pubmed}{text()}" rdfs:label="pubmed:{text()}"/&gt;
    &lt;dcterms:references rdf:resource="{$idorg}pubmed/{text()}" rdfs:label="pubmed:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:entity_src_gen/PDBx:pdbx_gene_src_ncbi_taxonomy_id[text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:entity_src_gen/PDBx:pdbx_host_org_ncbi_taxonomy_id[text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_taxonomy_host rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:entity_src_nat/PDBx:pdbx_ncbi_taxonomy_id[text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:entity/PDBx:pdbx_ec[text()!='']" mode="linked"&gt;
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
          &lt;PDBo:link_to_enzyme rdf:resource="{$enzyme}{$ec}" rdfs:label="enzyme:{$ec}"/&gt;
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

  &lt;xsl:template match="PDBx:pdbx_database_related[@db_name='PDB' and @content_type!='split']/@db_id" mode="linked"&gt;
    &lt;xsl:variable name="upper_code"&gt;&lt;xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/&gt;&lt;/xsl:variable&gt;
    &lt;PDBo:link_to_pdb rdf:resource="{$pdb_link}{$upper_code}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_database_related[@db_name='PDB' and @content_type='split']/@db_id" mode="linked"&gt;
    &lt;xsl:variable name="upper_code"&gt;&lt;xsl:value-of select="translate(.,'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/&gt;&lt;/xsl:variable&gt;
    &lt;PDBo:link_to_pdb_split rdf:resource="{$pdb_link}{$upper_code}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule/PDBx:representative_PDB_id_code[text()!='']" mode="linked"&gt;
    &lt;xsl:variable name="upper_code"&gt;&lt;xsl:value-of select="translate(text(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/&gt;&lt;/xsl:variable&gt;
    &lt;PDBo:link_to_pdb rdf:resource="{$pdb_link}{$upper_code}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:chem_comp/PDBx:pdbx_model_coordinates_db_code" mode="linked"&gt;
    &lt;xsl:variable name="upper_code"&gt;&lt;xsl:value-of select="translate(text(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/&gt;&lt;/xsl:variable&gt;
    &lt;PDBo:link_to_pdb rdf:resource="{$pdb_link}{$upper_code}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_poly/PDBx:db_code[../PDBx:db_name='UNP' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_poly/PDBx:db_code[../PDBx:db_name='NOR' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_norine rdf:resource="{$norine}{text()}" rdfs:label="norine:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}norine/{text()}" rdfs:label="norine:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_src_nat/PDBx:db_code[(../PDBx:db_name='UNP' or ../PDBx:db_name='UniProtKB' or ../PDBx:db_name='UniProt') and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_src_nat/PDBx:db_code[(../PDBx:db_name='NORINE' or ../PDBx:db_name='Norine' or ../PDBx:db_name='  Norine') and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_norine rdf:resource="{$norine}{text()}" rdfs:label="norine:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}norine/{text()}" rdfs:label="norine:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_src_nat/PDBx:db_code[../PDBx:db_name='KEGG' and substring(text(),1,1)='C']" mode="linked"&gt;
    &lt;PDBo:link_to_kegg_comp rdf:resource="{$kegg_comp}{text()}" rdfs:label="kegg.compound:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}kegg.compound/{text()}" rdfs:label="kegg.compound:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_src_nat/PDBx:db_code[../PDBx:db_name='KEGG' and substring(text(),1,1)='D']" mode="linked"&gt;
    &lt;PDBo:link_to_kegg_drug rdf:resource="{$kegg_drug}{text()}" rdfs:label="kegg.drug:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}kegg.drug/{text()}" rdfs:label="kegg.drug:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_src_nat/PDBx:db_code[../PDBx:db_name='NADB' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_nadb rdf:resource="{$nadb}{text()}.html" rdfs:label="nadb:{text()}"/&gt;
<!--
    &lt;xsl:choose&gt;
      &lt;xsl:when test="number(text()) &#38;lt; 360000"&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb1}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:when test="number(text()) &#38;lt; 460000"&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb2}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:when test="number(text()) &#38;lt; 510000"&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb3}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:when test="number(text()) &#38;lt; 550000"&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb4}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:otherwise&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb5}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:otherwise&gt;
    &lt;/xsl:choose&gt;
-->
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_src_nat/PDBx:db_name[../PDBx:db_code='Novel Antibiotics DataBase' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_nadb rdf:resource="{$nadb}{text()}.html" rdfs:label="nadb:{text()}"/&gt;
<!--
    &lt;xsl:choose&gt;
      &lt;xsl:when test="number(text()) &#38;lt; 360000"&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb1}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:when test="number(text()) &#38;lt; 460000"&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb2}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:when test="number(text()) &#38;lt; 510000"&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb3}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:when test="number(text()) &#38;lt; 550000"&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb3}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:otherwise&gt;
        &lt;PDBo:link_to_nadb rdf:resource="{$nadb5}{text()}" rdfs:label="nadb:{text()}"/&gt;
      &lt;/xsl:otherwise&gt;
    &lt;/xsl:choose&gt;
-->
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_src_nat/PDBx:db_code[../PDBx:db_name='PDB' and text()!='']" mode="linked"&gt;
    &lt;xsl:variable name="upper_code"&gt;&lt;xsl:value-of select="translate(text(),'abcdefghijklmnopqrstuvwxyz','ABCDEFGHIJKLMNOPQRSTUVWXYZ')"/&gt;&lt;/xsl:variable&gt;
    &lt;PDBo:link_to_pdb rdf:resource="{$pdb_link}{$upper_code}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_entity_src_nat/PDBx:taxid[text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_taxonomy_source rdf:resource="{$taxonomy}{text()}" rdfs:label="taxonomy:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}taxonomy/{text()}" rdfs:label="taxonomy:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_related_structures/PDBx:db_accession[../PDBx:db_name='CCDC' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_ccdc rdf:resource="{$ccdc_num}{text()}" rdfs:label="ccdc:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}ccdc/{text()}" rdfs:label="ccdc:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_related_structures/PDBx:db_code[../PDBx:db_name='CCDC' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_ccdc rdf:resource="{$ccdc_id}{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_annotation/PDBx:source[starts-with(text(),'PMID:')]" mode="linked"&gt;
    &lt;xsl:variable name="code"&gt;&lt;xsl:value-of select="substring-after(text(),':')"/&gt;&lt;/xsl:variable&gt;
    &lt;PDBo:link_to_pubmed rdf:resource="{$pubmed}{$code}" rdfs:label="pubmed:{$code}"/&gt;
    &lt;dcterms:references rdf:resource="{$idorg}pubmed/{$code}" rdfs:label="pubmed:{$code}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_annotation/PDBx:source[starts-with(text(),'DOI:')]" mode="linked"&gt;
    &lt;xsl:variable name="code"&gt;&lt;xsl:value-of select="substring-after(text(),':')"/&gt;&lt;/xsl:variable&gt;
    &lt;PDBo:link_to_doi rdf:resource="{$doi}{$code}" rdfs:label="doi:{$code}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='PubChem' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_pubchem_substance rdf:resource="{$pubchem.substance}{text()}" rdfs:label="pubchem.substance:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}pubchem.substance/{text()}" rdfs:label="pubchem.substance:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='ChemSpider' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_chemspider rdf:resource="{$chemspider}{text()}.html" rdfs:label="chemspider:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}chemspider/{text()}" rdfs:label="chemspider:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='CAS' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_cas rdf:resource="{$cas}{text()}" rdfs:label="cas:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}cas/{text()}" rdfs:label="cas:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[(../PDBx:source='ChEBI' or ../PDBx:source='CHEBI') and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_chebi rdf:resource="{$chebi}{text()}" rdfs:label="CHEBI:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}chebi/CHEBI:{text()}" rdfs:label="CHEBI:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[(../PDBx:source='MeSH' or ../PDBx:source='MESH') and text()!='']" mode="linked"&gt;
    &lt;xsl:choose&gt;
      &lt;xsl:when test="contains(text(),'.')"&gt;
        &lt;PDBo:link_to_mesh rdf:resource="{$mesh}{text()}" rdfs:label="mesh.tree:{text()}"/&gt;
      &lt;/xsl:when&gt;
      &lt;xsl:otherwise&gt;
        &lt;PDBo:link_to_mesh rdf:resource="{$mesh}{text()}" rdfs:label="mesh:{text()}"/&gt;
        &lt;rdfs:seeAlso rdf:resource="{$idorg}mesh/{text()}" rdfs:label="mesh:{text()}"/&gt;
      &lt;/xsl:otherwise&gt;
    &lt;/xsl:choose&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='ChemIDplus' and contains(text(),'-')]" mode="linked"&gt;
    &lt;PDBo:link_to_chemidplus rdf:resource="{$chemidplus}{text()}" rdfs:label="chemidplus:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}chemidplus/{text()}" rdfs:label="chemidplus:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[(../PDBx:source='ChEMBL' or ../PDBx:source='CHEMBL') and text()!='']" mode="linked"&gt;
    &lt;xsl:variable name="code"&gt;&lt;xsl:value-of select="concat('CHEMBL',text())"/&gt;&lt;/xsl:variable&gt;
    &lt;PDBo:link_to_chembl rdf:resource="{$chembl}{$code}" rdfs:label="chembl:{$code}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}chembl/{$code}" rdfs:label="chembl:{$code}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='BindingDB' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_bindingdb rdf:resource="{$bindingdb}{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='DrugBank' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_drugbank rdf:resource="{$drugbank}{text()}" rdfs:label="drugbank:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}drugbank/{text()}" rdfs:label="drugbank:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='KEGG' and ../PDBx:type='KEGG_Compound_ID' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_kegg_comp rdf:resource="{$kegg_comp}{text()}" rdfs:label="kegg.compound:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}kegg.compound/{text()}" rdfs:label="kegg.compound:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='KEGG' and ../PDBx:type='KEGG_Drug_ID' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_kegg_drug rdf:resource="{$kegg_drug}{text()}" rdfs:label="kegg.drug:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}kegg.drug/{text()}" rdfs:label="kegg.drug:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='ChemDB' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_chemdb rdf:resource="{$chemdb}{text()}" rdfs:label="chemdb:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}chemdb/{text()}" rdfs:label="chemdb:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='Norine' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_norine rdf:resource="{$norine}{text()}" rdfs:label="norine:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}norine/{text()}" rdfs:label="norine:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='NovelAntibiotics' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_nadb rdf:resource="{$nadb}{text()}.html" rdfs:label="nadb:{text()}"/&gt;
  &lt;/xsl:template&gt;

  &lt;xsl:template match="PDBx:pdbx_reference_molecule_features/PDBx:value[../PDBx:source='UniProt' and text()!='']" mode="linked"&gt;
    &lt;PDBo:link_to_uniprot rdf:resource="{$uniprot}{text()}" rdfs:label="uniprot:{text()}"/&gt;
    &lt;rdfs:seeAlso rdf:resource="{$idorg}uniprot/{text()}" rdfs:label="uniprot:{text()}"/&gt;
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
	<xsl2:when test="./xsd:selector/@xpath='PDBx:entity_poly_seqCategory/PDBx:entity_poly_seq'"/>
	<xsl2:when test="./xsd:selector/@xpath='PDBx:pdbx_poly_seq_schemeCategory/PDBx:pdbx_poly_seq_scheme'"/>
	<xsl2:when test="./xsd:selector/@xpath='PDBx:pdbx_nonpoly_schemeCategory/PDBx:pdbx_nonpoly_scheme'"/>
	<xsl2:otherwise>
	  <xsl2:call-template name="key_items"/>
	</xsl2:otherwise>
      </xsl2:choose>
    </xsl2:for-each>
  </xsl2:template>

  <xsl2:template name="key_items">
    <xsl2:variable name="key" select="@name"/>
    <xsl2:variable name="name" select="substring-after(xsd:selector/@xpath,'/PDBx:')"/>
    <xsl2:variable name="docpath">PDBx:datablock/PDBx:<xsl2:value-of select="$name"/>Category/PDBx:<xsl2:value-of select="$name"/></xsl2:variable>
    <xsl2:variable name="resource"><xsl2:value-of select="$name"/>/<xsl2:call-template name="concat_fields">
	<xsl2:with-param name="selector" select="$name"/>
	<xsl2:with-param name="field" select="xsd:field[1]"/></xsl2:call-template></xsl2:variable>
    <xsl2:text disable-output-escaping="yes">
  &lt;xsl:template match=&quot;</xsl2:text><xsl2:value-of select="$docpath"/><xsl2:text disable-output-escaping="yes">&quot;&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
      &lt;</xsl2:text>PDBo:has_<xsl2:value-of select='$name'/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
      &lt;</xsl2:text>PDBo:<xsl2:value-of select='$name'/> rdf:about="{$base}/<xsl2:value-of select='$resource'/>"<xsl2:text disable-output-escaping="yes">&gt;
      &lt;PDBo:of_datablock rdf:resource="{$base}"/&gt;</xsl2:text>
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
      &lt;</xsl2:text>/PDBo:<xsl2:value-of select='$name'/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
      &lt;</xsl2:text>/PDBo:has_<xsl2:value-of select='$name'/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
    <xsl2:text disable-output-escaping="yes">
  &lt;/xsl:template&gt;
</xsl2:text>
  </xsl2:template>

  <xsl2:template name="category_unique">
    <xsl2:param name="name"/>
    <xsl2:param name="original"/>
    <xsl2:variable name="xpath">PDBx:<xsl2:value-of select="$name"/>Category/PDBx:<xsl2:value-of select="$name"/></xsl2:variable>
    <xsl2:for-each select="/xsd:schema/xsd:element[@name='datablock']/xsd:unique[xsd:selector/@xpath=$xpath]|/xsd:schema/xsd:element[@name='datablock']/xsd:key[xsd:selector/@xpath=$xpath]">
      <xsl2:variable name="resource"><xsl2:value-of select="$name"/>/<xsl2:call-template name="concat_fields">
	  <xsl2:with-param name="selector" select="substring-after(xsd:selector/@xpath,'/PDBx:')"/>
	  <xsl2:with-param name="field" select="xsd:field[1]"/></xsl2:call-template></xsl2:variable>
      <!-- don't want duplicate key -->
      <xsl2:if test="$original!=$resource">
	<xsl2:variable name="check"><xsl2:call-template name="check_fields"><xsl2:with-param name="field" select="xsd:field[1]"/></xsl2:call-template></xsl2:variable>
	<xsl2:text disable-output-escaping="yes">
      &lt;xsl:if test=</xsl2:text>"<xsl2:value-of select='$check'/>"<xsl2:text disable-output-escaping='yes'>&gt;
        &lt;owl:sameAs&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
          &lt;</xsl2:text>PDBo:<xsl2:value-of select="$name"/> rdf:about="{$base}/<xsl2:value-of select='$resource'/>"<xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
            &lt;rdfs:label&gt;</xsl2:text>
	<xsl2:value-of select="@name"/>
	<xsl2:text disable-output-escaping="yes">&lt;/rdfs:label&gt;</xsl2:text>
	<xsl2:text disable-output-escaping="yes">
          &lt;</xsl2:text>/PDBo:<xsl2:value-of select="$name"/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
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
    <xsl2:variable name="xpath">PDBx:<xsl2:value-of select="$name"/>Category/PDBx:<xsl2:value-of select="$name"/></xsl2:variable>
    <xsl2:for-each select="/xsd:schema/xsd:element[@name='datablock']/xsd:keyref[xsd:selector/@xpath=$xpath]">
      <xsl2:variable name="refering" select="."/>
      <xsl2:variable name="keyname" select="substring-after($refering/@refer,':')"/>
      <xsl2:variable name="refer" select="../xsd:key[@name=$keyname] | ../xsd:unique[@name=$keyname]"/>
      <xsl2:variable name="refname" select="replace($refer/xsd:selector/@xpath,'.*/PDBx:','')"/>
	<xsl2:variable name="resource"><xsl2:value-of select="$refname"/>/<xsl2:call-template name="concat_fields2">
	    <xsl2:with-param name="field1" select="$refering/xsd:field[1]"/>
	    <xsl2:with-param name="selector2" select="substring-after($refer/xsd:selector/@xpath,'/')"/>
	    <xsl2:with-param name="field2" select="$refer/xsd:field[1]"/></xsl2:call-template></xsl2:variable>
        <xsl2:variable name="check"><xsl2:call-template name="check_fields"><xsl2:with-param name="field" select="$refering/xsd:field[1]"/></xsl2:call-template></xsl2:variable>
	<xsl2:text disable-output-escaping="yes">
      &lt;xsl:if test=</xsl2:text>"<xsl2:value-of select='$check'/>"<xsl2:text disable-output-escaping='yes'>&gt;
        &lt;</xsl2:text>PDBo:reference_to_<xsl2:value-of select="$refname"/><xsl2:text disable-output-escaping="yes">&gt;
	  &lt;</xsl2:text>rdf:Description  rdf:about="{$base}/<xsl2:value-of select='$resource'/>"<xsl2:text disable-output-escaping="yes">&gt;
	    &lt;</xsl2:text>PDBo:referenced_by_<xsl2:value-of select="$name"/> rdf:resource="{$base}/<xsl2:value-of select='$pathname'/>"<xsl2:text disable-output-escaping="yes">/&gt;
	  &lt;</xsl2:text>/rdf:Description<xsl2:text disable-output-escaping="yes">&gt;
        &lt;</xsl2:text>/PDBo:reference_to_<xsl2:value-of select="$refname"/><xsl2:text disable-output-escaping="yes">&gt;</xsl2:text>
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
