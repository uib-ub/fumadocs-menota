<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
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
        <xsl:variable name="source">
            <xsl:text expand-text="true">/images/{@url}</xsl:text>
        </xsl:variable>
        <xsl:if test="not(ancestor::tei:cell) or ancestor::tei:figure">
            <xsl:text>&#x0a;</xsl:text>
        </xsl:if>
        <xsl:text expand-text="true">&lt;AutoImage src="{
            $source}" alt="{(../tei:figDesc, @url)[1]}"/&gt;</xsl:text>
        <xsl:if test="not(ancestor::tei:cell) or ancestor::tei:figure">
            <xsl:text>&#x0a;</xsl:text>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:figDesc"/>
</xsl:stylesheet>