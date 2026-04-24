<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:menota="http://www.menota.org/ns/xsl"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:function name="menota:normalize-name" as="xs:string">
        <xsl:param name="input" as="xs:string"/>
        <xsl:choose>
            <xsl:when test="$input = 'OEH'">
                <xsl:text>Odd Einar Haugen</xsl:text>
            </xsl:when>
            <xsl:when test="$input = 'TMB' or $input = 'Tone Merete bruvik'">
                <xsl:text>Tone Merete Bruvik</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$input"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
    <xsl:template match="tei:teiHeader">
        <xsl:text>---&#x0a;</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>---&#x0a;</xsl:text>
    </xsl:template>
    <xsl:template match="tei:fileDesc">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:titleStmt">
        <xsl:text expand-text="true">title: "{tei:title 
                => replace('\s+', ' ')
                => replace('^(Menota handbook) \(v\.( (?:[23]\.0|4\.0 beta))\): List of contents$', '$1$2')
                => replace('^Menota handbook [Cc]h\. ([0-9]+) \(v\. [2-4]\.[01](?: beta|\.)?\)(: .*)$', '$1$2')
                => replace('^Menota handbook appendix ([A-I]) \(v\. 3\.0\)(: .*)$', '$1$2')
                => replace('^Menota handbook (preface .*|Introduction \(v\.2\.0\))$', 'Preface')
                => replace('^Menota handbook \(v\. 2\.0\): ', '')
                => replace('^Menota handbook &#x2013; ', '')
                => replace('^Ch\. (1?[0-9]) \(v\. 2\.0\)', '$1')
                => replace('^Menota handbook (&#x2013; )?\(v\. 3\.0\): ', '')
            }"&#x0a;</xsl:text>
        <xsl:if test="tei:author|tei:respStmt/tei:name">
            <xsl:text>author:&#x0a;</xsl:text>
            <xsl:for-each select="tei:author|tei:respStmt/tei:name">
                <xsl:text expand-text="true"> - {.}&#x0a;</xsl:text>
            </xsl:for-each>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:revisionDesc">
        <xsl:text>changeLog:&#x0a;</xsl:text>
        <xsl:text expand-text="true"> - date: {
                current-date() => format-date('[Y]-[M01]-[D01]')
            }&#x0a;</xsl:text>
        <xsl:text>   author: Robert K. Paulsen&#x0a;</xsl:text>
        <xsl:text>   changes:&#x0a;</xsl:text>
        <xsl:text>    - "Converted file from XML to MDX."&#x0a;</xsl:text>
        <xsl:for-each select="tei:change">
            <xsl:if test="string() => string-length() > 0">
                <xsl:text expand-text="true"> - date: {tei:date
                    => replace('^12 April 2016 and ', '')
                    => replace('^[0-3]?[0-9][-/]([0-3]?[0-9])', '$1')
                    => replace('(^[1-9]) ', '0$1 ')
                    => replace('^([0-9]+) (\w+) ([0-9]+)$', '$3-$2-$1')
                    => replace('January', '01')
                    => replace('February', '02')
                    => replace('March', '03')
                    => replace('April', '04')
                    => replace('May', '05')
                    => replace('[Jj]une', '06')
                    => replace('July', '07')
                    => replace('[Aa]ugust', '08')
                    => replace('September', '09')
                    => replace('October', '10')
                    => replace('November', '11')
                    => replace('December', '12')
                    => replace('^([0-3][0-9])\.([01][0-9])\.(20[0-2][0-9])$', '$3-$2-$1')
                }&#x0a;</xsl:text>
                <xsl:choose>
                    <xsl:when test="count(tei:persName) > 1">
                        <xsl:text>   author:&#x0a;</xsl:text>
                        <xsl:for-each select="tei:persName">
                            <xsl:text expand-text="true">    - {string()}&#x0a;</xsl:text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="count(tei:persName) = 1">
                        <xsl:text expand-text="true">   author: {
                            string(tei:persName) 
                                => menota:normalize-name()}&#x0a;</xsl:text>
                    </xsl:when>
                    <xsl:when test="count(tei:name) > 1">
                        <xsl:text>   author:&#x0a;</xsl:text>
                        <xsl:for-each select="tei:name">
                            <xsl:text expand-text="true">    - {
                                string() 
                                    => menota:normalize-name()}&#x0a;</xsl:text>
                        </xsl:for-each>
                    </xsl:when>
                    <xsl:when test="count(tei:name) = 1">
                        <xsl:text expand-text="true">   author: {
                            string(tei:name) 
                                => menota:normalize-name()}&#x0a;</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <xsl:text>   changes:&#x0a;</xsl:text>
                <xsl:text expand-text="true">    - "{.
                    => string()
                    => normalize-space()
                    => replace('^[0-3]?[0-9]([-/][0-3]?[0-9])? ', '')
                    => replace('^(January|February|March|April|May|[Jj]une|July|[Aa]ugust|September|October|November|December) ', '')
                    => replace('^20[0-2][0-9] ', '')
                    => replace('and 15 May 2017 ', '')
                    => replace('^[0-3][0-9]\.[01][0-9]\.20[0-2][0-9]', '')
                    => replace('^Beeke Stegmann(:| and)? ', '')
                    => replace('^Odd Einar Haugen(:| and) ', '')
                    => replace('^Tarrin Wills: ', '')
                    => replace('^Haraldur Bernharðsson: ', '')
                    => replace('^Nina Stensaker( and Odd Einar Haugen)?: ', '')
                    => replace('^Friederike Richter(( ?:)? )?', '')
                    => replace('^Marco Bianchi: ', '')
                    => replace('^Alex Speed Kjeldsen: ', '')
                    => replace('^Robert K\. Paulsen: ', '')
                    => replace('^Tone Merete [Bb]ruvik: ', '')
                    => replace('^(OEH|TMB):? ', '')
                    => replace('\\', '\\\\')
                    => replace('&#x2013;', '\\u2013')
                    => replace('&quot;', '\\&quot;')
                }"</xsl:text>
                <xsl:text>&#x0a;</xsl:text>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
    <xsl:template match="
        tei:profileDesc|
        tei:publicationStmt|
        tei:sourceDesc|
        tei:encodingDesc"/>
</xsl:stylesheet>