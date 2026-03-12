<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:tei_samples="http://www.tei-c.org/ns/Examples">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="tei:ref">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
        <xsl:text expand-text="true">({@target
                => replace('^(HB2_.*?)\.xml$', '/handbook/v2/$1')
                => replace('^(HB3_.*?)\.xml#?$', '/handbook/v3/$1')
                => replace('^(HB3_.*?)\.xml#(.+)$', '/handbook/v3/$1#$2')
                => replace('^(menota-entities)\.txt$', '/$1.txt') 
                => replace('^(menotaP5)\.xml$', '/$1.xml') 
            })</xsl:text>
    </xsl:template>
</xsl:stylesheet>