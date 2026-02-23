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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:me="http://www.menota.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">
    <!-- This style sheet was adjusted by Beeke Stegmann (May 2017). It is based on the Menota style sheets but was changed according to the specific needs and wishes of OEH.-->    
    
<xsl:output method="html" doctype-public="-//W3C/DTD XHTML 1.0 STRICT//EN" doctype-system="http:://www.w3.org/TR/xhtml1-strict.dtd" encoding="ASCII"></xsl:output>

<!--<xsl:param name="visning"/>-->
<!-- The xsl:strip-space element is used to prevent superflous spaces in the xml encoding from being displayed in the output HTML file -->    
<!-- Since necessary spaces are stripped from the file, some of the templates below contain functions that add spaces in relevant places (see templates for w, punct, unclear and supplied) -->    
<xsl:strip-space elements="*"/>


<!-- This global parameter below is used to decide which of the three text-levels is displayed, i.e the facsimile level, the diplomatic level or the normalised level. See the Menota handbook v. 1.1, ch. 3 for further details on these levels.The parameter has three values: 'facs', 'dipl' and 'norm'. -->
    
    <!-- Due to problems with parametres in Oxygen, we have inserted an extra select attribute in the parametre. For facs display, the value has to be 'facs' and for dipl display the value has to be 'dipl'. -->
    <!--<xsl:param name="visning" select="'dipl'"/>-->
  <xsl:param name="visning" select="'facs'"/>
    <!--   <xsl:param name="visning" select="'norm'"/>-->
    
    
<!-- This template writes the entire document into an HTML page -->

<xsl:template match="/">
    <xsl:element name="HTML">
        <xsl:element name="HEAD">
            <xsl:element name="TITLE">
                <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
            </xsl:element>
            <xsl:element name="META">
            <xsl:attribute name="http-equiv">Expires</xsl:attribute>
            <xsl:attribute name="content">0</xsl:attribute>
            </xsl:element>
            
