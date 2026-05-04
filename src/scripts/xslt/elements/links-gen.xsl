<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="tei:ref">
        <xsl:variable name="target">
            <xsl:value-of select="@target
                => replace('^https?://(www\.)?menota\.org/', '')
                => replace('^http://www\.aksis\.uib\.no/menota/', '')
                => replace('^DOK_(depo)(1-2)\.xhtml$', '/documents/$1/$2')
                => replace('^DOK_innkalling(20[0-2][0-9]-[01][0-9]-[0-3][0-9])\.xml$', 
                    '/documents/council/notice/$1')
                => replace('^DOK_raad(20[0-2][0-9]-20[0-2][0-9]).xml', '/documents/council/members/$1')
                => replace('^DOK_RaadsReferat(20[0-2][0-9]-[01][0-9]-[0-3][0-9]).xml$', 
                    '/documents/council/meetings/$1')
                => replace('^DOK_Referat(20[0-2][0-9]-[01][0-9]-[0-3][0-9]).xhtml$', 
                    '/documents/editorial-board/$1')
                => replace('^DOK_(vedtekter-(?:utkast|1)).xhtml$', '/documents/statutes/$1')
                => replace('^HB_index.xml$', '/handbook')
                => replace('^HB2-0-b_contents.xhtml$', '/handbook/v2')
                => replace('^HB(1-1)_([\w_0-9]*).xhtml$', '/handbook/v$1/$2')
                => replace('^HB([2-4])_([\w_0-9]*).xml$', '/handbook/v$1/$2')
                => replace('^ML_(.*?).xml$', '/news/$1')
                => replace('^([\w0-9\-_]+.pdf)$', '/documents/pdf/$1')
                => replace('^(standoff.odp)$', '/documents/presentations/$1')
                => replace('^internmappe/referat/RaadsReferat(20[0-2][0-9]-[01][0-9]-[0-3][0-9])\.page$', 
                    '/documents/council/meetings/$1')
                => replace('^(helpdesk)$', '/$1')
                => replace('^oversettelser\.xml$', '/translations')
                => replace('^(menotec)\.xml$', '/en/$1')
                => replace('/index$', '')"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="tei:graphic">
                <xsl:text expand-text="true">&#x0a;&lt;Link href="{$target}"&gt;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&#x0a;&lt;/Link&gt;</xsl:text>
            </xsl:when>
            <xsl:when test="ends-with(@target, '.odp')">
                <xsl:text expand-text="true">&lt;a href="{$target}" download&gt;{
                    text() => normalize-space()}&lt;/a&gt;</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>[</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>]</xsl:text>
                <xsl:text expand-text="true">({$target})</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>