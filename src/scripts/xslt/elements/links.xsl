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
                => replace('^(?:http://www\.menota\.org/)(HB2_.*?)\.xml$', '/handbook/v2/$1')
                => replace('^(HB3_.*?)\.xml#?$', '/handbook/v3/$1')
                => replace('^(HB3_.*?)\.xml#(.+)$', '/handbook/v3/$1#$2')
                => replace('^samplefiles/(.+\.xml)$', '/handbook/v3/samples/$1')
                => replace('^samples/(.+\.(?:jpg|pdf|plx|xml))$', '/handbook/v3/samples/$1')
                => replace('^(\w+)\.dtd$', '/$1.dtd')
                => replace('^(\w+)\.rng$', '/$1.rng') 
                => replace('^(\w+(-\w+)*)\.txt$', '/$1.txt')
                => replace('^(\w+)\.xml$', '/$1.xml')
                => replace('^([\w_0-9]+)\.xsl$', '/$1.xsl')
                => replace(' ', '%20')
            })</xsl:text>
    </xsl:template>
</xsl:stylesheet>