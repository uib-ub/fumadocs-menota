<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="tei:figure">
        <xsl:if test="not(ancestor::tei:cell)">
            <xsl:text>&#x0a;&#x0a;</xsl:text>
        </xsl:if>
        <xsl:text>&lt;Figure</xsl:text>
        <xsl:if test="tei:figDesc">
            <xsl:text> desc={`</xsl:text>
            <xsl:value-of select="tei:figDesc"/>
            <xsl:text>`}</xsl:text>
        </xsl:if>
        <xsl:text>&gt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x0a;&lt;/Figure&gt;&#x0a;</xsl:text>
        <xsl:if test="not(ancestor::tei:cell)">
            <xsl:text>&#x0a;</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:graphic">
        <xsl:if test="not(ancestor::tei:cell) or ancestor::tei:figure">
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
        <xsl:if test="not(ancestor::tei:cell) or ancestor::tei:figure">
            <xsl:text>&#x0a;</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:figDesc"/>
</xsl:stylesheet>