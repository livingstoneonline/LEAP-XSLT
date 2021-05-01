<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html [ <!ENTITY nbsp "&#160;"> ]> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="https://www.oxygenxml.com/ns/doc/xsl"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:jc="https://james.blushingbunny.net/ns.html"
	xpath-default-namespace="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="xs xd tei jc"
	version="2.0">
<!-- /*xmlns="http://www.w3.org/TR/REC-html40"*/ -->
<!-- Useful for DTDs https://www.w3.org/TR/xhtml1/dtds.html#h-A2 -->
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Author:</xd:b> Adrian S. Wisnicki</xd:p>
			<xd:p>Rewire LO XSL to Create OMV XSL</xd:p>
			<xd:p>May 2020</xd:p>
			<xd:p>Creative Commons Attribution 4.0 International (https://creativecommons.org/licenses/by/4.0/)</xd:p>
		</xd:desc>
	</xd:doc>

	<xsl:output method="html" version="5.0" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>

	<!-- Incoming parameters -->
	<xsl:param name="page" select="'0001'"/>
	<xsl:param name="paged" select="'true'"/>

	<!-- Transform these to global variables in case they are needed anywhere -->
	<xsl:variable name="pagenumber" select="$page"/>
	<xsl:variable name="isPaged" select="$paged"/>

	<xsl:template match="/">
		<xsl:variable name="subtitle">
			<xsl:choose>
				<xsl:when test="//sourceDesc/msDesc[@type='object-archive']|//sourceDesc/biblStruct[@type='object-book-journal']">Curated Historical Object</xsl:when>
				<xsl:otherwise>Critically-Edited Archival Text</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="additional-authors-1">			
			<xsl:choose>
				<xsl:when test="//teiHeader//titleStmt/author[@role='normalized']">
					<xsl:text>, </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='normalized']" separator=", "/>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="text-creator">
			<xsl:text>Colonial-era text by </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='first-normalized']"/><xsl:value-of select="$additional-authors-1"/> <xsl:text>; published by the One More Voice archival recovery project.</xsl:text>
		</xsl:variable>
		<xsl:variable name="object-creator">
			<xsl:text>Colonial-era object by </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='first-normalized']"/><xsl:value-of select="$additional-authors-1"/> <xsl:text>; published by the One More Voice archival recovery project.</xsl:text>
		</xsl:variable>
		<xsl:variable name="LEAP-ID">
			<xsl:value-of select="//idno[@type='LEAP-ID']"/>
		</xsl:variable>
		<html lang="en">
			<head>
				<meta charset="UTF-8"/>
				<title><!--<xsl:value-of select="//teiHeader//titleStmt/author[@role='first-normalized']"/><xsl:value-of select="$additional-authors-1"/>, --><xsl:value-of select="//teiHeader//titleStmt/title[1]"/> | One More Voice</title>
				<xsl:choose>
					<xsl:when test="//sourceDesc/msDesc[@type='object-archive']|//sourceDesc/biblStruct[@type='object-book-journal']">
						<meta name="description" content="{$object-creator}" />
					</xsl:when>
					<xsl:otherwise>
						<meta name="description" content="{$text-creator}" />
					</xsl:otherwise>
				</xsl:choose>
				<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
				<meta name="robots" content="index, follow"/>
				<meta name="theme-color" content="#204A79"/>
				<meta http-equiv="cache-control" content="no-cache, no-store, must-revalidate" />
				<meta http-equiv="pragma" content="no-cache" />
				<meta http-equiv="expires" content="0" />
				<link rel="apple-touch-icon" sizes="180x180" href="https://onemorevoice.org/img/icons/apple-touch-icon-180x180.png"/>
				<link rel="icon" type="image/png" sizes="32x32" href="https://onemorevoice.org/img/icons/favicon-32x32.png"/>
				<link rel="icon" type="image/png" sizes="16x16" href="https://onemorevoice.org/img/icons/favicon-16x16.png"/>
				<link rel="manifest" href="https://onemorevoice.org/site.webmanifest"/>
				<link rel="preload" as="style" href="https://onemorevoice.org/css/critical.css?=newVers_0004" onload="this.rel='stylesheet'"/>
				<link rel="preload" as="style" href="https://onemorevoice.org/css/style.css?=newVers_0004" onload="this.rel='stylesheet'"/>
				<link rel="preload" as="style" href="https://onemorevoice.org/css/styleTEI.css?=newVers_0001" onload="this.rel='stylesheet'"/>
				<xsl:if test="/TEI/text[contains(@n,'styleTEI-add')]">
					<link rel="preload" as="style" href="https://onemorevoice.org/css/styleTEI-add.css?=newVers_0001" onload="this.rel='stylesheet'"/>
				</xsl:if>
				<link rel="preconnect" as="style" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous"/>
				<link rel="preload" as="script" href="https://onemorevoice.org/js/scripts.js?=newVers_0003"/>
				<link rel="preconnect" as="script" href="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"/>
				<link rel="preconnect" href="https://fonts.gstatic.com"/>
				<link rel="stylesheet" type="text/css" href="https://onemorevoice.org/css/critical.css?=newVers_0004"/>
				<script>
					// Hides fallback nav so that it only appears if Javascript disabled
					function addStyle(styles){var css=document.createElement('style');if(css.styleSheet){css.styleSheet.cssText=styles}else{css.appendChild(document.createTextNode(styles))}document.getElementsByTagName("head")[0].appendChild(css)}var styles='.fallback,.fallback a#nav10,.fallback a#nav11,.fallback a#nav12{display:none !important;visibility:hidden !important}';window.onload=function(){addStyle(styles)};
				</script>
				<script>
					// Taken from https://stackoverflow.com/a/28840664 and https://stackoverflow.com/a/48542058
					// Reloads given page, keeps base URL, path, and any #, but removes random query string
					// (function(){if(window.localStorage){if(!localStorage.getItem('firstLoad')){localStorage['firstLoad']=true;window.location.href=window.location.origin+window.location.pathname+window.location.hash;}else{localStorage.removeItem('firstLoad')}}})();
				</script>			
				<script async="" src="https://www.googletagmanager.com/gtag/js?id=UA-31768072-5"></script>
				<script>window.dataLayer=window.dataLayer||[];function gtag(){dataLayer.push(arguments)}gtag('js',new Date());gtag('config','UA-31768072-5');</script>
			</head>
		
			<!--<xsl:comment>This HTML has been generated from an XML original. Do not manually modify this as a source.</xsl:comment>-->
			<!-- Site code first adapted from Adrian S. Wisnicki's Fieldwork of Empire website (https://awisnicki.github.io/fieldwork_of_empire/) which is released under a Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) license (https://creativecommons.org/licenses/by-nc/4.0/). -->
			<!-- Informed throughout by https://w3c.github.io/aria-practices/examples/ -->

			<body class="transcription " id="body"><!-- style="background:#{$body-color};" -->
				<nav class="navigation fallback"><div class="nav-wrapper"><div class="subnav-wrapper"><a id="nav10" href="https://onemorevoice.org/index.html"><img src="https://onemorevoice.org/img/logo/OMV-logo-87px.jpg" srcset="https://onemorevoice.org/img/logo/OMV-logo-87px.jpg 87w, https://onemorevoice.org/img/logo/OMV-logo-78px.jpg 78w, https://onemorevoice.org/img/logo/OMV-logo-72px.jpg 72w, https://onemorevoice.org/img/logo/OMV-logo-58px.jpg 58w, https://onemorevoice.org/img/logo/OMV-logo-39px.jpg 39w, https://onemorevoice.org/img/logo/OMV-logo-36px.jpg 36w, https://onemorevoice.org/img/logo/OMV-logo-29px.jpg 29w" sizes="(min-width: 768px) 39px, (min-width: 480px) 36px, 29px" alt="One More Voice logo in white on a blue field." title="Home"/></a><a id="nav11" href="https://onemorevoice.org/index.html"><h1>One More Voice</h1></a></div><a id="nav12" href="https://onemorevoice.org/site_sections.html"><i class="fa fa-bars"></i></a></div></nav>
		
				<div data-include="nav"></div>

				<div class="text-container">
		
					<div class="sidebar-container" data-include="sidebar"></div>
		
					<div class="page-wrapper">
						<!-- img sizes calculated using https://ausi.github.io/respimagelint/ -->
						<header id="header">
							<div class="image-wrapper">
								<img class="image-border content-holder-1" src="https://onemorevoice.org/img/main-pages/liv_023005_0001_deriv-1399px.jpg" srcset="https://onemorevoice.org/img/main-pages/liv_023005_0001_deriv-1399px.jpg 1399w, https://onemorevoice.org/img/main-pages/liv_023005_0001_deriv-1276px.jpg 1276w, https://onemorevoice.org/img/main-pages/liv_023005_0001_deriv-1216px.jpg 1216w, https://onemorevoice.org/img/main-pages/liv_023005_0001_deriv-699px.jpg 699w, https://onemorevoice.org/img/main-pages/liv_023005_0001_deriv-638px.jpg 638w, https://onemorevoice.org/img/main-pages/liv_023005_0001_deriv-608px.jpg 608w, https://onemorevoice.org/img/main-pages/liv_023005_0001_deriv-400px.jpg 400w" sizes="(min-width: 780px) 699px, 100vw" alt="Coded text from an XML file produced by One More Voice according to the TEI P5 guidelines." title="A segment of coded text from One More Voice." />
							</div>
						</header>
						<xsl:apply-templates select="TEI"/>
					</div>
		
				</div>
			
				<div data-include="footer"></div>
				
				<script>
					// Adapted from https://stackoverflow.com/a/22634359 and https://stackoverflow.com/a/39179486
					// Adds CSS file and adds random string to end of CSS file.
					// var randomString=Math.floor(Math.random()*1000000);var css=document.createElement("link");css.rel="stylesheet";css.type="text/css";css.href="https://onemorevoice.org/css/style.css?="+randomString;document.head.appendChild(css);var randomString=Math.floor(Math.random()*1000000);var css=document.createElement("link");css.rel="stylesheet";css.type="text/css";css.href="https://onemorevoice.org/css/styleTEI.css?="+randomString;document.head.appendChild(css);var randomString=Math.floor(Math.random()*1000000);var css=document.createElement("link");css.rel="stylesheet";css.type="text/css";css.href="https://onemorevoice.org/css/styleTEI-add.css?="+randomString;document.head.appendChild(css);
				</script>
				<link href="https://fonts.googleapis.com/css2?family=Libre+Franklin:wght@400;700&amp;family=Merriweather:wght@700;900&amp;family=Source+Sans+Pro:wght@400;600&amp;display=swap" rel="stylesheet"/>
				<xsl:if test="/TEI/text[contains(@n,'cedarville')]"><link href="https://fonts.googleapis.com/css2?family=Cedarville+Cursive&amp;display=swap" rel="stylesheet"/></xsl:if>
				<xsl:if test="/TEI/text[contains(@n,'dancing')]"><link href="https://fonts.googleapis.com/css2?family=Dancing+Script&amp;display=swap" rel="stylesheet"/></xsl:if>
				<xsl:if test="/TEI/text[contains(@n,'parisienne')]"><link href="https://fonts.googleapis.com/css2?family=Parisienne&amp;display=swap" rel="stylesheet"/></xsl:if>
				<xsl:if test="/TEI/text[contains(@n,'unifrakturM')]"><link href="https://fonts.googleapis.com/css2?family=UnifrakturMaguntia&amp;display=swap" rel="stylesheet"/></xsl:if>
				<link rel="stylesheet" type="text/css" href="https://onemorevoice.org/css/style.css?=newVers_0004"/>
				<link rel="stylesheet" type="text/css" href="https://onemorevoice.org/css/styleTEI.css?=newVers_0001"/>
				<xsl:if test="/TEI/text[contains(@n,'styleTEI-add')]">
					<link rel="stylesheet" type="text/css" href="https://onemorevoice.org/css/styleTEI-add.css?=newVers_0001"/>
				</xsl:if>
				<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css" integrity="sha512-HK5fgLBL+xu6dm/Ii3z4xhlSUyZgTT9tuc/hSrtw6uzJOvgRr2a9jyxxT1ely+B+xFAmJKVSTbpM/CuL7qxO8w==" crossorigin="anonymous"/>
				<script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
				<script>
					// Adapted from https://stackoverflow.com/a/31837264
					// Includes HTML snippets
					$(function(){var includes=$('[data-include]');jQuery.each(includes,function(){var file='https://onemorevoice.org/common/'+$(this).data('include')+'.html?=newVers_0001';$(this).load(file)})});
				</script>
				<xsl:if test="//sourceDesc/msDesc[@type='manuscript']">
					<script src="https://onemorevoice.org/js/manuscript-transform.js"></script>
				</xsl:if>
				<xsl:if test="//sourceDesc/biblStruct [@type='journal']">
					<script src="https://onemorevoice.org/js/journal-transform.js"></script>
				</xsl:if>
				<xsl:if test="//figure[@n='object' and @change='rotate-180']">
					<!-- Image Rotation -->
					<!-- Adapted from https://www.w3schools.com/howto/howto_js_toggle_class.asp and https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Switch_role -->
					<script>function myFunction(){var element1=document.getElementById("rotate-button");var element2=document.getElementById("image-to-rotate");if(element1.getAttribute("aria-checked")=="true"){element1.setAttribute("aria-checked","false")}else{element1.setAttribute("aria-checked","true")}element1.classList.toggle("click-color");element2.classList.toggle("rotate-180")}</script>
				</xsl:if>
				<script>function googleTranslateElementInit(){new google.translate.TranslateElement({pageLanguage:'en'},'google_translate_element')}</script>
				<script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
				<script>
					// Adapted from https://learn.jquery.com/using-jquery-core/document-ready/ and https://stackoverflow.com/a/39179486
					// Loads JS file only after rest of page has loaded; adds random string to end of file.
					// $(window).on("load",function(){var randomString=Math.floor(Math.random()*1000000);var element=document.createElement("script");element.src="https://onemorevoice.org/js/scripts.js?="+randomString;document.body.appendChild(element)});
					$(window).on("load",function(){var element=document.createElement("script");element.src="https://onemorevoice.org/js/scripts.js?=newVers_0003";document.body.appendChild(element)});
				</script>
				<!-- <script src="https://onemorevoice.org/js/scripts.js?=newVers_0003"></script> -->
			</body>
		</html>
	</xsl:template>

	<!-- Don't show -->
	<xsl:template match="teiHeader|facsimile|surface|zone"/>

	<!-- The following section is key as it sets up the whole text and chooses one of three paths, either manuscript, journal, or object (archive, book, journal). -->
	<!-- TEI -->
	<xsl:template match="TEI">
		<xsl:variable name="body-color-front">
			<xsl:if test="//front/@n[1]">
				<xsl:text>background:#</xsl:text><xsl:apply-templates select="//front/@n[1]"/><xsl:text>;</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="body-color-back">
			<xsl:if test="//back/@n[1]">
				<xsl:text>background:#</xsl:text><xsl:apply-templates select="//back/@n[1]"/><xsl:text>;</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="body-color">
			<xsl:if test="//body/@n[1]">
				<xsl:text>background:#</xsl:text><xsl:apply-templates select="//body/@n[1]"/><xsl:text>;</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="front">
			<xsl:choose>
				<xsl:when test="//front"/>
				<xsl:otherwise>none</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="back">
			<xsl:choose>
				<xsl:when test="//back"/>
				<xsl:otherwise>none</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="encoding">
			<xsl:choose>
				<xsl:when test="//teiHeader//respStmt/name">
					<xsl:value-of select="//teiHeader//respStmt/name[not(.=preceding::name)]" separator=", "/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//teiHeader//revisionDesc/change/name[not(.=preceding::name)]" separator=", "/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="warning-violence">
			<xsl:if test="/TEI/text[contains(@n,'warning-violence')]"><p class="warning"><span class="bold site-red">Warning:</span> Readers are advised to proceed with exceptional caution when consulting this document because it depicts situations involving graphic violence.</p></xsl:if>
		</xsl:variable>
		<xsl:variable name="warning-language">
			<xsl:if test="/TEI/text[contains(@n,'warning-language')]"><p class="warning"><span class="bold site-red">Warning:</span> Readers are advised to proceed with exceptional caution when consulting this document because it contains highly-offensive, racist language.</p></xsl:if>
		</xsl:variable>
		<xsl:variable name="sortedDates" as="xs:string*">
			<xsl:choose>
				<xsl:when test="//revisionDesc/change[@when]">
					<xsl:perform-sort select="//revisionDesc/change/@when[not(.=preceding::change/@when)]"><xsl:sort select="." order="ascending"/></xsl:perform-sort>
				</xsl:when>
				<xsl:otherwise>
					<xsl:perform-sort select="//revisionDesc/change/date[not(.=preceding::change/date)]"><xsl:sort select="." order="ascending"/></xsl:perform-sort>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="additional-authors-1">			
			<xsl:choose>
				<xsl:when test="//teiHeader//titleStmt/author[@role='normalized']">
					<xsl:text>; </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='normalized']" separator="; "/>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="additional-authors-2">			
			<xsl:choose>
				<xsl:when test="//teiHeader//titleStmt/author[@role='normalized']">
					<xsl:text>; </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='normalized']" separator="; "/>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="citation-authorship">
				<xsl:value-of select="//teiHeader//titleStmt/author[@role='first']"/>
				<xsl:value-of select="$additional-authors-2"/>
		</xsl:variable>
		<xsl:variable name="period-after-name">
			<xsl:choose>
				<xsl:when test="$citation-authorship[ends-with(text(), '.')]"/>
				<xsl:otherwise>
					<xsl:text>.</xsl:text>							
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="repo-location">
			<xsl:text> (</xsl:text><xsl:value-of select="string-join((//sourceDesc/msDesc/msIdentifier/settlement, //sourceDesc/msDesc/msIdentifier/country), ', ')"/><xsl:text>)</xsl:text>
		</xsl:variable>
		<xsl:variable name="show-repo-location">
			<xsl:choose>
				<xsl:when test="//sourceDesc/msDesc/msIdentifier/country/text() and //sourceDesc/msDesc/msIdentifier/settlement/text()">
					<xsl:copy-of select="$repo-location"/>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="repository">
			<xsl:choose>
				<xsl:when test="//teiHeader//sourceDesc/msDesc/msIdentifier/repository/text()">															<p><strong>Repository:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/msDesc/msIdentifier/repository" /><xsl:copy-of select="$show-repo-location"/></p>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="collection-link">
			<xsl:value-of select="//sourceDesc/msDesc/msIdentifier/collection/@ref"/>
		</xsl:variable>
		<xsl:variable name="collection-spec">
			<xsl:choose>
			<xsl:when test="//sourceDesc/msDesc/msIdentifier/collection[@ref]">
				<a href="{$collection-link}"><xsl:value-of select="//sourceDesc/msDesc/msIdentifier/collection"/></a>
			</xsl:when>
			<xsl:when test="not(//sourceDesc/msDesc/msIdentifier/collection[@ref])">
				<xsl:value-of select="//sourceDesc/msDesc/msIdentifier/collection"/>
			</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="collection">
			<xsl:choose>
				<xsl:when test="//teiHeader//sourceDesc/msDesc/msIdentifier/collection/text()">															<p><strong>Collection:</strong><xsl:text> </xsl:text><xsl:copy-of select="$collection-spec"/><xsl:copy-of select="$show-repo-location"/></p>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="shelfmark">
			<xsl:choose>
				<xsl:when test="//teiHeader//sourceDesc/msDesc/msIdentifier/idno[@type='shelfmark']/text()">											<p><strong>Shelfmark / Identifier:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/msDesc/msIdentifier/idno[@type='shelfmark']" /></p>
				</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="license1">
			<xsl:value-of select="//teiHeader//publicationStmt/availability/licence[1]/@target"/>
		</xsl:variable>
		<xsl:variable name="license2">
			<xsl:value-of select="//teiHeader//publicationStmt/availability/licence[2]/@target"/>
		</xsl:variable>
		<xsl:variable name="availP1">
			<xsl:apply-templates select="//availability/p[1]/node()"/>
		</xsl:variable>
		<xsl:variable name="availP2">
			<xsl:apply-templates select="//availability/p[2]/node()"/>
		</xsl:variable>
		<xsl:variable name="copyright">
			<xsl:choose>
			<xsl:when test="//availability/licence[@target]">
				<xsl:copy-of select="$availP1"/><xsl:text> </xsl:text><a href="{$license1}"><xsl:value-of select="//teiHeader//publicationStmt/availability/licence[1]"/></a>
				<xsl:if test="//availability/p[2]">
					<xsl:text>. </xsl:text><xsl:copy-of select="$availP2"/><xsl:text> </xsl:text><a href="{$license2}"><xsl:value-of select="//teiHeader//publicationStmt/availability/licence[2]"/></a>.
				</xsl:if>
			</xsl:when>
			<xsl:when test="not(//availability/licence[@target])">
				<xsl:copy-of select="$availP1"/><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//publicationStmt/availability/licence"/>
			</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="LEAP-ID">
			<xsl:value-of select="//idno[@type='LEAP-ID']"/>
		</xsl:variable>
		<xsl:variable name="pub-deets">
			<xsl:variable name="title">
				<xsl:if test="//teiHeader//sourceDesc/biblStruct[@type='journal']//title">
					<xsl:value-of select="//teiHeader//sourceDesc/biblStruct[@type='journal']//title"/>
				</xsl:if>
				<xsl:if test="//teiHeader//sourceDesc/biblStruct[@type='object-book-journal']//title">
					<xsl:value-of select="//teiHeader//sourceDesc/biblStruct[@type='object-book-journal']//title"/>
				</xsl:if>
			</xsl:variable>
			<xsl:variable name="period-after-date">
				<xsl:choose>
					<xsl:when test="//sourceDesc/biblStruct/monogr/imprint/biblScope[@unit='pages'][ends-with(text(), '.')]">
						<xsl:text> </xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text>. </xsl:text>							
					</xsl:otherwise>
				</xsl:choose>
			</xsl:variable>
			<xsl:choose>
				<xsl:when test="//sourceDesc/biblStruct/monogr[contains(@n,'book-section')]">
					<xsl:text>In </xsl:text>
					<xsl:if test="//sourceDesc/biblStruct/monogr/imprint/biblScope[@unit='section']/text()">
						<xsl:text>“</xsl:text><xsl:value-of select="//sourceDesc/biblStruct/monogr/imprint/biblScope[@unit='section']"/><xsl:text>,” </xsl:text>
					</xsl:if>
					<em><xsl:value-of select="$title"/></em>
					<xsl:if test="//sourceDesc/biblStruct/monogr/author/text()">
						<xsl:text>, by </xsl:text>
						<xsl:value-of select="//sourceDesc/biblStruct/monogr/author" separator=" and "/>
					</xsl:if>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="//sourceDesc/biblStruct/monogr/imprint/biblScope[@unit='pages']"/>
					<xsl:value-of select="$period-after-date"/>
					<xsl:if test="//sourceDesc/biblStruct/monogr/editor/text()">
						<xsl:text>Edited by </xsl:text><xsl:value-of select="//sourceDesc/biblStruct/monogr/editor" separator="; "/><xsl:text>. </xsl:text>
					</xsl:if>
					<xsl:value-of select="//sourceDesc/biblStruct/monogr/imprint/pubPlace" separator="; "/>
					<xsl:text>: </xsl:text>
					<xsl:value-of select="//sourceDesc/biblStruct/monogr/imprint/publisher" separator="; "/>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="//sourceDesc/biblStruct/monogr/imprint/date"/>
					<xsl:text>.</xsl:text>
				</xsl:when>
				<xsl:when test="//sourceDesc/biblStruct/monogr[contains(@n,'book')]">
					<xsl:if test="//sourceDesc/biblStruct/monogr/author/text()">
						<xsl:value-of select="//sourceDesc/biblStruct/monogr/author" separator=" and "/>
						<xsl:text>, </xsl:text>
					</xsl:if>
					<em><xsl:value-of select="$title"/></em>
					<xsl:text> (</xsl:text>
					<xsl:value-of select="//sourceDesc/biblStruct/monogr/imprint/pubPlace" separator="; "/>
					<xsl:text>: </xsl:text>
					<xsl:value-of select="//sourceDesc/biblStruct/monogr/imprint/publisher" separator="; "/>
					<xsl:text>, </xsl:text>
					<xsl:value-of select="//sourceDesc/biblStruct/monogr/imprint/date"/>
					<xsl:text>).</xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<em><xsl:value-of select="//sourceDesc/biblStruct[@type='journal']//title"/></em>
					<xsl:if test="//sourceDesc/biblStruct[@type='journal']//imprint/biblScope[@unit='vol']">													<xsl:text> </xsl:text><xsl:value-of select="//sourceDesc/biblStruct[@type='journal']//imprint/biblScope[@unit='vol']"/>
					</xsl:if>
					<xsl:if test="//sourceDesc/biblStruct[@type='journal']//imprint/biblScope[@unit='issue']">
						<xsl:text>, no. </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/biblStruct[@type='journal']//imprint/biblScope[@unit='issue']"/>
					</xsl:if>
					<xsl:text> (</xsl:text>
					<xsl:value-of select="//sourceDesc/biblStruct[@type='journal']//imprint/date"/>
					<xsl:text>)</xsl:text>
					<xsl:if test="//teiHeader//sourceDesc/biblStruct[@type='journal']//imprint/biblScope[@unit='pages']">
						<xsl:text>: </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/biblStruct[@type='journal']//imprint/biblScope[@unit='pages']"/>
					</xsl:if>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="normTitle">
			<xsl:choose>
				<xsl:when test="//teiHeader/fileDesc/titleStmt/title[(@type='normalized')]">
					<xsl:value-of select="//teiHeader/fileDesc/titleStmt/title[(@type='normalized')]"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//teiHeader//sourceDesc/bibl/title[not(@type='alternative')]"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="editorial">
			<xsl:if test="count(//teiHeader//respStmt) > 1">
				<xsl:text>, eds. </xsl:text>
			</xsl:if>
			<xsl:if test="count(//teiHeader//respStmt) = 1">
				<xsl:text>, ed. </xsl:text>
			</xsl:if>
			<xsl:if test="count(//teiHeader//respStmt) = 0">
				<xsl:text>. </xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="edition">
			<xsl:if test="//teiHeader//publicationStmt/date[contains(text(), '2020')]">
				<xsl:text>site launch edition, 2020</xsl:text>
			</xsl:if>
			<xsl:if test="//teiHeader//publicationStmt/date[contains(text(), '2021')]">
				<xsl:text>new dawn edition, 2021</xsl:text>
			</xsl:if>
		</xsl:variable>
		<xsl:variable name="base-uri" select="base-uri(.)"/>
 		<xsl:variable name="filename" select="(tokenize($base-uri,'/'))[last()]"/>
		<xsl:variable name="custom-note">
			<xsl:apply-templates select="//encodingDesc/projectDesc/p/node()"/>
		</xsl:variable>
		<xsl:variable name="prod-note">
			<xsl:choose>
				<xsl:when test="//encodingDesc/projectDesc/p">
					<xsl:copy-of select="$custom-note"/>
				</xsl:when>
				<xsl:when test="//sourceDesc/biblStruct[@type='journal']">This digital edition duplicates as much as possible the textual and material characteristics of the original document. The editors produced the edition by using the following workflow: 1) Convert PDF of original document via OCR to Word; 2) Convert Word to XML; 3) Proofread XML against PDF of original document; and 4) Edit and encode XML using the <em>One More Voice</em><xsl:text> </xsl:text><a href="https://onemorevoice.org/coding_guidelines.html">coding guidelines</a>. However, users are encouraged to consult the original document if possible.</xsl:when>
				<xsl:otherwise>This digital edition duplicates as much as possible the textual, structural, and material characteristics of the original document. The editors produced the edition by transcribing and encoding the text directly from images of the original document using the <em>One More Voice</em><xsl:text> </xsl:text><a href="https://onemorevoice.org/coding_guidelines.html">coding guidelines</a>. Users, however, are encouraged to consult the original document if possible.</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="//sourceDesc/msDesc[@type='manuscript']">
				<aside class="credits" id="main" aria-labelledby="opening-credits">
					<div class="translate" id="translate"><div id="google_translate_element" title="Google Translate provides only a rough, machine-generated rendering of the text. Users should proceed with caution and are urged to consult the original site page alongside any generated translation."></div></div>
					<h2 id="opening-credits"><xsl:value-of select="//teiHeader//titleStmt/title[1]"/></h2>
					<p><strong>Author(s) &amp; contributor(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='first-normalized']"/><xsl:value-of select="$additional-authors-1"/></p>
					<p><strong>Date(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/date" separator="; "/></p>
					<xsl:if test="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/placeName[@type='compositionPlace']">
						<p><strong>Place(s) of creation:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/placeName[@type='compositionPlace']" separator="; "/></p>
					</xsl:if>
					<xsl:copy-of select="$repository"/>
					<xsl:copy-of select="$collection"/>
					<xsl:copy-of select="$shelfmark"/>
					<p><strong>Digital edition &amp; date:</strong><xsl:text> </xsl:text><a href="https://onemorevoice.org/index.html"><xsl:value-of select="//teiHeader//authority"/></a>, an imprint of <a href="https://livingstoneonline.org/">Livingstone Online</a>,<xsl:text> </xsl:text><xsl:value-of select="//teiHeader//publicationStmt/date"/></p>
					<p><strong>Critical editing &amp; encoding</strong><xsl:text>: </xsl:text> <xsl:value-of select="$encoding"/></p>
					<p><strong>Note:</strong> This historical document, published in unabridged form, reflects the cultural beliefs, distortions, and prejudices of its time and may contain material that will upset or distress some readers.</p>
					<xsl:copy-of select="$warning-violence"/>
					<xsl:copy-of select="$warning-language"/>
					<hr/>
				</aside>
			</xsl:when>
			<xsl:when test="//sourceDesc/biblStruct[@type='journal']">
				<aside class="credits" id="main" aria-labelledby="opening-credits">
					<div class="translate" id="translate"><div id="google_translate_element" title="Google Translate provides only a rough, machine-generated rendering of the text. Users should proceed with caution and are urged to consult the original site page alongside any generated translation."></div></div>
					<h2 id="opening-credits"><xsl:value-of select="//teiHeader//titleStmt/title[1]"/></h2>
					<p><strong>Author(s) &amp; contributor(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='first-normalized']"/><xsl:value-of select="$additional-authors-1"/></p>
					<p><strong>Date(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/date" separator="; "/></p>
					<p><strong>Original publication details:</strong><xsl:text> </xsl:text><xsl:copy-of select="$pub-deets"/></p>
					<p><strong>Digital edition &amp; date:</strong><xsl:text> </xsl:text><a href="https://onemorevoice.org/index.html"><xsl:value-of select="//teiHeader//authority"/></a>, an imprint of <a href="https://livingstoneonline.org/">Livingstone Online</a>,<xsl:text> </xsl:text><xsl:value-of select="//teiHeader//publicationStmt/date"/></p>
					<p><strong>Critical editing &amp; encoding</strong><xsl:text>: </xsl:text> <xsl:value-of select="$encoding"/></p>
					<p><strong>Note:</strong> This historical document, published in unabridged form, reflects the cultural beliefs, distortions, and prejudices of its time and may contain material that will upset or distress some readers.</p>
					<xsl:copy-of select="$warning-violence"/>
					<xsl:copy-of select="$warning-language"/>
					<hr/>
				</aside>
			</xsl:when>
			<xsl:when test="//sourceDesc/msDesc[@type='object-archive']">
				<aside class="credits" id="main" aria-labelledby="opening-credits">
					<div class="translate" id="translate"><div id="google_translate_element" title="Google Translate provides only a rough, machine-generated rendering of the text. Users should proceed with caution and are urged to consult the original site page alongside any generated translation."></div></div>
					<h2 id="opening-credits"><xsl:value-of select="//teiHeader//titleStmt/title[1]"/></h2>
					<p><strong>Creator(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='first-normalized']"/><xsl:value-of select="$additional-authors-1"/></p>
					<p><strong>Date(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/date" separator="; "/></p>
					<xsl:if test="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/placeName[@type='compositionPlace']">
						<p><strong>Place(s) of creation:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/placeName[@type='compositionPlace']" separator="; "/></p>
					</xsl:if>
					<xsl:copy-of select="$repository"/>
					<xsl:copy-of select="$collection"/>
					<xsl:copy-of select="$shelfmark"/>
					<p><strong>Note:</strong> This historical object reflects the cultural beliefs, distortions, and prejudices of its time and may contain material that will upset or distress some readers.</p>
					<xsl:copy-of select="$warning-violence"/>
					<xsl:copy-of select="$warning-language"/>
					<hr/>
				</aside>
			</xsl:when>
			<xsl:when test="//sourceDesc/biblStruct[@type='object-book-journal']">
				<aside class="credits" id="main" aria-labelledby="opening-credits">
					<div class="translate" id="translate"><div id="google_translate_element" title="Google Translate provides only a rough, machine-generated rendering of the text. Users should proceed with caution and are urged to consult the original site page alongside any generated translation."></div></div>
					<h2 id="opening-credits"><xsl:value-of select="//teiHeader//titleStmt/title[1]"/></h2>
					<p><strong>Creator(s) &amp; contributor(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//titleStmt/author[@role='first-normalized']"/><xsl:value-of select="$additional-authors-1"/></p>
					<p><strong>Date(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/date" separator="; "/></p>
					<xsl:if test="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/placeName[@type='compositionPlace']">
						<p><strong>Place(s) of creation:</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/placeName[@type='compositionPlace']" separator="; "/></p>
					</xsl:if>
					<p><strong>Original publication details:</strong><xsl:text> </xsl:text><xsl:copy-of select="$pub-deets"/></p>
					<p><strong>Note:</strong> This historical object reflects the cultural beliefs, distortions, and prejudices of its time and may contain material that will upset or distress some readers.</p>
					<xsl:copy-of select="$warning-violence"/>
					<xsl:copy-of select="$warning-language"/>
					<hr/>
				</aside>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="//sourceDesc/msDesc[@type='manuscript']">
				<aside id="transcription-switches" class="manuscript-switches">
					<label for="remove-color" class="md_switch" title="Color: On/Off">
						<xsl:text>Remove Color</xsl:text>
						<input type="checkbox" role="switch" data-toggle="button" aria-checked="true" aria-label="Toggle color" id="remove-color" checked="" />
						<span class="md_switch__toggle"></span>
				 	</label>
				 	<label for="invert" class="md_switch" title="Color Inversion: On/Off">
						<xsl:text>Invert</xsl:text>
						<input type="checkbox" role="switch" data-toggle="button" aria-checked="true" aria-label="Toggle color inversion" id="invert" checked="" />
						<span class="md_switch__toggle"></span>
				 	</label>
				 	<label for="remove-rotation" class="md_switch" title="Rotation: On/Off">
						<xsl:text>Remove Rotation</xsl:text>
						<input type="checkbox" role="switch" data-toggle="button" aria-checked="true" aria-label="Toggle rotation" id="remove-rotation" checked="" />
						<span class="md_switch__toggle"></span>
				 	</label>
			 	</aside>
				<aside class="narrow-mobile" id="narrow-mobile-div" aria-labelledby="mobile">
					<p id="mobile">Please turn your mobile device to <span class="highlight">landscape</span> or <span class="highlight">widen your browser window</span> for optimal viewing of this archival document.</p>
				</aside>
				<main class="manuscript" id="manuscript-div"><!-- style="background:#{$body-color};" -->
					<section class="TEI front {$front}" style="{$body-color-front}" aria-labelledby="front-section">
						<div class="ms-container" id="front-section">
							<xsl:comment><xsl:value-of select="$isPaged"/></xsl:comment>
							<xsl:choose>
								<xsl:when test="$isPaged='true' and //jc:page[@n=$pagenumber]">
									<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
								</xsl:when>
								<xsl:when test="$isPaged='false'">
									<xsl:apply-templates select="text/front"/>
								</xsl:when>
								<xsl:when test="//jc:page[@n=$pagenumber]">
									<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="text/front"/>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</section>
					<section class="TEI" style="{$body-color}" aria-labelledby="main-section">
						<div class="ms-container" id="main-section">
							<xsl:comment><xsl:value-of select="$isPaged"/></xsl:comment>
							<xsl:choose>
								<xsl:when test="$isPaged='true' and //jc:page[@n=$pagenumber]">
									<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
								</xsl:when>
								<xsl:when test="$isPaged='false'">
									<xsl:apply-templates select="text/body"/>
								</xsl:when>
								<xsl:when test="//jc:page[@n=$pagenumber]">
									<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="text/body"/>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</section>
					<section class="TEI back {$back}" style="{$body-color-back}" aria-labelledby="back-section">
						<div class="ms-container" id="back-section">
							<xsl:comment><xsl:value-of select="$isPaged"/></xsl:comment>
							<xsl:choose>
								<xsl:when test="$isPaged='true' and //jc:page[@n=$pagenumber]">
									<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
								</xsl:when>
								<xsl:when test="$isPaged='false'">
									<xsl:apply-templates select="text/back"/>
								</xsl:when>
								<xsl:when test="//jc:page[@n=$pagenumber]">
									<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="text/back"/>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</section>
				</main>
			</xsl:when>
			<xsl:when test="//sourceDesc/biblStruct[@type='journal']">
				<aside id="transcription-switches" class="journal-switches">
				 	<label for="invert" class="md_switch" title="Color Inversion: On/Off">
						<xsl:text>Invert</xsl:text>
						<input type="checkbox" role="switch" data-toggle="button" aria-checked="true" aria-label="Toggle color inversion" id="invert" checked="" />
						<span class="md_switch__toggle"></span>
				 	</label>
				 	<label for="remove-justification" class="md_switch" title="Justification: On/Off">
						<xsl:text>Remove Justification</xsl:text>
						<input type="checkbox" role="switch" data-toggle="button" aria-checked="true" aria-label="Toggle rotation" id="remove-justification" checked="" />
						<span class="md_switch__toggle"></span>
				 	</label>
			 	</aside>
				<aside class="narrow-mobile" id="narrow-mobile-div" aria-labelledby="mobile">
					<p id="mobile">Please turn your mobile device to <span class="highlight">landscape</span> or <span class="highlight">widen your browser window</span> for optimal viewing of this archival document.</p>
				</aside>
				<xsl:variable name="narrow">
					<xsl:if test="//sourceDesc/biblStruct/monogr[contains(@n,'narrow')]">narrow</xsl:if>
				</xsl:variable>
				<main class="journal {$narrow}" id="journal-div"><!-- style="background:#{$body-color};" -->
					<div class="TEI">
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
				</main>
			</xsl:when>
			<xsl:when test="//sourceDesc/msDesc[@type='object-archive']|//sourceDesc/biblStruct[@type='object-book-journal']">
				<main class="object" id="object-div"><!-- style="background:#{$body-color};" -->
					<section class="TEI" aria-labelledby="main-section">
						<div class="ms-container" id="main-section">
							<p class="image-enlarge">Click on image(s) to enlarge</p>
							<xsl:comment><xsl:value-of select="$isPaged"/></xsl:comment>
							<xsl:choose>
								<xsl:when test="$isPaged='true' and //jc:page[@n=$pagenumber]">
									<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
								</xsl:when>
								<xsl:when test="$isPaged='false'">
									<xsl:apply-templates select="text/body"/>
								</xsl:when>
								<xsl:when test="//jc:page[@n=$pagenumber]">
									<xsl:apply-templates select="//jc:page[@n=$pagenumber]"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:apply-templates select="text/body"/>
								</xsl:otherwise>
							</xsl:choose>
						</div>
					</section>
				</main>
			</xsl:when>
		</xsl:choose>
		<xsl:choose>
			<xsl:when test="//sourceDesc/msDesc[@type='manuscript']">
				<aside class="credits" id="credits2-div" aria-labelledby="closing-credits">
					<div id="closing-credits">
						<hr />
						<!--<p class="back-button"><a class="trans-return" href="https://onemorevoice.org/texts.html#{$LEAP-ID}">&#11013;&#xFE0E; Back</a></p>-->
						<p><strong>Terms of use:</strong><xsl:text> </xsl:text><xsl:copy-of select="$copyright"/></p>
						<p><strong>Cite this digital edition (MLA)</strong><xsl:text>: </xsl:text>
						<xsl:value-of select="//teiHeader//titleStmt/author[@role='first']"/>
						<xsl:value-of select="$additional-authors-2"/><xsl:value-of select="$period-after-name"/><xsl:text> “</xsl:text>
						<xsl:value-of select="$normTitle"/><xsl:text>” (</xsl:text><xsl:value-of select="//sourceDesc/bibl/date" separator="; "/><xsl:text>). </xsl:text><xsl:value-of select="$encoding"/><xsl:value-of select="$editorial"/>
						<em>One More Voice</em> (an imprint of <em>Livingstone Online</em>), <xsl:value-of select="$edition"/>, <a href="https://onemorevoice.org/html/transcriptions/{substring-before($filename, '.xml')}.html">https://onemorevoice.org/html/transcriptions/<xsl:value-of select="substring-before($filename, '.xml')"/>.html</a>.</p>
						<xsl:if test="//publicationStmt/ref">
							<xsl:variable name="source-link1">
								<xsl:value-of select="//publicationStmt/ref[1]/@target"/>
							</xsl:variable>
							<xsl:variable name="source-link2">
								<xsl:value-of select="//publicationStmt/ref[2]/@target"/>
							</xsl:variable>
							<p><strong>Explore complete/original item:</strong><xsl:text> </xsl:text><a href="{$source-link1}"><xsl:value-of select="//publicationStmt/ref[1]"/></a>
							<xsl:if test="//publicationStmt/ref[2]">
								<xsl:text>; </xsl:text><a href="{$source-link2}"><xsl:value-of select="//publicationStmt/ref[2]"/></a>
							</xsl:if>
							</p>
						</xsl:if>
						<p><strong>Production note</strong><xsl:text>: </xsl:text><xsl:copy-of select="$prod-note"/></p>
					</div>
				</aside>
			</xsl:when>
			<xsl:when test="//sourceDesc/biblStruct[@type='journal']">
				<aside class="credits" id="credits2-div" aria-labelledby="closing-credits">
					<div id="closing-credits">
						<hr/>
						<!--<p class="back-button"><a class="trans-return" href="https://onemorevoice.org/texts.html#{$LEAP-ID}">&#11013;&#xFE0E; Back</a></p>-->
						<p><strong>Terms of use:</strong><xsl:text> </xsl:text><xsl:copy-of select="$copyright"/></p>
						<p><strong>Cite this digital edition (MLA)</strong><xsl:text>: </xsl:text>
						<xsl:value-of select="//teiHeader//titleStmt/author[@role='first']"/>
						<xsl:value-of select="$additional-authors-2"/><xsl:value-of select="$period-after-name"/><xsl:text> “</xsl:text>
						<xsl:value-of select="$normTitle"/><xsl:text>” (</xsl:text><xsl:value-of select="//sourceDesc/bibl/date" separator="; "/><xsl:text>). </xsl:text><xsl:value-of select="$encoding"/><xsl:value-of select="$editorial"/>
						<em>One More Voice</em> (an imprint of <em>Livingstone Online</em>), <xsl:value-of select="$edition"/>, <a href="https://onemorevoice.org/html/transcriptions/{substring-before($filename, '.xml')}.html">https://onemorevoice.org/html/transcriptions/<xsl:value-of select="substring-before($filename, '.xml')"/>.html</a>.</p>
						<xsl:if test="//publicationStmt/ref">
							<xsl:variable name="source-link1">
								<xsl:value-of select="//publicationStmt/ref[1]/@target"/>
							</xsl:variable>
							<xsl:variable name="source-link2">
								<xsl:value-of select="//publicationStmt/ref[2]/@target"/>
							</xsl:variable>
							<p><strong>Explore complete/original item:</strong><xsl:text> </xsl:text><a href="{$source-link1}"><xsl:value-of select="//publicationStmt/ref[1]"/></a>
							<xsl:if test="//publicationStmt/ref[2]">
								<xsl:text>; </xsl:text><a href="{$source-link2}"><xsl:value-of select="//publicationStmt/ref[2]"/></a>
							</xsl:if>
							</p>
						</xsl:if>
						<p><strong>Production note</strong><xsl:text>: </xsl:text><xsl:copy-of select="$prod-note"/></p>
					</div>
				</aside>
			</xsl:when>
			<xsl:when test="//sourceDesc/msDesc[@type='object-archive']|//sourceDesc/biblStruct[@type='object-book-journal']">
				<aside class="credits" id="credits2-div" aria-labelledby="closing-credits">
					<div id="closing-credits">
						<hr />
						<!--<p class="back-button"><a class="art-return" href="https://onemorevoice.org/visual_materials.html#{$LEAP-ID}">&#11013;&#xFE0E; Back</a></p>-->
						<p><strong>Terms of use:</strong><xsl:text> </xsl:text><xsl:copy-of select="$copyright"/></p>
						<p><strong>Digital edition &amp; date:</strong><xsl:text> </xsl:text><a href="https://onemorevoice.org/index.html"><xsl:value-of select="//teiHeader//authority"/></a>, an imprint of <a href="https://livingstoneonline.org/">Livingstone Online</a>,<xsl:text> </xsl:text><xsl:value-of select="//teiHeader//publicationStmt/date"/></p>
						<p><strong>Digital object curation</strong><xsl:text>: </xsl:text> <xsl:value-of select="$encoding"/></p>
						<p><strong>Cite this digital edition (MLA)</strong><xsl:text>: </xsl:text>
						<xsl:value-of select="//teiHeader//titleStmt/author[@role='first']"/>
						<xsl:value-of select="$additional-authors-2"/><xsl:value-of select="$period-after-name"/><xsl:text> “</xsl:text>
						<xsl:value-of select="$normTitle"/><xsl:text>” (</xsl:text><xsl:value-of select="//sourceDesc/bibl/date" separator="; "/><xsl:text>). </xsl:text><!--<xsl:value-of select="$encoding"/><xsl:value-of select="$editorial"/>-->
						<em>One More Voice</em> (an imprint of <em>Livingstone Online</em>), <xsl:value-of select="$edition"/>, <a href="https://onemorevoice.org/html/transcriptions/{substring-before($filename, '.xml')}.html">https://onemorevoice.org/html/transcriptions/<xsl:value-of select="substring-before($filename, '.xml')"/>.html</a>.</p>
						<xsl:if test="//publicationStmt/ref">
							<xsl:variable name="source">
								<xsl:for-each select="//publicationStmt/ref">
									<xsl:variable name="link" select="@target"/>
									<xsl:variable name="source" select="node()"/>
									<a href="{$link}"><xsl:value-of select="$source"/></a>
								 	<xsl:if test="position() != last()">
										<xsl:text>; </xsl:text>
								 	</xsl:if>
								</xsl:for-each>
							</xsl:variable>
								<!--<xsl:variable name="link">
									<xsl:value-of select="@target"/>
								</xsl:variable>
								<a href="{$link}"><xsl:value-of select="" separator="; "/></a>
							</xsl:variable>-->
							<p><strong>Explore complete/original item:</strong><xsl:text> </xsl:text><xsl:copy-of select="$source"/></p>
						</xsl:if>
					</div>
				</aside>
			</xsl:when>
		</xsl:choose>
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
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<!-- need: bold, italic, sub, sup -->

	<!-- Make rend classes -->
	<xsl:template match="*/@rend" priority="-1">
		<xsl:attribute name="class">
			<xsl:value-of select="concat(parent::node()/name(), ' ')"/>
			<xsl:value-of select="translate(., '-', '')"/>
		</xsl:attribute>
	</xsl:template>

	<!-- Textual divisions -->
	<xsl:template match="text|body|front|back">
		<div class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''))}">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="div">
		<div class="{concat(name(), ' ', @rend, ' ', @n)}">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="lg">
		<xsl:choose>
			<xsl:when test="@type='verse'">
				<div class="poem-wrapper">
					<div class="{concat('poem', ' ', @type, ' ', @rend, ' ', @n)}">
						<xsl:apply-templates/>
					</div>
				</div>
			</xsl:when>
			<xsl:when test="@type='stanza'">
				<p class="{concat('poetic-section', ' ', @type, ' ', @rend, ' ', @n)}">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<div class="{concat('poem', ' ', @type, ' ', @rend, ' ', @n)}">
					<xsl:apply-templates/>
				</div>
			</xsl:otherwise>	
		</xsl:choose>
	</xsl:template>

	<xsl:template match="l">
		<seg class="{concat('poetic-line', ' ', @type, ' ', @rend, ' ', @n)}">
			<xsl:apply-templates/>
		</seg>
	</xsl:template>

	<xsl:template match="lb">
			<br/>
		<xsl:variable name="num">
			<xsl:number level="any" from="pb"/>
		</xsl:variable>
		<xsl:if test="number($num) mod 5 =0">
			<span class="linenumber">
				<xsl:value-of select="$num"/>
			</span>
		</xsl:if>
	</xsl:template>

	<!-- Alphabetical list of elements. Alphabetized by last element in path *or* first element among options. -->

	<xsl:template match="ab|p">
		<p class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''))}">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="abbr">
		<abbr><xsl:apply-templates/></abbr>
	</xsl:template>

	<xsl:template match="add">
		<ins class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''), ' ', translate(@n, '-', ''))}"><xsl:apply-templates/></ins>
	</xsl:template>

	<xsl:template match="add[@place='over-text']">
		<ins class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''))}" title="Addition written over existing text"><xsl:apply-templates/></ins>
	</xsl:template>

	<xsl:template match="tei:addSpan[preceding-sibling::node()[1][name()='p']]|tei:addSpan[preceding-sibling::node()[2][name()='p']]|p/addSpan">
		<br/>
		<xsl:apply-templates/>
	</xsl:template>

	<!-- app: show first rdg, offer alternatives in title -->
	<xsl:template match="app">
		<xsl:variable name="rdg-rdg">
			<xsl:value-of select="../app/rdg" separator=" [or] "/>
		</xsl:variable>
		<span class="app">
			<xsl:attribute name="title">This passage can be read in alternate ways: <xsl:value-of select="$rdg-rdg"/></xsl:attribute>
			<xsl:apply-templates select="rdg[1]"/>
		</span>
	</xsl:template>

	<xsl:template match="cb">
		<xsl:apply-templates/>
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
			<u class="sic diplomatic">
				<xsl:attribute name="title">The editors suggest a correction as follows: <xsl:value-of select="$choice-orig-sic"/></xsl:attribute>
				<xsl:apply-templates/>
			</u>
	</xsl:template>

	<xsl:template match="corr|expan|reg"/>

	<xsl:template match="date">
		<time><xsl:apply-templates/></time>
	</xsl:template>

	<xsl:template match="del">
		<del class="del cancelled">
			<xsl:apply-templates/>
		</del>
	</xsl:template>

	<xsl:template match="del[following-sibling::add[1][@place='over-text']]" priority="10">
		<del class="del-by-over-text" title="Text deleted by over-writing"><xsl:apply-templates/></del>
	</xsl:template>

	<xsl:template match="figure">
		<!-- start of variables -->
		<xsl:variable name="figure-facs">
			<xsl:apply-templates select="self::node()/@facs"/>
		</xsl:variable>
		<xsl:variable name="graphic-url">
			<xsl:apply-templates select="self::node()/graphic/@url"/>
		</xsl:variable>
		<xsl:variable name="graphic-facs">
			<xsl:apply-templates select="self::node()/graphic/@facs"/>
		</xsl:variable>
		<xsl:variable name="graphic-n">
			<xsl:apply-templates select="self::node()/graphic/@n"/>
		</xsl:variable>
		<xsl:variable name="altText">
			<xsl:apply-templates select="self::node()/figDesc"/>
		</xsl:variable>
		<!-- This variable creates the title for the object image. -->
		<xsl:variable name="caption">
			<xsl:variable name="copyright">
				<xsl:if test="//availability/licence[@target]">
					<xsl:text> (</xsl:text><xsl:value-of select="//availability/licence/@target"/><xsl:text>).</xsl:text>
				</xsl:if>
			</xsl:variable>
			<xsl:value-of select="self::node()/label"/><xsl:text>. </xsl:text><xsl:value-of select="//availability/p"/><xsl:text> </xsl:text><xsl:value-of select="//availability/licence"/><xsl:value-of select="$copyright"/>
		</xsl:variable>
		<xsl:variable name="rotate-id">
			<xsl:if test="self::node()[@n='object' and @change='rotate-180']">
				<xsl:text>image-to-rotate</xsl:text>
			</xsl:if>
		</xsl:variable>
		<!-- The prior variable creates a static id for all images to be rotated. This is not an ideal solution and needs to be improved down the road because, if there are two object images in the same document that both need to rotated, they will both get the same id. However, The following code, if used in place of <xsl:text>image-to-rotate</xsl:text> above, gives each image to be rotated a unique id based on its page number(s). This could be the way to a better solution, but would involved working out the Javascript to select that same id.-->
		<!-- <xsl:value-of select="/TEI/text/body/div/p/figure/graphic/@*[namespace-uri()='http://www.w3.org/XML/1998/namespace' and local-name()='id']"/> -->
		<!-- end of variables -->
		<xsl:choose>
			<xsl:when test="contains(@n,'object') and contains(@change,'rotate-180')">
				<!-- Button/rotation functionality adapted from https://www.w3schools.com/howto/howto_js_toggle_class.asp and https://developer.mozilla.org/en-US/docs/Web/Accessibility/ARIA/Roles/Switch_role -->
				<button role="switch" aria-checked="false" aria-label="Rotate image" id="rotate-button" onclick="myFunction()">Rotate <i class="fa fa-repeat" aria-hidden="true"></i></button>
				<br/><br/><br/>
				<span class="{concat(name(), ' ', @rend, ' ', @n)}">
					<a href="{$figure-facs}">	
						<img loading="lazy" src="{$graphic-url}" srcset="{$graphic-facs}" sizes="{$graphic-n}" alt="{$altText}" title="{normalize-space($caption)}" id="{$rotate-id}"/>
					</a>
				</span>
			</xsl:when>
			<xsl:when test="contains(@n,'object')">
				<span class="{concat(name(), ' ', @rend, ' ', @n)}">
					<a href="{$figure-facs}">	
						<img loading="lazy" src="{$graphic-url}" srcset="{$graphic-facs}" sizes="{$graphic-n}" alt="{$altText}" title="{normalize-space($caption)}"/>
					</a>
				</span>
			</xsl:when>
			<xsl:when test="'[child::graphic]'">
				<span class="{concat(name(), ' ', @rend, ' ', @n)}"><img loading="lazy" src="{$graphic-url}" srcset="{$graphic-facs}" sizes="{$graphic-n}" alt="{$altText}"/></span>
			</xsl:when>
			<xsl:otherwise>
				<span class="{concat(name(), ' ', @rend, ' ', @n)}">{figure}</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- An undefined foreign word. -->
	<xsl:template match="foreign[not(term[@xml:lang])]">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="fw|fw[@type='catch']">
		<span class="{concat(name(), ' ', @type, ' ', @rend, ' ', @place)}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="gap[@extent][@unit]" priority="10">
		<xsl:choose>
			<xsl:when test="@unit='chars'"><span class="gap" title="{concat(name(), ', extent: ', @extent, ' ', @unit, '; reason: ', @agent)}">[<xsl:for-each select="1 to @extent">&#x00A0;</xsl:for-each>]</span></xsl:when>
			<xsl:when test="@unit='words'"><span class="gap" title="{concat(name(), ', extent: ', @extent, ' ', @unit, '; reason: ', @agent)}">[<xsl:for-each select="1 to @extent">&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;</xsl:for-each>]</span></xsl:when>
			<xsl:when test="@unit='lines'"><span class="gap" title="{concat(name(), ', extent: ', @extent, ' ', @unit, '; reason: ', @agent)}">[&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;]</span></xsl:when>
			<xsl:when test="@unit='pages'"><span class="gap" title="{concat(name(), ', extent: ', @extent, ' ', @unit, '; reason: ', @agent)}">[&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;]</span></xsl:when>
			<xsl:otherwise><span class="gap" title="{concat(name(), ', extent: ', @extent, ' ', @unit, 'reason: ', @agent)}">[<xsl:for-each select="1 to @extent">&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;&#x00A0;</xsl:for-each>]</span></xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- do not show graphic -->
	<xsl:template match="graphic"/>

	<xsl:template match="head">
		<xsl:choose>
			<xsl:when test="@type='subheading'">
				<h4 class="{concat(name(), ' ', @type, ' ', @rend, ' ', @place, ' ', @n)}">
					<xsl:apply-templates/>
				</h4>
			</xsl:when>
			<xsl:otherwise>
				<h3 class="{concat(name(), ' ', @type, ' ', @rend, ' ', @place, ' ', @n)}">
					<xsl:apply-templates/>
				</h3>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="idno[@type='LEAP-ID']">
		<span class="idno"><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="item">
		<li class="{concat(name(), ' ', @type, ' ', @rend, ' ', @n)}">
			<xsl:apply-templates/>
		</li>
	</xsl:template>

	<xsl:template match="list">
		<!--<span class="{concat(name(), ' ', @type, ' ', @rend, ' ', @place)}" title="list">
			<xsl:apply-templates/>
		</span>-->
		<xsl:if test="@type='ordered'">
			<ol class="{concat(name(), ' ', @type, ' ', @rend, ' ', @place)}">
				<xsl:apply-templates/>
			</ol>
		</xsl:if>
		<xsl:if test="@type='unordered'">
			<ul class="{concat(name(), ' ', @type, ' ', @rend, ' ', @n)}">
				<xsl:apply-templates/>
			</ul>
		</xsl:if>
	</xsl:template>

	<xsl:template match="metamark"><span class="metamark {@rend} {@function} {@place}" title="Editorial symbol, mark, or unusual character">#</span></xsl:template>

	<xsl:template match="add[@place='marginleft']/metamark|add[@place='marginright']/metamark" priority="10">
			<ins class="metamark {@rend} {@function} {@place}" title="Editorial symbol, mark, or unusual character">#</ins>
	</xsl:template>

	<xsl:template match="milestone">
		<xsl:choose>
			<xsl:when test="//sourceDesc/msDesc[@type='manuscript']">
				<xsl:choose>
					<xsl:when test="contains(@rend,'double-line')">
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''), ' ', 'line', ' ', 'first-double')}"/>
					</xsl:when>
					<xsl:when test="contains(@rend,'triple-line')">
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''), ' ', 'line')}"/>
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''), ' ', 'third-line')}"/>
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''), ' ', 'third-line')}"/>
					</xsl:when>
					<xsl:otherwise>
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''))}"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="//sourceDesc/biblStruct[@type='journal']">
				<xsl:choose>
					<xsl:when test="contains(@rend,'double-line')">
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''), ' ', 'line', ' ', 'first-double')}"/>
					</xsl:when>
					<xsl:when test="contains(@rend,'triple-line')">
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''), ' ', 'line')}"/>
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''), ' ', 'third-line')}"/>
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''), ' ', 'third-line')}"/>
					</xsl:when>
					<xsl:otherwise>
						<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@n, '-', ''))}"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="note">
		<span class="{concat(name(), ' ', @type, ' ', @rend, ' ', @place, ' ', @n)}"><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="orig">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="orgName">
		<span class="orgName"><xsl:attribute name="title">A formally-named group or organization.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="text/body/div[1]/pb[1]|text/front/div[1]/pb[1]|text/back/div[1]/pb[1]" priority="10">
		<span class="pb-title">
			<xsl:value-of select="@n"/>
		</span>
	</xsl:template>

	<xsl:template match="pb[@type='blank']">
		<br/>
		<span class="pb-title">
			<xsl:value-of select="@n"/>
		</span>
		<span class="blank">&lt;This page is blank in the original manuscript.&gt;</span>
		<!-- Adds appropriate number of empty lines on a blank page -->
		<!--<xsl:for-each select="1 to @ana"><br/></xsl:for-each>-->
	</xsl:template>

	<xsl:template match="pb">
		<xsl:choose>
			<xsl:when test="//sourceDesc/msDesc[@type='manuscript']">
				<br/>
				<span class="pb-title">
					<xsl:value-of select="@n"/>
				</span>
			</xsl:when>
			<xsl:when test="//sourceDesc/biblStruct[@type='journal']">
				<span class="pb-title">
					<xsl:value-of select="@n"/>
				</span>
			</xsl:when>
			<xsl:when test="//sourceDesc/msDesc[@type='object-archive']|//sourceDesc/biblStruct[@type='object-book-journal']">
				<br/>
				<span class="pb-title">
					<xsl:value-of select="@n"/>
				</span>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="jc:page">
		<xsl:choose> 
			<xsl:when test="//sourceDesc/msDesc[@type='manuscript']|//sourceDesc/msDesc[@type='object-archive']|//sourceDesc/biblStruct[@type='object-book-journal']">
			<div class="page">
				<!--<br/>-->
				<span class="pb-title">
					<xsl:value-of select="@n"/>
				</span>
				<xsl:apply-templates/>
			</div>
			</xsl:when>
			<xsl:when test="//sourceDesc/biblStruct[@type='journal']">
				<div class="page">
					<span class="pb-title">
						<xsl:value-of select="@n"/>
					</span>
					<xsl:apply-templates/>
				</div>
			</xsl:when>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="persName">
		<span class="persName"><xsl:attribute name="title">A formally-named person.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

