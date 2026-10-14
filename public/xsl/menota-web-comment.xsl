<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE xsl:stylesheet [
<!ENTITY aelig "&#230;">
<!ENTITY oslash "&#248;">
<!ENTITY aring "&#229;">
<!ENTITY AElig "&#198;">
<!ENTITY Oslash "&#216;">
<!ENTITY Aring "&#197;">
<!ENTITY dash "&#45;">
<!ENTITY lquo "&#171;">
<!ENTITY rquo "&#187;">
<!ENTITY nbsp "&#x0020;">
<!ENTITY carr "&#x0D;">
<!ENTITY lsquo  "&#x2018;">
<!ENTITY ldquo  "&#x201C;">
<!ENTITY rsquo  "&#x2019;">
<!ENTITY rdquo  "&#x201D;">
]>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<!-- This style sheet has been written by Vemund Olstad, Aksis, University of Bergen, for the Menota TVB project, http://www.hit.uib.no/menota/TVB. First version made for the research group Editing Medieval Manuscripts, Centre for Advanced Study, Oslo, 2000-2001. Last update 14 April 2004. -->

<!-- The entities defined above are needed for text generation in the style sheet, e.g. if you want to generate a header or multiple space. -->    
    
<xsl:output method="html" doctype-public="-//W3C/DTD XHTML 1.0 STRICT//EN" doctype-system="http:://www.w3.org/TR/xhtml1-strict.dtd" encoding="ASCII"></xsl:output>

<!-- The xsl:strip-space element is used to prevent superflous spaces in the xml encoding from being displayed in the output HTML file -->    
<!-- Since necessary spaces are stripped from the file, some of the templates below contain functions that add spaces in relevant places (see templates for w, punct, unclear and supplied) -->    
<xsl:strip-space elements="*"/>


<!-- This global parameter below is used to decide which of the three text-levels is displayed, i.e the facsimile level, the diplomatic level or the normalised level. See the Menota handbook v. 1.1, ch. 3 for further details on these levels.The parameter has three values: 'facs', 'dipl' and 'norm'. -->

<!-- Due to problems with parametres in Oxygen, we have inserted an extra select attribute in the parametre. For facs display, the value has to be 'facs' and for dipl display the value has to be 'dipl'. -->

<!--<xsl:param name="visning" select="'norm'"/>-->
<xsl:param name="visning"/>

<!-- This template writes the entire document into an HTML page -->

<xsl:template match="/">
    <xsl:element name="HTML">
        <xsl:element name="HEAD">
            <xsl:element name="TITLE">
                <xsl:value-of select="TEI.2/teiHeader/fileDesc/titleStmt/title"/>
            </xsl:element>
            <xsl:element name="META">
            <xsl:attribute name="http-equiv">Expires</xsl:attribute>
            <xsl:attribute name="content">0</xsl:attribute>
            </xsl:element>
            
