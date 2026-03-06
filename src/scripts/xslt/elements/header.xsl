<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="tei:teiHeader">
        <xsl:text>---&#x0a;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>---&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:fileDesc">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:titleStmt">
        <xsl:text>title: "</xsl:text>
        <!--xsl:value-of select="replace(string(tei:title), 
            '^Menota handbook preface .*$', 'Preface')"/-->
        <xsl:value-of select="replace(replace(replace(tei:title, 
            '\s+', ' '),
            '^Menota handbook ch\. ([0-9]+) \(v\. 3\.[01]\)(: .*)$', '$1$2'), 
            '^Menota handbook preface .*$', 'Preface')"/>
        <xsl:text>"&#x0a;</xsl:text>
        <xsl:if test="tei:author|tei:respStmt/tei:name">
            <xsl:text>author:&#x0a;</xsl:text>
            <xsl:for-each select="tei:author|tei:respStmt/tei:name">
                <xsl:value-of select="concat(' - ', ., '&#x0a;')"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template match="
        tei:profileDesc|
        tei:revisionDesc|
        tei:publicationStmt|
        tei:sourceDesc|
        tei:encodingDesc"/>
</xsl:stylesheet>