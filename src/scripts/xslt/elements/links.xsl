<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="3.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0">
    <xsl:output encoding="UTF-8" method="text"/>
    <xsl:template match="tei:ref">
        <xsl:variable name="samples-path">
            <xsl:text expand-text="true">/handbook/v{$version}/samples/$1</xsl:text>
        </xsl:variable>
        <xsl:variable name="file-path">
            <xsl:text expand-text="true">/handbook/v{$version}/$1</xsl:text>
        </xsl:variable>
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
        <xsl:text expand-text="true">({@target
                => replace('^HB(1-1)_(\w+)\.xhtml$', '/handbook/v$1/$2')
                => replace('^(?:http://www\.menota\.org/)(HB2_.*?)\.xml$', '/handbook/v2/$1')
                => replace('^(HB([2-4])_.*?)\.xml#?$', '/handbook/v$2/$1')
                => replace('^(HB([23])_.*?)\.xml#(.+)$', '/handbook/v$2/$1#$3')
                => replace('^(?:https://menota.org/handbok_4/)?samplefiles/(.+\.xml)$', $samples-path)
                => replace('^samples/(.+\.(?:jpg|pdf|html|plx|xml|xsl))$', $samples-path)
                => replace('^https://www.menota.org/DOK_Arbeidsgruppe(.*)\.xml', '/documents/workgroup/$1')
                => replace('^([\w_\-0-9]+\.pdf)', $file-path)
                => replace('^([\w\-0-9]+)\.dtd$', '/$1.dtd')
                => replace('^([\w\-0-9]+)\.rng$', '/$1.rng') 
                => replace('^(\w+(-\w+)*)\.txt$', '/$1.txt')
                => replace('^([\w\-0-9]+)\.xml$', '/$1.xml')
                => replace('^(archive)/([\w\-0-9]+)\.(dtd|(?:compiled\.)?rn[cg]|txt|xml)$', '/$1/$2.$3')
                => replace('^([\w_0-9]+)\.xsl$', '/$1.xsl')
                => replace(' ', '%20')
            })</xsl:text>
    </xsl:template>
</xsl:stylesheet>