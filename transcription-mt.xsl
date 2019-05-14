<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:jc="http://james.blushingbunny.net/ns.html"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd tei jc"
	version="2.0">
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> James Cummings</xd:p>
			<xd:p>First attempt at LEAP to HTML conversion</xd:p>
			<xd:p>Updated in Feb/Mar 2015.</xd:p>
		</xd:desc>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Adrian S. Wisnicki</xd:p>
			<xd:p>Extensive revisions</xd:p>
			<xd:p>Updated in Aug 2016.</xd:p>
		</xd:desc>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Justin Livingstone</xd:p>
			<xd:p>Revisions for Missionary Travles</xd:p>
			<xd:p>Updated in Mar 2017.</xd:p>
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Justin Livingstone</xd:p>
			<xd:p>Revisions for Missionary Travels</xd:p>
			<xd:p>Updated in May 2019.</xd:p>
		</xd:desc>
		</xd:desc>
	</xd:doc>
	
	<xsl:output method="xml" encoding="utf-8" indent="no"/>
	<!-- It's necessary that this be "no" or otherwise extra space is kicked in when there are two <span>s in a row. It also appearst to solve other minor formatting issues -->

	<!-- Incoming parameters -->
	<xsl:param name="page" select="'0001'"/>
	<xsl:param name="paged" select="'true'"/>

	<!-- Transform these to global variables in case I need to use them anywhere -->
	<xsl:variable name="pagenumber" select="$page"/>
	<xsl:variable name="isPaged" select="$paged"/>

	<!-- When not producing full HTML files, this template could be removed but javascript and CSS will need to be copied to correct location. -->
	<xsl:template match="/">
		<html>
			<xsl:comment>This HTML has been generated from an XML original. Do not manually modify this as a source.</xsl:comment>
			<head>
				<meta charset="UTF-8"/>
				<link rel="stylesheet" type="text/css" href="http://livingstoneonline.github.io/LEAP-XSLT/normalize.css"/>
				<link rel="stylesheet" type="text/css" href="http://livingstoneonline.github.io/LEAP-XSLT/common.css"/>
				<link rel="stylesheet" type="text/css" href="http://livingstoneonline.github.io/LEAP-XSLT/style-mt-html.css"/>
				<!-- http://livingstoneonline.github.io/LEAP-XSLT/ -->
				<title>
					<xsl:value-of select="//teiHeader//title[1]"/>
				</title>
				<!--<link type="text/css" rel="stylesheet" href="http://jamescummings.github.io/LEAP/style.css"/>-->
			</head>
			<body class="non-embedded-transcription">
				<xsl:text>&#xA;</xsl:text><!-- Added for MT -->
				<xsl:apply-templates select="TEI"/>
			</body>
		</html>
	</xsl:template>

	<!-- Don't show -->
	<xsl:template match="teiHeader|facsimile|surface|zone"/>

	<!-- TEI -->
	<xsl:template match="TEI">
		<div class="transcription style-mt-html">
			<!--<button id="toggle" title="toggle" type="button" class="hidden">Show unedited text</button>-->
			<!-- The above is the diplomatic/edited toggle button, which we've turned off because we're using tooltips instead. AW -->
			<!--<h2>
        <xsl:value-of select="//teiHeader//title[2]"/>
			</h2>-->
			<div class="TEI">
				<div class="item-details">
					<span class="title"><xsl:value-of select="//teiHeader//titleStmt/title[1]"/></span><br/>
					<span class="author"><xsl:value-of select="//teiHeader//titleStmt/author" separator=", "/></span><br/>
					<hr class="title-section"/><br/>
					<span class="authority"><strong>Date of composition:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//bibl[@type='sourceMetadata']/date[@type='composition']"/></span><br/>
					<!--<span class="authority"><strong>Place of composition:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//bibl[@type='sourceMetadata']/placeName[@type='compositionPlace']"/></span><br/>--><!-- Removed for MT -->
					<span class="authority"><strong>Repository:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//repository"/>, <xsl:value-of select="//teiHeader//settlement"/>, <xsl:value-of select="//teiHeader//country"/></span><br/>
					<span class="authority"><strong>Shelfmark:</strong><xsl:text> </xsl:text> <xsl:value-of select="//teiHeader//idno[@type='shelfmark']"/></span><br/>
					<span class="authority"><strong>Clendennen &amp; Cunningham number(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//idno[@type='ccnumber']"/></span><br/>
					<span class="authority"><strong>Digital edition and date:</strong><xsl:text> </xsl:text> <a href="http://livingstoneonline.org/" target="_blank"><xsl:value-of select="//teiHeader//authority"/></a>,</span><xsl:text> </xsl:text><span class="pub-date"><xsl:value-of select="//teiHeader//publicationStmt/date"/></span><br/>
					<span class="authority"><strong>Publisher:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//publicationStmt/publisher"/>,</span><xsl:text> </xsl:text><span class="pub-date"><xsl:value-of select="//teiHeader//publicationStmt/pubPlace"/></span><br/>
					<span class="idno"><strong>Project id:</strong><xsl:text> </xsl:text> <xsl:value-of select="//idno[@type='LEAP-ID']"/></span><br/>
					<span class="authority"><strong>TEI encoding:</strong><xsl:text> </xsl:text> <xsl:value-of select="//teiHeader//respStmt/name" separator=", "/></span><br/>
					<br/>
					<hr class="title-section"/>
					<br/>
				</div>
				<xsl:comment><xsl:value-of select="$isPaged"/></xsl:comment>
				<xsl:choose>
					<xsl:when test="$isPaged='true' and //jc:page[@n=$pagenumber]">
						<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
					</xsl:when>
					<xsl:when test="$isPaged='false'">
						<xsl:apply-templates select="text"/>
					</xsl:when>
					<xsl:when test="//jc:page[@n=$pagenumber]">
						<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:apply-templates select="text"/>
					</xsl:otherwise>
				</xsl:choose>
			</div>
		</div>
	</xsl:template>

	<!-- General match -->
	<xsl:template match="*" priority="-10">
		<xsl:variable name="class">
			<xsl:if test="@rend">
				<xsl:value-of select="translate(@rend, '-', '')"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="@place">
				<xsl:value-of select="translate(@place, '-', '')"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="@type">
				<xsl:value-of select="translate(@type, '-', '')"/>
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="title">
			<xsl:for-each select="@*">
				<xsl:sort/>
				<xsl:if test="not(name()='status')">
					<xsl:value-of select="concat(name(),': ', ., '; ')"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:variable>
		<span>
			<xsl:if test="$class/text()">
				<xsl:attribute name="class">
					<xsl:value-of select="$class"/>
				</xsl:attribute>
			</xsl:if>
			<!--<xsl:if test="$title/text()">
				<xsl:attribute name="title">
					<xsl:value-of select="$title"/>
				</xsl:attribute>
			</xsl:if>-->
			<!-- Necessary to turn this off, otherwise it creates wonky tooltips.
			Tooltips as needed should be set on the specific element. -->
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- Make rend class -->
	<xsl:template match="*/@rend" priority="-1">
		<xsl:attribute name="class">
			<xsl:value-of select="concat(parent::node()/name(), ' ')"/>
			<xsl:value-of select="translate(., '-', '')"/>
		</xsl:attribute>
	</xsl:template>


	<!-- Textual divisions -->
	<xsl:template match="text|body|front|back">
		<div class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

<!-- Removed the below template. If it doesn't mess up anything, remove completely -->
	<!--<xsl:template match="body[following-sibling::back]" priority="10">
		<div class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
		</div>
	</xsl:template>-->

	<xsl:template match="div">
		<div class="vertical-line">
			<div class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@resp, '-', ''), ' ', translate(@n, '-', ''))}"><!-- Added @resp and @n for MT -->
				<xsl:apply-templates/>
			</div>
		</div>
		<br/>
	</xsl:template>


