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
                => replace('^(?:http://www\.menota\.org/)HB2_(.*?)\.xml$', '/handbook/v2/$1')
                => replace('^HB([2-4])_(.*?)\.xml#?$', '/handbook/v$1/$2')
                => replace('^HB([2-4])_(.*?)\.xml#(.+)$', '/handbook/v$1/$2#$3')
                => replace('^(?:https://menota.org/handbok_4/)?samplefiles/(.+\.xml)$', 
                    $samples-path)
                => replace('^(?:eksempler|samples)/(.+\.(?:jpg|pdf|html|plx|xml|xsl))$', 
                    $samples-path)
                => replace('^https://www.menota.org/DOK_Arbeidsgruppe(.*)\.xml', 
                    '/documents/workgroup/$1')
                => replace('^(archive)/([\w\-0-9]+)\.(dtd|(?:compiled\.)?rn[cg]|txt|xml)$', 
                    '/$1/$2.$3')
                => replace('^([\w\-0-9]+/[\w\-0-9]+\.gif)', $file-path)
                => replace('^(Electronic-editions-2009-11-18\.pdf)$', '/documents/pdf/$1')
                => replace('^([\w_\-0-9]+\.pdf)$', $file-path)
                => replace('^(\w+(-\w+)*)\.txt$', '/ent/$1.txt')
                => replace('^([\w_\-0-9]+)\.(dtd|rng|xml|xsl)$', '/$2/$1.$2')
                => replace(' ', '%20')
            })</xsl:text>
    </xsl:template>
</xsl:stylesheet>