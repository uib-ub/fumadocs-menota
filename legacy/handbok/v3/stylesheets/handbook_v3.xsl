<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE xsl:stylesheet [ 
<!--<!ENTITY home_sti "http://www.menota.org/" >
<!ENTITY home "http://www.menota.org/" >
<!ENTITY grafikk_sti "http://www.menota.org/grafikk/" >
<!ENTITY aksis_sti "http://www.aksis.uib.no" >-->
<!ENTITY nbsp " " >

]>
    
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output method="xml" omit-xml-declaration="yes" indent="no"/>

    <!--* Output and whitespace details *-->
    <xsl:param name="currentPage"/>
    <xsl:param name="QPI"/>
    <xsl:param name="CONTENT_TYPE"/>
    <xsl:param name="DOCUMENT_FILENAME"/>
    <xsl:param name="DOCUMENT_NAME"/>
    <xsl:param name="DOCUMENT_PATH"/>
    <xsl:param name="DOCUMENT_ROOT"/>
    <xsl:param name="DOCUMENT_URL"/>
    <xsl:param name="HOME_PATH"/>
    <xsl:param name="HTTP_ACCEPT_CHARSET"/>
    <xsl:param name="HTTP_ACCEPT_ENCODING"/>
    <xsl:param name="HTTP_ACCEPT_LANGUAGE"/>
    <xsl:param name="HTTP_COOKIE"/>
    <xsl:param name="HTTP_REFERER"/>
    <xsl:param name="HTTP_USER_AGENT"/>
    <xsl:param name="LANG"/>
    <xsl:param name="NOW"/>
    <xsl:param name="NOW_UTC"/>
    <xsl:param name="PAGEMENU_URL"/>
    <xsl:param name="PATH_INFO"/>
    <xsl:param name="PROJECT_DOCUMENT_NAME"/>
    <xsl:param name="REMOTE_ADDR"/>
    <xsl:param name="REMOTE_USER"/>
    <xsl:param name="REQUEST_METHOD"/>
    <xsl:param name="REQUEST_URI"/>
    <xsl:param name="SERVER_NAME"/>
    <xsl:param name="SERVER_PORT"/>
    <xsl:param name="SERVER_SOFTWARE"/>
    <xsl:param name="STYLESHEET_FILENAME"/>
    <xsl:param name="STYLESHEET_NAME"/>
    <xsl:param name="TODAY"/>
    <xsl:param name="TODAY_UTC"/>
    <xsl:param name="param.id"/>
    <xsl:param name="param.name"/>

    <xsl:variable name="handbook-version-gif">
        <xsl:value-of select="'Handbook.gif'"/>
    </xsl:variable>

    <xsl:variable name="graphics-prefix">
        <xsl:choose>
            <!-- Håndbok 1 and 2 not treated by this stylesheet -->
            <!--
			<xsl:when test="contains($currentPage,'HB1')">
				<xsl:value-of select="'handbok_1/'"/>
			</xsl:when>
			
			<xsl:when test="contains($currentPage,'HB2')">
				<xsl:value-of select="'handbok_2-0/'"/>
			</xsl:when>
			-->
            <xsl:when test="contains($currentPage, 'HB3')">
                <xsl:value-of select="'handbok_3/'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'graphics/'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:variable name="list-of-contents">
        <xsl:choose>
            <xsl:when test="contains($currentPage, 'HB3')">
                <xsl:value-of select="'HB3_index.xml'"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="'HB3_index.xml'"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:variable>

    <xsl:template match="/">
        <!-- html5! -->
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <html>
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <link href="menota_handbook_3.css" rel="stylesheet" type="text/css" media="all"/>
            </head>
            <body>
                <!-- mb 2017.11.16 The html-skeleton -->
                <div id="page">
                    <div id="main-wrapper">
                        <div id="header-wrapper">
                            <header>
                                <xsl:call-template name="do_header"/>
                            </header>
                            <nav>
                                <xsl:call-template name="do_menu"/>
                            </nav>
                        </div>
                        <div id="content-wrapper">
                            <section id="sidebar" role="navigation">
                                <xsl:choose>
                                    <!-- 2018.02.14 mb: No toc on index-page. -->
                                    <xsl:when test="contains($currentPage, 'index')"/>
                                    <xsl:otherwise>
                                        <xsl:call-template name="do_toc"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </section>
                            <main id="content">
                                <xsl:choose>
                                    <xsl:when test="contains($QPI, 'del=nyheter')">
                                        <xsl:apply-templates
                                            select="//tei:list[attribute::type = 'nyheter']"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:apply-templates/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </main>
                        </div>
                    </div>
                    <footer>
                        <xsl:call-template name="do_signatur"/>
                    </footer>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div">
        <xsl:choose>
            <xsl:when test="attribute::type = 'display'">
                <xsl:element name="div">
                    <xsl:call-template name="do_tag">
                        <xsl:with-param name="addclass">display</xsl:with-param>
                    </xsl:call-template>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:teiHeader">
        <!--<xsl:apply-templates/>-->
    </xsl:template>
    <xsl:template match="tei:front">
        <div class="front">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:body">
        <article>
            <xsl:apply-templates/>
        </article>
    </xsl:template>

    <xsl:template match="tei:back">
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:note">
        <xsl:choose>
            <xsl:when test="attribute::type = 'privat'">
                <!-- Kortslutter -->
            </xsl:when>
            <xsl:otherwise> [<xsl:apply-templates/>] </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="tei:p">
        <!-- mb 2017-11-17: p-tags -->
        <xsl:choose>
            <!-- mb 2017-11-17: <p>'s with the attr @rend="sample" should be treated as blockquotes (no p, only <blockquote>) -->
            <xsl:when test="attribute::rend = 'sample'">
                <xsl:element name="blockquote">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="p">
                    <xsl:call-template name="do_tag"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:title">
        <!-- mb 2018-08-22: This was converted to <i> in earlier versions of the style sheet. <cite> is the html5 way of doing this -->
        <xsl:element name="cite">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:emph">
        <xsl:element name="em">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:hi">
        <xsl:choose>
            <!-- First some special translations of the hi-element -->
            <xsl:when test="@rend = 'bold'">
                <b>
                    <xsl:apply-templates/>
                </b>
            </xsl:when>
            <xsl:when test="@rend = 'italic'">
                <i>
                    <xsl:apply-templates/>
                </i>
            </xsl:when>
            <xsl:when test="@rend = 'italics'">
                <i>
                    <xsl:apply-templates/>
                </i>
            </xsl:when>
            <xsl:when test="@rend = 'code'">
                <code>
                    <xsl:apply-templates/>
                </code>
            </xsl:when>
            <xsl:when test="@rend = 'codepoint'">
                <xsl:element name="span">
                    <xsl:attribute name="class">codepoint</xsl:attribute>
                    <xsl:element name="code">
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <!-- Default: put it into a <span> and pass @rend to a class in html -->
                <xsl:element name="span">
                    <xsl:call-template name="do_tag"/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>


    <xsl:template match="tei:head">
        <!-- mb 2017-11-17: Generic markup for head elements (h1-h4 are styled below) -->
        <xsl:element name="div">
            <xsl:call-template name="do_tag">
                <xsl:with-param name="addclass">head</xsl:with-param>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>
    <!-- mb 2017-11-17:
