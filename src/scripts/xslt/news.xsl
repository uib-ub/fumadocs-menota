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
        <xsl:text>author: "</xsl:text>
        <xsl:value-of select="tei:author"/>
        <xsl:text>"&#x0a;</xsl:text>
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
        <xsl:text>&#x0a;&#x0a;&lt;div className="flex"&gt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x0a;&lt;/div&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:graphic">
        <xsl:text>  &#x0a;&lt;AutoImage</xsl:text>
        <xsl:text> src="</xsl:text>
        <xsl:value-of select="concat('/images/', @url)"/>
        <xsl:text>"</xsl:text>
        <xsl:text> alt="</xsl:text>
        <xsl:value-of select="@url"/>
        <xsl:text>"</xsl:text>
        <xsl:text>/&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:value-of select="concat('[', text(), ']')"/>
        <xsl:value-of select="concat('(', @target, ')')"/>
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
    <xsl:template match="text()">
        <xsl:value-of select="replace(replace(., '&lt;', '&amp;lt;'), '&gt;', '&amp;gt;')"/>
    </xsl:template>
    <xsl:template match="tei:profileDesc"/>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="tei:publicationStmt"/>
    <xsl:template match="tei:sourceDesc"/>
</xsl:stylesheet>
