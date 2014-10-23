<?xml version="1.0" encoding="UTF-8"?>
<!-- @generated mapFile="xslt/SBL_to_ContactQuery_Response.map" md5sum="4dd143ccbde11eb0c762e44a4a20c2c0" version="7.0.200" -->
<!--
*****************************************************************************
*   This file has been generated by the IBM XML Mapping Editor V7.0.200
*
*   Mapping file:		SBL_to_ContactQuery_Response.map
*   Map declaration(s):	SBL_to_ContactQuery_Response
*   Input file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252Fwservice.cerner.com%252F%257DContact_spcQuery_spcWPS_spcCERN_ContactQuery_Output/xpath%3D%252Fbody/smo.xsd
*   Output file(s):		smo://smo/name%3Dwsdl-primary/message%3D%257Bhttp%253A%252F%252FSBL_ContactWidget_Lib%252FInvoke%257DContactQueryResponseMsg/xpath%3D%252Fbody/smo.xsd
*
*   Note: Do not modify the contents of this file as it is overwritten
*         each time the mapping model is updated.
*****************************************************************************
-->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xalan="http://xml.apache.org/xslt"
    xmlns:in="wsdl.http://wservice.cerner.com/"
    xmlns:io="http://www.siebel.com/xml/Contact%20WPS%20CERN_V2"
    xmlns:io2="http://www.w3.org/2003/05/soap-envelope"
    xmlns:out="http://www.siebel.com/xml/Contact%20Web%20Access%20WPS%20CERN"
    xmlns:io3="http://www.ibm.com/websphere/sibx/smo/v6.0.1"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:out2="wsdl.http://SBL_ContactWidget_Lib/Invoke"
    xmlns:out3="http://SBL_ContactWidget_Lib/Invoke"
    xmlns:io4="http://www.ibm.com/xmlns/prod/websphere/mq/sca/6.0.0"
    xmlns:io5="http://wservice.cerner.com/"
    xmlns:io6="http://schemas.xmlsoap.org/ws/2004/08/addressing"
    xmlns:io7="http://www.ibm.com/xmlns/prod/websphere/http/sca/6.1.0"
    xmlns:out4="http://www.siebel.com/xml/Contact%20WPS%20CERN"
    xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:io8="http://www.w3.org/2005/08/addressing"
    xmlns:map="http://SBL_ContactWidget/xslt/SBL_to_ContactQuery_Response"
    exclude-result-prefixes="in map xalan"
    version="1.0">
  <xsl:output method="xml" encoding="UTF-8" indent="no"/>

  <!-- root template  -->
  <xsl:template match="/">
    <xsl:apply-templates select="body" mode="map:SBL_to_ContactQuery_Response"/>
  </xsl:template>

  <!-- This rule represents an element mapping: "body" to "body".  -->
  <xsl:template match="body"  mode="map:SBL_to_ContactQuery_Response">
    <body>
      <out3:ContactQueryResponse>
        <io5:Contact_spcQuery_spcWPS_spcCERN_ContactQuery_Output>
          <!-- a simple data mapping: "io5:Contact_spcQuery_spcWPS_spcCERN_ContactQuery_Output_V2/io5:Error_spcCode"(string) to "io5:Error_spcCode"(string) -->
          <io5:Error_spcCode>
            <xsl:value-of select="io5:Contact_spcQuery_spcWPS_spcCERN_ContactQuery_Output_V2/io5:Error_spcCode"/>
          </io5:Error_spcCode>
          <!-- a simple data mapping: "io5:Contact_spcQuery_spcWPS_spcCERN_ContactQuery_Output_V2/io5:Error_spcMessage"(string) to "io5:Error_spcMessage"(string) -->
          <io5:Error_spcMessage>
            <xsl:value-of select="io5:Contact_spcQuery_spcWPS_spcCERN_ContactQuery_Output_V2/io5:Error_spcMessage"/>
          </io5:Error_spcMessage>
          <!-- a structural mapping: "io5:Contact_spcQuery_spcWPS_spcCERN_ContactQuery_Output_V2/io:ListOfContactWpsCern"(ListOfContactWpsCern) to "out4:ListOfContactWpsCern"(ListOfContactWpsCern) -->
          <xsl:apply-templates select="io5:Contact_spcQuery_spcWPS_spcCERN_ContactQuery_Output_V2/io:ListOfContactWpsCern" mode="localListOfContactWpsCernToListOfContactWpsCern_1137927064"/>
        </io5:Contact_spcQuery_spcWPS_spcCERN_ContactQuery_Output>
      </out3:ContactQueryResponse>
    </body>
  </xsl:template>

  <!-- This rule represents an element mapping: "io:ListOfContactWpsCern" to "out4:ListOfContactWpsCern".  -->
  <xsl:template match="io:ListOfContactWpsCern"  mode="localListOfContactWpsCernToListOfContactWpsCern_1137927064">
    <out4:ListOfContactWpsCern>
      <!-- a for-each transform: "io:Contact"(Contact) to "out4:Contact"(Contact) -->
      <xsl:apply-templates select="io:Contact" mode="localContactToContact_1897725615"/>
    </out4:ListOfContactWpsCern>
  </xsl:template>

  <!-- This rule represents a for-each transform: "io:Contact" to "out4:Contact".  -->
  <xsl:template match="io:Contact"  mode="localContactToContact_1897725615">
    <out4:Contact>
      <!-- a simple data mapping: "io:Id"(string30) to "out4:Id"(string30) -->
      <xsl:if test="io:Id">
        <out4:Id>
          <xsl:value-of select="io:Id"/>
        </out4:Id>
      </xsl:if>
      <!-- a simple data mapping: "io:MobilePhoneNum"(string) to "out4:MobilePhoneNum"(string) -->
      <xsl:if test="io:MobilePhoneNum">
        <out4:MobilePhoneNum>
          <xsl:value-of select="io:MobilePhoneNum"/>
        </out4:MobilePhoneNum>
      </xsl:if>
      <!-- a simple data mapping: "io:PrimaryEmail"(string50) to "out4:PrimaryEmail"(string50) -->
      <xsl:if test="io:PrimaryEmail">
        <out4:PrimaryEmail>
          <xsl:value-of select="io:PrimaryEmail"/>
        </out4:PrimaryEmail>
      </xsl:if>
      <!-- a simple data mapping: "io:FirstName"(string50) to "out4:FirstName"(string50) -->
      <xsl:if test="io:FirstName">
        <out4:FirstName>
          <xsl:value-of select="io:FirstName"/>
        </out4:FirstName>
      </xsl:if>
      <!-- a simple data mapping: "io:HomePhoneNum"(string) to "out4:HomePhoneNum"(string) -->
      <xsl:if test="io:HomePhoneNum">
        <out4:HomePhoneNum>
          <xsl:value-of select="io:HomePhoneNum"/>
        </out4:HomePhoneNum>
      </xsl:if>
      <!-- a simple data mapping: "io:IntegrationId"(string30) to "out4:IntegrationId"(string30) -->
      <xsl:if test="io:IntegrationId">
        <out4:IntegrationId>
          <xsl:value-of select="io:IntegrationId"/>
        </out4:IntegrationId>
      </xsl:if>
      <!-- a simple data mapping: "io:JobTitle"(string75) to "out4:JobTitle"(string75) -->
      <xsl:if test="io:JobTitle">
        <out4:JobTitle>
          <xsl:value-of select="io:JobTitle"/>
        </out4:JobTitle>
      </xsl:if>
      <!-- a simple data mapping: "io:LastName"(string50) to "out4:LastName"(string50) -->
      <xsl:if test="io:LastName">
        <out4:LastName>
          <xsl:value-of select="io:LastName"/>
        </out4:LastName>
      </xsl:if>
      <!-- a simple data mapping: "io:LoginName"(string50) to "out4:LoginName"(string50) -->
      <xsl:if test="io:LoginName">
        <out4:LoginName>
          <xsl:value-of select="io:LoginName"/>
        </out4:LoginName>
      </xsl:if>
      <!-- a simple data mapping: "io:MrMs"(string15) to "out4:MrMs"(string15) -->
      <xsl:if test="io:MrMs">
        <out4:MrMs>
          <xsl:value-of select="io:MrMs"/>
        </out4:MrMs>
      </xsl:if>
      <!-- a simple data mapping: "io:Mnemonic"(string10) to "out4:Mnemonic"(string10) -->
      <xsl:if test="io:Mnemonic">
        <out4:Mnemonic>
          <xsl:value-of select="io:Mnemonic"/>
        </out4:Mnemonic>
      </xsl:if>
      <!-- a simple data mapping: "io:Role"(string30) to "out4:Role"(string30) -->
      <xsl:if test="io:Role">
        <out4:Role>
          <xsl:value-of select="io:Role"/>
        </out4:Role>
      </xsl:if>
      <!-- a simple data mapping: "io:WorkPhoneNum"(string) to "out4:WorkPhoneNum"(string) -->
      <xsl:if test="io:WorkPhoneNum">
        <out4:WorkPhoneNum>
          <xsl:value-of select="io:WorkPhoneNum"/>
        </out4:WorkPhoneNum>
      </xsl:if>
      <!-- a simple data mapping: "io:WorkPhoneExtension"(string10) to "out4:WorkPhoneExtension"(string10) -->
      <xsl:if test="io:WorkPhoneExtension">
        <out4:WorkPhoneExtension>
          <xsl:value-of select="io:WorkPhoneExtension"/>
        </out4:WorkPhoneExtension>
      </xsl:if>
      <!-- a structural mapping: "io:ListOfContact_Account"(ListOfContact_Account) to "out4:ListOfContact_Account"(ListOfContact_Account) -->
      <xsl:apply-templates select="io:ListOfContact_Account" mode="localListOfContact_AccountToListOfContact_Account_1776483226"/>
      <!-- a structural mapping: "io:ListOfContact_BusinessAddress"(ListOfContact_BusinessAddress) to "out4:ListOfContact_BusinessAddress"(ListOfContact_BusinessAddress) -->
      <xsl:apply-templates select="io:ListOfContact_BusinessAddress" mode="localListOfContact_BusinessAddressToListOfContact_BusinessAddress_1974700587"/>
      <!-- a structural mapping: "io:ListOfContact_AlternatePhone"(ListOfContact_AlternatePhone) to "out4:ListOfContact_AlternatePhone"(ListOfContact_AlternatePhone) -->
      <xsl:apply-templates select="io:ListOfContact_AlternatePhone" mode="localListOfContact_AlternatePhoneToListOfContact_AlternatePhone_244613081"/>
      <!-- a structural mapping: "io:ListOfAccount"(ListOfAccount) to "out4:ListOfAccount"(ListOfAccount) -->
      <xsl:apply-templates select="io:ListOfAccount" mode="localListOfAccountToListOfAccount_457318333"/>
    </out4:Contact>
  </xsl:template>

  <!-- This rule represents an element mapping: "io:ListOfContact_Account" to "out4:ListOfContact_Account".  -->
  <xsl:template match="io:ListOfContact_Account"  mode="localListOfContact_AccountToListOfContact_Account_1776483226">
    <out4:ListOfContact_Account>
      <!-- a for-each transform: "io:Contact_Account"(Contact_Account) to "out4:Contact_Account"(Contact_Account) -->
      <xsl:apply-templates select="io:Contact_Account" mode="localContact_AccountToContact_Account_1188375124"/>
    </out4:ListOfContact_Account>
  </xsl:template>

  <!-- This rule represents a for-each transform: "io:Contact_Account" to "out4:Contact_Account".  -->
  <xsl:template match="io:Contact_Account"  mode="localContact_AccountToContact_Account_1188375124">
    <out4:Contact_Account>
      <!-- a simple data mapping: "io:Account"(string100) to "out4:Account"(string100) -->
      <xsl:if test="io:Account">
        <out4:Account>
          <xsl:value-of select="io:Account"/>
        </out4:Account>
      </xsl:if>
      <!-- a simple data mapping: "io:AccountLocation"(string10) to "out4:AccountLocation"(string10) -->
      <xsl:if test="io:AccountLocation">
        <out4:AccountLocation>
          <xsl:value-of select="io:AccountLocation"/>
        </out4:AccountLocation>
      </xsl:if>
      <!-- a simple data mapping: "io:AccountStatus"(string30) to "out4:AccountStatus"(string30) -->
      <xsl:if test="io:AccountStatus">
        <out4:AccountStatus>
          <xsl:value-of select="io:AccountStatus"/>
        </out4:AccountStatus>
      </xsl:if>
    </out4:Contact_Account>
  </xsl:template>

  <!-- This rule represents an element mapping: "io:ListOfContact_BusinessAddress" to "out4:ListOfContact_BusinessAddress".  -->
  <xsl:template match="io:ListOfContact_BusinessAddress"  mode="localListOfContact_BusinessAddressToListOfContact_BusinessAddress_1974700587">
    <out4:ListOfContact_BusinessAddress>
      <!-- a for-each transform: "io:Contact_BusinessAddress"(Contact_BusinessAddress) to "out4:Contact_BusinessAddress"(Contact_BusinessAddress) -->
      <xsl:apply-templates select="io:Contact_BusinessAddress" mode="localContact_BusinessAddressToContact_BusinessAddress_712746639"/>
    </out4:ListOfContact_BusinessAddress>
  </xsl:template>

  <!-- This rule represents a for-each transform: "io:Contact_BusinessAddress" to "out4:Contact_BusinessAddress".  -->
  <xsl:template match="io:Contact_BusinessAddress"  mode="localContact_BusinessAddressToContact_BusinessAddress_712746639">
    <out4:Contact_BusinessAddress>
      <!-- a simple data mapping: "io:City"(string50) to "out4:City"(string50) -->
      <xsl:if test="io:City">
        <out4:City>
          <xsl:value-of select="io:City"/>
        </out4:City>
      </xsl:if>
      <!-- a simple data mapping: "io:Country"(string30) to "out4:Country"(string30) -->
      <xsl:if test="io:Country">
        <out4:Country>
          <xsl:value-of select="io:Country"/>
        </out4:Country>
      </xsl:if>
      <!-- a simple data mapping: "io:ZIPPostalCode"(string30) to "out4:ZIPPostalCode"(string30) -->
      <xsl:if test="io:ZIPPostalCode">
        <out4:ZIPPostalCode>
          <xsl:value-of select="io:ZIPPostalCode"/>
        </out4:ZIPPostalCode>
      </xsl:if>
      <!-- a simple data mapping: "io:StateProvince"(string10) to "out4:StateProvince"(string10) -->
      <xsl:if test="io:StateProvince">
        <out4:StateProvince>
          <xsl:value-of select="io:StateProvince"/>
        </out4:StateProvince>
      </xsl:if>
      <!-- a simple data mapping: "io:ClientAddress"(string200) to "out4:ClientAddress"(string200) -->
      <xsl:if test="io:ClientAddress">
        <out4:ClientAddress>
          <xsl:value-of select="io:ClientAddress"/>
        </out4:ClientAddress>
      </xsl:if>
      <!-- a simple data mapping: "io:AddressLine2"(string100) to "out4:AddressLine2"(string100) -->
      <xsl:if test="io:AddressLine2">
        <out4:AddressLine2>
          <xsl:value-of select="io:AddressLine2"/>
        </out4:AddressLine2>
      </xsl:if>
    </out4:Contact_BusinessAddress>
  </xsl:template>

  <!-- This rule represents an element mapping: "io:ListOfContact_AlternatePhone" to "out4:ListOfContact_AlternatePhone".  -->
  <xsl:template match="io:ListOfContact_AlternatePhone"  mode="localListOfContact_AlternatePhoneToListOfContact_AlternatePhone_244613081">
    <out4:ListOfContact_AlternatePhone>
      <!-- a for-each transform: "io:Contact_AlternatePhone"(Contact_AlternatePhone) to "out4:Contact_AlternatePhone"(Contact_AlternatePhone) -->
      <xsl:apply-templates select="io:Contact_AlternatePhone" mode="localContact_AlternatePhoneToContact_AlternatePhone_1295145733"/>
    </out4:ListOfContact_AlternatePhone>
  </xsl:template>

  <!-- This rule represents a for-each transform: "io:Contact_AlternatePhone" to "out4:Contact_AlternatePhone".  -->
  <xsl:template match="io:Contact_AlternatePhone"  mode="localContact_AlternatePhoneToContact_AlternatePhone_1295145733">
    <out4:Contact_AlternatePhone>
      <!-- a simple data mapping: "io:AlternatePhoneNum"(string) to "out4:AlternatePhoneNum"(string) -->
      <xsl:if test="io:AlternatePhoneNum">
        <out4:AlternatePhoneNum>
          <xsl:value-of select="io:AlternatePhoneNum"/>
        </out4:AlternatePhoneNum>
      </xsl:if>
    </out4:Contact_AlternatePhone>
  </xsl:template>

  <!-- This rule represents an element mapping: "io:ListOfAccount" to "out4:ListOfAccount".  -->
  <xsl:template match="io:ListOfAccount"  mode="localListOfAccountToListOfAccount_457318333">
    <out4:ListOfAccount>
      <!-- a for-each transform: "io:Account"(Account) to "out4:Account"(Account) -->
      <xsl:apply-templates select="io:Account" mode="localAccountToAccount_1042315751"/>
    </out4:ListOfAccount>
  </xsl:template>

  <!-- This rule represents a for-each transform: "io:Account" to "out4:Account".  -->
  <xsl:template match="io:Account"  mode="localAccountToAccount_1042315751">
    <out4:Account>
      <!-- a simple data mapping: "io:StatusofAffiliation"(string30) to "out4:StatusofAffiliation"(string30) -->
      <xsl:if test="io:StatusofAffiliation">
        <out4:StatusofAffiliation>
          <xsl:value-of select="io:StatusofAffiliation"/>
        </out4:StatusofAffiliation>
      </xsl:if>
      <!-- a simple data mapping: "io:JobTitle"(string50) to "out4:JobTitle"(string50) -->
      <xsl:if test="io:JobTitle">
        <out4:JobTitle>
          <xsl:value-of select="io:JobTitle"/>
        </out4:JobTitle>
      </xsl:if>
      <!-- a simple data mapping: "io:Role"(string30) to "out4:Role"(string30) -->
      <xsl:if test="io:Role">
        <out4:Role>
          <xsl:value-of select="io:Role"/>
        </out4:Role>
      </xsl:if>
      <!-- a simple data mapping: "io:Mnemonic"(string10) to "out4:Mnemonic"(string10) -->
      <xsl:if test="io:Mnemonic">
        <out4:Mnemonic>
          <xsl:value-of select="io:Mnemonic"/>
        </out4:Mnemonic>
      </xsl:if>
    </out4:Account>
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
