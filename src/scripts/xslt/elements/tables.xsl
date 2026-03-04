<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:strip-space elements="*"/>
    <xsl:template match="tei:table">
        <xsl:choose>
            <xsl:when test="@rend='abbr' or @rend='xml-elements'">
                <xsl:text>&#x0a;&#x0a;&lt;div className="table-</xsl:text>
                <xsl:value-of select="@rend"/>
                <xsl:text>"&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="@rend='plain' or descendant::tei:cell//tei:lb">
                <xsl:text>&#x0a;&lt;table&gt;</xsl:text>
                <xsl:if test="tei:row[@role='label']">
                    <xsl:text>&#x0a;&lt;thead&gt;</xsl:text>
                    <xsl:for-each select="tei:row[@role='label']">
                        <xsl:text>&#x0a;&lt;tr&gt;</xsl:text>
                        <xsl:for-each select="tei:cell">
                            <xsl:text>&#x0a;&lt;th&gt;</xsl:text>
                            <xsl:apply-templates/>
                            <xsl:text>&lt;/th&gt;</xsl:text>
                        </xsl:for-each>
                        <xsl:text>&#x0a;&lt;/tr&gt;</xsl:text>
                    </xsl:for-each>
                    <xsl:text>&#x0a;&lt;/thead&gt;</xsl:text>
                </xsl:if>
                <xsl:text>&#x0a;&lt;tbody&gt;</xsl:text>
                <xsl:for-each select="tei:row[not(@role='label')]">
                    <xsl:text>&#x0a;&lt;tr&gt;</xsl:text>
                    <xsl:for-each select="tei:cell">
                        <xsl:text>&#x0a;&lt;td&gt;</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>&lt;/td&gt;</xsl:text>
                    </xsl:for-each>
                    <xsl:text>&#x0a;&lt;/tr&gt;</xsl:text>
                </xsl:for-each>
                <xsl:text>&#x0a;&lt;/tbody&gt;</xsl:text>
                <xsl:text>&#x0a;&lt;/table&gt;&#x0a;</xsl:text>
            </xsl:when>
            <xsl:when test="tei:row[@role='label']">
                <xsl:for-each select="tei:row">
                    <xsl:text>&#x0a;|</xsl:text>
                    <xsl:for-each select="tei:cell">
                        <xsl:text> </xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text> |</xsl:text>
                    </xsl:for-each>
                    <xsl:if test="@role='label'">
                        <xsl:text>&#x0a;|</xsl:text>
                        <xsl:for-each select="tei:cell">
                            <xsl:text>-----|</xsl:text>
                        </xsl:for-each>
                    </xsl:if>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x0a;</xsl:text>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:if test="@rend='abbr' or @rend='xml-elements'">
            <xsl:text>&#x0a;&lt;/div&gt;</xsl:text>
        </xsl:if>
        <xsl:text>&#x0a;</xsl:text>
    </xsl:template>
</xsl:stylesheet>