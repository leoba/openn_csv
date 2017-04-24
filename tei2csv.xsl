<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">
    <xsl:output method="text" indent="yes" omit-xml-declaration="yes" />
    <xsl:variable name="files" select="collection('LJS_doc_list.xml')"/>
    
    <xsl:template match="/">
        <xsl:result-document href="openn-test.csv">"Repository","Title","Call No.","Language(s)","Origin","Date","CompuDate","Place","Illustrated","Illuminated","Subject","Genre","Front Cover","Navigation","Data","Record","Summary"<!--<xsl:for-each select="collection(iri-to-uri('../msDesc/?select=l*.xml;recurse=yes'))">--><xsl:for-each select="$files">
            <xsl:variable name="institution" select="//tei:institution"/>
            <xsl:variable name="repository" select="//tei:repository"/>
            <xsl:variable name="title" select="//tei:msContents/tei:msItem[1]/tei:title"/>
            <xsl:variable name="quote">"</xsl:variable>
            <xsl:variable name="callNo" select="//tei:msIdentifier/tei:idno[@type='call-number']"/>
            <xsl:variable name="lang" select="//tei:textLang"/>
            <xsl:variable name="origin" select="//tei:origin/tei:p"/>
            <xsl:variable name="date" select="//tei:origDate[1]"/>
            <xsl:variable name="summary" select="//tei:summary"/>
            <xsl:variable name="illustrated" select="contains(.,'illus') or contains(.,'Illus')"/>
            <xsl:variable name="illuminated" select="contains(.,'illum') or contains(.,'Illum')"/>
            <xsl:variable name="compuDate">
                <xsl:choose>
                    <xsl:when
                        test="contains($date,'between')">
                        <xsl:value-of select="substring($date,9,4)"/>-<xsl:value-of select="substring($date,18,4)"/>
                    </xsl:when>
                    <xsl:when
                        test="contains($date,'--')">
                        <xsl:value-of select="tokenize($date,'--') [position() = 1]"/>00-<xsl:value-of select="tokenize($date,'--') [position() = 1]"/>99</xsl:when>
                    <xsl:when
                        test="contains($date,'-')">
                        <xsl:value-of select="$date"/>
                    </xsl:when>
                    <xsl:when
                        test="contains($date,'approximately')">
                        <xsl:value-of select="substring($date,15,4)"/>
                    </xsl:when>
                    <xsl:when
                        test="contains($date,',')">
                        <xsl:value-of select="translate($date,',','-')"/>
                    </xsl:when>
                    <xsl:when
                        test="contains($date,'A.H.')">
                        <xsl:variable name="ah-token" select="tokenize($date,' ') [position() = 2]"/>
                        <xsl:if test="string-length($ah-token) = 3"><xsl:value-of select="substring(//tei:origDate,11,4)"/></xsl:if>
                        <xsl:if test="string-length($ah-token) = 4"><xsl:value-of select="substring(//tei:origDate,12,4)"/></xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$date"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="place" select="//tei:origin/tei:origPlace"></xsl:variable>
            <xsl:variable name="subjects"><xsl:for-each select="//tei:keywords[@n='subjects']/tei:term"><xsl:value-of select="."/>;</xsl:for-each></xsl:variable>
            <xsl:variable name="genres"><xsl:for-each select="//tei:keywords[@n='form/genre']/tei:term"><xsl:value-of select="."/>;</xsl:for-each></xsl:variable>
            <xsl:variable name="msNo" select="tokenize(tokenize(document-uri(.),'_')  [position() = 1],'/') [position() = last()]"/>
            <xsl:variable name="path">
                <xsl:choose><xsl:when test="starts-with($msNo,'m')">http://openn.library.upenn.edu/Data/0002/</xsl:when>
                <xsl:otherwise>http://openn.library.upenn.edu/Data/0001/</xsl:otherwise></xsl:choose>
            </xsl:variable>
            <xsl:variable name="cover" select="//tei:surface[1]/tei:graphic[contains(@url,'web')]/@url"/>
            <xsl:variable name="opennNav" select="concat($path,'html/',$msNo,'.html')"/>
            <xsl:variable name="opennData" select="concat($path,$msNo,'/data/')"/>
            <xsl:variable name="record" select="//tei:altIdentifier[@type='resource']/tei:idno"/>           
"<xsl:value-of select="concat($institution,' ',$repository)"/>","<xsl:value-of select="translate($title,$quote,concat($quote,$quote))"/>","<xsl:value-of select="$callNo"/>","<xsl:if test="not($lang)">None noted</xsl:if><xsl:value-of select="$lang"/>","<xsl:if test="not($origin)">None noted</xsl:if><xsl:value-of select="$origin"/>","<xsl:if test="not($date)">None noted</xsl:if><xsl:value-of select="$date"/>","<xsl:if test="not($compuDate)"></xsl:if><xsl:value-of select="normalize-space(translate($compuDate,'ca.?afterirbo',''))"/>","<xsl:if test="not($place)">None noted</xsl:if><xsl:value-of select="$place"/>","<xsl:choose><xsl:when test="$illustrated">Yes</xsl:when><xsl:otherwise>No</xsl:otherwise></xsl:choose>","<xsl:choose><xsl:when test="$illuminated">Yes</xsl:when><xsl:otherwise>No</xsl:otherwise></xsl:choose>","<xsl:if test="not($subjects)">None noted</xsl:if><xsl:value-of select="$subjects"/>","<xsl:if test="not($genres)">None noted</xsl:if><xsl:value-of select="$genres"/>","<xsl:value-of select="concat($path,$msNo,'/','data','/',$cover)"></xsl:value-of>","<xsl:value-of select="$opennNav"/>","<xsl:value-of select="$opennData"/>","<xsl:value-of select="$record"/>","<xsl:value-of select="$summary"/>"</xsl:for-each></xsl:result-document></xsl:template>
    
</xsl:stylesheet>