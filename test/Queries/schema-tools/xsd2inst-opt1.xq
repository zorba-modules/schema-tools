import module namespace st = "http://www.zorba-xquery.com/modules/schema-tools";

declare namespace sto = "http://www.zorba-xquery.com/modules/schema-tools/schema-tools-options";



let $xsd  :=
  <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema"
      attributeFormDefault="unqualified"
      elementFormDefault="qualified">
    <xs:element name="a" type="aType"/>
    <xs:complexType name="aType">
      <xs:sequence>
        <xs:element type="xs:string" name="b"/>
        <xs:element type="xs:string" name="c"/>
      </xs:sequence>
    </xs:complexType>
  </xs:schema>
let $opt  := <sto:options>
                 <sto:network-downloads>true</sto:network-downloads>
                 <sto:no-pvr>false</sto:no-pvr>
                 <sto:no-upa>true</sto:no-upa>
             </sto:options>
return
    st:xsd2inst(($xsd), "a", $opt)

