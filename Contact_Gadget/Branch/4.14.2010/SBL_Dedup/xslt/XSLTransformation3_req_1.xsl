<?xml version="1.0" encoding="UTF-8"?>
<!-- @generated mapFile="xslt/XSLTransformation3_req_1.map" md5sum="eda02c3a03cc66fa46495477c9403075" version="1.0.130" -->
<!--
*****************************************************************************
*   This file has been generated by the IBM XML Mapping Editor V1.0.130
*
*   Mapping file:		XSLTransformation3_req_1.map
*   Map declaration(s):	XSLTransformation3_req_1
*   Input file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252Fwservice.cerner.com%257DDeduplication_spcProxy_spcCERN_Dedup_Input/xpath%3D%252F/smo.xsd
*   Output file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252FSBL_Dedup_Lib%252FInvoke%257DDedup_fault1Msg/xpath%3D%252F/smo.xsd
*
*   Note: Do not modify the contents of this file as it is overwritten
*         each time the mapping model is updated.
*****************************************************************************
-->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xalan="http://xml.apache.org/xslt"
    xmlns:in="wsdl.http://wservice.cerner.com"
    xmlns:in2="http://wservice.cerner.com"
    xmlns:io="http://www.ibm.com/xmlns/prod/websphere/http/sca/6.1.0"
    xmlns:out="http://SBL_Dedup_Lib/Invoke"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:io3="http://www.ibm.com/xmlns/prod/websphere/mq/sca/6.0.0"
    xmlns:io2="http://www.ibm.com/websphere/sibx/smo/v6.0.1"
    xmlns:out2="wsdl.http://SBL_Dedup_Lib/Invoke"
    xmlns:io4="http://schemas.xmlsoap.org/ws/2004/08/addressing"
    exclude-result-prefixes="in in2 xalan"
    version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="yes" xalan:indent-amount="2"/>
  <xsl:strip-space elements="*"/>

  <!-- root template  -->
  <xsl:template match="/">
    <xsl:apply-templates select="io2:smo" mode="XSLTransformation3_req_1"/>
  </xsl:template>

  <!-- This rule represents an element mapping: "io2:smo" to "io2:smo".  -->
  <xsl:template match="io2:smo"  mode="XSLTransformation3_req_1">
    <io2:smo>
      <body>
        <!-- a simple data mapping: "context/failInfo/failureString"(String) to "out:string_element"(String) -->
        <out:string_element>
          <xsl:value-of select="context/failInfo/failureString"/>
        </out:string_element>
      </body>
    </io2:smo>
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
