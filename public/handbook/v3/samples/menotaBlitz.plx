#!/usr/bin/perl
use warnings;
use strict;
use utf8;

# menotaBlitz.plx
# Version 2.1.1 (30 March 2016)
# An RKP program

# This program converts diplomatic transcriptions into a piece of 
# Menota-conformant XML-code.

# ask the user for source file

print "Enter the name of your transcription file:\n";
my $source = <STDIN>;
chomp $source;

my $target = $source;
$target =~ s/(.*)\.xml$/$1/ or die "Invalid file name!";
$target .= "_prl.xml";

# Activate this for only one transcription style option
my $style = 2;

# Activate this to enable multiple transcription styles
=pod
my $style = 0;
while ($style !~ /[1-4]/) {
	print <<"STYLEQ";
Which transcription style do you want use?
(1) Menota style with facsimile and diplomatic transcription
(2) Menota style with diplomatic transcription only
(3) Menota style on FACS, DIPL, and tentative NORM level
(4) emroon style transcription
STYLEQ
	$style = <STDIN>;
	print "Invalid option\n" if ($style !~ /[1-4]/);
}
=cut

# open source and target file

open INPUT, "<:utf8", $source or die "Source file $source cannot be read: $!\n";
open OUTPUT, "> $target" or die "Could not write on file $target: $!\n";
binmode OUTPUT, "utf8";

# read source (without "record separator")
undef $/;
my $text = <INPUT>;

# definition of symbols
my $comment = '<!--[^>]*?-->';				# comment

my $div = '<div(?: type=\"[\w-]+\")?(?: subtype=\"[\w-]+\")?(?: n=\"\d+\")?>';
											# open div tag
my $head = '<head>';						# open head tag
my $paragraph = '<p>';						# open p tag
my $textO = "(?:$div|$head|$paragraph)";
my $textC = '<\/(?:div|head|p)>';

my $pb = '<pb n=\"[a-z0-9]+[prv]\"/>';	 	# page break
my $cb = '<cb n=\"[AB]\d?\"/>';				# column break
my $lb = '<lb n=\"\d+\"(?: rend=\"\d\")?/>';# line break
my $gap = '<gap[^>]*?>';					# gap
my $break = "(?:$pb|$cb|$lb|$gap)";

my $add = '<add(?: place=\"[\w-]+\")?>';	# addition opening tag
my $del = '<del(?: type=\"\w+\")?(?: rend=\"\w+\")?>';
											# deletion opening tag
my $supplied = '<supplied(?: reason=\"\w+\")?>';
											# supplied opening tag
my $unclear = '<unclear>';					# unclear opening tag
my $choice = '<choice>';
my $siccorr = '(?:<sic>|<corr>)';
my $surplus = '<surplus>';
my $suppressed = '<suppressed>';
my $editO = "(?:$add|$del|$supplied|$unclear|$choice|$siccorr|$surplus|$suppressed)";
my $editC = '<\/(?:add|del|supplied|unclear|choice|sic|corr|surplus|suppressed)>';

my $wordTag = '<w>.*?</w>';					# word
my $mepu = '<me:punct>[^<]*?<\/me:punct>';	# me:punct
my $seg = '<seg(?: type="\w+")>';			# seg opening tag

my $pchar = '[\wþÞ&\(]|<am[ >]|<c(?: type="\w+")?>.*?<\/c>';
											# parseable characters
my $punct = '(?:[\.,\?!#:§]|&semi;|&para;)'; # punctuation marks
my $num = '<num(?: type=\"\w+\")?(?: value=\"\d+\")?>[^<]*?</num>';
											# numerals

# Find Transcription and remove superfluous white space from it
$_ = $text;
my $header = "";
my $openTrans = "";
my $transcription = "";
my $tail = "";

print "Source file read.\n";