<!-- This is a complete CSS definition for Menota styles, included in the present XSLT style sheet. Thus it is possible to use this style sheet off line. -->          
<!-- We recommend using MUFI compliant fonts, which are listed in a prefential sequence as values for the font-framily. These fonts are available from http://www.hit.uib.no/mufi/fonts.html -->


            <xsl:element name="STYLE">
            <xsl:attribute name="type">text/css</xsl:attribute>
                BODY {
                line-height: 200%;
                }
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
                .head1			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
			                font-weight:	normal;
			                font-size:	28pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
      .head			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
			                font-weight:	normal;
			                font-size:	28pt;
			                color:		Red;
			                text-align:	left;
			                margin-bottom:  10px;}
			                .head2			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
			                font-weight:	normal;
			                font-size:	24pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
			                .head3			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
			                font-weight:	normal;
			                font-size:	18pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
			                .head4			{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
		                	 font-weight:	normal;
			                font-size:	14pt;
			                color:		#0000FF;
			                text-align:	left;
			                margin-bottom:  10px;}
			                .divwork            {font-family:             'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                         font-size:                18pt;
                                                         font-weight:           normal;
                                                         color:                      #0000FF;
                                                         margin-top:           10px;
                                                         margin-bottom:    10px;
                                                         text-align:               left;}
                                                         .divchapter                       {font-family:             'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                         font-size:                16pt;
                                                         font-weight:            normal;
                                                         color:                       #0000FF;
                                                         margin-top:           20px;
                                                         margin-bottom:    10px;
                                                         text-align:                left;}
             .paragraph                    {font-family:            'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                         font-size:                14pt;
                                                         font-weight:           normal;
                                                         color:                      #000000;
                                                         line-height:            1.5em;}
             .linegroup                     {font-family:            'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
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
                                                         .expan                          {font-family:          'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
                                                         font-style:             italic;
                                                         font-weight:         normal;}


                .notecritical		{font-size:	80%;
			                color:		#0076AE}
                .noteplain		{font-size:	80%;
	                		 color:		#008080}
	                		 .supplied		{font-family: 	'Andron Mega Corpus', 'Andron Corpus', 'Andron Scriptor Web', 'Palemonas MUFI', 'Cardo', LeedsUni, Junicode, 'ALPHABETUM Unicode', serif;
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
            <xsl:for-each select="tei:TEI">
                <xsl:element name="BR"></xsl:element>
                <xsl:element name="BR"></xsl:element>
                
<!-- This apply-template writes the teiHeader into the top of the document -->         
                
                <xsl:apply-templates select="tei:teiHeader"/>
                <xsl:element name="HR"></xsl:element>
                
<!-- This apply-template writes the text itself into the document, after the header. --> 
         
                <xsl:apply-templates select="tei:text/*"/>
                <xsl:element name="HR"></xsl:element>
               

<!-- This apply-template writes the notes into the document as foot notes, after the text itself. -->  
                <xsl:if test="descendant::tei:note">
                    <xsl:element name="DIV">
                    <xsl:attribute name="style">font-family: Verdana; font-size: 12pt; text-align: left</xsl:attribute>
                        <xsl:text>Noter:</xsl:text>
                        <xsl:apply-templates select="//tei:note" mode="footer"/>
                    </xsl:element>
                    <xsl:element name="BR"></xsl:element>
                </xsl:if>
            </xsl:for-each>
        </xsl:element>
    </xsl:element>
</xsl:template>


<!-- The following templates format the TEI Header, i.e. it decides which part(s) of the header that is going to be displayed (i.e. title from titleStmt)  or suppressed (i.e. publicationStmt from fileDesc). -->

<!-- Note that if a top element is suppressed, the descendent elements will also be suppressed. -->
    
    <xsl:template match="tei:fileDesc/tei:titleStmt">
        <xsl:apply-templates select="child::tei:title"/>
        <xsl:apply-templates select="child::tei:respStmt"/>
</xsl:template>    

    <xsl:template match="tei:fileDesc/tei:titleStmt/tei:title">
    <xsl:element name="DIV">
    <xsl:attribute name="class">head2</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

    <xsl:template match="tei:fileDesc/tei:titleStmt/tei:respStmt">
    <xsl:element name="DIV">
    <xsl:attribute name="class">paragraph</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

    <xsl:template match="tei:fileDesc/tei:sourceDesc"/>    
    
    <xsl:template match="tei:fileDesc/tei:publicationStmt"/>

    <xsl:template match="tei:encodingDesc"/>

    <xsl:template match="tei:profileDesc"/>

    <xsl:template match="tei:revisionDesc"/>



<!-- Templates for common milestone-elements (pagebreaks, linebreaks and columnbreaks) -->

<xsl:template match="tei:pb">
    <xsl:variable name="currentpb">
        <xsl:value-of select="attribute::n"/>
    </xsl:variable>
    <xsl:variable name="previouspb">
        <xsl:value-of select="preceding::tei:pb[1]/attribute::n"/>
    </xsl:variable>
<!-- The display of page breaks depends on the text level. The value of the global parameter "visning" is used to control how page breaks are formatted. -->
<!-- In facs, page break is displayed with page number and a line separator. -->
    
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">	
        <xsl:if test="preceding::tei:add[attribute::place='margin-bottom'][preceding::tei:pb[1][attribute::n=$previouspb]]">
            <xsl:element name="TABLE">
                <xsl:attribute name="border">0</xsl:attribute>
                <xsl:attribute name="width">650px</xsl:attribute>
                <xsl:element name="TR">
                    <xsl:element name="TD">
                        <xsl:attribute name="width">135</xsl:attribute>
                        <xsl:text>&#xA0;</xsl:text>
                    </xsl:element>
                    <xsl:element name="TD">
                        <xsl:attribute name="width">600px</xsl:attribute>
                        <xsl:for-each select="preceding::tei:add[attribute::place='margin-bottom'][preceding::tei:pb[1][attribute::n=$previouspb]]">
                            <xsl:apply-templates select="self::tei:add" mode="margin"/>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:if>
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
            
                <xsl:text>&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;&#x2014;</xsl:text>
            </xsl:element>
        </xsl:element>
    </xsl:element>
        <xsl:if test="following::tei:add[attribute::place='margin-top'][preceding::tei:pb[1][attribute::n=$currentpb]]">
            <xsl:element name="TABLE">
                <xsl:attribute name="border">0</xsl:attribute>
                <xsl:attribute name="width">650px</xsl:attribute>
                <xsl:element name="TR">
                    <xsl:element name="TD">
                        <xsl:attribute name="width">135</xsl:attribute>
                        <xsl:text>&#xA0;</xsl:text>
                    </xsl:element>
                    <xsl:element name="TD">
                        <xsl:attribute name="width">600px</xsl:attribute>
                        <xsl:for-each select="following::tei:add[attribute::place='margin-top'][preceding::tei:pb[1][attribute::n=$currentpb]]">
                            <xsl:apply-templates select="self::tei:add" mode="margin"/>
                        </xsl:for-each>
                    </xsl:element>
                </xsl:element>
            </xsl:element>
        </xsl:if>    
        
    </xsl:when>
   
<!-- In dipl, page break is displayed inline with page number within double vertical lines. -->

        <xsl:when test="contains($visning, 'facs')">	
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
    <xsl:if test="preceding::tei:add[attribute::type='external'][attribute::place='margin-bottom'][preceding::tei:pb[1][attribute::n=$previouspb]]">
        <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="width">650px</xsl:attribute>
            <xsl:element name="TR">
                <xsl:element name="TD">
                    <xsl:attribute name="width">135</xsl:attribute>
                    <xsl:text>&#xA0;</xsl:text>
                </xsl:element>
                <xsl:element name="TD">
                    <xsl:attribute name="width">600px</xsl:attribute>
                    <xsl:for-each select="preceding::tei:add[attribute::type='external'][attribute::place='margin-bottom'][preceding::tei:pb[1][attribute::n=$previouspb]]">
                        <xsl:apply-templates select="self::tei:add" mode="margin"/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:if>
    <xsl:if test="following::tei:add[attribute::type='external'][attribute::place='margin-top'][preceding::tei:pb[1][attribute::n=$currentpb]]">
        <xsl:element name="TABLE">
            <xsl:attribute name="border">0</xsl:attribute>
            <xsl:attribute name="width">650px</xsl:attribute>
            <xsl:element name="TR">
                <xsl:element name="TD">
                    <xsl:attribute name="width">135</xsl:attribute>
                    <xsl:text>&#xA0;</xsl:text>
                </xsl:element>
                <xsl:element name="TD">
                    <xsl:attribute name="width">600px</xsl:attribute>
                    <xsl:for-each select="following::tei:add[attribute::type='external'][attribute::place='margin-top'][preceding::tei:pb[1][attribute::n=$currentpb]]">
                        <xsl:apply-templates select="self::tei:add" mode="margin"/>
                    </xsl:for-each>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:if>
</xsl:otherwise>
  </xsl:choose>

</xsl:template>

<!-- The display of column breaks also depends on the text level. The value of the global parameter "visning" is used to control how column breaks are formatted. -->
<!-- In facs, column break is displayed with a dotted line separator. -->

<xsl:template match="tei:cb">
<xsl:choose>
    <xsl:when test="contains($visning, 'facs')">
    <xsl:if test="not(attribute::n='a')">
        <xsl:element name="BR"></xsl:element>
          
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

<xsl:template match="tei:lb"> 
    
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs') and not(attribute::n)">
            <xsl:element name="SPAN">
                <xsl:attribute name="class">linecount</xsl:attribute>
                <xsl:text>&nbsp;</xsl:text>
            </xsl:element>
        </xsl:when>
        <xsl:otherwise>
    
    <xsl:variable name="line">
     <xsl:value-of select="attribute::n"/>
 </xsl:variable>
 <xsl:variable name="nextline">
     <xsl:value-of select="$line+1"/>
 </xsl:variable>
 <xsl:variable name="linegroup">
     <xsl:value-of select="ancestor::tei:lg/attribute::xml:id"/>
 </xsl:variable>
    <xsl:variable name="preceding-pb" select="preceding::tei:pb[1]/attribute::n"/> 
    <xsl:variable name="preceding-cb" select="preceding::tei:cb[1]/attribute::n"/> 
 <xsl:choose>
     
    
     <!-- if the display is facs then these extra rules apply --> 
     <xsl:when test="contains($visning, 'facs')"> 
    <xsl:choose>
          <xsl:when test="attribute::n and not(attribute::rend > 1)"> 
       <xsl:element name="BR"></xsl:element>
        <xsl:element name="SPAN">
            <xsl:attribute name="style">width: 100px; float: left;</xsl:attribute>
            <xsl:choose>
                <xsl:when test="following::tei:add[1][attribute::place='margin-left'][following::tei:lb[1][attribute::n=$nextline]]">
                    <xsl:apply-templates select="following::tei:add[1][attribute::place='margin-left'][following::tei:lb[1][attribute::n=$nextline]]" mode="margin"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>&#xA0;</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:element>
        <xsl:element name="SPAN">
        <xsl:attribute name="class">linecount</xsl:attribute>
        
<!-- This test decides that only every 3rd line number is going to be displayed, starting with line number 1, i.e. 1, 4, 7, 10, etc. -->

        <xsl:if test="attribute::n mod 3 = 0 +1">
            <xsl:value-of select="attribute::n"/>
        </xsl:if>
        
<!-- This test supresses line numbers that are not going to be displayed, but generates a no-breaking space, so that text lines are displayed with the same margin. -->

        <xsl:if test="not(attribute::n mod 3 = 0 +1)">
            <xsl:text>&#xA0;</xsl:text>

        </xsl:if>
        
<!-- If you want all line numbers displayed, add the following "xsl:value-of test" to the style sheet, and comment out the two preceding if tests: -->

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
	<xsl:if test="not(ancestor::tei:w)">
        <xsl:text>&nbsp;</xsl:text>
    </xsl:if>
    </xsl:when>
    
<!-- In other levels (e.g. norm) no linebreak is displayed. -->    
    
<xsl:otherwise>
 </xsl:otherwise>   
    </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>
    
</xsl:template>



<!-- Template for headings -->
    

<!-- This template specifies that in a facs rendering, the head is displayed inline (and in red). 
        In other renderings (such as dipl and norm) the head is displayed as a block element. -->

<xsl:template match="tei:head">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs')">  
           
            <xsl:choose>  
                <xsl:when test="preceding::tei:lb[1][attribute::rend]"><xsl:apply-templates/>
                </xsl:when>
               
                               <xsl:otherwise>
                  <xsl:element name="SPAN">
                       <xsl:attribute name="style">
                           <xsl:text>display: inline; </xsl:text>
                           <xsl:text>color: red;</xsl:text>
                       </xsl:attribute>
                       <xsl:apply-templates/>
                  </xsl:element>
                
            </xsl:otherwise>
            </xsl:choose> 
            
        </xsl:when>
        <xsl:otherwise>
            <xsl:element name="DIV">
                <xsl:if test="parent::tei:div/attribute::type='work'">
                    <xsl:attribute name="class">divwork</xsl:attribute>
                </xsl:if>
                <xsl:if test="parent::tei:div/attribute::type='chapter'">
                    <xsl:attribute name="class">divchapter</xsl:attribute>
                </xsl:if>
                    <xsl:apply-templates/>
            </xsl:element>        
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
    
    <!-- new by BS: display headers in reorganised lines in red -->
    <xsl:template match="tei:head" mode="rend">
        <xsl:element name="SPAN">
            <xsl:attribute name="style">
                <xsl:text>display: inline;</xsl:text>
                <xsl:text> color: red;</xsl:text>
            </xsl:attribute>
            <xsl:apply-templates mode="rend"/>
        </xsl:element>
    </xsl:template>


<!-- Templates for displaying the text itself -->

<!-- This template refers to the body element, but does not have any formatting associated with it. -->

<xsl:template match="tei:body">
    <xsl:apply-templates/>
</xsl:template>

<!-- This template specifies the width of the text blocks. In facs, the block is 650 px wide; in other renderings (such as dipl or norm) there are no specification for the width.-->

<xsl:template match="tei:div">
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

<xsl:template match="tei:p">
    <xsl:element name="SPAN">
    <xsl:attribute name="class">paragraph</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>
    

<!-- This template specifies that in facs, line groups (typically stanzas) are displayed inline. In other renderings (such as dipl and norm), the lg elements are wrapped in DIV tags with an associated style class. If line groups (stanzas) have been numbered by the encoder, these numbers will be displayed in the top left corner of the line group. -->

<xsl:template match="tei:lg">
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

<xsl:template match="tei:l">
<xsl:variable name="lgline">
    <xsl:number level="any" from="tei:lg"/>
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

    <xsl:template match="tei:w | tei:num | tei:name | tei:persName | tei:orgName">
         
        <xsl:choose> 
            
            <xsl:when test="contains($visning, 'facs')"> 
           <xsl:apply-templates/>
            </xsl:when> 
            
            <xsl:otherwise> 
            <xsl:choose>
            <xsl:when test="preceding-sibling::*[1][self::me:punct/ancestor::place='rightlocation']">
                </xsl:when>
                <xsl:when test="preceding-sibling::*[1][self::tei:pc/ancestor::place='rightlocation']">
                    <!-- If it is a punct with rigth localation, do not add a space. -->
                </xsl:when>
            <xsl:when test="preceding-sibling::*[1][self::me:punct] or preceding-sibling::*[1][self::tei:supplied] or preceding-sibling::*[1][self::tei:quote] or preceding-sibling::*[1][self::tei:add]">
                <xsl:text>&nbsp;</xsl:text>        
            </xsl:when>
                <xsl:when test="preceding-sibling::*[1][self::tei:pc] or preceding-sibling::*[1][self::tei:supplied] or preceding-sibling::*[1][self::tei:quote] or preceding-sibling::*[1][self::tei:add]">
                    <xsl:text>&nbsp;</xsl:text>        
                </xsl:when>
            <xsl:when test="contains($visning, 'norm') and preceding-sibling::*[1][self::tei:lb] and not(descendant::me:expunged)">
                <xsl:text>&nbsp;</xsl:text> 
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="not(preceding-sibling::*[1]) and ancestor::tei:caption">
                        <xsl:text>&nbsp;</xsl:text> 
                    </xsl:when>
                    <xsl:when test="not(preceding-sibling::*[1]) and ancestor::tei:quote">
                        <xsl:text>&nbsp;</xsl:text> 
                    </xsl:when>                
                    <xsl:otherwise></xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>    
        <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
        
         <xsl:choose>
            <xsl:when test="following-sibling::*[1][self::me:punct]"></xsl:when>
            <xsl:when test="following-sibling::*[1][self::tei:pc]"></xsl:when>
            <xsl:when test="following-sibling::*[1][self::tei:anchor[attribute::type='supplied' or attribute::type='seg']] and not(following-sibling::*[2])"></xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="following-sibling::*[1][self::tei:w][descendant::me:expunged] and contains($visning, 'norm')"></xsl:when>
                    <xsl:when test="following-sibling::*[1][self::tei:w] and ancestor::tei:seg[attribute::type='enc']"></xsl:when>
                    <xsl:when test="following-sibling::*[1][self::tei:w] and ancestor::tei:seg[attribute::type='nb'] and not(contains($visning, 'norm'))"></xsl:when> 
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[2][self::tei:w][descendant::me:expunged] and contains($visning, 'norm')"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::me:punct]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::tei:pc]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::node()[following-sibling::*[1][self::tei:anchor[attribute::type='supplied']]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:supplied[following-sibling::*[1][self::tei:w]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:supplied[not(following-sibling::*[1])]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:add[following-sibling::*[1][self::tei:w]]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[1][self::tei:anchor] and following-sibling::*[2][self::me:punct]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and following-sibling::*[1][self::tei:anchor] and following-sibling::*[2][self::tei:pc]"></xsl:when>
                    <xsl:otherwise>
                        <xsl:text>&nbsp;</xsl:text>                    
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    

	<!-- Allways add a space after a punct-element, unless it is a right location punct, when the space should be before the punct.  -->
    <xsl:template match="me:punct | tei:pc | punct">  
        <xsl:choose>
            <xsl:when test="attribute::rend='rightlocation'">
                <xsl:text>&nbsp;</xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
                <xsl:choose>
                    <xsl:when test="following-sibling::*[1][self::tei:anchor]"></xsl:when>
                    <xsl:when test="not(following-sibling::*[1][self::tei:w]) and parent::tei:supplied"></xsl:when>
                    <xsl:otherwise><xsl:text>&nbsp;</xsl:text></xsl:otherwise>
                </xsl:choose>
           </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
	

<!-- The following three templates specify the display of the three main text levels, facs, dipl and norm.  -->
<!-- If the parameter "visning" contains the value "facs" the contents of the facs elements are output; otherwise the facs elements are suppressed.  -->

	<xsl:template match="tei:facs | facs | me:facs">
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

<xsl:template match="tei:dipl | dipl | me:dipl">
    
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

	<xsl:template match="tei:norm | norm | me:norm">
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
    
     <xsl:template match="tei:m"/>


<!-- This template specifies the display of highlighted text.-->

<xsl:template match="tei:hi">
    <xsl:element name="SPAN">
    <xsl:attribute name="style">color: #FF0000<xsl:if test="attribute::rend='stor_minuskel'">; font-size: 120%</xsl:if></xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>


<!-- This template specifies the display of text in the expan element. The actual style (typically italic) is specified in the accompanying CSS style sheet. -->

<!-- HB 2014.03.25 removed  | tei:am from the line below -->
    
    <xsl:template match="tei:expan | tei:ex">
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')">
			<xsl:element name="SPAN">
				<xsl:attribute name="class">expan</xsl:attribute>
				<xsl:apply-templates/>
			</xsl:element></xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- This template specifies the display of text in the add element. If the value of the attribute type is supralinear the text is shown within upper slanted strokes. Otherwise added text is shown within lower slanted strokes. -->

    <xsl:template match="tei:add">
        <xsl:variable name="supra">
            <xsl:number count="tei:add[contains(attribute::place, 'supra')][not(ancestor::me:dipl or ancestor::me:norm)]" from="/" level="any"/>
        </xsl:variable>
        <xsl:choose>
          
            <xsl:when test="attribute::place='inline'">
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:when test="attribute::place='supralinear'">
                <xsl:choose>
                    <xsl:when test="contains($visning, 'facs')">
                        <xsl:element name="SUP">
                            <xsl:attribute name="style">line-height: 0.1em;</xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="contains($visning, 'dipl')">
                        <xsl:element name="SUP">
                            <xsl:attribute name="style">line-height: 0.1em;</xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="attribute::place='infralinear'">
                <xsl:choose>
                    <xsl:when test="contains($visning, 'facs')">
                        <xsl:element name="SUB">
                            <xsl:attribute name="style">line-height: 0.1em;</xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:when test="contains($visning, 'dipl')">
                        <xsl:element name="SUB">
                            <xsl:attribute name="style">line-height: 0.1em;</xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:apply-templates/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="contains(attribute::place, 'margin')">
                <xsl:variable name="marginal">
                    <xsl:number count="tei:add[contains(attribute::place, 'margin')]" from="/" level="any"/>
                </xsl:variable>
                <!-- Start test av margin, mai 2009-->
                <xsl:choose>
                    <xsl:when test="contains($visning, 'facs')">
                        <xsl:choose>
                         
                            <xsl:when test="attribute::place='margin-top'"></xsl:when>
                            <xsl:when test="attribute::place='margin-bottom'"></xsl:when>
                            <xsl:when test="attribute::place='margin-left'"></xsl:when>
                            <xsl:when test="attribute::place='margin-right'">
                              
                                <xsl:element name="DIV">
                                    <xsl:attribute name="style">display: inline; float: right; clear: none; width: 100px; font-size: 12pt; line-height: 135%</xsl:attribute>
                                  
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                            
                                <xsl:element name="SPAN">
                                    <xsl:attribute name="style">color: red;</xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:when test="contains($visning, 'dipl')">
                        <xsl:text>&#x2E0D;</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>&#x2E0C;</xsl:text>
                    </xsl:when>
                    <xsl:when test="contains($visning, 'norm')">
                        <xsl:choose>
                            <xsl:when test="attribute::type='external'">
                                <xsl:choose>
                                    <xsl:when test="attribute::place='margin-top'"></xsl:when>
                                    <xsl:when test="attribute::place='margin-bottom'"></xsl:when>
                                    <xsl:when test="attribute::place='margin-left'"></xsl:when>
                                    <xsl:when test="attribute::place='margin-right'">
                                        <xsl:element name="DIV">
                                            <xsl:attribute name="style">display: inline; float: right; clear: none; width: 100px; font-size: 12pt; line-height: 135%</xsl:attribute>
                                            <xsl:apply-templates/>
                                        </xsl:element>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:element name="SPAN">
                                            <xsl:attribute name="style">color: red;</xsl:attribute>
                                            <xsl:apply-templates/>
                                        </xsl:element>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:apply-templates/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                       
                        <xsl:text>&#x2E0D;</xsl:text>
                        <xsl:apply-templates/>
                        <xsl:text>&#x2E0C;</xsl:text>
                        
                    </xsl:otherwise>
                </xsl:choose>
               </xsl:when>
            <xsl:otherwise>
                <xsl:text>&#x2E0C;</xsl:text>
                <xsl:apply-templates/>
                <xsl:text>&#x2E0D;</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:add" mode="margin">
            <xsl:variable name="marginal">
                <xsl:number count="tei:add[contains(attribute::place, 'margin')]" from="/" level="any"/>
            </xsl:variable>
        <xsl:element name="SPAN">
            <xsl:attribute name="style">font-size: 12pt; line-height: 135%</xsl:attribute>
           
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="tei:add" mode="supra">
        <xsl:variable name="supra">
            <xsl:number count="tei:add[contains(attribute::place, 'supra')][not(ancestor::me:dipl or ancestor::me:norm)]" from="/" level="any"/>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')">
                <xsl:choose>
                    <xsl:when test="ancestor::me:dipl or ancestor::me:norm"></xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="DIV">
                            <xsl:attribute name="style">font-size: 10pt; line-height: 75%; display: inline; margin-left: 250px</xsl:attribute>
                           
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise></xsl:otherwise>
        </xsl:choose>
        

    </xsl:template>

<!-- This template specifies the display of text in the del element. If the value of the attribute rend is overstrike the text is shown with a line through. Otherwise deleted text are shown within |- and -|. -->

<xsl:template match="tei:del">
    <xsl:choose>
        <xsl:when test="attribute::rend='overstrike'">
            <xsl:text>&#xF1D9;</xsl:text>
            <xsl:element name="SPAN">
            <xsl:attribute name="style">text-decoration: line-through</xsl:attribute>
                <xsl:apply-templates/>
            </xsl:element>
            <xsl:text>&#xF1D8;</xsl:text>
        </xsl:when>
        <xsl:otherwise>
            <xsl:text>&#xF1D9;</xsl:text>
                <xsl:apply-templates/>
            <xsl:text>&#xF1D8;</xsl:text>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This template specifies the display of text in the emph element. The actual style (typically bold) is specified in the accompanying CSS style sheet. The emph element is not used in the Menota handbook v. 1.0. -->

<xsl:template match="tei:emph">
    <xsl:element name="SPAN">
    <xsl:attribute name="class">emph</xsl:attribute>
        <xsl:apply-templates/>
    </xsl:element>
</xsl:template>

<!-- This template specifies the display of text in the seg element. Text in this element does not receive any special formatting. Cf. The Menota handbook v. 1.0 ch. 6.4.6. -->

    <xsl:template match="tei:seg">  
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
    
    <xsl:template match="tei:supplied">
        <xsl:choose>
            <xsl:when test="contains($visning, 'facs')">
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="attribute::type='head'">
                        <xsl:element name="DIV">
                            <xsl:attribute name="style">margin-top: 15px; margin-bottom: 10px;</xsl:attribute>
                            <xsl:if test="attribute::type='start' or attribute::type='repetition' or not(attribute::type)"> <xsl:text>&#x27E8;</xsl:text></xsl:if>
                            <xsl:element name="SPAN">
                                <xsl:attribute name="class">supplied</xsl:attribute>
                                <xsl:apply-templates/>
                            </xsl:element>
                            <xsl:if test="attribute::type='end' or attribute::type='repetition' or not(attribute::type)"> <xsl:text>&#x27E9;</xsl:text></xsl:if>                        
                        </xsl:element>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:if test="attribute::type='start' or attribute::type='repetition' or not(attribute::type)"> <xsl:text>&#x27E8;</xsl:text></xsl:if>
                        <xsl:element name="SPAN">
                            <xsl:attribute name="class">supplied</xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                        <xsl:if test="attribute::type='end' or attribute::type='repetition' or not(attribute::type)"> <xsl:text>&#x27E9;</xsl:text></xsl:if>                
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose> 
    </xsl:template>

<!-- This template specifies that text in the unclear element is displayed with dotted underline, except in norm - where it is show without any specific style. -->

<xsl:template match="tei:unclear">
    <xsl:choose>
        <xsl:when test="preceding-sibling::*[1][self::me:punct]">
            <xsl:text>&nbsp;</xsl:text>        
        </xsl:when>
        <xsl:when test="preceding-sibling::*[1][self::tei:pc]">
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
        <xsl:when test="ancestor::tei:w"></xsl:when>
        <xsl:otherwise>
            <xsl:choose>
                <xsl:when test="following-sibling::*[1][self::me:punct]"></xsl:when>
                <xsl:when test="following-sibling::*[1][self::tei:pc]"></xsl:when>
                <xsl:otherwise>
                    <xsl:text>&nbsp;</xsl:text>        
                </xsl:otherwise>                
            </xsl:choose>
        </xsl:otherwise>
    </xsl:choose>        
</xsl:template>
    
    
    <xsl:template match="tei:corr">
        <xsl:text>*</xsl:text>
        <xsl:apply-templates/>
    </xsl:template>

<!-- Templates for displaying the apparatus -->

<!-- This template refers to the way notes are displayed in the running text. Notes are counted from the top of the document and displayed as superscript numbers that are linked to footnotes. -->

<xsl:template match="tei:note">
<xsl:param name="notes">
    <xsl:number from="/tei:text" level="any"/>
</xsl:param>
    <xsl:element name="A">
    <xsl:attribute name="name">in<xsl:value-of select="$notes"/></xsl:attribute>
    </xsl:element>
    <xsl:element name="A">
    <xsl:attribute name="href">#off<xsl:value-of select="$notes"/></xsl:attribute>
    <xsl:attribute name="class">note</xsl:attribute>
        <xsl:value-of select="$notes"/>
    </xsl:element>
</xsl:template>

<!-- This template specifies the formatting of the foot notes. Foot notes are located at the bottom of the page; in HTML this means that there is no distinction between foot notes and end notes. -->

<xsl:template match="tei:note" mode="footer">
<xsl:param name="foot">
    <xsl:number from="/tei:text" level="any"/>
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
    
<xsl:template match="tei:q">
    <xsl:choose>
        <xsl:when test="contains($visning, 'facs') or contains($visning, 'dipl')">
            <xsl:choose>
                <xsl:when test="preceding-sibling::*[1][self::me:punct]">
                    <xsl:text>&nbsp;</xsl:text>
                </xsl:when>
                <xsl:when test="preceding-sibling::*[1][self::tei:pc]">
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
    
<xsl:template match="tei:quote">
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
    
<xsl:template match="me:expunged">
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
	
	<!-- Handle how textSpan elements shold be displayed.  -->
	<xsl:template match="me:textSpan">
		<xsl:choose>
			<xsl:when test="contains($visning, 'norm') or contains($visning, 'dipl')">
				<xsl:choose>
					<xsl:when test="attribute::category='add'">
						<xsl:text>`</xsl:text>
					</xsl:when>
					<xsl:when test="attribute::category='corr'">
						<xsl:text>*</xsl:text>
					</xsl:when>
					<xsl:when test="attribute::category='del'">
						<xsl:text>|-</xsl:text>
					</xsl:when>
					<xsl:when test="attribute::category='damage'">
						<xsl:text>[</xsl:text>
					</xsl:when>
					<xsl:when test="attribute::category='supplied'">
						<xsl:text>&#x27E8;</xsl:text>
					</xsl:when>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>    
	
	<!--  Handle how textSpan elements shold be displayed.  -->
    <xsl:template match="tei:anchor">
        <xsl:choose>
            <xsl:when test="contains($visning, 'norm') or contains($visning, 'dipl')">
                <xsl:variable name="ref"><xsl:value-of select="attribute::xml:id"/></xsl:variable>
                <xsl:variable name="categ"><xsl:value-of select="preceding::me:textSpan[1][attribute::spanTo=$ref]/attribute::category"/></xsl:variable>
                <xsl:choose>
                    <!-- Have to look up the corresponding start element to see what kind of anchor element this is. -->
                    <xsl:when test="$categ='add'">
                        <xsl:text>´</xsl:text>
                    </xsl:when>
                    <xsl:when test="$categ='corr'">
                        <xsl:text></xsl:text>
                    </xsl:when>
                    <xsl:when test="$categ='del'">
                        <xsl:text>-|</xsl:text>
                    </xsl:when>
                    <xsl:when test="$categ='damage'">
                        <xsl:text>]</xsl:text>
                    </xsl:when>
                    <xsl:when test="$categ='supplied'">
                        <!--<xsl:text>&gt;</xsl:text>-->
                        <xsl:text>&#x27E9;</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </xsl:when>
        </xsl:choose>
        <xsl:if test="preceding-sibling::*[1][self::tei:w] and following-sibling::*[1][self::tei:w]">
            <xsl:text>&nbsp;</xsl:text>
        </xsl:if>
    </xsl:template>  
    
    <xsl:template match="tei:c">
        <xsl:choose>
            <xsl:when test="attribute::type='initial'">
                <xsl:variable name="position">
                    <xsl:value-of select="substring-before(attribute::rend, '_')"/>
                </xsl:variable>
                <xsl:variable name="size">
                    <xsl:call-template name="size">
                        <xsl:with-param name="rend" select="substring-after(attribute::rend, '_')"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:variable name="color">
                    <xsl:call-template name="color">
                        <xsl:with-param name="rend" select="substring-after(attribute::rend, '_')"/>
                    </xsl:call-template>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="contains($visning, 'facs')">
                        <xsl:choose>
                            <xsl:when test="contains($position, 'margin-left') and contains($position, 'inline')">
                                <xsl:element name="DIV">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; align: left; margin-left: -10px; font-size: 140%; font-weight: bold;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="contains($position, 'margin-left') and not(contains($position, 'inline'))">
                                <xsl:element name="DIV">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; align: left; margin-left: -50px; padding-right: 35px; font-size: 140%; font-weight: bold;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="SPAN">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; font-size: 140%; font-weight: bold;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="contains($position, 'margin-left') and contains($position, 'inline')">
                                <xsl:element name="DIV">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; align: font-size: 140%; font-weight: bold;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="contains($position, 'margin-left') and not(contains($position, 'inline'))">
                                <xsl:element name="DIV">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; align: font-size: 140%; font-weight: bold;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="SPAN">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; align: font-size: 140%; font-weight: bold;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="attribute::type='littNot'">
                <xsl:variable name="position">
                    <xsl:value-of select="substring-before(attribute::rend, '_')"/>
                </xsl:variable>
                <xsl:variable name="color">
                    <xsl:value-of select="substring-after(attribute::rend, '_')"/>
                </xsl:variable>
                <xsl:choose>
                    <xsl:when test="contains($visning, 'facs')">
                        <xsl:choose>
                            <xsl:when test="contains($position, 'margin-left') and contains($position, 'inline')">
                                <xsl:element name="DIV">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; align: font-size: 150%; font-weight: bold; align: left; margin-left: -10px;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:when test="contains($position, 'margin-left') and not(contains($position, 'inline'))">
                                <xsl:element name="DIV">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; align: font-size: 150%; font-weight: bold; align: left; margin-left: -50px; padding-right: 35px;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:element name="SPAN">
                                    <xsl:attribute name="style">
                                        <xsl:text>display: inline; align: font-size: 150%; font-weight: bold;</xsl:text>
                                        <xsl:if test="not($color='NA')">
                                            <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                        </xsl:if>
                                    </xsl:attribute>
                                    <xsl:apply-templates/>
                                </xsl:element>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="SPAN">
                            <xsl:attribute name="style">
                                <xsl:attribute name="style">
                                    <xsl:text>display: inline; align: font-size: 150%; font-weight: bold;</xsl:text>
                                    <xsl:if test="not($color='NA')">
                                        <xsl:text> color: </xsl:text><xsl:value-of select="$color"/><xsl:text>;</xsl:text>
                                    </xsl:if>
                                 </xsl:attribute>
                            </xsl:attribute>
                            <xsl:apply-templates/>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            
         
            <!-- for hyphenation -->
            <xsl:when test="@type='hyphen'"> 
                <xsl:apply-templates/>
            </xsl:when>
            
            
            <xsl:otherwise>
                <xsl:element name="SPAN">
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="size">
        <xsl:param name="rend"/>
        <xsl:value-of select="substring-before($rend, '_')"/>
    </xsl:template>
    
    <xsl:template name="color">
        <xsl:param name="rend"/>
        <xsl:value-of select="substring-after($rend, '_')"/>
    </xsl:template>
    
    <xsl:template name="colorlist">
        <xsl:param name="color"/>
        <xsl:choose>
            <xsl:when test="$color='black'"> #000000;</xsl:when>
            <xsl:when test="$color='blue'"> #0000FF;</xsl:when>
            <xsl:when test="$color='green'"> #008000;</xsl:when>
            <xsl:when test="$color='red'"> #FF0000;</xsl:when>
            <xsl:otherwise> #000000;</xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
