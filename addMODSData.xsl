<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
     xpath-default-namespace="http://www.tei-c.org/ns/1.0"
     xmlns:mods='http://www.loc.gov/mods/v3'
    exclude-result-prefixes="#default xs tei mods"
    version="2.0"
    >
    
    <!-- 
     Stylesheet to convert LEAP files to add in various MODS data   
        
    Run on individual files with 9.x saxon as:
    saxon -o:newFileName -s:currentFileName -xsl:addMODSData.xsl
    
    Version 1.5 - 2016-04-26:
     - adds some spacing at top of file
     - replaces processing instructions to point to github
     - updates from MODS: title, author, shelfmark, ccnumber, date, recipient
     
    -->

<!-- copy all -->
    <xsl:template match="@*|node()" priority="-1">
        <xsl:copy copy-namespaces="no">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template> 
    
    <!-- general variables for MODS file -->
    <xsl:variable name="file" select="replace(concat('liv_', substring-after(base-uri(), '/liv_')), 'TEI', 'MODS')"/>
    <xsl:variable name="doc" select="doc($file)"/>
    
    <!-- replace processing instructions -->
    <xsl:template match="/"><xsl:text>
</xsl:text>
    <xsl:processing-instruction name="xml-model"> href="http://livingstoneonline.github.io/LEAP-ODD/leap.rng" type="application/xml" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction><xsl:text>
