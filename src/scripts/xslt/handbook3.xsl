<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
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
        <xsl:value-of select="replace(tei:title, '^Nyhetsmelding ', '')"/>
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
    <xsl:template match="tei:p">
        <xsl:text>&#x0a;&#x0a;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:egXML">
        <xsl:text>&#x0a;```xml&#x0a;</xsl:text>
        <!--xsl:apply-templates/-->
        <xsl:text>&#x0a;```&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="replace(replace(., '&lt;', '&amp;lt;'), '&gt;', '&amp;gt;')"/>
    </xsl:template>
    <xsl:template match="tei:profileDesc"/>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="tei:publicationStmt"/>
    <xsl:template match="tei:sourceDesc"/>
    <xsl:template match="tei:encodingDesc"/>
    <xsl:template match="tei:div"/>
</xsl:stylesheet>