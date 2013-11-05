<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xslthl="http://xslthl.sf.net" exclude-result-prefixes="xslthl"
	version="1.0">

	<xsl:import href="urn:docbkx:stylesheet" />
	
	<xsl:param name="toc.list.type">ul</xsl:param>
	
	<xsl:template name="user.preroot">
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
	</xsl:template>

	<xsl:template name="user.head.content">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css" />
		<script type="text/javascript" src="http://code.jquery.com/jquery-2.0.3.min.js" />
		<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js" />
	</xsl:template>

<xsl:template name="make.lots">
  <xsl:param name="toc.params" select="''"/>
  <xsl:param name="toc"/>

  <h1>make.lots</h1>
</xsl:template>

	<xsl:template name="book.titlepage">
		<div class="navbar navbar-fixed-top navbar-inverse" role="navigation">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="../">
						Ralph Jones
					</a>
				</div>
				<div class="collapse navbar-collapse">
					<ul class="nav navbar-nav">
						<li>
							<a href="../">Home</a>
						</li>
						<li class="active">
							<a href="portfolio.html">Portfolio</a>
						</li>
					</ul>
				</div><!-- /.nav-collapse -->
			</div><!-- /.container -->
		</div><!-- /.navbar -->
	</xsl:template>
	
	<xsl:template name="make.toc">
		<xsl:param name="toc-context" select="." />
		<xsl:param name="toc.title.p" select="true()" />
		<xsl:param name="nodes" select="/NOT-AN-ELEMENT" />
	
		<xsl:variable name="nodes.plus" select="$nodes | qandaset" />
	
		<xsl:variable name="toc.title">
			<xsl:if test="$toc.title.p">
				<xsl:choose>
					<xsl:when test="$make.clean.html != 0">
						<div class="toc-title">
							<xsl:call-template name="gentext">
								<xsl:with-param name="key">TableofContents</xsl:with-param>
							</xsl:call-template>
						</div>
					</xsl:when>
					<xsl:otherwise>
						<p>
							<b>
								<xsl:call-template name="gentext">
									<xsl:with-param name="key">TableofContents</xsl:with-param>
								</xsl:call-template>
							</b>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
		</xsl:variable>
	
		<xsl:choose>
			<xsl:when test="$manual.toc != ''">
				<xsl:variable name="id">
					<xsl:call-template name="object.id" />
				</xsl:variable>
				<xsl:variable name="toc" select="document($manual.toc, .)" />
				<xsl:variable name="tocentry" select="$toc//tocentry[@linkend=$id]" />
				<xsl:if test="$tocentry and $tocentry/*">
					<div class="toc">
						<xsl:copy-of select="$toc.title" />
						<xsl:element name="{$toc.list.type}">
							<xsl:call-template name="manual-toc">
								<xsl:with-param name="tocentry" select="$tocentry/*[1]" />
							</xsl:call-template>
						</xsl:element>
					</div>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$qanda.in.toc != 0">
						<xsl:if test="$nodes.plus">
							<div class="toc">
								<xsl:copy-of select="$toc.title" />
								<xsl:element name="{$toc.list.type}">
									<xsl:apply-templates select="$nodes.plus"
										mode="toc">
										<xsl:with-param name="toc-context" select="$toc-context" />
									</xsl:apply-templates>
								</xsl:element>
							</div>
						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:if test="$nodes">
							<div class="bs-sidebar hidden-print affix-top" role="complementary">
								<xsl:element name="{$toc.list.type}">
									<xsl:attribute name="class">nav bs-sidenav</xsl:attribute>
									<xsl:apply-templates select="$nodes" mode="toc">
										<xsl:with-param name="toc-context" select="$toc-context" />
									</xsl:apply-templates>
								</xsl:element>
							</div>
						</xsl:if>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="article"><h1>article</h1></xsl:template>
<xsl:template match="set"><h1>set</h1></xsl:template>
<xsl:template match="book"><h1>book</h1></xsl:template>
</xsl:stylesheet>