while ($_) {
	if (/^($comment)(.*)/s) {						# ignores comments and notes
		$header .= $1;
		$_ = $2;
	} elsif (/^(<text>)(.*)/s) {					# finds the text start tag
		$openTrans = $1;
		$_ = $2;
		while ($_) {
			if (/^($comment)(.*)/s) {				# ignores comments and notes
				$transcription .= $1;
				$_ = $2;
			} elsif (/^\s+(.*)/s) {					# removes superfluous white space
				$transcription .= " ";
				$_ = $1;
			} elsif (/^:([a-z0-9]+[prv]):(.*)/s) {	# puts in page breaks
				$transcription .= "<pb n=\"$1\"/>";
				$_ = $2;
			} elsif (/^:([AB]):(.*)/s) {			# puts in column breaks
				$transcription .= "<cb n=\"$1\"/>";
				$_ = $2;
			} elsif (/^:([AB])(\d):(.*)/s) {		# puts in column breaks
				$transcription .= "<cb n=\"$1\" rend=\"$2\"/>";
				$_ = $3;
			} elsif (/^:(\d+):(.*)/s) {				# puts in line breaks
				$transcription .= "<lb n=\"$1\"/>";
				$_ = $2;
			} elsif (/^:(\d+)\.(\d+):(.*)/s) {		# puts in rendered line breaks
				$transcription .= "<lb n=\"$1\" rend=\"$2\"/>";
				$_ = $3;
			} elsif (/^<\/text>(.*)/s) {			# finds the text end tag
				$tail = $1;
				$_ = "";
			} else {
				$transcription .= substr $_, 0, 1;	# pushes parser onwards
				$_ = substr $_, 1;
			}
		}
	} else {
		$header .= substr $_, 0, 1;					# pushes parser onwards
		$_ = substr $_, 1;
	}
}

print "Page, column, and line breaks created.\n";

# Parsing through transcription to put in word tags

$_ = $transcription;
$transcription = "";

while ($_) {
	if (/^($comment|$textO|$break|$editO|$num)(.*)/s) {	# ignores comments, notes, and already existing word-tags
		$transcription .= "$1";
		$_ = $2;
	} elsif (/^ ($pchar|$editO)(.*)/s) {
		$transcription .= "</w> <w>$1";
		$_ = $2;
	} elsif (/^($pchar)(.*)/s) {
		$transcription .= "$1";
		$_ = $2;
	} else {
		$transcription .= substr $_, 0, 1;				# pushes the parser onwards
		$_ = substr $_, 1;
	}
}

print "Word tags inserted.\n";

$transcription = "<w>" . $transcription . "</w>";

# Punctuation and correcting element order


$transcription =~ s/>\s+</> </g;
$transcription =~ s/ ?((?:$comment ?|$textO|$textC|$break|$num|$mepu)+)(<\/w>)/$2$1/g;
$transcription =~ s/ ((?:$comment ?|$editO|$editC|$break|$num|$mepu)+)(<\/w>)/$2$1/g;
$transcription =~ s/<w><\/w>//g;
$transcription =~ s/<w>($editO|$editC)<\/w>/$1/g;
$transcription =~ s/($num)($punct)/$1<me:punct>$2<\/me:punct>/g;
while ($transcription =~ /$punct\s*<\/w>/) {
	$transcription =~ s/($punct)\s*(<\/w>)/$2<me:punct>$1<\/me:punct>/g;
	$transcription =~ s/( )((?:$comment ?|$editO|$editC ?|$break ?|$num|$mepu)+)(<\/w>)/$1$3$2/g;
	$transcription =~ s/ ?((?:$comment ?|$editO ?|$textO ?|$textC ?|$break ?|$num|$mepu)+)(<\/w>)/$2$1/g;
}
$transcription =~ s/((?:$editO)+$num(?:$editC)+)(<\/w>)/$2$1/g;
$transcription =~ s/ ($editC)(<\/w>)/$2$1/g;
$transcription =~ s/<w><\/w>//g;
$transcription =~ s/($textC ?)((?:$textO ?)+)((?:$break ?)+)/$1$3$2 /g;

print "Element order corrected.\n";

# Plus and Underline

$_ = $transcription;
$transcription = "";

while ($_) {
	if (/^($comment)(.*)/s) {						# ignores comments and notes
		$transcription .= $1;
		$_ = $2;
	} elsif (/^<w>(.*?)<\/w>(.*)/s) {
		my $wort = $1;
		my $rest = $2;
		$wort =~ s/_/ /g;							# deals with plus
		if ($wort =~ s/\+/<\/w><w>/g) {				# deals with underline
			$transcription .= "<seg type=\"nb\"><w>$wort</w></seg>";
		} else {
			$transcription .= "<w>$wort</w>";
		}
		$_ = $rest;
	} else {
		$transcription .= substr $_, 0, 1;			# pushes the parser onwards
		$_ = substr $_, 1;
	}
}

print "Additional word and segment tags created.\n";

# Multi-level transcription and abbreviations

$_ = $transcription;
$transcription = "";