</xsl:text>  <xsl:processing-instruction name="xml-model">href="http://livingstoneonline.github.io/LEAP-ODD/leap.rng" type="application/xml" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction><xsl:text>
 </xsl:text>  <xsl:processing-instruction name="xml-stylesheet">href="http://livingstoneonline.github.io/LEAP-XSLT/transcription.xsl" type="text/xsl"</xsl:processing-instruction><xsl:text>
 </xsl:text>
        <xsl:apply-templates select="node()"/>
    </xsl:template>
    
    <!-- remove existing processing instructions -->
    <xsl:template match="processing-instruction()"/>
    
    <!-- linebreak before TEI element -->
    <xsl:template match="TEI"><xsl:text>
         </xsl:text>
        <TEI><xsl:apply-templates select="@*|node()"/></TEI>
    </xsl:template>
    
    <!-- update title -->
    <xsl:template match="/TEI/teiHeader/fileDesc/titleStmt/title[1]">
        <xsl:choose>
            <xsl:when test="$doc//mods:titleInfo/mods:title"><title><xsl:value-of select="$doc//mods:titleInfo[not(@type='alternate')][1]/mods:title[1]"/></title></xsl:when>
            <xsl:otherwise><xsl:copy><xsl:apply-templates select="@*|node()"></xsl:apply-templates></xsl:copy></xsl:otherwise>
        </xsl:choose>
        <xsl:if test="$doc//mods:titleInfo[@type='alternative']/mods:title">
            <xsl:text>
                </xsl:text>
                <title type="alternative"><xsl:value-of select="$doc//mods:titleInfo[@type='alternative']/mods:title[1]"/></title></xsl:if>
    </xsl:template>
    
    <!-- update authors, but can't add @xml:id to them-->
    <xsl:template match="/TEI/teiHeader/fileDesc/titleStmt/author[1]">
        <xsl:choose>
        <xsl:when test="$doc//mods:name[mods:role/mods:roleTerm='creator']/mods:namePart">
                <xsl:for-each select="$doc//mods:name[mods:role/mods:roleTerm='creator']/mods:namePart">
                    <author><xsl:value-of select="."/></author>
                </xsl:for-each>
        </xsl:when>
            <xsl:otherwise><xsl:copy><xsl:apply-templates select="@*|node()"></xsl:apply-templates></xsl:copy></xsl:otherwise>
        </xsl:choose>
   </xsl:template>
    <xsl:template match="/TEI/teiHeader/fileDesc/titleStmt/author[2-99]"/>
    
    <!-- update shelfmark -->
    <xsl:template match="bibl[@xml:id='shelfmark']">
        <xsl:choose>
            <xsl:when test="$doc//mods:relatedItem[@type='original'][mods:name/mods:role/mods:roleTerm[contains(.,'repository')]/../../mods:namePart/text()][mods:location/mods:shelfLocator/text()]">
                <bibl xml:id="shelfmark"><xsl:value-of select="$doc//mods:relatedItem[@type='original'][mods:name/mods:role/mods:roleTerm[contains(.,'repository')]]/mods:name[@type='corporate']/mods:namePart"/>; <xsl:value-of select="$doc//mods:relatedItem[@type='original'][mods:name/mods:role/mods:roleTerm[contains(.,'repository')]]/mods:location/mods:shelfLocator"/></bibl>
                </xsl:when>
            <xsl:otherwise><xsl:copy><xsl:apply-templates select="@*|node()"></xsl:apply-templates></xsl:copy></xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    
    <!-- update ccnumber -->
    <xsl:template match="bibl[@xml:id='ccnumber']">
        <xsl:choose>
            <xsl:when test="$doc//mods:identifier[@displayLabel='Canonical Catalog Number']">
                <bibl xml:id="ccnumber"><xsl:value-of select="$doc//mods:identifier[@displayLabel='Canonical Catalog Number']"/></bibl></xsl:when>
            <xsl:otherwise><xsl:copy><xsl:apply-templates select="@*|node()"></xsl:apply-templates></xsl:copy></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- update where -->
    <xsl:template match="bibl[@xml:id='where']">
        <xsl:choose>
            <xsl:when test="$doc//mods:originInfo[@displayLabel='Livingstone']/mods:place/mods:placeTerm">
                <bibl xml:id="where"><xsl:value-of select="$doc//mods:originInfo[@displayLabel='Livingstone']/mods:place/mods:placeTerm"/></bibl></xsl:when>
            <xsl:otherwise><xsl:copy><xsl:apply-templates select="@*|node()"></xsl:apply-templates></xsl:copy></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    
    <!-- update date created -->
    <xsl:template match="bibl[@xml:id='date']">
        <xsl:choose>
            <xsl:when test="$doc//mods:dateCreated[not(@encoding)]/text()">
                <bibl xml:id="date">
                    <date><xsl:if test="$doc//mods:dateCreated[@encoding='iso8601']">
                        <xsl:variable name="date" select="$doc//mods:dateCreated[@encoding='iso8601'][1]"/>
                        <xsl:choose>
                            <xsl:when test="contains($date, '/')"><xsl:attribute name="from"><xsl:value-of select="substring-before($date, '/')"/></xsl:attribute><xsl:attribute name="to"><xsl:value-of select="substring-after($date, '/')"/></xsl:attribute></xsl:when>
                            <xsl:otherwise><xsl:attribute name="when"><xsl:value-of select="$date"/></xsl:attribute></xsl:otherwise>
                        </xsl:choose></xsl:if>
                        <xsl:value-of select="$doc//mods:dateCreated[not(@encoding)]"/>
                    </date></bibl></xsl:when>
            <xsl:otherwise><xsl:copy><xsl:apply-templates select="@*|node()"></xsl:apply-templates></xsl:copy></xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    
    <!-- update recipients -->
    <xsl:template match="bibl[@xml:id='recipient']">
        <xsl:choose>
                <xsl:when test="$doc//mods:name[mods:role/mods:roleTerm='addressee']/mods:namePart">
                    <bibl xml:id="recipient">
                    <xsl:for-each select="$doc//mods:name[mods:role/mods:roleTerm='addressee']/mods:namePart">
                       <persName><xsl:value-of select="."/></persName><xsl:if test="following-sibling::node()"><xsl:text>; </xsl:text></xsl:if>  
                    </xsl:for-each>
                    </bibl>
                </xsl:when>
                <xsl:otherwise><xsl:copy><xsl:apply-templates select="@*|node()"></xsl:apply-templates></xsl:copy></xsl:otherwise>
            </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