This takes care of headings, i.e. everything between xml's <head>-tags. <h1>-<h4> are assigned depending on the node position of the head element
Output: <h2 id="NAME in xml name-attribute (if defined)">Header</h2>
[Output in earlier version: <h3><a name="sec7.1"/><a name="d0e250">Header</a></h3>, which is not valid html5 (name-attribute=deprecated); <a />-syntax probably invalid (in any case, rendered strangely in Firefox)]
    -->
    <xsl:template match="tei:body/tei:head">
        <xsl:element name="h1">
            <xsl:call-template name="do_tag">
                <xsl:with-param name="force_id">true</xsl:with-param>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:body/tei:div/tei:head">
        <xsl:element name="h2">
            <xsl:call-template name="do_tag">
                <xsl:with-param name="force_id">true</xsl:with-param>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:body/tei:div/tei:div/tei:head">
        <xsl:element name="h3">
            <xsl:call-template name="do_tag">
                <xsl:with-param name="force_id">true</xsl:with-param>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:body/tei:div/tei:div/tei:div/tei:head">
        <xsl:element name="h4">
            <xsl:call-template name="do_tag">
                <xsl:with-param name="force_id">true</xsl:with-param>
            </xsl:call-template>
        </xsl:element>
    </xsl:template>

    <!-- mb 2017-11-16: List styling -->
    <xsl:template match="tei:item">
        <xsl:element name="li">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:list">
        <xsl:choose>
            <!-- mb 2017-11-16: make ordered list (<ol>) if @rend=numbered -->
            <xsl:when test="@rend = 'numbered'">
                <xsl:element name="ol">
                    <xsl:apply-templates select="tei:item"/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <!-- mb 2017-11-16: make unordered list otherwise, pass @rend and @type to @class in html -->
                <xsl:element name="ul">
                    <xsl:call-template name="do_tag">
                        <xsl:with-param name="addclass">
                            <xsl:value-of select="attribute::type"/>
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Table styling -->
    <xsl:template match="tei:table">
        <!-- mb 2017-11-17: Don't pass it through do_tag because of the @rend -> @class translations below -->
        <xsl:element name="table">
            <xsl:if test="attribute::xml:id">
                <xsl:attribute name="id">
                    <xsl:value-of select="attribute::xml:id"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="attribute::rend">
                <xsl:choose>
                    <xsl:when test="(@rend = 'glyph2') or (@rend = 'glyph4') or (@rend = 'glyph5')">
                        <xsl:attribute name="class">glyphtable</xsl:attribute>
                    </xsl:when>
                    <xsl:when test="@rend = 'abbr'">
                        <xsl:attribute name="class">glyphtable</xsl:attribute>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:attribute name="class">
                            <xsl:value-of select="attribute::rend"/>
                        </xsl:attribute>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:if>
            <!-- mb 2017-11-17: Make table html5-compliant -->
            <!-- 1: mb 2017-11-17: add a colgroup element if the cells of the first row have @rend set -->
            <xsl:element name="colgroup">
                <xsl:for-each select="child::*[1]">
                    <xsl:for-each select="child::*">
                        <xsl:if test="attribute::rend">
                            <xsl:element name="col">
                                <xsl:attribute name="class">
                                    <xsl:value-of select="attribute::rend"/>
                                </xsl:attribute>
                            </xsl:element>
                        </xsl:if>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:element>

            <!-- 2: mb 2017-11-17: make a <thead> element if there are rows with @rend=label -->
            <xsl:if test="child::tei:row[attribute::role = 'label']">
                <xsl:element name="thead">
                    <xsl:for-each select="child::tei:row[attribute::role = 'label']">
                        <xsl:element name="tr">
                            <xsl:call-template name="do_tag"/>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>

            <!-- 3: mb 2017-11-17: make <tbody>-element for the table bodies -->
            <xsl:choose>
                <xsl:when test="attribute::rend = 'xml-elements'">
                    <!-- 3.1: mb 2017-11-30: check whether the table has @rend="xml-elements" and prepare table for that -->
                    <xsl:for-each select="child::tei:row[not(attribute::role = 'label')]">
                        <!-- Take care of non-header rows (without @role="label") -->
                        <!--<xsl:if test="tei:cell[count(preceding-sibling::child) &lt; 1]/tei:tag">-->
                        <xsl:if test="tei:cell[1]/tei:gi">
                            <!-- The first cell of this row contains a <gi>-element. Use this as flag to wrap following rows into <tbody>, until another first cell with <gi> appears -->
                            <xsl:choose>
                                <xsl:when test="count(preceding-sibling::child) &lt; 2">
                                    <!-- It's the first row, make an opening <tbody> -->
                                    <xsl:text disable-output-escaping="yes">&lt;tbody&gt;</xsl:text>
                                </xsl:when>
                                <xsl:when test="count(preceding-sibling::child) &lt; 3">
                                    <!-- It's the second row -->
                                    <xsl:choose>
                                        <xsl:when
                                            test="preceding-sibling::tei:row[attribute::role = 'label']">
                                            <!-- This second row has a preceding row with @role="label", i.e. it's the very first row after the header row -->
                                            <xsl:text disable-output-escaping="yes">&lt;tbody&gt;</xsl:text>
                                            <!-- Make an opening <tbody> -->
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <!-- All other rows should close the <tbody> first -->
                                            <xsl:text disable-output-escaping="yes">&lt;/tbody&gt;&lt;tbody&gt;</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:when>
                                <xsl:otherwise>
                                    <!-- All other rows should close the <tbody> first -->
                                    <xsl:text disable-output-escaping="yes">&lt;/tbody&gt;&lt;tbody&gt;</xsl:text>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:if>
                        <xsl:element name="tr">
                            <!-- Create the table rows -->
                            <xsl:call-template name="do_tag"/>
                        </xsl:element>
                    </xsl:for-each>
                    <xsl:text disable-output-escaping="yes">&lt;/tbody&gt;</xsl:text>
                    <!-- The last closing </tbody> -->

                </xsl:when>
                <xsl:otherwise>
                    <!-- All other tables -->
                    <xsl:element name="tbody">
                        <xsl:for-each select="child::tei:row[not(attribute::role = 'label')]">
                            <xsl:element name="tr">
                                <xsl:call-template name="do_tag"/>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <!-- mb 2017-11-17: Template for table cells -->
    <xsl:template match="tei:cell">
        <xsl:choose>
            <!-- mb 2017-11-17: if the parent-<row> has @role='label', make th-tags -->
            <xsl:when test="(ancestor::tei:row[attribute::role = 'label'])">
                <xsl:element name="th">
                    <!-- mb 2017-11-17: Take care of colspans -->
                    <xsl:if test="attribute::cols > 1">
                        <xsl:attribute name="colspan">
                            <xsl:value-of select="attribute::cols"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="attribute::rows > 1">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="attribute::rows"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="attribute::rend">
                        <xsl:attribute name="class">
                            <xsl:value-of select="attribute::rend"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <!-- mb 2017-11-17:not a header row, make ordinary td-tags -->
                <xsl:element name="td">
                    <!-- take care of colspans -->
                    <xsl:if test="attribute::cols > 1">
                        <xsl:attribute name="colspan">
                            <xsl:value-of select="attribute::cols"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="attribute::rows > 1">
                        <xsl:attribute name="rowspan">
                            <xsl:value-of select="attribute::rows"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:if test="attribute::rend">
                        <xsl:attribute name="class">
                            <xsl:value-of select="attribute::rend"/>
                        </xsl:attribute>
                    </xsl:if>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <!-- mb 2017-11-17: Links (old code) -->
    <xsl:template match="tei:ref">
        <xsl:element name="a">
            <xsl:if test="attribute::rend">
                <xsl:attribute name="class">
                    <xsl:value-of select="attribute::rend"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:attribute name="href">
                <xsl:choose>
                    <xsl:when
                        test="
                            starts-with(@target, 'samples/') or
                            starts-with(@target, 'samplefiles/') or
                            (contains(@target, '.xsl') and contains($currentPage, 'HB3'))">
                        <xsl:value-of select="concat($graphics-prefix, @target)"/>
                    </xsl:when>
                    <xsl:when test="@target">
                        <xsl:value-of select="@target"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="."/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- mb 2017-11-17: convert <graphic> to <img> -->
    <xsl:template match="tei:graphic">
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:choose>
                    <xsl:when test="@url">
                        <xsl:value-of select="concat($graphics-prefix, @url)"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat($graphics-prefix, @value)"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:call-template name="do_tag"/>
        </xsl:element>
    </xsl:template>

    <!-- mb 2017-11-17: use the tei:figure element as a flag for a wrapping <figure>-element around image and caption. -->
    <xsl:template match="tei:figure">
        <xsl:element name="figure">
            <xsl:choose>
                <xsl:when test="child::tei:figDesc">
                    <!-- There is a figDesc-element, i.e. caption -> do nothing -->
                </xsl:when>
                <xsl:otherwise>
                    <!-- There is no figDesc-element, i.e. no caption. Mark this with a html class for appropriate styling in css -->
                    <xsl:attribute name="class">nocaption</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:call-template name="do_tag"/>
        </xsl:element>
    </xsl:template>
    <!-- mb 2017-11-17: The image caption -->
    <xsl:template match="tei:figDesc">
        <xsl:element name="figcaption">
            <xsl:if test="attribute::n">
                <xsl:element name="span">
                    <xsl:attribute name="class">imagelabel</xsl:attribute>
                    <xsl:text>Fig. </xsl:text>
                    <xsl:element name="span">
                        <xsl:attribute name="class">imageid</xsl:attribute>
                        <xsl:value-of select="attribute::n"/>
                    </xsl:element>
                    <xsl:text>. </xsl:text>
                </xsl:element>
            </xsl:if>
            <xsl:call-template name="do_tag"/>
            <!-- <xsl:apply-templates/> -->
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:lb">
        <xsl:element name="br"/>
    </xsl:template>
    <xsl:template match="tei:lg">
        <xsl:element name="ul">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:l">
        <xsl:element name="li">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei_samples:eg | tei_samples:code | tei_samples:egXML | tei:eg">
        <!-- mb 2017-11-17: The html5-way to markup code in a block (https://stackoverflow.com/questions/4611591/code-vs-pre-vs-samp-for-inline-and-block-code-snippet) -->
        <xsl:choose>
            <xsl:when test="attribute::rend = 'inline'">
                <xsl:element name="code">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="pre">
                    <xsl:element name="code">
                        <!-- Insert a line break before the content to avoid indentation in pre-formatted text -->
                        <xsl:text>&#10;</xsl:text>
                        <xsl:call-template name="do_tag"/>

                    </xsl:element>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- 2006.01.05 tmb: q inside q should have simple '' -->
    <xsl:template match="tei:q//tei:q">&#x2018;<xsl:apply-templates/>&#x2019;</xsl:template>

    <xsl:template match="tei:q">&#x201c;<xsl:apply-templates/>&#x201d;</xsl:template>

    <xsl:template match="tei:quote">
        <xsl:element name="blockquote">
            <xsl:call-template name="do_tag"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:tag">
        <!-- 2005.12.28 tmb: Set tags  within angle brackets -->
        <xsl:element name="span">
            <xsl:attribute name="class">tag</xsl:attribute>
            <xsl:element name="code">&lt;<xsl:apply-templates/>&gt;</xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:gi">
        <!-- 2017.12.01 mb: Set general identifiers (xml-elements) within angle brackets and mark them with class="tag"-->
        <xsl:element name="span">
            <xsl:attribute name="class">tag</xsl:attribute>
            <xsl:element name="code">&lt;<xsl:apply-templates/>&gt;</xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:att">
        <!-- 2005.12.28 tmb: Set attributes in bold with @ in front. -->
        <xsl:element name="span">
            <xsl:attribute name="class">attribute</xsl:attribute>
            <xsl:element name="code">@<xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="tei:val">
        <!-- 2005.12.28 tmb: Set values with '' -->
        <xsl:element name="span">
            <xsl:attribute name="class">value</xsl:attribute> '<xsl:apply-templates/>'
        </xsl:element>
    </xsl:template>

    <!-- 2005.12.27 tmb: Make toc (table of contents) if there more than 3 divs in the file. -->
    <!-- 2017.11.16 mb: Make toc (table of contents) for all h2-headers. -->
    <xsl:template name="do_toc">
        <xsl:if test="/descendant::tei:body/descendant::tei:div/child::tei:head">
            <!-- 2018.08.22 mb: don't create a TOC if the xml body-element contains @rend=index -->
            <xsl:if test="not(//tei:body[attribute::rend = 'index'])">
                <xsl:element name="h3">Contents</xsl:element>
                <xsl:element name="ul">
                    <xsl:attribute name="class">toc</xsl:attribute>
                    <xsl:if test="not(//tei:teiHeader[attribute::type = 'versionPage'])">
                        <xsl:for-each select="//tei:body/tei:div/tei:head">
                            <xsl:element name="li">
                                <xsl:element name="a">
                                    <xsl:choose>
                                        <!-- mb 2017-11-17: Use the xml:id if there is one, genereta a random id otherwise -->
                                        <xsl:when test="attribute::xml:id">
                                            <xsl:attribute name="href">#<xsl:value-of
                                                  select="attribute::xml:id"/></xsl:attribute>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:attribute name="href">#<xsl:value-of
                                                  select="generate-id(..)"/></xsl:attribute>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <xsl:value-of select="."/>
                                </xsl:element>
                            </xsl:element>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:element>
            </xsl:if>
        </xsl:if>
    </xsl:template>
    <!-- Template for header -->
    <xsl:template name="do_header">
        <a href="HB3_index.xml">
            <div class="main-header"> Menota Handbook 3.0 </div>
            <div class="sub-header"> Guidelines for the electronic encoding of <br/>Medieval Nordic
                primary sources </div>
        </a>
    </xsl:template>

    <!-- Template for footer line -->
    <xsl:template name="do_signatur">
        <xsl:choose>
            <xsl:when test="//tei:text[@xml:lang = 'en']">
                <p>First published <xsl:value-of
                        select="//tei:revisionDesc/tei:change[last()]/tei:date"/>. Last updated
                        <xsl:value-of select="//tei:revisionDesc/tei:change[1]/tei:date"/>. <a
                            href="mailto:beeke.stegmann@arnastofnun.is">Webmaster</a>. <a href="https://uustatus.no/nb/erklaringer/publisert/444ec719-a38f-4bc1-8ae0-9b2d9d84079f">Accessibility statement</a>. </p>
            </xsl:when>
            <xsl:otherwise>
                <p>Opprettet <xsl:value-of select="//tei:revisionDesc/tei:change[last()]/tei:date"
                    />. Sist oppdatert <xsl:value-of
                        select="//tei:revisionDesc/tei:change[1]/tei:date"/>. <a
                            href="mailto:beeke.stegmann@arnastofnun.is">Vevsjef</a>. <a href="https://uustatus.no/nb/erklaringer/publisert/444ec719-a38f-4bc1-8ae0-9b2d9d84079f">Tilgjengelighetserklæring</a>. </p>
            </xsl:otherwise>
        </xsl:choose>
        <a href="http://www.tei-c.org/">
            <img src="http://www.tei-c.org/About/Badges/We-use-TEI.png" alt="We use TEI"/>
        </a>
        
    </xsl:template>
    <xsl:template name="do-language-alternativ">
        <xsl:if test="//tei:ref/@type = 'lang_alternativ'">
            <xsl:element name="a">
                <xsl:attribute name="href">
                    <xsl:value-of select="//tei:ref[@type = 'lang_alternativ']/@url"/>
                </xsl:attribute>
                <xsl:value-of select="//tei:ref[@type = 'lang_alternativ']"/>
            </xsl:element>
        </xsl:if>
    </xsl:template>
    <!-- Template for menu -->
    <xsl:template name="do_menu">
        <xsl:element name="ul">
            <xsl:choose>
                <xsl:when test="//tei:text[@xml:lang = 'en']">
                    <xsl:if test="not(//tei:teiHeader[attribute::type = 'mainpage'])">
                        <li>
                            <a href="forside.xhtml">Menota main page</a>
                        </li>
                        <xsl:if test="not(//tei:teiHeader[attribute::type = 'versionPage'])">
                            <li>
                                <a href="{$list-of-contents}">List of contents</a>
                            </li>
                        </xsl:if>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="not(//tei:teiHeader[attribute::type = 'mainpage'])">
                        <li>
                            <a href="forside.xhtml">Menota hovedside</a>
                        </li>
                        <xsl:if test="not(//tei:teiHeader[attribute::type = 'versionPage'])">
                            <li>
                                <a href="{$list-of-contents}">Innhold</a>
                            </li>
                        </xsl:if>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
    </xsl:template>

    <xsl:template name="svnTest">
        <xsl:text>SVN er helt sjef</xsl:text>
    </xsl:template>
    <xsl:template name="do_partners"/>

    <xsl:template name="do_tag">
        <!-- mb 2017-11-17: Generic template for block-tags
        adds @rend as classes and xml:id as id
        Parameters:
        - addclass [css-classes to be hard coded, separated with space]
        - force_id [if true, a random id is generated]
        -->
        <xsl:param name="addclass"/>
        <xsl:param name="force_id"/>
        <xsl:choose>
            <xsl:when test="attribute::xml:id">
                <xsl:attribute name="id">
                    <xsl:value-of select="attribute::xml:id"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:when test="$force_id">
                <xsl:attribute name="id">
                    <xsl:value-of select="generate-id(..)"/>
                </xsl:attribute>
            </xsl:when>
            <xsl:otherwise/>
        </xsl:choose>
        <xsl:if test="attribute::rend or $addclass">
            <xsl:attribute name="class">
                <xsl:value-of select="attribute::rend"/>
                <xsl:if test="$addclass">
                    <xsl:if test="attribute::rend">
                        <xsl:text> </xsl:text>
                    </xsl:if>
                    <xsl:value-of select="$addclass"/>
                </xsl:if>
            </xsl:attribute>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>
