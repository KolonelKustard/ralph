<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'
		xmlns:d="http://docbook.org/ns/docbook">
	<xsl:template name="make.toc.ralph">
		<xsl:param name="toc-context" select="." />
		<xsl:param name="toc.title.p" select="true()" />
		<xsl:param name="nodes" select="/NOT-AN-ELEMENT" />

		<ul class="nav">
			<xsl:apply-templates select="$nodes" mode="toc.ralph">
				<xsl:with-param name="toc-context" select="$toc-context" />
			</xsl:apply-templates>
		</ul>
	</xsl:template>

	<xsl:template name="division.toc.ralph">
		<xsl:param name="toc-context" select="." />
		<xsl:param name="toc.title.p" select="true()" />

		<xsl:call-template name="make.toc.ralph">
			<xsl:with-param name="toc-context" select="$toc-context" />
			<xsl:with-param name="toc.title.p" select="$toc.title.p" />
			<xsl:with-param name="nodes" select="d:chapter" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="subtoc.ralph">
		<xsl:param name="toc-context" select="." />
		<xsl:param name="nodes" select="NOT-AN-ELEMENT" />

		<li>
			<xsl:call-template name="toc.line.ralph">
				<xsl:with-param name="toc-context" select="$toc-context" />
			</xsl:call-template>
			<xsl:if test="count($nodes) &gt; 0">
				<ul class="nav">
					<xsl:apply-templates mode="toc.ralph" select="$nodes">
						<xsl:with-param name="toc-context" select="$toc-context" />
					</xsl:apply-templates>
				</ul>
			</xsl:if>
		</li>
	</xsl:template>

	<xsl:template name="toc.line.ralph">
		<xsl:param name="toc-context" select="." />
		<xsl:param name="depth" select="1" />
		<xsl:param name="depth.from.context" select="8" />

		<a>
			<xsl:attribute name="href">
				<xsl:call-template name="href.target">
					<xsl:with-param name="context" select="$toc-context" />
					<xsl:with-param name="toc-context" select="$toc-context" />
				</xsl:call-template>
			</xsl:attribute>

			<xsl:apply-templates select="." mode="titleabbrev.markup" />
		</a>
	</xsl:template>

	<xsl:template match="d:book" mode="toc.ralph">
		<xsl:param name="toc-context" select="." />

		<xsl:call-template name="subtoc.ralph">
			<xsl:with-param name="toc-context" select="$toc-context" />
			<xsl:with-param name="nodes" select="chapter" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="d:chapter" mode="toc.ralph">
		<xsl:param name="toc-context" select="." />

		<xsl:call-template name="subtoc.ralph">
			<xsl:with-param name="toc-context" select="$toc-context" />
			<xsl:with-param name="nodes" select="d:section" />
		</xsl:call-template>
	</xsl:template>

	<xsl:template match="d:section" mode="toc.ralph">
		<xsl:param name="toc-context" select="." />

		<xsl:call-template name="subtoc.ralph">
			<xsl:with-param name="toc-context" select="$toc-context" />
			<xsl:with-param name="nodes" select="d:section" />
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
