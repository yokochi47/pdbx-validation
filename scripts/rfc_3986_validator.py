import sys
import gzip
from lxml import etree
from urllib.parse import urljoin
from rfc3986 import uri_reference, validators, exceptions

RDF_NS = "http://www.w3.org/1999/02/22-rdf-syntax-ns#"
XML_NS = "http://www.w3.org/XML/1998/namespace"

validator = validators.Validator().check_validity_of(
    "scheme", "host", "path", "query", "fragment"
)

def check_uri(candidate, context):
    """Run an ASCII check plus an RFC 3986 syntax check, and report any problems"""
    problems = []
    if not candidate.isascii():
        problems.append("contains non-ASCII character(s)")
    try:
        validator.validate(uri_reference(candidate))
    except exceptions.ValidationError as e:
        problems.append(f"RFC 3986 syntax error: {e}")
    if problems:
        print(f"[NG] {context}: '{candidate}' -> {', '.join(problems)}")
    else:
        print(f"[OK] {context}: '{candidate}'")

def resolve(base, ref):
    return urljoin(base, ref) if ref else base

def open_input(path):
    """Open path for reading; transparently decompress if it has a .gz extension"""
    if path.endswith(".gz"):
        return gzip.open(path, "rb")
    return open(path, "rb")

def walk(elem, base):
    # Update the base URI in effect for this node
    xml_base = elem.get(f"{{{XML_NS}}}base")
    if xml_base:
        check_uri(xml_base, f"xml:base (line {elem.sourceline})")
        base = resolve(base, xml_base)

    # URI of the element name (type/property) = namespace + local name
    if elem.tag.startswith("{"):
        ns, local = elem.tag[1:].split("}", 1)
        check_uri(ns, f"element namespace (line {elem.sourceline}, <{local}>)")

    for attr, value in elem.attrib.items():
        if attr.startswith("{"):
            ns, local = attr[1:].split("}", 1)
        else:
            ns, local = "", attr

        if ns == RDF_NS and local in ("about", "resource"):
            check_uri(resolve(base, value), f"rdf:{local} (line {elem.sourceline})")
        elif ns == RDF_NS and local == "ID":
            check_uri(resolve(base, "#" + value), f"rdf:ID (line {elem.sourceline})")
        elif ns == RDF_NS and local == "datatype":
            check_uri(resolve(base, value), f"rdf:datatype (line {elem.sourceline})")
        elif attr.startswith("xmlns"):
            check_uri(value, f"{attr} (line {elem.sourceline})")

    for child in elem:
        walk(child, base)

def main(path, doc_base):
    with open_input(path) as f:
        tree = etree.parse(f)
    root = tree.getroot()
    walk(root, doc_base)

if __name__ == "__main__":
    # doc_base: the default base URI for the document
    # (usually the file's own location, or the xml:base right under rdf:RDF)
    main(sys.argv[1], sys.argv[2] if len(sys.argv) > 2 else "http://example.org/")
