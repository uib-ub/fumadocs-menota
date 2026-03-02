<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
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
        <xsl:value-of select="tei:title"/>
        <xsl:text>"&#x0a;</xsl:text>
        <xsl:if test="tei:author|tei:respStmt/tei:name">
            <xsl:text>author:&#x0a;</xsl:text>
            <xsl:for-each select="tei:author|tei:respStmt/tei:name">
                <xsl:value-of select="concat(' - ', ., '&#x0a;')"/>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:body">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:head">
        <xsl:choose>
            <xsl:when test="count(ancestor::tei:div) = 0">
                <xsl:text>&#x0a;# </xsl:text>
            </xsl:when>
            <xsl:when test="count(ancestor::tei:div) = 1">
                <xsl:text>&#x0a;## </xsl:text>
            </xsl:when>
            <xsl:when test="count(ancestor::tei:div) = 2">
                <xsl:text>&#x0a;### </xsl:text>
            </xsl:when>
        </xsl:choose>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:div">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:p">
        <xsl:text>&#x0a;&#x0a;</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:lb">
        <xsl:text>&lt;br/&gt;&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:title">
        <xsl:text>_</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>_</xsl:text>
    </xsl:template>
    <xsl:template match="tei:q">
        <xsl:text>&#x201c;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x201d;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:quote">
        <xsl:text>&#x0a;&lt;Quote&gt;&#x0a;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&#x0a;&lt;/Quote&gt;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
        <xsl:value-of select="concat('(', @target, ')')"/>
    </xsl:template>
    <xsl:template match="tei:gi">
        <xsl:text>`&lt;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>&gt;`</xsl:text>
    </xsl:template>
    <xsl:template match="tei_samples:egXML">
        <xsl:choose>
            <xsl:when test="@rend='inline'">
                <xsl:text>`</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>`</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;```xml&#x0a;</xsl:text>
                <xsl:value-of select="."/>
                <xsl:text>&#x0a;```&#x0a;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:table">
        <xsl:choose>
            <xsl:when test="@rend='plain'">
                <xsl:text>&#x0a;&#x0a;&lt;table&gt;</xsl:text>
                <xsl:text>&#x0a;&lt;tbody&gt;</xsl:text>
                <xsl:for-each select="tei:row">
                    <xsl:text>&#x0a;&lt;tr&gt;</xsl:text>
                    <xsl:for-each select="tei:cell">
                        <xsl:text>&#x0a;&lt;td&gt;</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>&#x0a;&lt;/td&gt;</xsl:text>
                    </xsl:for-each>
                    <xsl:text>&#x0a;&lt;/tr&gt;</xsl:text>
                </xsl:for-each>
                <xsl:text>&#x0a;&lt;/tbody&gt;</xsl:text>
                <xsl:text>&#x0a;&lt;/table&gt;&#x0a;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;</xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="text()">
        <xsl:variable name="text1">
            <xsl:choose>
                <xsl:when test="ancestor::tei:quote">
                    <xsl:value-of select="replace(., '\s+', ' ')"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="text2">
            <xsl:value-of select="replace(replace($text1, '&lt;', '&amp;lt;'), '&gt;', '&amp;gt;')"/>
        </xsl:variable>
        <xsl:value-of select="$text2"/>
    </xsl:template>
    <xsl:template match="tei:profileDesc"/>
    <xsl:template match="tei:revisionDesc"/>
    <xsl:template match="tei:publicationStmt"/>
    <xsl:template match="tei:sourceDesc"/>
    <xsl:template match="tei:encodingDesc"/>
</xsl:stylesheet>