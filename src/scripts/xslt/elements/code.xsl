<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="tei_samples:egXML">
        <xsl:choose>
            <xsl:when test="@rend='inline'">
                <xsl:text expand-text="true">`{string() => normalize-space()}</xsl:text>
                <xsl:text>{:xml}`</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;```xml&#x0a;</xsl:text>
                <xsl:value-of select="string() => replace('&#x2028;', '')"/>
                <xsl:text>&#x0a;```&#x0a;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:eg">
        <xsl:choose>
            <xsl:when test="@rend='inline'">
                <xsl:text expand-text="true">`{string() => normalize-space()}`</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;```&#x0a;</xsl:text>
                <xsl:value-of select="string() => replace('&#x2028;', '')"/>
                <xsl:text>&#x0a;```&#x0a;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>