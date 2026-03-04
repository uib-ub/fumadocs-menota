<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
    <xsl:include href="elements/spans.xsl"/>
    <xsl:include href="elements/tables.xsl"/>
    <xsl:include href="elements/text.xsl"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:teiHeader">
        <xsl:text>---&#x0a;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>---&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:fileDesc">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:titleStmt">
        <xsl:text>title: "</xsl:text>
        <xsl:value-of select="tei:title"/>
        <xsl:text>"&#x0a;</xsl:text>
        <xsl:if test="tei:author|tei:respStmt/tei:name">
            <xsl:text>author:&#x0a;</xsl:text>
            <xsl:for-each select="tei:author|tei:respStmt/tei:name">
                <xsl:value-of select="concat(' - ', ., '&#x0a;')"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:body">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:head">
        <xsl:choose>
            <xsl:when test="count(ancestor::tei:div) = 0">
                <xsl:text>&#x0a;# </xsl:text>
            </xsl:when>
            <xsl:when test="count(ancestor::tei:div) = 1">
                <xsl:text>&#x0a;## </xsl:text>
            </xsl:when>
            <xsl:when test="count(ancestor::tei:div) = 2">
                <xsl:text>&#x0a;### </xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:div">
        <xsl:choose>
            <xsl:when test="@type='display'">
                <xsl:text>&#x0a;&lt;DisplayFrame&gt;&#x0a;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&#x0a;&lt;/DisplayFrame&gt;&#x0a;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:p">
        <xsl:choose>
            <xsl:when test="@rend='caption'">
                <xsl:text>&#x0a;&lt;Caption</xsl:text>
                <xsl:if test="tei:hi[@rend='bold'][position() = 1]">
                    <xsl:text> title="</xsl:text>
                    <xsl:value-of select="tei:hi[@rend='bold'][position() = 1]"/>
                    <xsl:text>"</xsl:text>
                </xsl:if>
                <xsl:text>&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&lt;/Caption&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;&#x0a;</xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:lb">
        <xsl:text>&lt;br/&gt;</xsl:text>
        <xsl:if test="not(ancestor::tei:cell)">
            <xsl:text>&#x0a;</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:title">
        <xsl:text>_</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>_</xsl:text>
    </xsl:template>
    <xsl:template match="tei:q">
        <xsl:text>&#x201c;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x201d;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:quote">
        <xsl:text>&#x0a;&lt;Quote&gt;&#x0a;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x0a;&lt;/Quote&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
        <xsl:value-of select="concat('(', @target, ')')"/>
    </xsl:template>
    <xsl:template match="tei_samples:egXML">
        <xsl:choose>
            <xsl:when test="@rend='inline'">
                <xsl:text>`</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>`</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;```xml&#x0a;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>&#x0a;```&#x0a;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:list">
        <xsl:text>&#x0a;</xsl:text>
        <xsl:for-each select="tei:item">
            <xsl:text>&#x0a;- </xsl:text>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:figure">
        <xsl:choose>
            <xsl:when test="ancestor::tei:cell">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;&#x0a;&lt;Figure</xsl:text>
                <xsl:if test="tei:figDesc">
                    <xsl:text> caption={`</xsl:text>
                    <xsl:value-of select="tei:figDesc"/>
                    <xsl:text>`}</xsl:text>
                </xsl:if>
                <xsl:text>&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&#x0a;&lt;/Figure&gt;&#x0a;&#x0a;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:graphic">
        <xsl:if test="not(ancestor::tei:cell)">
            <xsl:text>&#x0a;</xsl:text>
        </xsl:if>
        <xsl:text>&lt;AutoImage</xsl:text>
        <xsl:text> src="</xsl:text>
        <xsl:value-of select="concat('/images/hb3/', @url)"/>
        <xsl:text>"</xsl:text>
        <xsl:text> alt="</xsl:text>
        <xsl:value-of select="(../tei:figDesc, @url)[1]"/>
        <xsl:text>"</xsl:text>
        <xsl:text>/&gt;</xsl:text>
        <xsl:if test="ancestor::tei:cell">
            <xsl:text> </xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:profileDesc"/>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="tei:publicationStmt"/>
    <xsl:template match="tei:sourceDesc"/>
    <xsl:template match="tei:encodingDesc"/>
</xsl:stylesheet>