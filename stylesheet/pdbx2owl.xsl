<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE rdf:RDF [
  <!ENTITY xsd "http://www.w3.org/2001/XMLSchema#">
  <!ENTITY rdf "http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <!ENTITY rdfs "http://www.w3.org/2000/01/rdf-schema#">
  <!ENTITY owl "http://www.w3.org/2002/07/owl#">
]>
<xsl:stylesheet
   version="1.0"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xsd="http://www.w3.org/2001/XMLSchema"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
   xmlns:owl="http://www.w3.org/2002/07/owl#"
   exclude-result-prefixes="xsd xsi">

  <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <xsl:text disable-output-escaping="yes">
&lt;?xml-stylesheet type="text/xsl" href="https://rdf.wwpdb.org/schema/pdbxowl.xsl"?&gt;
</xsl:text>
    <rdf:RDF
       xml:base="http://rdf.wwpdb.org/schema/pdbx-v50.owl"
       xmlns:xml="http://www.w3.org/XML/1998/namespace"
       xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
       xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
       xmlns:owl="http://www.w3.org/2002/07/owl#"
       xmlns:dc="http://purl.org/dc/elements/1.1/"
       xmlns:dcterms="http://purl.org/dc/terms/">

      <owl:Ontology rdf:about="http://rdf.wwpdb.org/schema/pdbx-v50.owl">
	<rdfs:label>PDBx ontology</rdfs:label>
	<rdfs:comment xml:lang="en">The OWL ontology for PDB/RDF, generated from the PDBML Schema.</rdfs:comment>
	<rdfs:seeAlso rdf:resource="http://mmcif.wwpdb.org/dictionaries/ascii/mmcif_pdbx_v50.dic"/>
	<rdfs:seeAlso rdf:resource="http://mmcif.wwpdb.org/schema/pdbx-v50.xsd"/>
	<owl:versionIRI rdf:resource="http://rdf.wwpdb.org/schema/pdbx-v50.owl/5.399"/>
      </owl:Ontology>

      <owl:Class rdf:ID="Category">
	<rdfs:label>Category</rdfs:label>
	<rdfs:comment xml:lang="en">Abstract class for category holders.</rdfs:comment>
      </owl:Class>

      <owl:Class rdf:ID="CategoryElement">
	<rdfs:label>CategoryElement</rdfs:label>
	<rdfs:comment xml:lang="en">Abstract class for category elements.</rdfs:comment>
      </owl:Class>

      <owl:DatatypeProperty rdf:ID="categoryItem">
	<rdfs:label>categoryItem</rdfs:label>
	<rdfs:comment xml:lang="en">Abstract datatype property for category items.</rdfs:comment>
	<rdfs:domain rdf:resource="#CategoryElement"/>
      </owl:DatatypeProperty>

      <owl:ObjectProperty rdf:ID="crossReference">
	<rdfs:comment xml:lang="en">Abstract property for cross-references within PDBML.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="reference_to">
	<rdfs:comment xml:lang="en">Abstract property for cross-references between categories.</rdfs:comment>
	<rdfs:subPropertyOf rdf:resource="#crossReference"/>
	<rdfs:subPropertyOf rdf:resource="dcterms:references"/>
	<rdfs:domain rdf:resource="#CategoryElement"/>
	<rdfs:range rdf:resource="#CategoryElement"/>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="referenced_by">
	<rdfs:comment xml:lang="en">Abstract property for cross-references between categories.</rdfs:comment>
	<rdfs:subPropertyOf rdf:resource="#crossReference"/>
	<rdfs:subPropertyOf rdf:resource="dcterms:isReferencedBy"/>
	<rdfs:domain rdf:resource="#CategoryElement"/>
	<rdfs:range rdf:resource="#CategoryElement"/>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to">
	<rdfs:subPropertyOf rdf:resource="#crossReference"/>
	<rdfs:comment xml:lang="en">Abstract property for external links.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="rdf_link_to">
	<rdfs:subPropertyOf rdf:resource="#link_to"/>
	<rdfs:comment xml:lang="en">Abstract property for external RDF links.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="html_link_to">
	<rdfs:subPropertyOf rdf:resource="#link_to"/>
	<rdfs:comment xml:lang="en">Abstract property for external HTML links.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pdbml">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">link to PDBML-all file.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pdbml_noatom">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">link to PDBML-noatom file.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pdbml_extatom">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">link to PDBML-extatom file.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pdb">
	<rdfs:subPropertyOf rdf:resource="#rdf_link_to"/>
	<rdfs:comment xml:lang="en">link to related PDB entry.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_vrpt">
	<rdfs:subPropertyOf rdf:resource="#rdf_link_to"/>
	<rdfs:comment xml:lang="en">link to associated wwPDB validation report.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pdb_split">
	<rdfs:subPropertyOf rdf:resource="#link_to_pdb"/>
	<rdfs:comment xml:lang="en">link to split PDB entry.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_bmrb">
	<rdfs:subPropertyOf rdf:resource="#rdf_link_to"/>
	<rdfs:comment xml:lang="en">link to associated BMRB entry.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_emdb">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">link to associated EMDB entry.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_sasbdb">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">link to associated SASBDB entry.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pubmed">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to PubMed.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_sequence_db">
	<rdfs:subPropertyOf rdf:resource="#link_to"/>
	<rdfs:comment xml:lang="en">external link to sequence databases.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_uniprot">
	<rdfs:subPropertyOf rdf:resource="#link_to_sequence_db"/>
	<rdfs:subPropertyOf rdf:resource="#rdf_link_to"/>
	<rdfs:comment xml:lang="en">external link to UniProt.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_genbank">
	<rdfs:subPropertyOf rdf:resource="#link_to_sequence_db"/>
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to GenBank.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_embl">
	<rdfs:subPropertyOf rdf:resource="#link_to_sequence_db"/>
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to EMBL.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_norine">
	<rdfs:subPropertyOf rdf:resource="#link_to_sequence_db"/>
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to NORINE.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pir">
	<rdfs:subPropertyOf rdf:resource="#link_to_sequence_db"/>
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to PIR.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_refseq">
	<rdfs:subPropertyOf rdf:resource="#link_to_sequence_db"/>
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to RefSeq.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_glycoinfo">
	<rdfs:subPropertyOf rdf:resource="#link_to_sequence_db"/>
	<rdfs:subPropertyOf rdf:resource="#rdf_link_to"/>
	<rdfs:comment xml:lang="en">external link to glycoinfo.org.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_kegg_comp">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to KEGG Compound.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_kegg_drug">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to KEGG Drug.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_nadb">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to Novel Antibiotics Data Base.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_orcid">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to ORCiD (Open Researcher and Contributor ID).</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_doi">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to DOI (digital object identifier).</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_taxonomy">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to NCBI taxonomy.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_taxonomy_source">
	<rdfs:subPropertyOf rdf:resource="#link_to_taxonomy"/>
	<rdfs:comment xml:lang="en">external link to NCBI taxonomy (source organism).</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_taxonomy_host">
	<rdfs:subPropertyOf rdf:resource="#link_to_taxonomy"/>
	<rdfs:comment xml:lang="en">external link to NCBI taxonomy (host organism).</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_enzyme">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to EC (enzyme commission) number.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_go">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to GO (gene ontology).</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_interpro">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to InterPro.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pfam">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to Pfam.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_cath">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to CATH.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_scop">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to SCOP, SCOP2, and SCOP2B.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_ensembl">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to Ensembl (Eukaryotic Genome).</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_chem_comp">
	<rdfs:subPropertyOf rdf:resource="#rdf_link_to"/>
	<rdfs:comment xml:lang="en">external link to chemical component in CCD.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_parent_chem_comp">
	<rdfs:subPropertyOf rdf:resource="#link_to_chem_comp"/>
	<rdfs:comment xml:lang="en">external link to parental chemical component in CCD.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_prd">
	<rdfs:subPropertyOf rdf:resource="#rdf_link_to"/>
	<rdfs:comment xml:lang="en">external link to peptide reference in PRD (a part of BIRD, Biologically Interesting molecules Reference Dictionary).</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_ccdc">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to CCDC (Cambridge Crystallographic Data Centre).</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_pubchem_substance">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to PubChem Substance.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_chemspider">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to ChemSpider.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_cas">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to CAS.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_chebi">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to ChEBI.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_mesh">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to MeSH.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_chemidplus">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to ChemIDplus.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_chembl">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to ChEMBL.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_bindingdb">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to BindingDB.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_drugbank">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to DrugBank.</rdfs:comment>
      </owl:ObjectProperty>

      <owl:ObjectProperty rdf:ID="link_to_chemdb">
	<rdfs:subPropertyOf rdf:resource="#html_link_to"/>
	<rdfs:comment xml:lang="en">external link to ChemDB.</rdfs:comment>
      </owl:ObjectProperty>

      <xsl:apply-templates/>
    </rdf:RDF>
  </xsl:template>

  <!-- schema root -->
  <xsl:template match="xsd:schema">
    <xsl:call-template name="datablockType"/>
    <xsl:apply-templates select="./xsd:complexType/xsd:sequence/*" mode="category_element"/>
  </xsl:template>

  <!-- datablockType is special -->
  <xsl:template name="datablockType">
    <owl:Class rdf:ID="datablock">
      <rdfs:label>datablock</rdfs:label>
      <rdfs:comment xml:lang="en">The datablock class holds all categories of PDB data.</rdfs:comment>
      <rdfs:subClassOf>
	<owl:Class>
	  <owl:intersectionOf rdf:parseType="Collection">
	    <xsl:for-each select="/xsd:schema/xsd:complexType[@name='datablockType']/xsd:all/*">
	      <xsl:variable name="category"><xsl:value-of select="substring-before(@name,'Category')"/></xsl:variable>
	      <xsl:call-template name="hasCategory_restriction">
		<xsl:with-param name="category" select="$category"/>
	      </xsl:call-template>
	    </xsl:for-each>
	  </owl:intersectionOf>
	</owl:Class>
      </rdfs:subClassOf>
    </owl:Class>

    <owl:DatatypeProperty rdf:ID="datablockName">
      <rdfs:domain rdf:resource="#datablock"/>
      <rdfs:range rdf:resource="&xsd;string"/>
      <xsl:apply-templates select="./xsd:annotation"/>
    </owl:DatatypeProperty>

    <owl:InverseFunctionalProperty rdf:ID="hasCategory">
      <rdfs:comment xml:lang="en">Abstract property pointing to category.</rdfs:comment>
      <rdfs:domain rdf:resource="#datablock"/>
    </owl:InverseFunctionalProperty>

    <owl:InverseFunctionalProperty rdf:ID="hasCategoryElement">
      <rdfs:comment xml:lang="en">Abstract property pointing to category element.</rdfs:comment>
      <!-- range should be rdf:List, but OWL doesn't allow this... -->
    </owl:InverseFunctionalProperty>

    <owl:ObjectProperty rdf:ID="of_datablock">
      <rdfs:label>link_to_datablock</rdfs:label>
      <rdfs:comment xml:lang="en">Link to the base datablock of category elements.</rdfs:comment>
      <rdfs:domain rdf:resource="#CategoryElement"/>
      <rdfs:range rdf:resource="#datablock"/>
    </owl:ObjectProperty>

    <owl:ObjectProperty rdf:ID="datablock_of">
      <owl:inverseOf rdf:resource="#of_datablock"/>
    </owl:ObjectProperty>

  </xsl:template>

  <xsl:template name="hasCategory_restriction">
    <xsl:param name="category"/>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#has_{$category}Category"/>
      <owl:minCardinality rdf:datatype="&xsd;nonNegativeInteger">0</owl:minCardinality>
    </owl:Restriction>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#has_{$category}Category"/>
      <owl:maxCardinality rdf:datatype="&xsd;nonNegativeInteger">1</owl:maxCardinality>
    </owl:Restriction>
  </xsl:template>

  <xsl:template name="hasCategoryElement_restriction">
    <xsl:param name="category"/>
    <xsl:variable name="categoryType" select="/xsd:schema/xsd:complexType[@name=concat($category,'Type')]/xsd:sequence/xsd:element"/>
    <owl:Restriction>
      <owl:onProperty rdf:resource="#has_{$category}"/>
      <owl:minCardinality rdf:datatype="&xsd;nonNegativeInteger"><xsl:value-of select="$categoryType/@minOccurs"/></owl:minCardinality>
    </owl:Restriction>
    <xsl:if test="$categoryType/@maxOccurs!='unbounded'">
      <owl:Restriction>
	<owl:onProperty rdf:resource="#has_{$category}"/>
	<owl:maxCardinality rdf:datatype="&xsd;nonNegativeInteger"><xsl:value-of select="$categoryType/@maxOccurs"/></owl:maxCardinality>
      </owl:Restriction>
    </xsl:if>
  </xsl:template>

  <!-- basic category types -->
  <xsl:template match="xsd:element" mode="category_element">
    <xsl:variable name="category"><xsl:value-of select="@name"/></xsl:variable>
    <xsl:variable name="category_id"><xsl:value-of select="concat($category,'Category')"/></xsl:variable>
    <owl:Class rdf:ID="{$category_id}">
      <rdfs:subClassOf>
	<owl:Class>
	  <owl:intersectionOf rdf:parseType="Collection">
	    <owl:Class rdf:about="#Category"/>
	    <xsl:call-template name="hasCategoryElement_restriction">
	      <xsl:with-param name="category" select="$category"/>
	    </xsl:call-template>
	  </owl:intersectionOf>
	</owl:Class>
      </rdfs:subClassOf>
    </owl:Class>

    <owl:Class rdf:ID="{$category}">
      <rdfs:label><xsl:value-of select="$category"/></rdfs:label>
      <xsl:apply-templates select="../../xsd:annotation"/>
      <rdfs:subClassOf>
	<owl:Class>
	  <owl:intersectionOf rdf:parseType="Collection">
	    <owl:Class rdf:about="#CategoryElement"/>
	    <xsl:for-each select="./xsd:complexType/xsd:all/*|./xsd:complexType/xsd:attribute">
	      <xsl:call-template name="category_item_restriction">
		<xsl:with-param name="category" select="$category"/>
	      </xsl:call-template>
	    </xsl:for-each>
	  </owl:intersectionOf>
	</owl:Class>
      </rdfs:subClassOf>
    </owl:Class>

    <owl:InverseFunctionalProperty rdf:ID="has_{$category_id}">
      <rdfs:label><xsl:value-of select="$category_id"/></rdfs:label>
      <rdfs:comment xml:lang="en">
	This property indicates that datablock
	has a category holder <xsl:value-of select="$category_id"/>.
      </rdfs:comment>
      <rdfs:subPropertyOf rdf:resource="#hasCategory"/>
      <rdfs:seeAlso rdf:resource="#{$category}"/>
    </owl:InverseFunctionalProperty>

    <owl:InverseFunctionalProperty rdf:ID="has_{$category}">
      <rdfs:label><xsl:value-of select="$category_id"/></rdfs:label>
      <rdfs:comment xml:lang="en">
	This property indicates that <xsl:value-of select="$category_id"/>.
	has a category <xsl:value-of select="$category"/>.
      </rdfs:comment>
      <rdfs:subPropertyOf rdf:resource="#hasCategoryElement"/>
      <rdfs:seeAlso rdf:resource="#{$category}"/>
      <rdfs:domain rdf:resource="#{$category_id}"/>
      <rdfs:range rdf:resource="#{$category}"/>
    </owl:InverseFunctionalProperty>

    <owl:DatatypeProperty rdf:ID="{$category}Item">
      <rdfs:label><xsl:value-of select="$category"/>Item</rdfs:label>
      <rdfs:comment xml:lang="en">Abstract datatype property for <xsl:value-of select="$category"/> items.</rdfs:comment>
      <rdfs:subPropertyOf rdf:resource="#categoryItem"/>
      <rdfs:domain rdf:resource="#{$category}"/>
    </owl:DatatypeProperty>

    <owl:ObjectProperty rdf:ID="reference_to_{$category}">
      <rdfs:label>reference_to_<xsl:value-of select="$category"/></rdfs:label>
      <rdfs:comment xml:lang="en">cross-reference to <xsl:value-of select="$category"/>.</rdfs:comment>
      <rdfs:subPropertyOf rdf:resource="#reference_to"/>
      <rdfs:domain rdf:resource="#{$category}"/>
    </owl:ObjectProperty>

    <owl:ObjectProperty rdf:ID="referenced_by_{$category}">
      <rdfs:label>referenced_by_<xsl:value-of select="$category"/></rdfs:label>
      <rdfs:comment xml:lang="en">cross-reference from <xsl:value-of select="$category"/>.</rdfs:comment>
      <rdfs:subPropertyOf rdf:resource="#referenced_by"/>
      <rdfs:range rdf:resource="#{$category}"/>
    </owl:ObjectProperty>

    <xsl:for-each select="./xsd:complexType/xsd:all/*|./xsd:complexType/xsd:attribute">
      <xsl:call-template name="category_item">
	<xsl:with-param name="category" select="$category"/>
      </xsl:call-template>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="category_item_restriction">
    <xsl:param name="category"/>
    <xsl:variable name="resource"><xsl:value-of select="concat('#',$category,'.',@name)"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="@use='required'">
	<owl:Restriction>
	  <owl:onProperty rdf:resource="{$resource}"/>
	  <owl:cardinality rdf:datatype="&xsd;nonNegativeInteger">1</owl:cardinality>
	</owl:Restriction>
      </xsl:when>
      <xsl:when test="@use='optional'">
	<owl:Restriction>
	  <owl:onProperty rdf:resource="{$resource}"/>
	  <owl:minCardinality rdf:datatype="&xsd;nonNegativeInteger">0</owl:minCardinality>
	</owl:Restriction>
	<owl:Restriction>
	  <owl:onProperty rdf:resource="{$resource}"/>
	  <owl:maxCardinality rdf:datatype="&xsd;nonNegativeInteger">1</owl:maxCardinality>
	</owl:Restriction>
      </xsl:when>
      <xsl:otherwise>
	<owl:Restriction>
	  <owl:onProperty rdf:resource="{$resource}"/>
	  <owl:minCardinality rdf:datatype="&xsd;nonNegativeInteger"><xsl:value-of select="@minOccurs"/></owl:minCardinality>
	</owl:Restriction>
	<owl:Restriction>
	  <owl:onProperty rdf:resource="{$resource}"/>
	  <owl:maxCardinality rdf:datatype="&xsd;nonNegativeInteger"><xsl:value-of select="@maxOccurs"/></owl:maxCardinality>
	</owl:Restriction>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="category_item">
    <xsl:param name="category"/>
    <xsl:variable name="id"><xsl:value-of select="concat($category,'.',@name)"/></xsl:variable>
    <xsl:choose>
      <xsl:when test="count(.//xsd:enumeration)=0">
	<!-- basic types -->
	<xsl:variable name="datatype1" select="substring-after(@type,':')"/>
	<xsl:variable name="datatype2" select="substring-after(./xsd:complexType/xsd:simpleContent/xsd:extension/@base,':')"/>
	<xsl:variable name="datatype3" select="substring-after(./xsd:simpleType[1]/xsd:restriction/@base,':')"/>
	<owl:DatatypeProperty rdf:ID="{$id}">
	  <rdfs:subPropertyOf rdf:resource="#{$category}Item"/>
	  <rdfs:range rdf:resource="&xsd;{concat($datatype1,$datatype2,$datatype3)}"/>
	  <rdfs:label><xsl:value-of select="$id"/></rdfs:label>
	  <xsl:apply-templates select="./xsd:annotation"/>
	</owl:DatatypeProperty>
      </xsl:when>
      <xsl:otherwise>
	<xsl:variable name="datatype"><xsl:value-of select="substring-after(.//@base,':')"/></xsl:variable>
	<owl:DatatypeProperty rdf:ID="{$id}">
	  <rdfs:subPropertyOf rdf:resource="#{$category}Item"/>
	  <rdfs:domain rdf:resource="#{$category}"/>
	  <rdfs:range>
	    <owl:DataRange>
	      <owl:oneOf>
		<xsl:call-template name="enumeration">
		  <xsl:with-param name="elm" select=".//xsd:enumeration[1]"/>
		  <xsl:with-param name="t" select="$datatype"/>
		</xsl:call-template>
	      </owl:oneOf>
	    </owl:DataRange>
	  </rdfs:range>
	  <xsl:apply-templates select="./xsd:annotation"/>
	</owl:DatatypeProperty>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="enumeration">
    <xsl:param name="elm"/>
    <xsl:param name="t"/>
    <rdf:List>
      <rdf:first rdf:datatype="&xsd;{$t}"><xsl:value-of select="$elm/@value"/></rdf:first>
      <xsl:choose>
	<xsl:when test="count($elm/following-sibling::node())=0">
	  <rdf:rest rdf:resource="&rdf;nil"/>
	</xsl:when>
	<xsl:otherwise>
	  <rdf:rest>
	    <xsl:call-template name="enumeration">
	      <xsl:with-param name="elm" select="$elm/following-sibling::node()[1]"/>
	      <xsl:with-param name="t" select="$t"/>
	    </xsl:call-template>
	  </rdf:rest>
	</xsl:otherwise>
      </xsl:choose>
    </rdf:List>
  </xsl:template>

  <!-- annotation of categories and items -->
  <xsl:template match="xsd:annotation">
    <rdfs:comment xml:lang="en">
      <xsl:value-of select="./xsd:documentation"/>
    </rdfs:comment>
    <xsl:variable name="pointer"><xsl:value-of select="./xsd:documentation/@source"/></xsl:variable>
    <xsl:if test="$pointer!=''">
      <rdfs:seeAlso rdf:resource="{$pointer}"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="text()|*|@*"/>
  <xsl:template match="text()|*|@*" mode="annotation"/>

</xsl:stylesheet>
