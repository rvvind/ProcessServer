<?xml version="1.0" encoding="UTF-8"?>
<!-- @generated mapFile="xslt/SBLContactQueryV2Fail.map" md5sum="b14acbe51ce57b723667a47e0d6b80d8" version="7.0.401" -->
<!--
*****************************************************************************
*   This file has been generated by the IBM XML Mapping Editor V7.0.401
*
*   Mapping file:		SBLContactQueryV2Fail.map
*   Map declaration(s):	SBLContactQueryV2Fail
*   Input file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252Fwservice.cerner.com%252FV3%257DContact_spcQuery_spcWPS_spcCERN_ContactQuery_Input/xpath%3D%252F/smo.xsd
*   Output file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252FSBL_ContactWidget_Lib%252FInvoke%257DContactQueryV2_ContactQueryV2Fault1Msg/xpath%3D%252F/smo.xsd
*
*   Note: Do not modify the contents of this file as it is overwritten
*         each time the mapping model is updated.
*****************************************************************************
-->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xalan="http://xml.apache.org/xslt"
    xmlns:str="http://exslt.org/strings"
    xmlns:set="http://exslt.org/sets"
    xmlns:math="http://exslt.org/math"
    xmlns:exsl="http://exslt.org/common"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:in="http://wservice.cerner.com/V3"
    xmlns:in2="wsdl.http://wservice.cerner.com/V3"
    xmlns:out="http://www.siebel.com/xml/Contact%20WPS%20CERN_V2"
    xmlns:io="http://www.siebel.com/xml/Contact%20WPS%20CERN_V3"
    xmlns:io2="http://www.w3.org/2003/05/soap-envelope"
    xmlns:io3="http://www.ibm.com/websphere/sibx/smo/v6.0.1"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:out3="wsdl.http://SBL_ContactWidget_Lib/Invoke"
    xmlns:out2="http://SBL_ContactWidget_Lib/Invoke"
    xmlns:io4="http://www.ibm.com/xmlns/prod/websphere/mq/sca/6.0.0"
    xmlns:io5="http://schemas.xmlsoap.org/ws/2004/08/addressing"
    xmlns:io6="http://www.ibm.com/xmlns/prod/websphere/http/sca/6.1.0"
    xmlns:out4="http://www.siebel.com/xml/Contact%20WPS%20CERN"
    xmlns:xsd4xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:io7="http://www.w3.org/2005/08/addressing"
    xmlns:map="http://SBL_ContactWidget/xslt/SBLContactQueryV2Fail"
    xmlns:msl="http://www.ibm.com/xmlmap"
    exclude-result-prefixes="xalan str set in msl math map exsl in2 date"
    version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="no"/>

  <!-- root wrapper template  -->
  <xsl:template match="/">
    <xsl:choose>
      <xsl:when test="msl:datamap">
        <msl:datamap>
          <dataObject>
            <xsl:attribute name="xsi:type">
              <xsl:value-of select="'io3:ServiceMessageObject'"/>
            </xsl:attribute>
            <xsl:call-template name="map:SBLContactQueryV2Fail2">
              <xsl:with-param name="smo" select="msl:datamap/dataObject[1]"/>
            </xsl:call-template>
          </dataObject>
        </msl:datamap>
      </xsl:when>
      <xsl:otherwise>
        <xsl:apply-templates select="io3:smo" mode="map:SBLContactQueryV2Fail"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <!-- This rule represents an element mapping: "io3:smo" to "io3:smo".  -->
  <xsl:template match="io3:smo"  mode="map:SBLContactQueryV2Fail">
    <io3:smo>
      <body>
        <xsl:attribute name="xsi:type">
          <xsl:value-of select="'out3:ContactQueryV2_ContactQueryV2Fault1Msg'"/>
        </xsl:attribute>
        <!-- a simple data mapping: "context/failInfo/failureString"(string) to "out2:ContactQueryV2Fault1"(string) -->
        <out2:ContactQueryV2Fault1>
          <xsl:value-of select="context/failInfo/failureString"/>
        </out2:ContactQueryV2Fault1>
      </body>
    </io3:smo>
  </xsl:template>

  <!-- This rule represents a type mapping: "io3:smo" to "io3:smo".  -->
  <xsl:template name="map:SBLContactQueryV2Fail2">
    <xsl:param name="smo"/>
    <body>
      <xsl:attribute name="xsi:type">
        <xsl:value-of select="'out3:ContactQueryV2_ContactQueryV2Fault1Msg'"/>
      </xsl:attribute>
      <!-- a simple data mapping: "$smo/context/failInfo/failureString"(string) to "out2:ContactQueryV2Fault1"(string) -->
      <out2:ContactQueryV2Fault1>
        <xsl:value-of select="$smo/context/failInfo/failureString"/>
      </out2:ContactQueryV2Fault1>
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