while ($_) {
	if (/^($comment|$pb|$cb|$lb|$num)(.*)/s) {		# ignores all non-word tags
		$transcription .= $1;
		$_ = $2;
	} elsif (/^($wordTag)(.*)/s) {					# creates correct mark-up for words
		my $word = $1;
		$_ = $2;
		$word =~ s/<w>(.*?)<\/w>/$1/g;
		
		my $emro = $word;
		$emro =~ s/\(\)/<am rend="0">&bar;<\/am>/g;
		$emro =~ s/\(:([^\)]+?)\)/<am rend="$1"\/>/g;
		$emro =~ s/\(([^\):]?):\)/<am rend="0">$1<\/am>/g;
		$emro =~ s/\(\.\)/<am rend="0">.<\/am>/g;
		$emro =~ s/\(([^\):]+?):([^\)]+?)\)/<am rend="$2">$1<\/am>/g;
		$emro =~ s/\((o[ck])\)/<am rend="$1">&et;<\/am>/g;
		$emro =~ s/\(([^\)]+?)\)/<am rend="$1">&bar;<\/am>/g;
		
		my $restEmro = $emro;
		my $newEmro = "";
		while ($restEmro) {
			$restEmro =~ s/^(<[^>]*?>)(.*)/$2/	and $newEmro .= "$1" and next;
			$restEmro =~ s/^s(.*)/$1/			and $newEmro .= "&slong;" and next;
			$restEmro =~ s/^&sscap;(.*)/$1/		and $newEmro .= "s" and next;
			$restEmro =~ s/^(&[^;]*?;)(.*)/$2/ 	and $newEmro .= "$1" and next;
			$restEmro =~ s/^(.)(.*)/$2/			and $newEmro .= "$1";
		}
		$emro = $newEmro;
		
		my $facs = $word;
		# general stuff
		$facs =~ s/\(\.\)/<am>.<\/am>/g;
		$facs =~ s/\(0:.*?\)//g;
		$facs =~ s/\(([^\)]+?):.*?\)/<am>$1<\/am>/g;
# YOUR NEW ABBREVIATION RULES BELOW THIS LINE

			$facs =~ s/\(o[ck]\)/<am>&etslash;<\/am>/g;
				