<!-- Removed the below two templates. If it doesn't mess up anything, remove them completely -->
	<!--<xsl:template match="div/div">
		<br/><br/><div class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''))}">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="div[preceding-sibling::div][child::pb[1]]">
		<br/><div class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''))}">
			<xsl:apply-templates/>
		</div>
	</xsl:template>-->

	<xsl:template match="lb">
		<xsl:variable name="class">
			<xsl:if test="@rend">
				<xsl:value-of select="translate(@rend, '-', '')"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="@place">
				<xsl:value-of select="translate(@place, '-', '')"/>
				<xsl:text> </xsl:text>
			</xsl:if>
			<xsl:if test="@type">
				<xsl:value-of select="translate(@type, '-', '')"/>
				<xsl:text> </xsl:text>
			</xsl:if>
		</xsl:variable>
		<!--<br><xsl:if test="$class/text()"><xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute></xsl:if></br>-->
		<br/>
		<xsl:choose>
			<xsl:when test="lb[(ancestor::add[@place='marginleft'])]"/>
			<xsl:otherwise>
				<xsl:variable name="num">
					<xsl:number level="any" from="pb" count="lb[not(ancestor::add[@place='marginleft'])]|lb[not(ancestor::add[@place='marginleft']/note)]"/><!-- count="lb[not(ancestor::add[@place='marginleft'])]|lb[not(ancestor::add[@place='marginleft']/note)]" -->
				</xsl:variable>
				<xsl:if test="number($num) mod 1 =0">
					<span class="linenumber">
						<xsl:value-of select="$num"/>
					</span>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="choice">
		<xsl:apply-templates/>
	</xsl:template>

	
	<xsl:template match="choice/sic">
			<xsl:variable name="choice-orig-sic">
			<xsl:choose>
				<!-- If there are orig and reg values in the corr, show the orig -->
				<xsl:when test="../corr/choice/orig">
					<xsl:value-of select="../corr/choice/orig"/>
				</xsl:when>
				<!-- If there are sic and corr values in the corr, show both sic and corr -->
				<xsl:when test="../corr/choice/sic">
					<xsl:value-of select="../corr/choice/sic"/> [or] <xsl:value-of select="../corr/choice/corr"/>
				</xsl:when>
				<!-- If there are two rdgs, show both rdgs -->
				<xsl:when test="../corr/app/rdg">
					<xsl:value-of select="../corr/app/rdg[1]"/> [or] <xsl:value-of select="../corr/app/rdg[2]"/>
				</xsl:when>
				<xsl:when test="../corr[not(text())]">[no text]</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="../corr"/>
				</xsl:otherwise>
			</xsl:choose>			
			</xsl:variable>
			<!--<xsl:if test="../corr">
				<xsl:attribute name="title">The editors suggest a correction as follows: <xsl:value-of select="../corr"/></xsl:attribute>
			</xsl:if>-->
		<span class="sic diplomatic">
			<xsl:attribute name="title">The editors suggest a correction as follows: <xsl:value-of select="$choice-orig-sic"/></xsl:attribute>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!--<xsl:template match="choice/corr">
		<span class="corr edited hidden">
			<xsl:if test="../sic">
				<xsl:attribute name="title">sic: <xsl:value-of select="../sic"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->

	<!-- "Choice" variants begin here -->

	<xsl:template match="abbr|orig">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="corr|expan|reg|supplied"/>
	
	<!-- Text below removed for annotated edition; also see app, supplied & unclear -->
	
	<!--<xsl:template match="choice/abbr">
		<span class="abbr diplomatic">
			<xsl:if test="../expan">
				<xsl:attribute name="title"><xsl:value-of select="../expan"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="choice/expan">
		<span class="abbr edited hidden">
			<xsl:if test="../abbr">
				<xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="../abbr[1]/node()"/>
		</span>
	</xsl:template>

	<xsl:template match="choice/orig|choice/reg">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="orig">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="reg" priority="10"> </xsl:template>-->

	<!-- "Choice" variants end here -->

	<!-- Alphabetical list of elements. Alphabetized by last element in path *or* first element among options. -->

	<xsl:template match="ab|p">
		<p class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@n, '-', ''))}">
			<xsl:apply-templates/>
		</p><!-- Added @hand and @n for MT -->
	</xsl:template>

	<!-- added p/cb for 1870 FD -->
	<xsl:template match="cb/ab|p/cb" priority="10">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- For "abbr" see above -->

	<xsl:template match="add">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@n, '-', ''))}">
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'ition, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span><!-- Added @hand and @n for MT -->
	</xsl:template>

	<xsl:template match="add[@place='marginleft']|add[@place='marginright']|add[@place='marginbottom']|add[@place='margintop']" priority="9"><!-- Should 9 be 10? -->
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@n, '-', ''), ' ', 'addmargin')}">
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'ition, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					 [<xsl:apply-templates/>] </span><!-- Added @n for MT -->
	</xsl:template>

	<xsl:template match="add[@place='over-text']">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@n, '-', ''))}" title="Addition written over existing text">
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'ition, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					{<xsl:apply-templates/>}</span><!-- Added @n for MT -->
	</xsl:template>

	<xsl:template match="opener/add">
		<span
			class="opener-add {concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@n, '-', ''))}">
			
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'ition, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/>
		</span><!-- Added @n for MT -->
	</xsl:template>

	<!-- The following template added for MT -->
	<xsl:template match="add[@rend='gray right'][preceding-sibling::add[@rend='gray center']]" priority="9">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@n, '-', ''), ' ', 'add-right')}">
			
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'ition, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- The following template added for MT -->
	<xsl:template match="add[@rend='gray right'][preceding-sibling::add[@rend='gray right']]" priority="10">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@n, '-', ''), ' ', 'right-right')}">
			
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'ition, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/>
		</span>
	</xsl:template>