<!-- placeNames -->

	<xsl:template match="placeName">
		<span class="placeName"><xsl:attribute name="title">A formally-named place.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="geogName">
		<span class="geogName"><xsl:attribute name="title">A formally-named geographical entity.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

	<!--<xsl:template match="bloc">
		<span class="bloc"><xsl:attribute name="title">A multinational entity, usually continents.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>-->

	<!--<xsl:template match="country">
		<span class="country"><xsl:attribute name="title">A country.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>-->

	<xsl:template match="region">
		<span class="region"><xsl:attribute name="title">A formally-named region.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="bloc">
		<span class="bloc"><xsl:attribute name="title">A multinational entity, usually a continent.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="settlement">
		<span class="settlement"><xsl:attribute name="title">A settlement, such as a state, city, town, or village.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

	<xsl:template match="country">
		<span class="country"><xsl:attribute name="title">A country.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

<!-- end placeNames -->

	<xsl:template match="//encodingDesc/projectDesc//ref[@target]">
		<xsl:variable name="link">
			<xsl:value-of select="@target"/>
		</xsl:variable>
		<a href="{$link}"><xsl:apply-templates/></a>
	</xsl:template>

	<xsl:template match="//fileDesc/publicationStmt/availability/p/ref[@target]">
		<xsl:variable name="link">
			<xsl:value-of select="@target"/>
		</xsl:variable>
		<a href="{$link}"><xsl:apply-templates/></a>
	</xsl:template>

	<xsl:template match="rdg">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="seg">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@type, '-', ''), ' ', translate(@n, '-', ''))}"><xsl:apply-templates/></span>
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
				<!-- Adds empty space at the end of pages OMV -->
				<!--<xsl:for-each select="1 to @extent"><br/></xsl:for-each>-->
				<xsl:apply-templates/>
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

	<xsl:template match="supplied">			
		<span class="supplied"><xsl:attribute name="title">The editors have supplied this text because it is illegible, not visible in, or missing from the original item.</xsl:attribute><xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text>
		</span>
	</xsl:template>
	
	<!-- Beginning of elements that go with table -->
	<xsl:template match="table">
		<table class="{concat(name(), ' ', @rend, ' ', @n)}">
			<xsl:apply-templates/>
		</table>
	</xsl:template>

	<xsl:template match="row">
		<tr class="{concat(name(), ' ', @rend, ' ', @n)}">
			<xsl:apply-templates/>
		</tr>
	</xsl:template>

	<xsl:template match="cell">
		<td class="{concat(name(), ' ', @rend, ' ', @n)}"><xsl:apply-templates/></td>
	</xsl:template>
	<!-- Non-breaking space &#x00A0; -->

	<xsl:template match="term[@type]" priority="1">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="term[@type='collective']" priority="10">
		<span class="collective"><xsl:attribute name="title">A collective term that signifies an individual or plural entity.</xsl:attribute><xsl:apply-templates/></span>
	</xsl:template>

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

	<xsl:template match="w">
		<span class="word"><xsl:apply-templates/></span>
	</xsl:template>

	<!-- ******************* -->

	<!-- Removed from <xsl:template match="TEI">-->
	<!--<xsl:variable name="document-uri" select="document-uri(.)"/>-->
	<!--<p><strong>Date(s):</strong><xsl:text> </xsl:text><xsl:value-of select="//teiHeader//sourceDesc/bibl[@type='sourceMetadata']/date"/></p>-->
	<!--<p class="item-spec"><strong>Encoding dates</strong><xsl:text>: </xsl:text><xsl:value-of select="$sortedDates" separator=", "/></p>-->

	<!-- Removed from <xsl:template match="*" priority="-10">-->
	<!--<xsl:if test="$title/text()">
		<xsl:attribute name="title">
			<xsl:value-of select="$title"/>
		</xsl:attribute>
	</xsl:if>-->
	<!-- Necessary to turn this off, otherwise it creates wonky tooltips.
	Tooltips as needed should be set on the specific element. -->

	<!-- Removed from <xsl:template match="lb">-->
	<!--<br/><xsl:if test="$class/text()"><xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute></xsl:if></br>-->
	<!--<xsl:variable name="lb-with-p">
		<xsl:choose>
			<xsl:when test="lb[child::p]"/>
			<xsl:otherwise>
				<br/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>-->
	<!-- <xsl:value-of select="$lb-with-p"/> -->

	<!-- Removed from <xsl:template match="app"> -->
	<!--<span class="app">
		<xsl:attribute name="title">
			<xsl:for-each select="rdg">
				<xsl:value-of select="concat(name(),': ', ., '; ')"/>
			</xsl:for-each>
		</xsl:attribute>
		<xsl:apply-templates select="rdg[1]"/>
	</span>-->

	<!-- Removed from <xsl:template match="del"> -->
	<!--<xsl:if test="@*">
		<xsl:attribute name="title">
			<xsl:value-of select="concat(name(), 'etion, ')"/>
			<xsl:for-each select="@*">
				<xsl:sort/>
				<xsl:if test="not(name()='status')">
					<xsl:value-of select="concat(name(),': ', ., '; ')"/>
				</xsl:if>
			</xsl:for-each>
		</xsl:attribute>
	</xsl:if>-->
	
	<!-- Removed from <xsl:template match="figure"> -->
		<!-- newFigDesc goes away and applies templates to content to get it into a single dedupped string -->
		<!--<xsl:variable name="newHead">
			<xsl:apply-templates select="head" mode="normalizeHead"/>
		</xsl:variable>
		<xsl:variable name="newFigDesc">
			<xsl:apply-templates select="figDesc" mode="normalizeFigDesc"/>
		</xsl:variable>-->
		<!--<xsl:when test="head and $newFigDesc/text()">
			<span class="{concat(name(), ' ', @rend, ' ', @place)}" title="{concat('&quot;', $newHead, '.&quot; ', $newFigDesc)}">{figure}</span>
		</xsl:when>
		<xsl:when test="head and not($newFigDesc/text())">
			<span class="{concat(name(), ' ', @rend, ' ', @place)}" title="{concat('&quot;', $newHead, '.&quot; ')}">{figure}</span>
		</xsl:when>
		<xsl:when test="not(head) and $newFigDesc/text()">
			<span class="{concat(name(), ' ', @rend, ' ', @place)}" title="{$newFigDesc}">{figure}</span>
		</xsl:when>-->

		<!-- Removed from <xsl:template match="milestone"> -->
		<!--<hr class="{concat(name(), ' ', translate(@rend, '-', ''), ' ', 'second-line')}"/>-->

		<!-- Removed from: <xsl:template match="table"> / row /cell -->
		<!-- select="@*|node()" -->

	<!-- ******************* -->

	<!-- Code not in use, but that could be useful -->

	<!-- <xsl:template match="*[not(@type)][not(@reason)][not(@unit)][not(@extent)]" priority="-1">
		<span class="{name()}"><xsl:apply-templates select="@*|node()"/></span>
		</xsl:template> -->
	
	<!-- <xsl:template match="opener/add">
		<span
			class="opener-add {concat(name(), ' ', translate(@rend, '-', ''), ' ', translate(@place, '-', ''))}">
			<xsl:apply-templates/>
		</span>
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
	</xsl:template> -->

	<!--<xsl:template match="choice/abbr">
		<span class="abbr diplomatic">
			<xsl:if test="../../expan">
				<xsl:attribute name="title"><xsl:value-of select="../../expan"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="choice/expan">
		<span class="abbr edited hidden">
			<xsl:if test="../../abbr">
				<xsl:attribute name="title"><xsl:value-of select="."/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="../../abbr[1]/node()"/>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="choice/orig">
		<span class="orig diplomatic">
			<xsl:if test="../../reg">
				<xsl:attribute name="title">reg: <xsl:value-of select="../../reg"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="choice/reg" priority="10">
		<span class="reg edited hidden">
			<xsl:if test="../../orig">
				<xsl:attribute name="title">orig: <xsl:value-of select="../../orig"/></xsl:attribute>
			</xsl:if>
			<xsl:apply-templates select="../../orig/node()"/>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="dateline">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
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

	<!-- Template passes through abbr, sic, and orig in head in normalizeHead mode -->
	<!--<xsl:template match="head//abbr|head//sic|head//orig" mode="normalizeHead">
		<xsl:apply-templates/>
	</xsl:template>-->

	<!-- remove gb spans -->
	<!--<xsl:template match="gb">
		<xsl:apply-templates/>
	</xsl:template>-->

	<!-- Template kills through expan, corr, reg, and supplied in head in normalizeHead mode -->
	<!--<xsl:template match="head//expan|head//corr|head//reg|head//supplied"
		mode="normalizeHead"/>-->

	<!-- Template passes through abbr, sic, and orig in figDesc in normalizeFigDesc mode -->
	<!--<xsl:template match="figDesc//abbr|figDesc//sic|figDesc//orig" mode="normalizeFigDesc">
		<xsl:apply-templates/>
	</xsl:template>-->

	<!-- Template kills through expan, corr, reg, and supplied in figDesc in normalizeFigDesc mode -->
	<!--<xsl:template match="figDesc//expan|figDesc//corr|figDesc//reg|figDesc//supplied"
		mode="normalizeFigDesc"/>-->

	<!--<xsl:template match="add[@place='marginleft']/figure|add[@place='marginright']/figure" priority="10">
		<xsl:choose>
		<xsl:when test="head">
			<span class="figure" title="{concat('&quot;', head, '.&quot; ', figDesc)}">figure</span>
		</xsl:when>
		<xsl:otherwise>
			<span class="figure" title="{figDesc}">figure</span>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:template>-->

	<!--<xsl:template match="tei:addSpan|p/anchor">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:anchor">		
		<xsl:apply-templates/>
		<br/>
	</xsl:template>-->

	<!--<xsl:template match="closer">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
		</span>
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
		<span class="fw pageno">
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

	<!--<xsl:template match="opener">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''))}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="postscript">
		<xsl:apply-templates/>
	</xsl:template>-->

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

	<!--<xsl:template match="opener/salute">
		<span class="opener-salute">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="closer/salute">
		<span class="closer-salute">
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="signed">
		<span class="signed">
			<xsl:apply-templates/>
		</span>
	</xsl:template>-->

	<!--<xsl:template match="supplied">
	<span class="supplied edited hidden"> <xsl:if test="@*"> <xsl:attribute name="title">
		<xsl:value-of select="concat(name(), ', certainty: ', @cert, ', reason: ', @reason)"/>
		</xsl:attribute> </xsl:if>[<xsl:apply-templates select="node()"/>]</span></xsl:template>-->

<!--	<xsl:template match="trailer">
		<span class="{concat(name(), ' ', translate(@rend, '-', ''))}"><xsl:apply-templates/></span>
	</xsl:template>-->
</xsl:stylesheet>