# YOUR NEW ABBREVIATION RULES ABOVE THIS LINE
		# &bar;
		$facs =~ s/\(:?[^\)]*?\)/<am>&bar;<\/am>/g;
		# special stuff
	
		my $restFacs = $facs;
		my $newFacs = "";
		my $charFacs = "";
		$restFacs =~ s/<choice>\s*(<sic>.*?<\/sic>)\s*<corr>.*?<\/corr>\s*<\/choice>/$1/g;
		while ($restFacs) {
			$restFacs =~ s/^(<[^>]*?>)(.*)/$2/	and $newFacs .= "$1" and next;
# YOUR NEW FACSIMILE RULES BELOW THIS LINE

			$restFacs =~ s/^d(.*)/$1/			and $newFacs .= "&drot;" and next;
			$restFacs =~ s/^E(.*)/$1/			and $newFacs .= "&Euncclose;" and next;
			$restFacs =~ s/^f(.*)/$1/			and $newFacs .= "&fins;" and next;
			$restFacs =~ s/^H(.*)/$1/			and $newFacs .= "&henl;" and next;
			$restFacs =~ s/^i(.*)/$1/ 			and $newFacs .= "&inodot;" and next;
			$restFacs =~ s/^j(.*)/$1/ 			and $newFacs .= "&jnodot;" and next;
			$restFacs =~ s/^pp(.*)/$1/ 			and $newFacs .= "&pplig;" and next;
			$restFacs =~ s/^s(.*)/$1/			and $newFacs .= "&slong;" and next;
			$restFacs =~ s/^&sscap;(.*)/$1/		and $newFacs .= "s" and next;
			$restFacs =~ s/^t(.*)/$1/			and $newFacs .= "&trot;" and next;
			$restFacs =~ s/^Þ(.*)/$1/			and $newFacs .= "&thornenl;" and next;
			$restFacs =~ s/^y(.*)/$1/			and $newFacs .= "&vinsdot;" and next;
			$restFacs =~ s/^z(.*)/$1/			and $newFacs .= "&zstrok;" and next;
			$restFacs =~ s/^ø(.*)/$1/			and $newFacs .= "&oloop;" and next;
			
# YOUR NEW FACSIMILE RULES ABOVE THIS LINE
			$restFacs =~ s/^(-)(.*)/$2/			and $newFacs .= "<pc>$1</pc>" and next;
			$restFacs =~ s/^(&[^;]*?;)(.*)/$2/ 	and $newFacs .= "$1" and next;
			$restFacs =~ s/^(.)(.*)/$2/			and $newFacs .= "$1";
		}
		$facs = $newFacs;
			
		my $dipl = $word;
		# general stuff
		$dipl =~ s/\(\.?\)//g;
		$dipl =~ s/\((?:[^\)]*?:)\)//g;
		$dipl =~ s/\((?:[^\)]*?:)(.+?)\)/<ex>$1<\/ex>/g;
		$dipl =~ s/\((.*?)\)/<ex>$1<\/ex>/g;
		# special stuff

		my $restDipl = $dipl;
		my $newDipl = "";
		my $charDipl = "";
		$restDipl =~ s/<choice>\s*<sic>.*?<\/sic>\s*(<corr>.*?<\/corr>)\s*<\/choice>/$1/g;
		while ($restDipl) {
			$restDipl =~ s/^(<[^>]*?>)(.*?)/$2/	and $newDipl .= "$1" and next;
# YOUR NEW DIPLOMATIC RULES BELOW THIS LINE

			$restDipl =~ s/^&Eunc;(.*)/$1/		and $newDipl .= "E" and next;
			$restDipl =~ s/^&mscap;(.*)/$1/		and $newDipl .= "m" and next;
			$restDipl =~ s/^&nenl;(.*)/$1/		and $newDipl .= "N" and next;
			$restDipl =~ s/^&nscap;(.*)/$1/		and $newDipl .= "n" and next;
			$restDipl =~ s/^&rrot;(.*)/$1/		and $newDipl .= "r" and next;
			$restDipl =~ s/^&rscap;(.*)/$1/		and $newDipl .= "r" and next;
			$restDipl =~ s/^&sscap;(.*)/$1/		and $newDipl .= "s" and next;
			$restDipl =~ s/^&uscap;(.*)/$1/		and $newDipl .= "U" and next;
			
# YOUR NEW DIPLOMATIC RULES ABOVE THIS LINE
			$restDipl =~ s/^(-)(.*)/$2/			and $newDipl .= "<pc>$1</pc>" and next;
			$restDipl =~ s/^(&[^;]*?;)(.*)/$2/ 	and $newDipl .= "$1" and next;
			$restDipl =~ s/^(.)(.*)/$2/			and $newDipl .= "$1";
		}
		$dipl = $newDipl;
		
		my $norm = $word;
		$norm =~ s/\((?:[^:]*:)?([^\)]*)\)/$1/g;
		my $restNorm = $norm;
		my $newNorm = "";
		my $charNorm = "";
		$restNorm =~ s/<choice>\s*<sic>.*?<\/sic>\s*<corr>(.*?)<\/corr>\s*<\/choice>/$1/g;
		$restNorm =~ s/&jacute;/j/g;
		$restNorm =~ s/&uscap;/u/g;
		while ($restNorm) {
			$restNorm =~ s/^<surplus>.*?<\/surplus>(.*)/$newNorm$1/ 
												and $newNorm = "" and next;
			$restNorm =~ s/^<suppressed>.*?<\/suppressed>(.*)/$newNorm$1/
												and $newNorm = "" and next;
			$restNorm =~ s/^<(c)(?: type="\w+")?>(.*?)<\/\1>(.*)/$2$3/
												and $newNorm .= "" and next;
			$restNorm =~ s/^<(supplied)(?: reason="\w+")>(.*?)<\/\1>(.*)/$2$3/
												and $newNorm .= "" and next;
			$restNorm =~ s/^<(unclear)>(.*?)<\/\1>(.*)/$2$3/
												and $newNorm .= "" and next;
			$restNorm =~ s/^ (.*)/$1/			and next;
			$restNorm =~ s/^(<[^>]*?>)(.*)/$2/	and $newNorm .= "$1" and next;
# YOUR NEW NORMALIZATION RULES BELOW THIS LINE

			$restNorm =~ s/^c(.*)/$1/			and $newNorm .= "k" and next;
			$restNorm =~ s/^dð(.*)/$1/			and $newNorm .= "dd" and next;
			$restNorm =~ s/^&Eunc;(.*)/$1/		and $newNorm .= "E" and next;
			$restNorm =~ s/^[ií]([aou])(.*)/$2/	and $newNorm .= "j$1" and next;
			$restNorm =~ s/^llð(.*)/$1/			and $newNorm .= "ld" and next;
			$restNorm =~ s/^&mscap;(.*)/$1/		and $newNorm .= "m" and next;
			$restNorm =~ s/^&nenl;(.*)/$1/		and $newNorm .= "N" and next;
			$restNorm =~ s/^&nscap;(.*)/$1/		and $newNorm .= "n" and next;
			$restNorm =~ s/^&rrot;(.*)/$1/		and $newNorm .= "r" and next;
			$restNorm =~ s/^&rscap;(.*)/$1/		and $newNorm .= "r" and next;
			$restNorm =~ s/^&sscap;(.*)/$1/		and $newNorm .= "s" and next;
			$restNorm =~ s/^&slong;(.*)/$1/		and $newNorm .= "s" and next;
			$restNorm =~ s/^u([aeiíoæ])(.*)/$2/	and $newNorm .= "v$1" and next;
			$restNorm =~ s/^v([mt])(.*)/$2/		and $newNorm .= "u$1" and next;
			$restNorm =~ s/^æ[ií](.*)/$1/		and $newNorm .= "ei" and next;
			$restNorm =~ s/^æy(.*)/$1/			and $newNorm .= "ey" and next;
			
# YOUR NEW NORMALIZATION RULES ABOVE THIS LINE
			$restNorm =~ s/^(-)(.*)/$2/			and $newNorm .= "<pc>$1</pc>" and next;
			$restNorm =~ s/^\.(.*)/$1/			and next;
			$restNorm =~ s/^(&[^;]*?;)(.*)/$2/ 	and $newNorm .= "$1" and next;
			$restNorm =~ s/^(.)(.*)/$2/			and $newNorm .= "$1";
		}
		$norm = $newNorm;
		
		if ($style == 1) {
			$transcription .= <<"WORDTAG";
<w>
	<choice>
		<me:facs>$facs</me:facs>
		<me:dipl>$dipl</me:dipl>
	</choice>
</w>
WORDTAG
		} elsif ($style == 2) {
			$transcription .= "<w>$dipl</w>";
		} elsif ($style == 3) {
			$transcription .= <<"WORDTAG";
<w>
	<choice>
		<me:facs>$facs</me:facs>
		<me:dipl>$dipl</me:dipl>
		<me:norm>$norm</me:norm>
	</choice>
</w>
WORDTAG
		} elsif ($style == 4) {
			$transcription .= "<w lemma=\"F0000-00\">$emro</w>";
		}
	} elsif (/^(<me:punct>.*?<\/me:punct>)(.*)/s) {
		my $puma = $1;
		$_ = $2;
		$puma =~ s/<me:punct>(.*?)<\/me:punct>/$1/;
		my $facs = $puma;
		my $dipl = $puma;
		my $norm = $puma;
		my $emro = $puma;
		if ($style == 1) {
			$transcription .= <<"PUNCTTAG";
<me:punct>
	<choice>
		<me:facs>$facs</me:facs>
		<me:dipl>$dipl</me:dipl>
	</choice>
</me:punct>
PUNCTTAG
		} elsif ($style == 2) {
			$transcription .= "<me:punct>$dipl</me:punct>";
		} elsif ($style == 3) {
			$transcription .= <<"PUNCTTAG";
<me:punct>
	<choice>
		<me:facs>$facs</me:facs>
		<me:dipl>$dipl</me:dipl>
		<me:norm>$norm</me:norm>
	</choice>
</me:punct>
PUNCTTAG
		} elsif ($style == 4) {
			$transcription .= "<pc>$emro</pc>"
		}
	} else {
		$transcription .= substr $_, 0, 1;				# pushes the parser onwards
		$_ = substr $_, 1;
	}
}

