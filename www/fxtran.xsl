<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
 xmlns:f="http://fxtran.net/#syntax"
 xmlns:html="http://www.w3.org/1999/xhtml">

  <xsl:output method="xml"/>

  <xsl:template match="*">
    <xsl:copy-of select="."/>
  </xsl:template>

  <xsl:template match="/f:object">


<html:link rel="stylesheet" href="fxtran.css"/>

<html:script src="fxtran.js"/>

<html:body onload="_onload()">

    <xsl:apply-templates/>

</html:body>

  </xsl:template>

</xsl:stylesheet>

