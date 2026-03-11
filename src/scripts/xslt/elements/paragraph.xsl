<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="tei:p">
        <xsl:choose>
            <xsl:when test="@rend='caption'">
                <xsl:text>&#x0a;&lt;Caption</xsl:text>
                <xsl:if test="tei:hi[@rend='bold'][position() = 1]">
                    <xsl:text expand-text="true"> title="{
                            tei:hi[@rend='bold'][position() = 1]
                        }"</xsl:text>
                </xsl:if>
                <xsl:text>&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&lt;/Caption&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="@xml:id">
                <xsl:text expand-text="true">&#x0a;&lt;LitItem id="{@xml:id}"&gt;&#x0a;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&#x0a;&lt;/LitItem&gt;&#x0a;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;&#x0a;</xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>