print "Multi-level transcription generated.\n";

=pod
# Indentation

$transcription =~ s/\s*($comment|$mepu|$textO|$textC|$editO|$editC|$seg|<w(?:\s*[^>]+)*>|<\/seg>)/\n$1/g;
$transcription =~ s/(>)($break)/$1\n$2/g;
$transcription =~ s/(>)($break)/$1\n$2/g;
$transcription =~ s/(<\/(?:am|ex)>)\s+($break)/$1$2/g;

print "Indentation inserted.\n";
=cut

# The Menota header and tail

my $menotaHeader = <<'NEWHEADER';
<?xml version="1.0" encoding="UTF-8"?>
<?oxygen 
	RNGSchema="http://www.menota.org/menotaP5.rng"
	type="xml" ?>

<!DOCTYPE TEI [
   <!ENTITY % menotaEntities SYSTEM
      'http://www.menota.org/menota-entities.txt'>
   %menotaEntities;
]>

<TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:me="http://www.menota.org/ns/1.0">
	<teiHeader xml:lang="eng">
		<fileDesc>
			<titleStmt>
				<title>A digital edition of YOUR MANUSCRIPT</title>
			</titleStmt>
			<editionStmt>
				<p>SOMETHING ABOUT YOUR EDITION HERE!</p>
				<p>
					Converted into menota standard with 'menotaBlitz.plx' (v. 2.0.1) program written by 
					<persName>Robert Kristof Paulsen</persName>, 
					<orgName type="affiliation">University of Bergen</orgName>
				</p>
			</editionStmt>			
			<publicationStmt>
				<availability status="restricted">
					<p>
						This text is available for purposes of academic research and teaching only.
						Re-distribution in any form without prior permission is prohibited. Short extracts may
						be cited with full acknowledgment of the source.
					</p>
				</availability>
			</publicationStmt>
			<sourceDesc>
				<msDesc>
					<msIdentifier>
						<idno>YOUR MANUSCRIPT'S SHELF-MARK HERE</idno>
						<msName>YOUR MANUSCRIPT'S NAME HERE</msName>
					</msIdentifier>
				</msDesc>
			</sourceDesc>
		</fileDesc>
	</teiHeader>
	<text>
		<body>
