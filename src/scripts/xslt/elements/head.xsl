<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:template match="tei:head">
        <xsl:choose>
            <xsl:when test="descendant::tei:graphic">
                <xsl:variable name="level" select="string(count(ancestor::tei:div) + 1)"/>
                <xsl:text expand-text="true">&#x0a;&#x0a;&lt;h{$level}&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text expand-text="true">&lt;/h{$level}&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;&#x0a;#</xsl:text>
                <xsl:for-each select="ancestor::tei:div|ancestor::tei:list">
                    <xsl:text>#</xsl:text>
                </xsl:for-each>
                <xsl:text> </xsl:text>
                <xsl:apply-templates/>
                <xsl:if test="@xml:id">
                    <xsl:text expand-text="true"> [#{@xml:id}]</xsl:text>
                </xsl:if>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>