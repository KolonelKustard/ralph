<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xslthl="http://xslthl.sf.net" exclude-result-prefixes="xslthl"
	version="1.0">

	<xsl:import href="../../docbook/xhtml/docbook.xsl" />
	
	<xsl:output method="html" encoding="UTF-8" indent="yes" version="5.0" doctype-public="" doctype-system="" omit-xml-declaration="yes" />
	
	<xsl:param name="toc.list.type">ul</xsl:param>

	<!-- <xsl:template name="user.preroot">
		<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
	</xsl:template> -->

	<xsl:template name="user.head.content">
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css" />
		<link rel="stylesheet" type="text/css" href="../styles.css" />
		<script type="text/javascript" src="http://code.jquery.com/jquery-2.0.3.min.js" />
		<script type="text/javascript" src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js" />
	</xsl:template>
	
	<xsl:template name="body.attributes">
		<xsl:attribute name="data-spy">scroll</xsl:attribute>
		<xsl:attribute name="data-target">.portfolio-sidebar</xsl:attribute>
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
				</div>
			</div>
		</div>
	</xsl:template>

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
								<xsl:call-template name="division.toc">
									<xsl:with-param name="toc.title.p" select="contains($toc.params, 'title')" />
								</xsl:call-template>
							</xsl:with-param>
						</xsl:call-template>
					</div>
				</div>
				<div class="col-md-9" role="main">
					<div id="mainContent">
						<xsl:apply-templates />
					</div>
				</div>
			</div>
		</div>
	</xsl:template>

<xsl:template name="toc.line">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="depth" select="1"/>
  <xsl:param name="depth.from.context" select="8"/>

  <!-- * if $autotoc.label.in.hyperlink is zero, then output the label -->
  <!-- * before the hyperlinked title (as the DSSSL stylesheet does) -->
  <xsl:if test="$autotoc.label.in.hyperlink = 0">
    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="label.markup"/>
    </xsl:variable>
    <xsl:copy-of select="$label"/>
    <xsl:if test="$label != ''">
      <xsl:value-of select="$autotoc.label.separator"/>
    </xsl:if>
  </xsl:if>

  <a>
    <xsl:attribute name="href">
      <xsl:call-template name="href.target">
        <xsl:with-param name="context" select="$toc-context"/>
        <xsl:with-param name="toc-context" select="$toc-context"/>
      </xsl:call-template>
    </xsl:attribute>
    
  <!-- * if $autotoc.label.in.hyperlink is non-zero, then output the label -->
  <!-- * as part of the hyperlinked title -->
  <xsl:if test="not($autotoc.label.in.hyperlink = 0)">
    <xsl:variable name="label">
      <xsl:apply-templates select="." mode="label.markup"/>
    </xsl:variable>
    <xsl:copy-of select="$label"/>
    <xsl:if test="$label != ''">
      <xsl:value-of select="$autotoc.label.separator"/>
    </xsl:if>
  </xsl:if>

    <xsl:apply-templates select="." mode="titleabbrev.markup"/>
  </a>
</xsl:template>