NEWHEADER

my $menotaTail = <<'NEWTAIL';

		</body>
	</text>
</TEI>
NEWTAIL

my $emroonHeader = <<'NEWHEADER';
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE TEI [
   <!ENTITY % myEntities SYSTEM
      'http://folk.uib.no/rpa021/emroon/v2-1-1/xml/entities.txt'>
   %myEntities;
]>
<TEI xmlns="http://www.tei-c.org/ns/1.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xsi:schemaLocation="http://www.tei-c.org/ns/1.0 http://folk.uib.no/rpa021/emroon/v2-1-1/xml/XSD/emroon.xsd">
   <teiHeader xml:lang="eng">
      <fileDesc>
         <titleStmt>
            <title>YOUR TITLE HERE</title>
            <respStmt>
               <resp>Edition and annotation by </resp>
               <name>YOUR NAME HERE 
			      <orgName type="affiliation">YOUR AFFILIATION HERE</orgName>
			   </name>
            </respStmt>
			<respStmt>
			   <resp>menotaBlitz.plx program written by </resp>
			   <name>Robert Kristof Paulsen
			      <orgName type="affiliation">University of Bergen</orgName>
			   </name>
			</respStmt>
         </titleStmt>
         <editionStmt>
            <p>Preliminary version, created with the help of the menotaBlitz.plx Perl program</p>
         </editionStmt>
         <publicationStmt>
            <distributor>The &emroon; database</distributor>
            <date when="2016-05-25">25 May 2016</date>
            <availability status="restricted">
               <p>This text intended for purposes of academic research and teaching only.
                  Re-distribution is possible in accordance with a Creative Commons license
                  CC-BY-SA.</p>
            </availability>
         </publicationStmt>
         <sourceDesc>
            <msDesc>
               <msIdentifier>
                  <country key="COUNTRY'S KEY">COUNTRY</country>
                  <settlement>CITY</settlement>
                  <repository>LIBRARY</repository>
                  <idno>YOUR MANUSCRIPT'S SHELF-MARK</idno>
               </msIdentifier>
            </msDesc>
         </sourceDesc>
      </fileDesc>
      <profileDesc>
         <handNotes>
            <handNote xml:id="h1">
               <name>YOUR SCRIBE HERE</name>
            </handNote>
         </handNotes>
      </profileDesc>
   </teiHeader>
   <text>
	  <body>
NEWHEADER

my $emroonTail = <<'NEWTAIL';
      </body>
   </text>
</TEI>
NEWTAIL

if ($style < 4) {
	$transcription =~ s/<suppressed>(.*?)<\/suppressed>/<me:expunged>$1<\/me:expunged>/g;
	$header = $menotaHeader;
	$tail = $menotaTail;
} else {
	$transcription =~ s/<suppressed>(.*?)<\/suppressed>/<surplus>$1<\/surplus>/g;
	$transcription =~ s/(<(w|pc)(?: [^>]*?)?>.*?<\/\2>)/\n$1/g;
	$header = $emroonHeader;
	$tail = $emroonTail;
}

# Putting together the output

$text = $header . $transcription . $tail;
		
# Print out (on screen and to file handled by OUTPUT)

print OUTPUT $text and print ("\nA converted transcription has been saved to a file '$target'.\n");