<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
	<xsl:template name="anchor">
		<xsl:param name="node" select="." />
		<xsl:param name="conditional" select="1" />
		<xsl:variable name="id">
			<xsl:call-template name="object.id">
				<xsl:with-param name="object" select="$node" />
			</xsl:call-template>
		</xsl:variable>
		<xsl:if test="$conditional = 0 or $node/@id or $node/@xml:id">
			<a id="{$id}" />
		</xsl:if>
	</xsl:template>
</xsl:stylesheet>