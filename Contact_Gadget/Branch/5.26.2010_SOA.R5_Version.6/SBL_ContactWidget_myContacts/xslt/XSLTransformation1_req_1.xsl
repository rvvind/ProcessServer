<?xml version="1.0" encoding="UTF-8"?>
<!-- @generated mapFile="xslt/XSLTransformation1_req_1.map" md5sum="575be26139e3c21d013a0c7eb8d72132" version="1.0.130" -->
<!--
*****************************************************************************
*   This file has been generated by the IBM XML Mapping Editor V1.0.130
*
*   Mapping file:		XSLTransformation1_req_1.map
*   Map declaration(s):	XSLTransformation1_req_1
*   Input file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252FSBL_ContactWidget_myContacts_Lib%252FInvoke%257DContactListUpsertRequestMsg/xpath%3D%252Fbody/smo.xsd
*   Output file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252Fwservice.cerner.com%252F%257DContact_spcList_spcUpsert_spcWPS_spcCERN_ContactListUpsert_Input/xpath%3D%252Fbody/smo.xsd
*
*   Note: Do not modify the contents of this file as it is overwritten
*         each time the mapping model is updated.
*****************************************************************************
-->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xalan="http://xml.apache.org/xslt"
    xmlns:in2="http://SBL_ContactWidget_myContacts_Lib/Invoke"
    xmlns:in="wsdl.http://SBL_ContactWidget_myContacts_Lib/Invoke"
    xmlns:io="http://www.siebel.com/xml/Contact%20List%20WPS%20CERN"
    xmlns:out="wsdl.http://wservice.cerner.com/"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:io2="http://wservice.cerner.com/"
    exclude-result-prefixes="in2 in xalan"
    version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="yes" xalan:indent-amount="2"/>
  <xsl:strip-space elements="*"/>

  <!-- root template  -->
  <xsl:template match="/">
    <xsl:apply-templates select="body" mode="XSLTransformation1_req_1"/>
  </xsl:template>

  <!-- This rule represents an element mapping: "body" to "body".  -->
  <xsl:template match="body"  mode="XSLTransformation1_req_1">
    <body>
      <io2:Contact_spcList_spcUpsert_spcWPS_spcCERN_ContactListUpsert_Input>
        <!-- a structural mapping: "in2:ContactListUpsert/io2:Contact_spcList_spcUpsert_spcWPS_spcCERN_ContactListUpsert_Input/io:ListOfContactListWpsCern"(ListOfContactListWpsCern) to "io:ListOfContactListWpsCern"(ListOfContactListWpsCern) -->
        <xsl:copy-of select="in2:ContactListUpsert/io2:Contact_spcList_spcUpsert_spcWPS_spcCERN_ContactListUpsert_Input/io:ListOfContactListWpsCern"/>
      </io2:Contact_spcList_spcUpsert_spcWPS_spcCERN_ContactListUpsert_Input>
    </body>
  </xsl:template>

  <!-- *****************    Utility Templates    ******************  -->
  <!-- copy the namespace declarations from the source to the target -->
  <xsl:template name="copyNamespaceDeclarations">
    <xsl:param name="root"/>
    <xsl:for-each select="$root/namespace::*">
      <xsl:copy/>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
