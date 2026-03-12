<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:menota="http://www.menota.org/ns/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:function name="menota:simple-spaces" as="xs:string">
        <xsl:param name="s" as="xs:string"/>
        <xsl:param name="node" as="text()"/>
        <xsl:choose>
            <xsl:when test="$node[
                    ancestor::tei:quote|
                    ancestor::tei:cell|
                    ancestor::tei:head|
                    ancestor::tei:item
                ]">
                <xsl:value-of select="replace($s, '\s+', ' ')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$s"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:template match="text()">
        <xsl:value-of select=". 
                => replace('\n +', '&#x0a;')
                => replace('([\{\|\}])', '\\$1')
                => replace('&lt;', '&amp;lt;')
                => replace('&gt;', '&amp;gt;')
                => replace('\s+\+', ' +')
                => replace('&#x00a0;', '&amp;ensp;')
                => replace('&#x2013;', '&amp;ndash;')
                => menota:simple-spaces(.)
            "/>
    </xsl:template>
</xsl:stylesheet>