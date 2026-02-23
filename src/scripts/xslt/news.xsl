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
        <xsl:if test="tei:author">
            <xsl:text>author:&#x0a;</xsl:text>
            <xsl:for-each select="tei:author">
                <xsl:value-of select="concat(' - ', ., '&#x0a;')"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:head">
        <xsl:text>&#x0a;# </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:p">
        <xsl:text>&#x0a;&#x0a;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:title">
        <xsl:text>_</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>_</xsl:text>
    </xsl:template>
    <xsl:template match="tei:figure">
        <xsl:text>&#x0a;&#x0a;&lt;Figure</xsl:text>
        <xsl:if test="tei:figDesc">
            <xsl:text> caption={`</xsl:text>
            <xsl:value-of select="tei:figDesc"/>
            <xsl:text>`}</xsl:text>
        </xsl:if>
        <xsl:text>&gt;</xsl:text>
        <xsl:for-each select="tei:graphic">
            <xsl:text>&#x0a;&lt;AutoImage</xsl:text>
            <xsl:text> src="</xsl:text>
            <xsl:value-of select="concat('/images/', @url)"/>
            <xsl:text>"</xsl:text>
            <xsl:text> alt="</xsl:text>
            <xsl:value-of select="@url"/>
            <xsl:text>"</xsl:text>
            <xsl:text>/&gt;</xsl:text>
        </xsl:for-each>
        <xsl:text>&#x0a;&lt;/Figure&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="tei:graphic">
                <xsl:text>&#x0a;&lt;Link href="</xsl:text>
                <xsl:value-of select="@target"/>
                <xsl:text>"&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&#x0a;&lt;/Link&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="concat('[', text(), ']')"/>
                <xsl:value-of select="concat('(', @target, ')')"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='bold']">
        <xsl:text>**</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>**</xsl:text>
    </xsl:template>
    <xsl:template match="tei:hi[@rend='italic']">
        <xsl:text>*</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>*</xsl:text>
    </xsl:template>
    <xsl:template match="tei:list">
        <xsl:text>&#x0a;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:item">
        <xsl:text>&#x0a;- </xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:lb">
        <xsl:text>&lt;br/&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:q">
        <xsl:text>*</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>*</xsl:text>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:value-of select="
            replace(
                replace(
                    replace(., '\n +', '&#x0a;'), 
                    '&lt;', 
                    '&amp;lt;'), 
                '&gt;', 
                '&amp;gt;')
        "/>
    </xsl:template>
    <xsl:template match="tei:profileDesc"/>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="tei:publicationStmt"/>
    <xsl:template match="tei:sourceDesc"/>
</xsl:stylesheet>
