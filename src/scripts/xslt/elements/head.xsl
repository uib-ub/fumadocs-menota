<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:template match="tei:head">
        <xsl:text>&#x0a;&#x0a;#</xsl:text>
        <xsl:for-each select="ancestor::tei:div|ancestor::tei:list">
            <xsl:text>#</xsl:text>
        </xsl:for-each>
        <xsl:text> </xsl:text>
        <xsl:apply-templates/>
        <xsl:if test="@xml:id">
            <xsl:text expand-text="true"> [#{@xml:id}]</xsl:text>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>