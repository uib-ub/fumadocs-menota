<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="tei:att">
        <xsl:if test="position() = 1 and ancestor::tei:table[@rend='xml-elements']">
            <xsl:text>&lt;span className="p-3"/&gt;</xsl:text>
        </xsl:if>
        <xsl:value-of select="concat('`@', ., '{:sh}`')"/>
    </xsl:template>
    <xsl:template match="tei:gi">
        <xsl:choose>
            <xsl:when test="ancestor::tei:head">
                <xsl:value-of select="concat('`&lt;', string(.), '&gt;`')"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text expand-text="true">&lt;E&gt;{string(.)}&lt;/E&gt;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:hi">
        <xsl:choose>
            <xsl:when test="@rend='entity'">
                <xsl:value-of select="concat('`', ., '{:xml}`')"/>
            </xsl:when>
            <xsl:when test="@rend='codepoint' or @rend='descName'">
                <xsl:value-of select="concat('`', ., '`')"/>
            </xsl:when>
            <xsl:when test="@rend='bold'">
                <xsl:choose>
                    <xsl:when test="parent::tei:p[@rend='caption'] and position() = 1"/>
                    <xsl:when test="string() => ends-with(' ')">
                        <xsl:text>&lt;HI style="bold"&gt;</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>&lt;/HI&gt;</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>**</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>**</xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="@rend='italic'">
                <xsl:text>&lt;em&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&lt;/em&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="@rend='glyph'">
                <xsl:text>&lt;Glyph&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&lt;/Glyph&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="@rend='red' or @rend='blue'">
                <xsl:text expand-text="true">&lt;HI color="{@rend}"&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&lt;/HI&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="tei:val">
        <xsl:if test="position() = 1 and ancestor::tei:table[@rend='xml-elements']">
            <xsl:text>&lt;span className="p-6"/&gt;</xsl:text>
        </xsl:if>
        <xsl:value-of select="concat('`&quot;', ., '&quot;{:js}`')"/>
    </xsl:template>
</xsl:stylesheet>