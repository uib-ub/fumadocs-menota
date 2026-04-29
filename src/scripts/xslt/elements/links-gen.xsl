<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="tei:graphic">
                <xsl:text>&#x0a;&lt;Link href="</xsl:text>
                <xsl:value-of select="@target"/>
                <xsl:text>"&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&#x0a;&lt;/Link&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text expand-text="true">[{text()}]</xsl:text>
                <xsl:text expand-text="true">({@target
                        => replace('^DOK_(vedtekter-utkast).xhtml$', '/documents/statutes/$1')
                        => replace('HB_index.xml$', '/handbook/v1-0')
                    })</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>