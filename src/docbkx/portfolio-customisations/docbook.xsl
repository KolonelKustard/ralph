<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
	<xsl:import href="urn:docbkx:stylesheet" />
	
	<xsl:include href="autotoc.xsl" />
	<xsl:include href="html.xsl" />
	<xsl:include href="division.xsl" />
	<xsl:include href="titlepage.templates.xsl" />
	
	<xsl:template name="user.preroot">
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
	</xsl:template>

	<xsl:template name="user.head.content">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="./styles.min.css" />
		<link rel="shortcut icon" href="../images/favicon.ico" />
		<script type="text/javascript" src="http://code.jquery.com/jquery-2.0.3.min.js" />
		<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js" />
	</xsl:template>
	
	<xsl:template name="body.attributes">
		<xsl:attribute name="data-spy">scroll</xsl:attribute>
		<xsl:attribute name="data-target">.portfolio-sidebar</xsl:attribute>
	</xsl:template>
</xsl:stylesheet>
