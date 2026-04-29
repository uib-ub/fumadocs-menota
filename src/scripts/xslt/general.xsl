<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
    <xsl:include href="elements/head.xsl"/>
    <xsl:include href="elements/header.xsl"/>
    <xsl:include href="elements/links-gen.xsl"/>
    <xsl:include href="elements/text.xsl"/>
    <xsl:template match="/">
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
        <xsl:for-each select="tei:item">
            <xsl:text>&#x0a;- </xsl:text>
            <xsl:apply-templates/>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="tei:lb">
        <xsl:text>&lt;br/&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:q">
        <xsl:text>*</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>*</xsl:text>
    </xsl:template>
</xsl:stylesheet>
