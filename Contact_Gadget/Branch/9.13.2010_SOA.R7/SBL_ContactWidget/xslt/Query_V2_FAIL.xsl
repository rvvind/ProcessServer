<?xml version="1.0" encoding="UTF-8"?>
<!-- @generated mapFile="xslt/Query_V2_FAIL.map" md5sum="6f2de2c6147fb4c21894199b8f6cb8d6" version="7.0.200" -->
<!--
*****************************************************************************
*   This file has been generated by the IBM XML Mapping Editor V7.0.200
*
*   Mapping file:		Query_V2_FAIL.map
*   Map declaration(s):	Query_V2_FAIL
*   Input file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252Fwservice.cerner.com%252F%257DContact_spcQuery_spcWPS_spcCERN_ContactQuery_Input/xpath%3D%252F/smo.xsd
*   Output file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252FSBL_ContactWidget_Lib%252FInvoke%257DContactQuery_V2_fault1Msg/xpath%3D%252F/smo.xsd
*
*   Note: Do not modify the contents of this file as it is overwritten
*         each time the mapping model is updated.
*****************************************************************************
-->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xalan="http://xml.apache.org/xslt"
    xmlns:in="http://wservice.cerner.com/"
    xmlns:in2="wsdl.http://wservice.cerner.com/"
    xmlns:io="http://www.siebel.com/xml/Contact%20WPS%20CERN_V2"
    xmlns:io2="http://www.w3.org/2003/05/soap-envelope"
    xmlns:io3="http://www.ibm.com/websphere/sibx/smo/v6.0.1"
    xmlns:out2="http://www.siebel.com/xml/Contact%20Web%20Access%20WPS%20CERN"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:out3="wsdl.http://SBL_ContactWidget_Lib/Invoke"
    xmlns:out="http://SBL_ContactWidget_Lib/Invoke"
    xmlns:io4="http://www.ibm.com/xmlns/prod/websphere/mq/sca/6.0.0"
    xmlns:io5="http://schemas.xmlsoap.org/ws/2004/08/addressing"
    xmlns:io6="http://www.ibm.com/xmlns/prod/websphere/http/sca/6.1.0"
    xmlns:out4="http://www.siebel.com/xml/Contact%20WPS%20CERN"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:io7="http://www.w3.org/2005/08/addressing"
    xmlns:map="http://SBL_ContactWidget/xslt/Query_V2_FAIL"
    exclude-result-prefixes="in in2 map xalan"
    version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="no"/>

  <!-- root template  -->
  <xsl:template match="/">
    <xsl:apply-templates select="io3:smo" mode="map:Query_V2_FAIL"/>
  </xsl:template>

  <!-- This rule represents an element mapping: "io3:smo" to "io3:smo".  -->
  <xsl:template match="io3:smo"  mode="map:Query_V2_FAIL">
    <io3:smo>
      <body>
        <!-- a simple data mapping: "context/failInfo/failureString"(string) to "out:ContactQuery_V2Fault1_fault1"(string) -->
        <out:ContactQuery_V2Fault1_fault1>
          <xsl:value-of select="context/failInfo/failureString"/>
        </out:ContactQuery_V2Fault1_fault1>
      </body>
    </io3:smo>
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