<xsl:template name="make.toc">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="toc.title.p" select="true()"/>
  <xsl:param name="nodes" select="/NOT-AN-ELEMENT"/>

  <xsl:variable name="nodes.plus" select="$nodes | qandaset"/>

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
            <strong xmlns:xslo="http://www.w3.org/1999/XSL/Transform">
              <xsl:call-template name="gentext">
                <xsl:with-param name="key">TableofContents</xsl:with-param>
              </xsl:call-template>
            </strong>
          </p>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$manual.toc != ''">
      <xsl:variable name="id">
        <xsl:call-template name="object.id"/>
      </xsl:variable>
      <xsl:variable name="toc" select="document($manual.toc, .)"/>
      <xsl:variable name="tocentry" select="$toc//tocentry[@linkend=$id]"/>
      <xsl:if test="$tocentry and $tocentry/*">
        <div class="toc">
          <xsl:copy-of select="$toc.title"/>
          <xsl:element name="{$toc.list.type}" namespace="http://www.w3.org/1999/xhtml">
            <xsl:call-template name="manual-toc">
              <xsl:with-param name="tocentry" select="$tocentry/*[1]"/>
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
              <xsl:copy-of select="$toc.title"/>
              <xsl:element name="{$toc.list.type}" namespace="http://www.w3.org/1999/xhtml">
                <xsl:apply-templates select="$nodes.plus" mode="toc">
                  <xsl:with-param name="toc-context" select="$toc-context"/>
                </xsl:apply-templates>
              </xsl:element>
            </div>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:if test="$nodes">
              <xsl:element name="{$toc.list.type}">
                <xsl:attribute name="class">nav</xsl:attribute>
                <xsl:apply-templates select="$nodes" mode="toc">
                  <xsl:with-param name="toc-context" select="$toc-context"/>
                </xsl:apply-templates>
              </xsl:element>
          </xsl:if>
        </xsl:otherwise>
      </xsl:choose>

    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template name="subtoc">
  <xsl:param name="toc-context" select="."/>
  <xsl:param name="nodes" select="NOT-AN-ELEMENT"/>

  <xsl:variable name="nodes.plus" select="$nodes | qandaset"/>

  <xsl:variable name="subtoc">
    <xsl:element name="{$toc.list.type}">
      <xsl:attribute name="class">nav</xsl:attribute>
      <xsl:choose>
        <xsl:when test="$qanda.in.toc != 0">
          <xsl:apply-templates mode="toc" select="$nodes.plus">
            <xsl:with-param name="toc-context" select="$toc-context"/>
          </xsl:apply-templates>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates mode="toc" select="$nodes">
            <xsl:with-param name="toc-context" select="$toc-context"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:element>
  </xsl:variable>

  <xsl:variable name="depth">
    <xsl:choose>
      <xsl:when test="local-name(.) = 'section'">
        <xsl:value-of select="count(ancestor::section) + 1"/>
      </xsl:when>
      <xsl:when test="local-name(.) = 'sect1'">1</xsl:when>
      <xsl:when test="local-name(.) = 'sect2'">2</xsl:when>
      <xsl:when test="local-name(.) = 'sect3'">3</xsl:when>
      <xsl:when test="local-name(.) = 'sect4'">4</xsl:when>
      <xsl:when test="local-name(.) = 'sect5'">5</xsl:when>
      <xsl:when test="local-name(.) = 'refsect1'">1</xsl:when>
      <xsl:when test="local-name(.) = 'refsect2'">2</xsl:when>
      <xsl:when test="local-name(.) = 'refsect3'">3</xsl:when>
      <xsl:when test="local-name(.) = 'simplesect'">
        <!-- sigh... -->
        <xsl:choose>
          <xsl:when test="local-name(..) = 'section'">
            <xsl:value-of select="count(ancestor::section)"/>
          </xsl:when>
          <xsl:when test="local-name(..) = 'sect1'">2</xsl:when>
          <xsl:when test="local-name(..) = 'sect2'">3</xsl:when>
          <xsl:when test="local-name(..) = 'sect3'">4</xsl:when>
          <xsl:when test="local-name(..) = 'sect4'">5</xsl:when>
          <xsl:when test="local-name(..) = 'sect5'">6</xsl:when>
          <xsl:when test="local-name(..) = 'refsect1'">2</xsl:when>
          <xsl:when test="local-name(..) = 'refsect2'">3</xsl:when>
          <xsl:when test="local-name(..) = 'refsect3'">4</xsl:when>
          <xsl:otherwise>1</xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:otherwise>0</xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:variable name="depth.from.context" select="count(ancestor::*)-count($toc-context/ancestor::*)"/>

  <xsl:variable name="subtoc.list">
    <xsl:choose>
      <xsl:when test="$toc.dd.type = ''">
        <xsl:copy-of select="$subtoc"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:element name="{$toc.dd.type}">
          <xsl:copy-of select="$subtoc"/>
        </xsl:element>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:element name="{$toc.listitem.type}">
    <xsl:call-template name="toc.line">
      <xsl:with-param name="toc-context" select="$toc-context"/>
    </xsl:call-template>
    <xsl:if test="$toc.listitem.type = 'li'                   and $toc.section.depth &gt; $depth and                    ( ($qanda.in.toc = 0 and count($nodes)&gt;0) or                     ($qanda.in.toc != 0 and count($nodes.plus)&gt;0) )                   and $toc.max.depth &gt; $depth.from.context">
      <xsl:copy-of select="$subtoc.list"/>
    </xsl:if>
  </xsl:element>
  <xsl:if test="$toc.listitem.type != 'li'                 and $toc.section.depth &gt; $depth and                  ( ($qanda.in.toc = 0 and count($nodes)&gt;0) or                   ($qanda.in.toc != 0 and count($nodes.plus)&gt;0) )                 and $toc.max.depth &gt; $depth.from.context">
    <xsl:copy-of select="$subtoc.list"/>
  </xsl:if>
</xsl:template>
</xsl:stylesheet>
