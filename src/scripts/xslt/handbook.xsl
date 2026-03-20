<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
    <xsl:preserve-space elements="tei:p tei:hi tei:item tei:change"/>
    <xsl:include href="elements/graphics.xsl"/>
    <xsl:include href="elements/head.xsl"/>
    <xsl:include href="elements/header.xsl"/>
    <xsl:include href="elements/links.xsl"/>
    <xsl:include href="elements/paragraph.xsl"/>
    <xsl:include href="elements/spans.xsl"/>
    <xsl:include href="elements/tables.xsl"/>
    <xsl:include href="elements/text.xsl"/>
    <xsl:param name="version" as="xs:string"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:body">
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
    <xsl:template match="tei_samples:egXML">
        <xsl:choose>
            <xsl:when test="@rend='inline'">
                <xsl:text>`</xsl:text>
                <xsl:value-of select="string() => normalize-space()"/>
                <xsl:text>{:xml}`</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;```xml&#x0a;</xsl:text>
                <xsl:value-of select="string() => replace('&#x2018;', '')"/>
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
</xsl:stylesheet>