<!-- If the below template is not needed, remove completely -->
	<!--<xsl:template match="//note[parent::add[@place='marginleft']]" priority="10">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@n, '-', ''), ' ', 'marginleft')}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->
	
	<!-- The following template added for MT -->
	<xsl:template match="addSpan">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@n, '-', ''))}">
			<xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="address">
		<span class="address">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="addrLine">
		<br/>
		<span class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:variable name="ailment" select="doc('ailment.xml')"/>
	<xsl:template match="term[@type='ailment']">
		<!-- Make the output of the @title attribute in a variable -->
		<!--<xsl:variable name="title">An ailment.</xsl:variable>--><!-- Removed last -->
		<!--<xsl:choose>-->
		<!-- when there is a @ref, assume it is right and go get information about the ailment -->
		<!--<xsl:when test="@ref">
				<xsl:variable name="id" select="substring-after(@ref, '#')"/>
				<xsl:variable name="thisEntry" select="$ailment//entry[@xml:id=$id]"/>
				<xsl:if test="$thisEntry/form/orth"><xsl:value-of select="normalize-space($thisEntry/form/orth)"/>. </xsl:if>
				<xsl:value-of select="normalize-space($thisEntry/def[1])"/>
			</xsl:when>-->
		<!-- otherwise... -->
		<!--<xsl:otherwise>An ailment.</xsl:otherwise>
		</xsl:choose>
		</xsl:variable>-->
		<!-- output the term @type="ailment" in a html:span element with whatever is now in the $title variable -->
		<!--<span class="term-ailment" title="{$title}">--><!-- Removed last -->
			<xsl:apply-templates/>
		<!--</span>--><!-- Removed last -->
	</xsl:template>

	<!-- app: show first rdg, offer alternatives in title -->
	<xsl:template match="app">
		<!-- Hidden for annotated version. Also choice, supplied & unclear. -->
		<!--<span class="app">
			<xsl:attribute name="title">
				<xsl:for-each select="rdg">
					<xsl:value-of select="concat(name(),': ', ., '; ')"/>
				</xsl:for-each>
			</xsl:attribute>
			<xsl:apply-templates select="rdg[1]"/>
		</span>-->
		<xsl:variable name="rdg-rdg">
			<xsl:value-of select="../app/rdg" separator=" [or] "/>
		</xsl:variable>
		<span class="app">
			<xsl:attribute name="title">This passage can be read in alternate ways: <xsl:value-of select="$rdg-rdg"/></xsl:attribute>
			<xsl:apply-templates select="rdg[1]"/>
		</span>
	</xsl:template>

	<!-- For "back" see above -->

	<!-- For "body" see above -->

	<xsl:template match="cb">
		<br/>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="div/cb">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- For "choice" see above -->

	<xsl:template match="closer">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- For "corr" see above -->

	<xsl:template match="date[@when]" priority="10">
		<span class="date" data-date="{@when}"><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="date[@from]" priority="10">
		<span class="date" data-date="{@from} {@to}"><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="date">
		<span class="date" data-date="unknown"><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="dateline">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<!-- The following template added for MT: words deleted by another hand in another colour. This replaces regular del template -->	
	<xsl:template match="del">
		<xsl:choose>
			<xsl:when test="@n='DL' and ancestor::div[@n='U5']"><!-- This is controlling the strikethrough in another color -->
				<span style='color:black;text-decoration:line-through'><span style='color:#936541'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='gray' and ancestor::div[@n='U5']"><!-- This is controlling the strikethrough in another color -->
				<span style='color:gray;text-decoration:line-through'><span style='color:#936541'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@n='CL' and ancestor::div[@n='DL']"><!-- This is controlling the strikethrough in another color -->
				<span style='color:#746553;text-decoration:line-through'><span style='color:black'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@n='DL' and ancestor::div[@n='CL']"><!-- This is controlling the strikethrough in another color -->
				<span style='color:black;text-decoration:line-through'><span style='color:#746553'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray' and ancestor::div[@n='CL']"><!-- This is controlling the strikethrough in another color -->
				<span style='color:gray;text-decoration:line-through'><span style='color:#746553'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='red' and ancestor::div[@n='CL']"><!-- This is controlling the strikethrough in another color -->
				<span style='color:#B33B24;text-decoration:line-through'><span style='color:#746553'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@hand='#DL' and parent::add[@rend='red']/..">
				<span style='color:black;text-decoration:line-through'><span style='color:#B33B24'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@hand='#DL' and parent::add[@rend='gray']/..">
				<span style='color:black;text-decoration:line-through'><span style='color:gray'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='red' and parent::add[@rend='red']/..">
				<span style='color:#B33B24;text-decoration:line-through'><span style='color:#B33B24'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='gray' and parent::add[@rend='gray']/..">
				<span style='color:gray;text-decoration:line-through'><span style='color:gray'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='red' and parent::add[@rend='gray']/..">
				<span style='color:#B33B24;text-decoration:line-through'><span style='color:gray'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='gray' and parent::add[@rend='red']/..">
				<span style='color:gray;text-decoration:line-through'><span style='color:#B33B24'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@hand='#DL' and parent::note[ancestor::add[@rend='red']]/..">
				<span style='color:black;text-decoration:line-through'><span style='color:#B33B24'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>		
			<xsl:when test="@hand='#DL' and parent::note[ancestor::add[@rend='gray']]/..">
				<span style='color:black;text-decoration:line-through'><span style='color:gray'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='red' and parent::note[ancestor::add[@rend='red']]/..">
				<span style='color:#B33B24;text-decoration:line-through'><span style='color:#B33B24'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray' and parent::note[ancestor::add[@rend='gray']]/..">
				<span style='color:gray;text-decoration:line-through'><span style='color:gray'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray' and parent::note[ancestor::add[@rend='red']]/..">
				<span style='color:gray;text-decoration:line-through'><span style='color:#B33B24'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='red' and parent::note[ancestor::add[@rend='gray']]/..">
				<span style='color:#B33B24;text-decoration:line-through'><span style='color:gray'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='brown'">
				<span style='color:#8e6352;text-decoration:line-through'><span style='color:black'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='red'">
				<span style='color:#B33B24;text-decoration:line-through'><span style='color:black'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='gray'">
				<span style='color:gray;text-decoration:line-through'><span style='color:black'>
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:otherwise>
				<span class="del cancelled">
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(', ', name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
	
	<xsl:template match="del[following-sibling::add[@place='over-text']]" priority="10">
		<span class="del-by-over-text" title="Text deleted by over-writing">					
				<xsl:choose>
					<xsl:when test="@hand and @type|@hand or @type">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(', ', name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:when>
					<xsl:otherwise>
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'etion')"/>
						</xsl:attribute>
					</xsl:otherwise>
				</xsl:choose>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- added for 1870 FD -->
	<xsl:template match="desc"><span class="figure" title="{../desc}">{text description}</span></xsl:template>

	<!-- For "div" see above -->

	<!-- For "expan" see above -->

	<!-- For "facsimile" see above -->

	<!-- For "front" see above -->

	<!--<xsl:template match="figure">
		<xsl:choose>
		<xsl:when test="head">
			<span class="figure" title="{concat('&quot;', head, '.&quot; ', figDesc)}">{figure}</span>
		</xsl:when>
		<xsl:otherwise>
			<span class="figure" title="{figDesc}">{figure}</span>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>--><!-- Replaced with templated provided by James Cummings -->

	<xsl:template match="figure">
		<!-- newFigDesc goes away and applies templates to content to get it into a single dedupped string -->
		<xsl:variable name="newHead">
			<xsl:apply-templates select="head" mode="normalizeHead"/>
		</xsl:variable>
		<xsl:variable name="newFigDesc">
			<xsl:apply-templates select="figDesc" mode="normalizeFigDesc"/>
		</xsl:variable>
		<xsl:variable name="graphicURL">
			<xsl:apply-templates select="..//@url"/>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="head and $newFigDesc/text()">
				<span class="{concat(name(), ' ', @rend, ' ', @place)}" title="{concat('&quot;', $newHead, '.&quot; ', $newFigDesc)}">{figure}</span>
			</xsl:when>
			<xsl:when test="head and not($newFigDesc/text())">
				<span class="{concat(name(), ' ', @rend, ' ', @place)}" title="{concat('&quot;', $newHead, '.&quot; ')}">{figure}</span>
			</xsl:when>
			<xsl:when test="not(head) and $newFigDesc/text()">
				<span class="{concat(name(), ' ', @rend, ' ', @place)}" title="{$newFigDesc}">{figure}</span>
			</xsl:when>
			<xsl:when test="..//graphic">
				<span class="graphic"><a href="{$graphicURL}"><img src="{$graphicURL}" style="width:100%;"/></a></span>
			</xsl:when>
			<xsl:otherwise>
				<span class="{concat(name(), ' ', @rend, ' ', @place)}">{figure}</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Template passes through abbr, sic, and orig in head in normalizeHead mode -->
	<xsl:template match="head//abbr|head//sic|head//orig" mode="normalizeHead">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Template kills through expan, corr, reg, and supplied in head in normalizeHead mode -->
	<xsl:template match="head//expan|head//corr|head//reg|head//supplied"
		mode="normalizeHead"/>

	<!-- Template passes through abbr, sic, and orig in figDesc in normalizeFigDesc mode -->
	<xsl:template match="figDesc//abbr|figDesc//sic|figDesc//orig" mode="normalizeFigDesc">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Template kills through expan, corr, reg, and supplied in figDesc in normalizeFigDesc mode -->
	<xsl:template match="figDesc//expan|figDesc//corr|figDesc//reg|figDesc//supplied"
		mode="normalizeFigDesc"/>

	<xsl:template match="add[@place='marginleft']/figure|add[@place='marginright']/figure" priority="10">
		<xsl:choose>
		<xsl:when test="head">
			<span class="figure" title="{concat('&quot;', head, '.&quot; ', figDesc)}">figure</span>
		</xsl:when>
		<xsl:otherwise>
			<span class="figure" title="{figDesc}">figure</span>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- An undefined foreign word. -->
	<xsl:template match="foreign[not(term[@xml:lang])]">
		<!--<xsl:variable name="title">A foreign word (not defined).</xsl:variable>
		<span class="foreign" title="{$title}">-->
			<xsl:apply-templates/>
		<!--</span>-->
	</xsl:template>

	<!-- A foreign word defined using an additional <term> tag -->
	<xsl:variable name="foreign" select="doc('foreign-word.xml')"/>
	<xsl:template match="foreign//term[@xml:lang]">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the tribe -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisEntry" select="$foreign//entry[@xml:id=$id]"/>
					<xsl:if test="$thisEntry/form/orth"><xsl:value-of
						select="normalize-space($thisEntry/form/orth)"/> (<xsl:value-of
						select="normalize-space($thisEntry/form/lang)"/>). <xsl:value-of
						select="normalize-space($thisEntry/def[1])"/>.</xsl:if>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A foreign word (not defined).</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the term @type="tribe" in a html:span element with whatever is now in the $title variable -->
		<span class="foreign" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!--<xsl:template match="fw">
		<span class="{concat(name(), ' ', @type, ' ', @rend)}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->
	<!-- Removed the above. If it doesn't mess up anything, remove completely -->


	<xsl:template match="fw[@type='catch']|fw[@type='pageno']">
		<span class="{concat(name(), ' ', @type, ' ', @rend)}" title="">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="fw[child::add[@rend, 'right']][preceding-sibling::note[@rend, 'center']]" priority="10">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@n, '-', ''), ' ', 'right-remove')}"><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="gap[@extent][@unit]" priority="10">
		<xsl:variable name="agent">
			<xsl:if test="@agent">
				<xsl:text>; cause: </xsl:text><xsl:value-of select="@agent">
			</xsl:value-of>
			</xsl:if>
		</xsl:variable>	
		<xsl:choose>
			<xsl:when test="@unit='chars'"><span class="gap" title="{concat(name(), ', extent: ',@extent, ' ', @unit, $agent)}">[<xsl:for-each select="1 to @extent">&#x00A0;</xsl:for-each>]</span></xsl:when>
			<xsl:when test="@unit='words'"><span class="gap" title="{concat(name(), ', extent: ',@extent, ' ', @unit, $agent)}">[<xsl:for-each select="1 to @extent">&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;</xsl:for-each>]</span></xsl:when>
			<xsl:otherwise><span class="gap" title="{concat(name(), ', extent: ',@extent, ' ', @unit, $agent)}">[<xsl:for-each select="1 to @extent">&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;</xsl:for-each>]</span></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- remove gb spans -->
	<xsl:template match="gb">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- geogName begins -->

	<xsl:variable name="geogName" select="doc('geogName.xml')"/>

	<xsl:template match="placeName/geogName[@type='bay']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A bay.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName bay" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='cape']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A Cape.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName cape" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='cataracts']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>Cataracts.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName cataracts" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="placeName/geogName[@type='cave']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A cave.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName cave" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="placeName/geogName[@type='desert']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A desert.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName desert" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='drainage']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A drainage.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName drainage" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='forest']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A forest.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName forest" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='garden']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A garden.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName garden" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='headland']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A headland.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName headland" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='hill']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A hill.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName hill" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='island']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>An island.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName island" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='lake']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A lake.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName lake" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='mountain']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A mountain.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName mountain" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="placeName/geogName[@type='pan']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A pan.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName pan" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="placeName/geogName[@type='pass']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A pass.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName pass" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='plain']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A plain.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName plain" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="placeName/geogName[@type='plateau']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A plateau.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName plateau" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='river']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A river.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName river" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='rivulet']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A rivulet.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName rivulet" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='sea']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A sea.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName sea" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='source']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A source.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName source" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='spring']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A spring.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName spring" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/geogName[@type='valley']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A valley.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName valley" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="placeName/geogName[@type='waterfall']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisGeogName" select="$geogName//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisGeogName/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisGeogName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A waterfall.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the geogName in a html:span element with whatever is now in the $title variable -->
		<span class="geogName waterfall" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- geogName ends -->

	<xsl:template match="head">
		<xsl:variable name="num" select="count(ancestor::*)"/>
		<xsl:element name="{concat('h', $num)}">
			<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@resp, '-', ''), ' ', translate(@n, '-', ''))}"><xsl:apply-templates select="@*|node()"/></span>
		</xsl:element>
	</xsl:template>

	<!-- The following template added for MT: words underlined in another colour-->
	<xsl:template match="hi">
		<xsl:choose>
			<xsl:when test="@hand='#DL' and @rend='underline' and parent::add[@rend='red']/..">
				<span style='color:black;text-decoration:underline'><span style='color:#B33B24'><xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@hand='#DL' and @rend='underline' and parent::add[@rend='gray']/..">
				<span style='color:black;text-decoration:underline'><span style='color:gray'><xsl:apply-templates/></span></span>
			</xsl:when>		
			<xsl:when test="@rend='red underline' and parent::add[@rend='red']/..">
				<span style='color:#B33B24;text-decoration:underline'><span style='color:#B33B24'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray underline' and parent::add[@rend='gray']/..">
				<span style='color:gray;text-decoration:underline'><span style='color:gray'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray underline' and parent::add[@rend='red']/..">
				<span style='color:gray;text-decoration:underline'><span style='color:#B33B24'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='red underline' and parent::add[@rend='gray']/..">
				<span style='color:#B33B24;text-decoration:underline'><span style='color:gray'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@hand='#DL' and @rend='underline' and parent::note[ancestor::add[@rend='red']]/..">
				<span style='color:black;text-decoration:underline'><span style='color:#B33B24'><xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@hand='#DL' and @rend='underline' and parent::note[ancestor::add[@rend='gray']]/..">
				<span style='color:black;text-decoration:underline'><span style='color:gray'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='red underline' and parent::note[ancestor::add[@rend='red']]/..">
				<span style='color:#B33B24;text-decoration:underline'><span style='color:#B33B24'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray underline' and parent::note[ancestor::add[@rend='gray']]/..">
				<span style='color:gray;text-decoration:underline'><span style='color:gray'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray underline' and parent::note[ancestor::add[@rend='red']]/..">
				<span style='color:gray;text-decoration:underline'><span style='color:#B33B24'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='red underline' and parent::note[ancestor::add[@rend='gray']]/..">
				<span style='color:#B33B24;text-decoration:underline'><span style='color:gray'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@hand='#DL' and @rend='underline' and ancestor::div[@hand='#CL']/..">
				<span style='color:black;text-decoration:underline'><span style='color:#746553'><xsl:apply-templates/></span></span>
			</xsl:when>			
			<xsl:when test="@rend='red underline' and ancestor::div[@hand='#CL']/..">
				<span style='color:#B33B24;text-decoration:underline'><span style='color:#746553'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray underline' and ancestor::div[@hand='#CL']/..">
				<span style='color:gray;text-decoration:underline'><span style='color:#746553'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@hand='#DL' and @rend='underline' and ancestor::div[@hand='#U5']/..">
				<span style='color:black;text-decoration:underline'><span style='color:#936541'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='gray underline' and ancestor::div[@hand='#U5']/..">
				<span style='color:gray;text-decoration:underline'><span style='color:#936541'><xsl:apply-templates/></span></span>
			</xsl:when>	
			<xsl:when test="@rend='red underline'">
				<span style='color:#B33B24;text-decoration:underline'><span style='color:black'><xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='gray underline'">
				<span style='color:gray;text-decoration:underline'><span style='color:black'><xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:when test="@rend='brown underline'">
				<span style='color:#8e6352;text-decoration:underline'><span style='color:black'><xsl:apply-templates/></span></span>
			</xsl:when>
			<xsl:otherwise>
				<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@n, '-', ''))}">
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	

	<xsl:template match="idno[@type='LEAP-ID']">
		<span class="idno"><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="list/item">
		<span class="listitem" title="item">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- For "lb" see above -->

	<xsl:template match="list">
		<span class="list" title="list">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<!-- The following templates added for MT. This replaces standard metamark template -->

	<!-- Metamarks alphabetized by @function -->

	<xsl:template match="metamark[@function='close-space']" priority="8">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial symbol used to indicate that the space between words should be reduced">&#65081;<xsl:text> </xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='deletion']" priority="10">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial symbol used to mark a deletion"
			>&#8368;<xsl:text> </xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='dele-abbr']" priority="8">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial annotation instructing that a portion of text should be deleted">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='ed-mark']" priority="10">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial symbol used to point to or highlight a particular portion of text"><xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='insertion']" priority="10">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial symbol used to mark an insertion from another place on the page">&#8618;<xsl:text> </xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='newParagraph']" priority="8">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial instruction to begin a new paragraph">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='no-newParagraph']" priority="10">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial symbol used to close the space between paragraphs">&#645;<xsl:text> </xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='placeMark']" priority="10">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial symbol used to mark the editor's place in the text">/<xsl:text> </xsl:text>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='query']" priority="8"><span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial annotation querying a portion of text"><xsl:apply-templates/>
	</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='stet']" priority="8">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial annotation instructing that a deleted portion of text should be retained"><xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='substitution']" priority="8">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial symbol used to indicate the substitution of one character or word for another, and sometimes to mark an insertion"><xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='transposition']" priority="8">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial instruction to transpose a portion of text from one place to another"><xsl:apply-templates/>
		</span>
	</xsl:template>
	
	<xsl:template match="metamark[@function='unknown']" priority="10">
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n)}" title="Editorial symbol with an unknown function">&#10023;<xsl:text> </xsl:text>
		</span>
	</xsl:template>

	<!-- End list of metamarks alphabetized by @function -->


	<!-- The following template added for MT: two marginal metamarks beside each other. This replaces the corresponding metamark template -->
	<!-- Add all necessary variables below  -->

	<xsl:template match="metamark[@place='marginleft'][preceding-sibling::metamark[@place='marginleft']]" priority="9">
			<xsl:variable name="title">
				<xsl:if test="@function='close-space'">
					<xsl:text>Editorial symbol used to indicate that the space between words should be reduced</xsl:text>
				</xsl:if>
				<xsl:if test="@function='transposition'">
					<xsl:text>Editorial instruction to transpose a portion of text from one place to another</xsl:text>
				</xsl:if>
			</xsl:variable>
		<span class="{concat(name(), ' ', @place, ' ', @rend, ' ', @resp, ' ', @function, ' ', @n, ' ', 'second-margin-metamark')}"
			title="{$title}"><xsl:apply-templates/></span>
	</xsl:template>

	
	<!-- The following templates added for MT: alphabetised metamarks using @spanTo. Organized by @function. -->
	
	<!-- @function flag  -->
	<xsl:template match="metamark
		[contains(@function, 'flag')]
		[substring-after(@spanTo, '#')= following::anchor/@xml:id]">
		<span class="metamark {@rend} {@n}" title="Editorial line, circle, or bracket used to flag a portion of text">&#9136;</span>
	</xsl:template>	
	
	<xsl:template match="metamark
		[contains(@rend, 'gray') and contains(@function, 'flag')]
		[substring-after(@spanTo, '#')= following::anchor/@xml:id]" priority="10">
		<span class="metamark {@rend} {@n}" title="Editorial line, circle, or bracket used to flag a portion of text">&#9136;</span>
	</xsl:template>
	
	<xsl:template match="metamark
		[contains(@rend, 'red') and contains(@function, 'flag')]
		[substring-after(@spanTo, '#')= following::anchor/@xml:id]" priority="10">
		<span class="metamark {@rend} {@n}" title="Editorial line, circle, or bracket used to flag a portion of text">&#9136;</span>
	</xsl:template>
	
	<!-- @function let-stand -->
	<xsl:template match="metamark[contains(@function, 'let-stand')][substring-after(@spanTo, '#')= following::anchor/@xml:id]">
		<xsl:variable name="let-stand">Editorial symbol used to indicate that a deleted word or phrase should be retained</xsl:variable>
		<xsl:element name="span">
			<xsl:attribute name="class" select="'dashed'"/>
			<xsl:attribute name="title" select="$let-stand"/>
			<xsl:comment>Comment needed to make this work.</xsl:comment>
		</xsl:element>
		<xsl:text>&#xA;</xsl:text>
	</xsl:template>
	
	<xsl:template match="metamark[contains(@function, 'let-stand') and contains(@rend, 'gray')][substring-after(@spanTo, '#')= following::anchor/@xml:id]" priority="10">
		<xsl:variable name="let-stand">Editorial symbol used to indicate that a deleted word or phrase should be retained</xsl:variable>
		<xsl:element name="span">
			<xsl:attribute name="class" select="'dashed-gray'"/>
			<xsl:attribute name="title" select="$let-stand"/>
			<xsl:comment>Comment needed to make this work.</xsl:comment>
		</xsl:element>
		<xsl:text>&#xA;</xsl:text>
	</xsl:template>
	
	<xsl:template match="metamark[contains(@function, 'let-stand') and contains(@rend, 'red')][substring-after(@spanTo, '#')= following::anchor/@xml:id]" priority="10">
		<xsl:variable name="let-stand">Editorial symbol used to indicate that a deleted word or phrase should be retained</xsl:variable>
		<xsl:element name="span">
			<xsl:attribute name="class" select="'dashed-red'"/>
			<xsl:attribute name="title" select="$let-stand"/>
			<xsl:comment>Comment needed to make this work.</xsl:comment>
		</xsl:element>
		<xsl:text>&#xA;</xsl:text>
	</xsl:template>
	
	<!-- Added for metamark @function let-stand: see previous above -->
	<xsl:template match="main">
		<xsl:apply-templates select="metamark"/>
	</xsl:template>
	
	<xsl:template match="@*|node()">
		<xsl:copy><xsl:apply-templates select="@*|node()"/></xsl:copy>
	</xsl:template>
	
	<!-- @function reorder -->
	<xsl:template match="metamark
		[contains(@function, 'reorder')]
		[substring-after(@spanTo, '#')= following::anchor/@xml:id]" priority="9">
		<span class="metamark {@rend} {@n}" title="Editorial symbol used to transpose a portion of text from one place to another">&#9136;</span>
	</xsl:template>
	
	<xsl:template match="metamark
		[contains(@rend, 'gray') and contains(@function, 'reorder')]
		[substring-after(@spanTo, '#')= following::anchor/@xml:id]" priority="10">
		<span class="metamark {@rend} {@n}" title="Editorial symbol used to transpose a portion of text from one place to another">&#9136;</span>
	</xsl:template>
	
	<xsl:template match="metamark
		[contains(@rend, 'red') and contains(@function, 'reorder')]
		[substring-after(@spanTo, '#')= following::anchor/@xml:id]" priority="10">
		<span class="metamark {@rend} {@n}" title="Editorial symbol used to transpose a portion of text from one place to another">&#9136;</span>
	</xsl:template>
	
	<!-- The following anchor templates adde for MT: to work with metamarks using @spanTo, @function 'flag' and 'reorder' -->
	<xsl:template match="anchor
		[@xml:id]
		[preceding::metamark/@spanTo = concat('#', @xml:id)]">
		<xsl:variable name="id" select="@xml:id"/>
		<xsl:variable name="metamark" select="preceding::metamark[concat('#', $id)=@spanTo][1]"/>
		<!--  <xsl:variable name="meta-edits">
			<xsl:choose>
				<xsl:when test="preceding::metamark[concat('#', $id)=@spanTo][1][parent::del[@hand, '#DL']]">del</xsl:when>
				<xsl:when test="preceding::metamark[concat('#', $id)=@spanTo][1][parent::retrace]">retrace</xsl:when>
			</xsl:choose>
		</xsl:variable>--> <!--  add {$meta-edits} to span class-->
		<xsl:variable name="metamarkText">
			<xsl:choose>
				<xsl:when test="preceding::metamark[concat('#', $id)=@spanTo][1][contains(@function, 'flag')]"><xsl:text>Editorial line, circle, or bracket used to flag a portion of text</xsl:text></xsl:when>
				<xsl:when test="preceding::metamark[concat('#', $id)=@spanTo][1][contains(@function, 'reorder')]"><xsl:text>Editorial symbol used to transpose a portion of text from one place to another</xsl:text></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<span class="metamark {$metamark/@rend} {$metamark/@n} {$metamark}" title="{$metamarkText}">&#9137;</span>
	</xsl:template>

	<!-- anchor: to work with metamark using @spanTo, @function 'let-stand'. -->
	<xsl:template match="anchor
		[@xml:id]
		[preceding::metamark[@function='let-stand']/@spanTo = concat('#', @xml:id)]" priority="10">
		<xsl:variable name="id" select="@xml:id"/>
		<xsl:variable name="metamark" select="preceding::metamark[concat('#', $id)=@spanTo][1]"/>
		<xsl:variable name="metamarkText">
			<xsl:choose>
				<xsl:when test="preceding::metamark[concat('#', $id)=@spanTo][1][contains(@function, 'let-stand')]"><xsl:text>Editorial symbol used to indicate that a deleted word or phrase should be retained</xsl:text></xsl:when>
			</xsl:choose>
		</xsl:variable>
		<span class="metamark {$metamark/@rend} {$metamark/@n}" title="{$metamarkText}"><xsl:comment>Comment needed to make this work.</xsl:comment></span><!--<xsl:text disable-output-escaping="yes">&lt;/span&gt;</xsl:text><xsl:text disable-output-escaping="yes">&lt;/span&gt;</xsl:text>-->
	</xsl:template>
	
	<!-- End of MT metamarks using @spanTo -->


	<xsl:template match="milestone">
		<xsl:choose>
			<xsl:when test="contains(@rend,'double-line')">
				<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', 'line', ' ', 'first-double')}">&#160;</span><br/>
				<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', 'second-line')}">&#160;</span>
			</xsl:when>
			<xsl:when test="contains(@rend,'triple-line')">
				<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', 'line')}">&#160;</span>
				<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', 'third-line')}">&#160;</span>
				<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', 'third-line')}">&#160;</span>
			</xsl:when>
			<xsl:otherwise>
				<span class="{concat(name(), ' ', translate(@rend, '-', ''))}">&#160;</span>
			</xsl:otherwise>
		</xsl:choose>
			<!--<xsl:if test="@*">
				<xsl:attribute name="title">
					<xsl:value-of select="concat(name(), ': ')"/>
					<xsl:for-each select="@*">
						<xsl:sort/>
						<xsl:value-of select="concat(name(),': ', ., '; ')"/>
					</xsl:for-each>
				</xsl:attribute>
			</xsl:if>
		</hr>-->
	</xsl:template>

	<!-- added for 1870 FD -->
	<xsl:template match="milestone[@unit='column']" priority="10">
		<xsl:apply-templates/>
	</xsl:template>


	<!-- Begin note templates modified for MT -->

	<xsl:template match="note">
		<span class="{concat(name(), ' ', translate(@type, '-', ''), ' ', translate(@anchored, '-', ''), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@n, '-', ''))}"
			>[<xsl:apply-templates/>]</span><!-- @hand and @n added for MT-->
	</xsl:template>

	<xsl:template match="note[ancestor::div]" priority="9">
		<span class="{concat(name(), ' ', translate(@type, '-', ''), ' ', translate(@anchored, '-', ''), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@n, '-', ''))}">
			<xsl:apply-templates/>
		</span><!-- @hand and @n added for MT-->
	</xsl:template>


	<xsl:template match="note[ancestor::add[@place='marginleft']]" priority="10">
		<span class="{concat(name(), ' ', translate(@type, '-', ''), ' ', translate(@anchored, '-', ''), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''))}">
			<xsl:apply-templates/>
		</span><!-- @hand and @n added for MT-->
	</xsl:template>

	<xsl:template match="add[@place='marginleft'][descendant::note]" priority="10">
		<span class="{concat(name(), ' ', translate(@type, '-', ''), ' ', translate(@anchored, '-', ''), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@n, '-', ''))}">
			
					<xsl:if test="@*">
						<xsl:attribute name="title">
							<xsl:value-of select="concat(name(), 'ition, ')"/>
							<xsl:for-each select="@*[not(name()='n')]">
								<xsl:sort/>
								<xsl:if test="not(name()='status')">
									<xsl:value-of select="concat(name(),': ', ., '; ')"/>
								</xsl:if>
							</xsl:for-each>
						</xsl:attribute>
					</xsl:if>
					<xsl:apply-templates/>
		</span><!-- @hand and @n added for MT-->
	</xsl:template>

	<xsl:template match="p/note" priority="8">
		<span class="{concat(name(), ' ', translate(@type, '-', ''), ' ', translate(@anchored, '-', ''), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''))}"><xsl:apply-templates/></span><!-- @hand and @n added for MT-->
	</xsl:template>

	<!-- End note templates modified for MT -->


	<xsl:template match="opener">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- For "orig" see above -->

	<xsl:template match="orgName[not(@ref)]">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:variable name="orgName" select="doc('orgName.xml')"/>
	<xsl:template match="orgName[@ref]" priority="10">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the organization -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisOrgName" select="$orgName//org[@xml:id=$id]"/>
					<xsl:value-of select="$thisOrgName/orgName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisOrgName/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>Group, organization, or other collective not based on nationality.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the orgName in a html:span element with whatever is now in the $title variable -->
		<span class="orgName" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- Not sure what this does. AW -->
	<xsl:template match="jc:page">
		<div class="page">
			<span class="pb-title">
				<xsl:value-of select="@n"/>
			</span>
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="pb">
		<span class="pb-title">
			<xsl:value-of select="@n"/>
		</span>
	</xsl:template>

	<!-- Prevents page numbers from being struckthrough when nestled in one or two dels -->
	<xsl:template match="pb[ancestor::del]|pb[ancestor::del[ancestor::del]]" priority="10">
		<span class="pb-title pb-del">
			<xsl:value-of select="@n"/>
		</span>
	</xsl:template>

	<xsl:variable name="people" select="doc('people.xml')"/>
	<xsl:template match="persName">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisPerson" select="$people//person[@xml:id=$id]"/>
					<xsl:value-of select="$thisPerson/persName[@type='main']"/>					
					<xsl:if test="$thisPerson/birth|$thisPerson/death"> (<xsl:value-of
						select="concat($thisPerson/birth, '-', $thisPerson/death)"/>)</xsl:if>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisPerson/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A person.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the persName in a html:span element with whatever is now in the $title variable -->
		<span class="persName" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- @placeName plus others. To eliminate two spans and addition of whitespace in HTML -->
	<xsl:template match="placeName/bloc|placeName/country">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="postscript">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- For "reg" see above -->

	<xsl:template match="rdg">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:variable name="region" select="doc('region.xml')"/>
	<xsl:template match="placeName/region">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisRegion" select="$region//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisRegion/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisRegion/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A region.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the region in a html:span element with whatever is now in the $title variable -->
		<span class="region" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:variable name="quote" select="doc('quote.xml')"/>
	<xsl:template match="quote">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @corresp, assume it is right and go get information about the person -->
				<xsl:when test="@corresp">
					<xsl:variable name="id" select="substring-after(@corresp, '#')"/>
					<xsl:variable name="thisQuote" select="$quote//bibl[@xml:id=$id]"/>
					<xsl:if test="$thisQuote/author"><xsl:value-of select="normalize-space($thisQuote/author)"/>. <xsl:value-of 
						select="normalize-space($thisQuote/title)"/>. <xsl:value-of
						select="normalize-space($thisQuote/pubPlace)"/>: <xsl:value-of
						select="normalize-space($thisQuote/publisher)"/>, <xsl:value-of
						select="normalize-space($thisQuote/date)"/>. <xsl:value-of
						select="normalize-space($thisQuote/biblScope[@unit='page'])"/>.</xsl:if>
					<xsl:if test="$thisQuote/biblScope[@unit='book']">
						<xsl:value-of select="normalize-space($thisQuote/title)"/>
						<xsl:text>. </xsl:text>
						<xsl:value-of select="normalize-space($thisQuote/biblScope[@unit='book'])"/>
						<xsl:text> </xsl:text>
						<xsl:value-of select="normalize-space($thisQuote/biblScope[@unit='chapter'])"/>
						<xsl:text>:</xsl:text>
						<xsl:value-of select="normalize-space($thisQuote/biblScope[@unit='verse'])"/>
						<xsl:text>.</xsl:text>
					</xsl:if>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A quotation.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the quote in a html:span element with whatever is now in the $title variable -->
		<span class="quote" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>


	<!-- The following templates added for MT: retrace -->

	<xsl:template match="retrace[@rend='gray']" priority="10">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''))}" title="Text retraced in gray by an editor.">
			<xsl:apply-templates/></span>
	</xsl:template>
	
	<xsl:template match="retrace[@rend='red']" priority="10">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''))}" title="Text retraced in red by an editor.">
			<xsl:apply-templates/></span>
	</xsl:template>
	
	<xsl:template match="retrace[@hand='#DL']">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', 'DL')}" title="Text retraced by David Livingstone.">
			<xsl:apply-templates/></span>
	</xsl:template>
	
	<xsl:template match="retrace[@hand='#CL']">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', 'CL')}" title="Text retraced by Charles Livingstone.">
			<xsl:apply-templates/></span>
	</xsl:template>
	
	<xsl:template match="retrace[@hand='#U5']">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', 'U5')}" title="Text retraced by David Livingstone's amanuensis.">
			<xsl:apply-templates/></span>
	</xsl:template>

	<!-- End retrace templates -->


	<xsl:template match="opener/salute">
		<span class="opener-salute">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="closer/salute">
		<span class="closer-salute">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="seg">
	<xsl:choose>
		<xsl:when test='@type="let-stand"'>
			<xsl:variable name="let-stand">Editorial symbol used to indicate that a deleted word or phrase should be retained</xsl:variable>
			<span title="{$let-stand}" class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@type, '-', ''), ' ', translate(@n, '-', ''))}"><xsl:apply-templates/></span>
		</xsl:when>
		<xsl:otherwise>
			<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@hand, '-', ''), ' ', translate(@type, '-', ''), ' ', translate(@n, '-', ''))}"><xsl:apply-templates/></span>
		</xsl:otherwise>	
	</xsl:choose>
	</xsl:template>

	<xsl:variable name="settlement" select="doc('settlement.xml')"/>
	<xsl:template match="placeName/settlement[not(@*)]">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisSettlement" select="$settlement//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisSettlement/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisSettlement/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A settlement.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the settlement in a html:span element with whatever is now in the $title variable -->
		<span class="settlement" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/settlement[@type='city']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisSettlement" select="$settlement//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisSettlement/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisSettlement/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A city.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the settlement @type="city" in a html:span element with whatever is now in the $title variable -->
		<span class="settlement city" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/settlement[@type='town']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisSettlement" select="$settlement//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisSettlement/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisSettlement/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A town.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the settlement @type="town" in a html:span element with whatever is now in the $title variable -->
		<span class="settlement town" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/settlement[@type='state']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisSettlement" select="$settlement//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisSettlement/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisSettlement/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A state.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the settlement @type="state" in a html:span element with whatever is now in the $title variable -->
		<span class="settlement state" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="placeName/settlement[@type='village']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the person -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisSettlement" select="$settlement//place[@xml:id=$id]"/>
					<xsl:value-of select="$thisSettlement/placeName[@type='main']"/>
					<xsl:text>. </xsl:text>
					<xsl:value-of select="normalize-space($thisSettlement/note[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>A village.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the settlement @type="village" in a html:span element with whatever is now in the $title variable -->
		<span class="settlement village" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>


	<!-- For "sic" see above -->

	<xsl:template match="signed">
		<span class="signed">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="space[@extent][@unit]" priority="10">
		<xsl:choose>
			<xsl:when test="@unit='chars'">
				<span class="space">
					<xsl:for-each select="1 to @extent">&#x00A0;&#x00A0;</xsl:for-each>
				</span>
			</xsl:when>
			<xsl:when test="@unit='words'">
				<span class="space">
					<xsl:for-each select="1 to @extent"
						>&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;</xsl:for-each>
				</span>
			</xsl:when>
			<xsl:when test="@dim='vertical'">
				<span class="verticalSpace" title="{concat('vertical space: ',@extent, ' ', @unit)}">
					<xsl:for-each select="1 to @extent">
						<br class="verticalSpace"/>
					</xsl:for-each>
				</span>
				<!--[&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;]
					<br class="verticalSpace"/>-->
			</xsl:when>
			<xsl:otherwise>
				<span class="space-other">
					[<xsl:for-each select="1 to @extent">&#x00A0;&#x00A0;</xsl:for-each>]</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="subst">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- Text below removed for annotated edition; also see app, choice & unlcear -->
	<!--<xsl:template match="supplied">
		<span class="supplied edited hidden"> <xsl:if test="@*"> <xsl:attribute name="title">
			<xsl:value-of select="concat(name(), ', certainty: ', @cert, ', reason: ', @reason)"/>
			</xsl:attribute> </xsl:if>[<xsl:apply-templates select="node()"/>]</span>
	</xsl:template>-->

	<!-- For "surface" see above -->


	<!-- Beginning of elements that go with table -->
	<xsl:template match="table">
		<table>
			<xsl:apply-templates/>
			<!-- select="@*|node()" -->
		</table>
	</xsl:template>

	<xsl:template match="row">
		<tr>
			<xsl:apply-templates/>
			<!-- select="@*|node()" -->
		</tr>
	</xsl:template>

	<xsl:template match="cell">
		<td> &#x00A0;<xsl:apply-templates/>&#x00A0;<!-- select="@*|node()" --> </td>
	</xsl:template>
	<!-- End of elements that go with table -->


	<!-- For "TEI" see above -->

	<!-- For "teiHeader" see above -->

	<!-- For "text" see above -->

	<!-- @term plus other @. To eliminate two spans and addition of whitespace in HTML -->
	<xsl:template match="term[@type='animal']|term[@type='faith']|term[@type='foodstuff']|term[@type='insect']|term[@type='medicament']|term[@type='nationality']|term[@type='occupation']|term[@type='person']|term[@type='people']|term[@type='plant_foodstuff']|term[@type='plant']">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:variable name="tribe" select="doc('ethnic-group.xml')"/>
	<xsl:template match="term[@type='tribe']">
		<!-- Make the output of the @title attribute in a variable -->
		<xsl:variable name="title">
			<xsl:choose>
				<!-- when there is a @ref, assume it is right and go get information about the tribe -->
				<xsl:when test="@ref">
					<xsl:variable name="id" select="substring-after(@ref, '#')"/>
					<xsl:variable name="thisEntry" select="$tribe//entry[@xml:id=$id]"/>
					<xsl:if test="$thisEntry/form/orth"><xsl:value-of
						select="normalize-space($thisEntry/form/orth)"/>. </xsl:if>
					<xsl:value-of select="normalize-space($thisEntry/def[1])"/>
				</xsl:when>
				<!-- otherwise... -->
				<xsl:otherwise>African ethnic group.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<!-- output the term @type="tribe" in a html:span element with whatever is now in the $title variable -->
		<span class="term-tribe" title="{$title}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- Text below removed for annotated edition; also see app, choice & supplied -->	
	<xsl:template match="unclear">
		<span class="unclear">
				<xsl:choose>
				<xsl:when test="@cert">
					<xsl:attribute name="title">
						<xsl:value-of select="concat('word(s) ', name(), '; certainty of transcription: ', @cert)"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="title">
						<xsl:value-of select="concat('word(s) ', name())"/>
					</xsl:attribute>
				</xsl:otherwise>
				</xsl:choose>
			<xsl:apply-templates select="node()"/>
		</span>
	</xsl:template>

	<!-- This and the next are needed for 1871 FD when there are two or more <unclear>s within <choice>. This is the best way I could do this. There is probably a better way. -->
	<xsl:template match="choice/unclear" priority="9">
		<span class="unclear" title="{concat('Unclear. Alternate reading: ', ../unclear[2])}"><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="choice/unclear[2]" priority="10"/>

	<xsl:template match="w">
		<xsl:apply-templates/>
	</xsl:template>

	<!-- For "zone" see above -->


	<!-- Code not in use, but that could be useful -->

	<!--  <xsl:template match="*[not(@type)][not(@reason)][not(@unit)][not(@extent)]" priority="-1">
		<span class="{name()}"><xsl:apply-templates select="@*|node()"/></span>
		</xsl:template> -->

	<!--<xsl:template match="choice/orig">
		<span class="orig diplomatic">
			<xsl:if test="../reg">
				<xsl:attribute name="title">reg: <xsl:value-of select="../reg"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="choice/reg" priority="10">
		<span class="reg edited hidden">
			<xsl:if test="../orig">
				<xsl:attribute name="title">orig: <xsl:value-of select="../orig"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="../orig/node()"/>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="figure/head">
		<span class="figHead">
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="figure/figDesc">
		<xsl:variable name="title"><xsl:apply-templates/></xsl:variable>
		<span class="figfigDesc" title="{$title}">{figure}</span>
	</xsl:template>-->


	<!-- foreign should be italiced in edited view -->
	<!-- <xsl:template match="foreign" xml:space="preserve">
		<span class="foreign diplomatic">
		<xsl:if test="@xml:lang">
			<xsl:attribute name="title">
				<xsl:value-of select="concat('lang: ', @xml:lang)"/>
			</xsl:attribute>
		</xsl:if>
				<xsl:apply-templates/>
		</span>
		<span class="foreign foreignItalic edited hidden" style="font-style:italic;">
		<xsl:if test="@xml:lang">
			<xsl:attribute name="title">
				<xsl:value-of select="concat('lang: ', @xml:lang)"/>
			</xsl:attribute>
		</xsl:if>
			<xsl:apply-templates/></span>
		</xsl:template>-->

	<!--<xsl:template match="fw[@type='pageno']">
		<span class="fw pageno" title="">
			<xsl:apply-templates/>
		</span>
		<br/>
	</xsl:template>-->

	<!--<xsl:template match="lb">
		<br/>
		<xsl:variable name="num">
			<xsl:number level="any" from="pb"/>
		</xsl:variable>
		<xsl:if test="number($num) mod 5 =0">
			<span class="linenumber">
				<xsl:value-of select="$num"/>
			</span>
		</xsl:if>
	</xsl:template>-->
	<!--[not(ancestor::note)]-->

	<!--<xsl:template match="space[@extent][@unit][@dim='vertical']" priority="1">
		<span class="space-other vertical verticalSpace">
			<xsl:attribute name="title">
				<xsl:for-each select="@*">
					<xsl:sort/>
					<xsl:value-of select="concat(name(),': ', ., '; ')"/>
				</xsl:for-each>
			</xsl:attribute>
			<xsl:for-each select="1 to @extent">
				<br class="verticalSpace"/>
			</xsl:for-each>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="term[@type]" priority="1">
		<span class="term" title="{@type}">
		<xsl:apply-templates/>
		</span>
	</xsl:template>-->

	<!-- Tooltip text: ailment, ethnic-group, foreign-word, geogName, orgName, persName/people, region, quote, settlement-->

</xsl:stylesheet>
