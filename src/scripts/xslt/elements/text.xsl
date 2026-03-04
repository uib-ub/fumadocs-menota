<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="text()">
        <xsl:variable 
            name="curlies" 
            select="replace(replace(., '\{', '\\{'), '\}', '\\}')"
        />
        <xsl:variable 
            name="anglies" 
            select="replace(replace($curlies, '&lt;', '&amp;lt;'), '&gt;', '&amp;gt;')"
        />
        <xsl:variable name="plus" select="replace($anglies, '\s+\+', ' +')"/>
        <xsl:variable name="ensp" select="replace($plus, '&#x00a0;', '&amp;ensp;')"/>
        <xsl:variable name="simple-spaces">
            <xsl:choose>
                <xsl:when test="ancestor::tei:quote|ancestor::tei:cell">
                    <xsl:value-of select="replace($ensp, '\s+', ' ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="$ensp"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="$simple-spaces"/>
    </xsl:template>
</xsl:stylesheet>