<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
	<xsl:template match="book">
		<xsl:call-template name="id.warning" />

		<xsl:apply-templates select="." mode="common.html.attributes" />
		<xsl:if test="$generate.id.attributes != 0">
			<xsl:attribute name="id">
        		<xsl:call-template name="object.id" />
			</xsl:attribute>
		</xsl:if>

		<xsl:call-template name="book.titlepage" />

		<xsl:apply-templates select="dedication" mode="dedication" />
		<xsl:apply-templates select="acknowledgements" mode="acknowledgements" />

		<xsl:variable name="toc.params">
			<xsl:call-template name="find.path.params">
				<xsl:with-param name="table" select="normalize-space($generate.toc)" />
			</xsl:call-template>
		</xsl:variable>

		<div class="container" data-offset-top="200">
			<div class="row">
				<div class="col-md-3">
					<div class="portfolio-sidebar hidden-print" role="complementary" data-spy="affix">
						<xsl:call-template name="make.lots">
							<xsl:with-param name="toc.params" select="$toc.params" />
							<xsl:with-param name="toc">
								<xsl:call-template name="division.toc.ralph">
									<xsl:with-param name="toc.title.p" select="contains($toc.params, 'title')" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
				<div class="col-md-9" role="main">
					<xsl:apply-templates />
				</div>
			</div>
		</div>
	</xsl:template>
</xsl:stylesheet>