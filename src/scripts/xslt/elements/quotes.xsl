<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:menota="http://www.menota.org/ns/xsl"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:template match="tei:quote">
        <xsl:text>&#x0a;&lt;Quote</xsl:text>
        <xsl:if test="$version='2'">
            <xsl:text> straight={true}</xsl:text>
        </xsl:if>
        <xsl:text>&gt;&#x0a;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x0a;&lt;/Quote&gt;</xsl:text>
    </xsl:template>
</xsl:stylesheet>