<!-- This is a complete CSS definition for Menota styles, included in the present XSLT style sheet. Thus it is possible to use this style sheet off line. -->          
<!-- We recommend using MUFI compliant fonts, which are listed in a prefential sequence as values for the font-framily. These fonts are available from http://www.hit.uib.no/mufi/fonts.html -->
<!-- However, structural elements may use another font, like Verdana. -->

            <xsl:element name="STYLE">
            <xsl:attribute name="type">text/css</xsl:attribute>
                .pagebreak                   {font-family:             Verdana;
                                                         font-size:                12pt;
                                                         font-weight:            normal;
                                                         color:                       #BEBEBE;
                                                         vertical-align:         middle;}
                .linecount                      {font-family:             Verdana;
                                                         font-size:                10pt;
                                                         font-weight:            normal;
                                                         color:                       #BEBEBE;
                                                         padding-right:        15px;
                                                         float:                         left;
                                                         text-align:                right;
                                                         width:                      25px;}
                .head1			{font-family: 	Notator Uni, ALPHABETUM Unicode, Verdana;
			                font-weight:	normal;
			                font-size:	28pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
                .head2			{font-family: 	Notator Uni, ALPHABETUM Unicode, Verdana;
			                font-weight:	normal;
			                font-size:	24pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
                .head3			{font-family: 	Notator Uni, ALPHABETUM Unicode, Verdana;
			                font-weight:	normal;
			                font-size:	18pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
                .head4			{font-family: 	Notator Uni, ALPHABETUM Unicode, Verdana;
		                	 font-weight:	normal;
			                font-size:	14pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
               .divwork                          {font-family:             Notator Uni, ALPHABETUM Unicode, Verdana;
                                                         font-size:                18pt;
                                                         font-weight:           normal;
                                                         color:                      #0000FF;
                                                         margin-top:           10px;
                                                         margin-bottom:    10px;
                                                         text-align:               left;}
               .divchapter                       {font-family:             Notator Uni, ALPHABETUM Unicode, Verdana;
                                                         font-size:                16pt;
                                                         font-weight:            normal;
                                                         color:                       #0000FF;
                                                         margin-top:           20px;
                                                         margin-bottom:    10px;
                                                         text-align:                left;}
                .paragraph                    {font-family:            Notator Uni, ALPHABETUM Unicode, Verdana;
                                                         font-size:                14pt;
                                                         font-weight:           normal;
                                                         color:                      #000000;
                                                         line-height:            140%;}
                .linegroup                     {font-family:            Notator Uni, ALPHABETUM Unicode, Verdana;
                                                         font-size:                14pt;
                                                         font-weight:           normal;
                                                         color:                      #000000;
                                                         line-height:            140%;
                                                         margin-left:            25px;}                                                         
                .lglines                          {font-family:             Verdana;
                                                         font-size:                10pt;
                                                         font-weight:            normal;
                                                         color:                       #BEBEBE;
                                                         padding-right:        5px;
                                                         float:                         left;
                                                         text-align:                right;
                                                         width:                      25px;}
                .note                               {font-family:             Verdana;
                                                         font-size:                 8pt;
                                                         font-weight:             normal;
                                                         color:                        #0000FF;
                                                         text-decoration:      none;
                                                         vertical-align:          super;}
                .foot                               {font-family:              Verdana;
                                                         font-size:                 8pt;
                                                         font-weight:             normal;
                                                         color:                        #0000FF;
                                                         text-decoration:      none;
                                                         float:                         left;
                                                         width:                        15px;
                                                         padding-right:            5px;
                                                         text-align:                  right;}
                .footnote                        {font-family:              Verdana;
                                                         font-size:                 10pt;
                                                         font-weight:             normal;
                                                         color:                        #000000;}                                                          
                .expan                            {font-family:          Notator Uni, ALPHABETUM Unicode, Verdana;
                                                         font-style:             italic;
                                                         font-weight:         normal;}


                .notecritical		{font-size:	80%;
			                color:		#0076AE}
                .noteplain		{font-size:	80%;
	                		 color:		#008080}
                .supplied		{font-family: 	Notator Uni, ALPHABETUM Unicode, Verdana;
                                                            font-size:	100%;}
                .gap			{font-size:	80%;
	                		 color:		#0076AE}
                .add			{color:		#008000}
                .emph			{color:		#0000FF}
            </xsl:element>
            
        </xsl:element>
        <xsl:element name="BODY">
        <xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
        <xsl:attribute name="class">paragraph</xsl:attribute>
            <xsl:for-each select="TEI.2">
                <xsl:element name="BR"></xsl:element>
                <xsl:element name="BR"></xsl:element>
                
<!-- This apply-template writes the teiHeader into the top of the document -->         
                
                    <xsl:apply-templates select="teiHeader"/>
                <xsl:element name="HR"></xsl:element>
                
<!-- This apply-template writes the text itself into the document, after the header. --> 
         
                    <xsl:apply-templates select="text/*"/>
                <xsl:element name="HR"></xsl:element>
                <!--<xsl:element name="A">
                <xsl:attribute name="name">topp</xsl:attribute>
                    <xsl:text>For en beskrivelse av fargekodingen</xsl:text>
                </xsl:element>
                    <xsl:text>, trykk&nbsp;</xsl:text>
                <xsl:element name="A">
                <xsl:attribute name="href">#bunn</xsl:attribute>
                    <xsl:text>her</xsl:text>
                </xsl:element>-->

<!-- This apply-template writes the notes into the document as foot notes, after the text itself. -->  
                <xsl:if test="descendant::note">
                    <xsl:element name="DIV">
                    <xsl:attribute name="style">font-family: Verdana; font-size: 12pt; text-align: left</xsl:attribute>
                        <xsl:text>Noter:</xsl:text>
                            <xsl:apply-templates select="//note" mode="footer"/>
                    </xsl:element>
                    <xsl:element name="BR"></xsl:element>
                </xsl:if>
<!-- The following rules add an explanation of the colour encoding -->            
                
                <!--<xsl:element name="A">
                <xsl:attribute name="name">bunn</xsl:attribute>
                    <xsl:text>Fargekoding:</xsl:text>
                </xsl:element>-->
                <!--<xsl:element name="BR"></xsl:element>-->
                    <!--<xsl:element name="UL">
                        <xsl:element name="LI">
                            <xsl:text>Alle &lt;supplied&gt; elementer er kodet&nbsp;</xsl:text>
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">supplied</xsl:attribute>
                            <xsl:text>&lt;p&aring; denne m&aring;ten&gt;.</xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">notecritical</xsl:attribute>
                            <xsl:text>(Tekstkritiske noter ser slik ut).</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">noteplain</xsl:attribute>
                            <xsl:text>(Ordin&aelig;re noter ser slik ut).</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">add</xsl:attribute>
                            <xsl:text>Alle &lt;add&gt; elementer er kodet med denne fargen.</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">emph</xsl:attribute>
                            <xsl:text>Uthevinger (emph) er kodet med denne fargen.</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                        <xsl:element name="LI">
                            <xsl:text>&lt;gap&gt; elementer blir vist som tekstkritiske noter, med verdien av extent-attributtet i klammeparenteser. Slik:&nbsp;</xsl:text>
                            <xsl:element name="SPAN">
                            <xsl:attribute name="class">gap</xsl:attribute>
                            <xsl:text>[00..00]</xsl:text>
                            </xsl:element>                        
                        </xsl:element>
                    </xsl:element>-->
                <!--<xsl:element name="BR"></xsl:element>-->
                <!--<xsl:element name="A">
                <xsl:attribute name="href">#topp</xsl:attribute>
                    <xsl:text>Tilbake til toppen</xsl:text>
                </xsl:element>-->
            </xsl:for-each>
        </xsl:element>
    </xsl:element>
</xsl:template>


<!-- The following templates format the TEI Header, i.e. it decides which part(s) of the header that is going to be displayed (i.e. title from titleStmt)  or suppressed (i.e. publicationStmt from fileDesc). -->

<!-- Note that if a top element is suppressed, the descendent elements will also be suppressed. -->
    
<xsl:template match="//fileDesc/titleStmt">
    <xsl:apply-templates select="child::title"/>
    <xsl:apply-templates select="child::respStmt"/>
</xsl:template>    

<xsl:template match="fileDesc/titleStmt/title">
    <xsl:element name="DIV">
    <xsl:attribute name="class">head2</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="fileDesc/titleStmt/respStmt">
    <xsl:element name="DIV">
    <xsl:attribute name="class">paragraph</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<xsl:template match="fileDesc/sourceDesc"/>    
<!--<xsl:template match="fileDesc/sourceDesc">
    <xsl:element name="DIV">
    <xsl:attribute name="class">head4</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>-->

<xsl:template match="fileDesc/publicationStmt"/>

<xsl:template match="encodingDesc"/>

<xsl:template match="profileDesc"/>

<xsl:template match="revisionDesc"/>


<!-- Whitespace control -->
<!-- Due to what is most likely a bug in the Safari browser for Mac,
       the following template can be used to control whitespace -->
<!-- Including this template will, however, increase processing time 
       quite dramatically, so unless you use Safari this template is better
       left out. -->
<!-- Update 19 March 2004: we believe this bug has been fixed in the latest version of Safari. -->

<!--
<xsl:template match="text()">
<xsl:variable name="normalized" select="normalize-space(.)"/>
<xsl:variable name="blanked" select="translate(., '&#9;&#10;&#9;&#13;', '    ')"/>
<xsl:variable name="out">
    <xsl:choose>
        <xsl:when test="string-length(.)=0"/>
        <xsl:when test="$normalized=''">
            <xsl:text> </xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:if test="substring($blanked, 1, 1)=' '">
                <xsl:text> </xsl:text>
            </xsl:if>
                <xsl:value-of select="$normalized"/>
            <xsl:if test="substring($blanked, string-length($blanked), 1)=' '">
                <xsl:text> </xsl:text>
            </xsl:if>
        </xsl:otherwise>
    </xsl:choose>
</xsl:variable>
    <xsl:value-of select="$out"/>
</xsl:template>
-->

<!-- Templates for common milestone-elements (pagebreaks, linebreaks and columnbreaks) -->

<xsl:template match="//pb">
    
<!-- The display of page breaks depends on the text level. The value of the global parameter "visning" is used to control how page breaks are formatted. -->
<!-- In facs, page break is displayed with page number and a line separator. -->
    
    <xsl:choose>
    <xsl:when test="contains($visning, 'facs')">	
    <xsl:element name="BR"></xsl:element>
    <xsl:element name="BR"></xsl:element>
    <xsl:element name="TABLE">
    <xsl:attribute name="border">0</xsl:attribute>
    <xsl:attribute name="width">650px</xsl:attribute>
        <xsl:element name="TR">
            <xsl:element name="TD">
            <xsl:attribute name="width">35</xsl:attribute>
                <xsl:element name="SPAN">
                <xsl:attribute name="class">pagebreak</xsl:attribute>
                    <xsl:value-of select="attribute::n"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="TD">
            <xsl:attribute name="width">600px</xsl:attribute>
                <!-- <xsl:element name="IMG">
                <xsl:attribute name="style">vertical-align: middle</xsl:attribute>
                <xsl:attribute name="src">http://gandalf.hit.uib.no/~vemund/menota/pagebreak.gif</xsl:attribute>
                </xsl:element> -->
                <xsl:text>&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;</xsl:text>
            </xsl:element>
        </xsl:element>
    </xsl:element>
    </xsl:when>
   
<!-- In dipl, page break is displayed inline with page number within double vertical lines. -->

          <xsl:when test="contains($visning, 'dipl')">	
<xsl:text>
&nbsp;&#x007C;&#x007C;&nbsp;
</xsl:text>
                    <xsl:value-of select="attribute::n"/>
<xsl:text>
&nbsp;&#x007C;&#x007C;&nbsp;
</xsl:text>
</xsl:when>

<!-- In other levels (e.g. norm) no page number is displayed. -->

<xsl:otherwise>
</xsl:otherwise>
  </xsl:choose>

</xsl:template>

<!-- The display of column breaks also depends on the text level. The value of the global parameter "visning" is used to control how column breaks are formatted. -->
<!-- In facs, column break is displayed with a dotted line separator. -->

<xsl:template match="//cb">
<xsl:choose>
<xsl:when test="contains($visning, 'facs')">
    <xsl:if test="not(attribute::n='a')">
        <xsl:element name="BR"></xsl:element>
            <!-- <xsl:element name="IMG">
            <xsl:attribute name="src">http://gandalf.hit.uib.no/~vemund/menota/columnbreak.gif</xsl:attribute>
            </xsl:element> -->
            <xsl:text>&#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7; &#x00B7;</xsl:text>
    </xsl:if>
    </xsl:when>
    
<!-- In dipl, column break is displayed inline with column identifier (a,b,...) within single vertical lines. -->

          <xsl:when test="contains($visning, 'dipl')">	
    <xsl:if test="not(attribute::n='a')">

<xsl:text>
&nbsp;&#x007C;&nbsp;col.&nbsp;
</xsl:text>
                    <xsl:value-of select="attribute::n"/>
<xsl:text>
&nbsp;&#x007C;&nbsp;
</xsl:text>
</xsl:if>
</xsl:when>

<!-- In other levels (e.g. norm) no column identifier is displayed. -->

<xsl:otherwise>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<!-- The display of line breaks also depends on the text level. The value of the global parameter "visning" is used to control how line breaks are formatted. -->
<!-- In facs, line break is displayed with line breaks (i.e. as physical lines) and, if encoded, with line numbers in left margin. -->

<xsl:template match="//lb">
 
 <xsl:choose>
    <xsl:when test="contains($visning, 'facs')">
    <xsl:choose>
    <xsl:when test="attribute::n">
    
    	<xsl:element name="BR"></xsl:element>
        <xsl:element name="SPAN">
        <xsl:attribute name="class">linecount</xsl:attribute>
        
<!-- This if test decides that only every 3rd line number is going to be displayed, starting with line number 1, i.e. 1, 4, 7, 10, etc. -->

        <xsl:if test="attribute::n mod 3 = 0 +1">
            <xsl:value-of select="attribute::n"/>
        </xsl:if>
        
<!-- This if test supresses line numbers that are not going to be displayed, but generates a no-breaking space, so that text lines are displayed with the same margin. -->

        <xsl:if test="not(attribute::n mod 3 = 0 +1)">
            <xsl:text>&#xA0;</xsl:text>
<!--            <xsl:element name="SPAN">
            <xsl:attribute name="style">color: #FFFFFF; bgcolor: #FFFFFF;</xsl:attribute>
                <xsl:text>lb</xsl:text>
            </xsl:element>-->
        </xsl:if>
        
<!-- If you want all line numbers displayed, add the following "xsl:value-of test" to the style sheet, and comment out the two preceding if tests: -->
<!-- <xsl:value-of test="attribute::n"/> -->

        </xsl:element>
        </xsl:when>
        
<!-- The "otherwise" condition specifies that if line numbers are not encoded in the XML file, lines will be displayed with the same kind of formatting (hanging indents) as above, but with no line numbers. -->

        <xsl:otherwise>
        <xsl:element name="SPAN">
        <xsl:attribute name="class">linecount</xsl:attribute>
                    <xsl:text>&nbsp;</xsl:text>
		</xsl:element>
		</xsl:otherwise>
		</xsl:choose>
    </xsl:when>
    
<!-- In dipl, line break is displayed inline with page number within single vertical lines if attribute n is present. If not, only a single vertical line is displayed. In both cases, a nobreaking space is displayed on either side, if the line break is contained within a word element, i.e. when words are divided over two lines. If the line break occurs outside the word element, no space will be added. -->

<xsl:when test="contains($visning, 'dipl')">
    <xsl:if test="not(parent::w) or not(parent::facs) or not(parent::dipl) or not(parent::norm)">
        <xsl:text>&nbsp;</xsl:text>
    </xsl:if>
   <!-- <xsl:choose>
    <xsl:when test="attribute::n">

<xsl:text>
&#x007C;&nbsp;
</xsl:text>
                    <xsl:value-of select="attribute::n"/>
<xsl:text>
&nbsp;&#x007C;
</xsl:text>
    </xsl:when>-->
    
   
<!-- The "otherwise" condition specifies that if line numbers are not encoded in the XML file, lines will be displayed with the same kind of formatting (hanging indents) as above, but with no line numbers. -->

        <!--<xsl:otherwise>
        <xsl:text>
&#x007C;
</xsl:text>
		</xsl:otherwise>
		</xsl:choose>--><xsl:if test="not(parent::w) or not(parent::facs) or not(parent::dipl) or not(parent::norm)">
        <xsl:text>&nbsp;</xsl:text>
    </xsl:if>
    </xsl:when>
    
<!-- In other levels (e.g. norm) no linebreak is displayed. -->    
    
<xsl:otherwise>
 </xsl:otherwise>   
    </xsl:choose>
    
</xsl:template>


<!-- Template for headings -->

<!-- This template specifies that in a facs rendering, the head is displayed inline. In other renderings (such as dipl and norm) the head is displayed as a block element. -->

<xsl:template match="//head">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="DIV">
                <xsl:if test="parent::div/attribute::type='work'">
                    <xsl:attribute name="class">divwork</xsl:attribute>
                </xsl:if>
                <xsl:if test="parent::div/attribute::type='chapter'">
                    <xsl:attribute name="class">divchapter</xsl:attribute>
                </xsl:if>
                    <xsl:apply-templates/>
            </xsl:element>        
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- Templates for displaying the text itself -->

<!-- This template refers to the body element, but does not have any formatting associated with it. -->

<xsl:template match="//body">
    <xsl:apply-templates/>
</xsl:template>

<!-- This template specifies the width of the text blocks. In facs, the block is 650 px wide; in other renderings (such as dipl or norm) there are no specification for the width.-->

<xsl:template match="//div">
    <xsl:choose>
        <xsl:when test="attribute::type='work'">
            <xsl:element name="DIV">
            <xsl:attribute name="style">margin-left: 10px</xsl:attribute>
            <xsl:if test="contains($visning, 'facs')">
            <xsl:attribute name="style">width: 650px</xsl:attribute>
            </xsl:if>
                <xsl:apply-templates/>
            </xsl:element>        
        </xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="contains($visning, 'facs')">
                    <xsl:apply-templates/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:element name="DIV">
                        <xsl:apply-templates/>
                    </xsl:element>                
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template wraps the p elements in SPAN tags with an associated style class.-->

<xsl:template match="//p">
    <xsl:element name="SPAN">
    <xsl:attribute name="class">paragraph</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!-- This template specifies that in facs, line groups (typically stanzas) are displayed inline. In other renderings (such as dipl and norm), the lg elements are wrapped in DIV tags with an associated style class. If line groups (stanzas) have been numbered by the encoder, these numbers will be displayed in the top left corner of the line group. -->

<xsl:template match="//lg">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="DIV">
                <xsl:attribute name="class">linegroup</xsl:attribute>
               <xsl:if test="attribute::n">
               <xsl:element name="SPAN">
               <xsl:attribute name="STYLE">float: left</xsl:attribute>
               <xsl:value-of select="attribute::n"/>
               </xsl:element>
               </xsl:if>
               <xsl:apply-templates/>
            </xsl:element>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template does not affect facs display. In other renderings (such as dipl and norm), lines are numbered automatically within each lg element.-->

<xsl:template match="//l">
<xsl:variable name="lgline">
    <xsl:number level="any" from="lg"/>
</xsl:variable>
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="BR"></xsl:element>
            <xsl:element name="SPAN">
            <xsl:attribute name="class">lglines</xsl:attribute>
                <xsl:value-of select="$lgline"/>
            </xsl:element>
                <xsl:apply-templates/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template refers to the word element, but does not have any formatting associated with it. -->
<!-- Since spaces inside p elements are stripped from the file (see general comment at the start of the stylesheet), a function has been created within this template to generate spaces after individual words, but not before punctuation marks. -->    

<xsl:template match="//w">
    <xsl:choose>
        <xsl:when test="preceding-sibling::*[1][self::punct] or preceding-sibling::*[1][self::supplied] or preceding-sibling::*[1][self::quote]">
            <xsl:text>&nbsp;</xsl:text>        
        </xsl:when>
        <xsl:when test="contains($visning, 'norm') and preceding-sibling::*[1][self::lb] and not(descendant::expunged)">
            <xsl:text>&nbsp;</xsl:text> 
        </xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="not(preceding-sibling::*[1]) and ancestor::caption">
                    <xsl:text>&nbsp;</xsl:text> 
                </xsl:when>
                <xsl:when test="not(preceding-sibling::*[1]) and ancestor::quote">
                    <xsl:text>&nbsp;</xsl:text> 
                </xsl:when>                
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>    
    <xsl:apply-templates/>
    <xsl:choose>
        <xsl:when test="following-sibling::*[1][self::punct]"></xsl:when>
        <xsl:when test="not(following-sibling::*[1])"></xsl:when>        
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="following-sibling::*[1][self::w][descendant::expunged] and contains($visning, 'norm')"></xsl:when>
                <xsl:when test="not(following-sibling::*[1][self::w]) and following-sibling::*[2][self::w][descendant::expunged] and contains($visning, 'norm')"></xsl:when>
                <xsl:otherwise>
                    <xsl:text>&nbsp;</xsl:text>                        
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- The following three templates specify the display of the three main text levels, facs, dipl and norm.  -->
<!-- If the parameter "visning" contains the value "facs" the contents of the facs elements are output; otherwise the facs elements are suppressed.  -->

<xsl:template match="//facs">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- If the parameter "visning" contains the value "dipl" the contents of the dipl elements are output; otherwise the dipl elements are suppressed.  -->
<!-- If the dipl element contains the attribute corr, the contents of this attribute are displayed in stead of the element contents.  -->
<!-- If the type-attribute has the value 'out-of-place', the contents of the dipl-element are suppressed -->

<xsl:template match="//dipl">
    <xsl:choose>
        <xsl:when test="contains($visning, 'dipl')">
            <xsl:choose>
                <xsl:when test="attribute::corr">
                    <xsl:value-of select="attribute::corr" disable-output-escaping="yes"/>
                </xsl:when>
                <xsl:when test="attribute::type='out-of-place'"></xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- If the parameter "visning" contains the value "norm" the contents of the norm elements are output; otherwise the norm elements are suppressed.  -->
<!-- If the norm element contains the attribute corr, the contents of this attribute are displayed in stead of the element contents.  -->
<!-- If the type-attribute has the value 'out-of-place', the contents of the norm-element are suppressed -->

<xsl:template match="//norm">
    <xsl:choose>
        <xsl:when test="contains($visning, 'norm')">
            <xsl:choose>
                <xsl:when test="attribute::corr">
                    <xsl:value-of select="attribute::corr" disable-output-escaping="yes"/>
                </xsl:when>
                <xsl:when test="attribute::type='out-of-place'"></xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- This template specifies the display of highlighted text.-->

<xsl:template match="//hi">
    <xsl:element name="SPAN">
    <xsl:attribute name="style">color: #FF0000<xsl:if test="attribute::rend='stor_minuskel'">; font-size: 120%</xsl:if></xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>


<!-- This template specifies the display of text in the expan element. The actual style (typically italic) is specified in the accompanying CSS style sheet. -->

<xsl:template match="//expan">
    <xsl:element name="SPAN">
    <xsl:attribute name="class">expan</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>


<!-- This template specifies the display of text in the add element. If the value of the attribute type is supralinear the text is shown within upper slanted strokes. Otherwise added text is shown within lower slanted strokes. -->

<xsl:template match="//add">
    <xsl:choose>
        <xsl:when test="attribute::type='supralinear'">
            <xsl:text>&#xF16E;</xsl:text>
                <xsl:apply-templates/>
                        <xsl:text>&#xF16F;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>&#xF1D6;</xsl:text>
                <xsl:apply-templates/>
                        <xsl:text>&#xF1D7;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
    </xsl:template>

<!-- This template specifies the display of text in the del element. If the value of the attribute rend is overstrike the text is shown with a line through. Otherwise deleted text are shown within |- and -|. -->

<xsl:template match="//del">
    <xsl:choose>
        <xsl:when test="attribute::rend='overstrike'">
            <xsl:text>|-</xsl:text>
            <xsl:element name="SPAN">
            <xsl:attribute name="style">text-decoration: line-through</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
            <xsl:text>-|</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>|-</xsl:text>
                <xsl:apply-templates/>
            <xsl:text>-|</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template specifies the display of text in the emph element. The actual style (typically bold) is specified in the accompanying CSS style sheet. The emph element is not used in the Menota handbook v. 1.0. -->

<xsl:template match="//emph">
    <xsl:element name="SPAN">
    <xsl:attribute name="class">emph</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!-- This template specifies the display of text in the seg element. Text in this element does not receive any special formatting. Cf. The Menota handbook v. 1.0 ch. 6.4.6. -->

<xsl:template match="//seg">
    <xsl:choose>
        <xsl:when test="attribute::type='ligature'">
                <xsl:apply-templates/>
           
        </xsl:when>
        <xsl:otherwise>
                <xsl:apply-templates/>
                  
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>


<!-- This template specifies the display of text in the supplied element. The present solution depends on attributes, but may be changed in the near future. -->
<!-- If the type-attribute has the value 'head', the contents of the element are displayed as a block heading with slightly more space above than below -->    
<!-- If the type-attribute has the value 'start', or there is no type-attribute present, the contents are displayed inline - but surrounded by brackets -->
    
<xsl:template match="//supplied">
<xsl:choose>
        <xsl:when test="contains($visning, 'facs')">
        </xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="attribute::type='head'">
                    <xsl:element name="DIV">
                    <xsl:attribute name="style">margin-top: 15px; margin-bottom: 10px;</xsl:attribute>
                        <xsl:if test="attribute::type='start' or not(attribute::type)"> <xsl:text>&#x27E8;</xsl:text></xsl:if>
                        <xsl:element name="SPAN">
                        <xsl:attribute name="class">supplied</xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                        <xsl:if test="attribute::type='end' or not(attribute::type)"> <xsl:text>&#x27E9;</xsl:text></xsl:if>                        
                    </xsl:element>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="attribute::type='start' or not(attribute::type)"> <xsl:text>&#x27E8;</xsl:text></xsl:if>
                    <xsl:element name="SPAN">
                    <xsl:attribute name="class">supplied</xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                    <xsl:if test="attribute::type='end' or not(attribute::type)"> <xsl:text>&#x27E9;</xsl:text></xsl:if>                
                </xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose> 
</xsl:template>

<!-- This template specifies that text in the unclear element is displayed with dotted underline, except in norm - where it is show without any specific style. -->

<xsl:template match="//unclear">
    <xsl:choose>
        <xsl:when test="preceding-sibling::*[1][self::punct]">
            <xsl:text>&nbsp;</xsl:text>        
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>    
    <xsl:choose>
        <xsl:when test="contains($visning, 'norm')">
            <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="SPAN">
            <xsl:attribute name="style">border-width: thin; border-bottom-style: dotted; padding: 0px; margin: 0px;</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>        
        </xsl:otherwise>
    </xsl:choose>
    <xsl:choose>
        <xsl:when test="ancestor::w"></xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="following-sibling::*[1][self::punct]"></xsl:when>
                <xsl:otherwise>
                    <xsl:text>&nbsp;</xsl:text>        
                </xsl:otherwise>                
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>        
</xsl:template>


<!-- Templates for displaying the apparatus -->

<!-- This template refers to the way notes are displayed in the running text. Notes are counted from the top of the document and displayed as superscript numbers that are linked to footnotes. -->

<xsl:template match="//note">
<xsl:param name="note">
    <xsl:number from="/text" level="any"/>
</xsl:param>
    <xsl:element name="A">
    <xsl:attribute name="name">in<xsl:value-of select="$note"/></xsl:attribute>
    </xsl:element>
    <xsl:element name="A">
    <xsl:attribute name="href">#off<xsl:value-of select="$note"/></xsl:attribute>
    <xsl:attribute name="class">note</xsl:attribute>
        <xsl:value-of select="$note"/>
    </xsl:element>
</xsl:template>

<!-- This template specifies the formatting of the foot notes. Foot notes are located at the bottom of the page; in HTML this means that there is no distinction between foot notes and end notes. -->

<xsl:template match="//note" mode="footer">
<xsl:param name="foot">
    <xsl:number from="/text" level="any"/>
</xsl:param>
    <xsl:element name="BR"></xsl:element>
    <xsl:element name="A">
    <xsl:attribute name="name">off<xsl:value-of select="$foot"/></xsl:attribute>
    </xsl:element>
    <xsl:element name="A">
    <xsl:attribute name="href">#in<xsl:value-of select="$foot"/></xsl:attribute>
    <xsl:attribute name="class">foot</xsl:attribute>
        <xsl:value-of select="$foot"/>
    </xsl:element>
    <xsl:element name="SPAN">
    <xsl:attribute name="class">footnote</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!-- This template specifies how quotation marks should be displayed. The actual type of marks are specified with entity references within the xsl:text element. Note that nbsp entites are only used for spacing purposes. -->    
    
<xsl:template match="//q">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs') or contains($visning, 'dipl')">
            <xsl:choose>
                <xsl:when test="preceding-sibling::*[1][self::punct]">
                    <xsl:text>&nbsp;</xsl:text>
                </xsl:when>
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="attribute::type='start'">
                    <xsl:choose>
                        <xsl:when test="attribute::rend='single'">
                            <xsl:text>&nbsp;&lsquo;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>&nbsp;&ldquo;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="attribute::type='end'">
                    <xsl:choose>
                        <xsl:when test="attribute::rend='single'">
                            <xsl:text>&rsquo;&nbsp;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>&rdquo;&nbsp;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>                
                </xsl:when> 
                <xsl:otherwise></xsl:otherwise>
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template makes sure that quotes are displayed in italics in the normalized version of the text -->    
    
<xsl:template match="//quote">
    <xsl:choose>
        <xsl:when test="contains($visning, 'norm')">
            <xsl:element name="SPAN">
            <xsl:attribute name="style">font-style: italic;</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>    
    
<xsl:template match="//expunged">
    <xsl:choose>
        <xsl:when test="contains($visning, 'dipl')">
            <xsl:text>{</xsl:text>
                <xsl:apply-templates/>
            <xsl:text>}</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:apply-templates/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>    
    
</xsl:stylesheet>