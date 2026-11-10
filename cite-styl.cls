<?xml version="1.0" encoding="utf-8"?>
<style xmlns="http://purl.org/net/xbiblio/csl" class="in-text" version="1.0" demote-non-dropping-particle="never" default-locale="de-DE">
  <info>
    <title>Uni-Richtlinie Custom</title>
    <id>http://www.zotero.org/styles/uni-richtlinie-custom</id>
    <updated>2026-01-01T00:00:00+00:00</updated>
  </info>

  <locale xml:lang="de">
    <terms>
      <term name="et-al">u.a.</term>
      <term name="and">u.</term>
      <term name="anonymous">ANONYM</term>
      <term name="editor" form="short">Hrsg.</term>
      <term name="page" form="short">S.</term>
    </terms>
  </locale>

  <!-- KURZBELEG IM TEXT: GROSSBUCHSTABEN + u.a. -->
  <macro name="author-short">
    <names variable="author">
      <name form="short" and="text" delimiter=", " initialize-with=". ">
        <name-part name="family" text-case="uppercase"/>
      </name>
      <substitute>
        <names variable="editor">
          <name form="short" and="text" delimiter=", ">
            <name-part name="family" text-case="uppercase"/>
          </name>
        </names>
        <text term="anonymous" text-case="uppercase"/>
      </substitute>
    </names>
  </macro>

  <!-- AUTOREN IM VERZEICHNIS: 1. Autor "NACHNAME, V.", Co-Autoren "V. NACHNAME" -->
  <macro name="author-bib">
    <names variable="author">
      <name name-as-sort-order="first" and="text" sort-separator=", " initialize-with=". " delimiter=", " delimiter-precedes-last="never" et-al-min="10" et-al-use-first="1">
        <name-part name="family" text-case="uppercase"/>
      </name>
      <substitute>
        <names variable="editor">
          <name name-as-sort-order="first" and="text" sort-separator=", " initialize-with=". " delimiter=", " et-al-min="2" et-al-use-first="1">
            <name-part name="family" text-case="uppercase"/>
          </name>
          <label form="short" prefix=" (" suffix=")"/>
        </names>
        <text term="anonymous" text-case="uppercase"/>
      </substitute>
    </names>
  </macro>

  <macro name="year-date">
    <choose>
      <if variable="issued">
        <date variable="issued">
          <date-part name="year"/>
        </date>
      </if>
      <else>
        <text term="no date" form="short"/>
      </else>
    </choose>
  </macro>

  <!-- IM TEXT: (MÜLLER 1980) bzw. für #cite(form: "prose") -> MÜLLER 1980 -->
  <citation et-al-min="3" et-al-use-first="1" disambiguate-add-year-suffix="true">
    <layout prefix="(" suffix=")" delimiter="; ">
      <group delimiter=" ">
        <text macro="author-short"/>
        <text macro="year-date"/>
      </group>
    </layout>
  </citation>

  <!-- LITERATURVERZEICHNIS -->
  <bibliography hanging-indent="true" et-al-min="9" et-al-use-first="1">
    <sort>
      <key macro="author-bib"/>
      <key macro="year-date"/>
    </sort>
    <layout suffix=".">
      <group delimiter=": ">
        <text macro="author-bib"/>
        <group delimiter=". ">
          <text variable="title"/>
          <choose>
            <!-- Zeitschriftenartikel: Titel. Zeitschriftenname, Jahrgang, Jahr, Heft-Nr., Seite ...-... -->
            <if type="article-journal article-magazine article-newspaper" match="any">
              <group delimiter=", ">
                <text variable="container-title"/>
                <text variable="volume"/>
                <text macro="year-date"/>
                <text variable="issue"/>
                <group delimiter=" ">
                  <label variable="page" form="short"/>
                  <text variable="page"/>
                </group>
              </group>
            </if>
            <!-- Beitrag in Sammelwerk / Tagungsband -->
            <else-if type="chapter paper-conference" match="any">
              <text variable="container-title"/>
              <group delimiter=", ">
                <text variable="volume" prefix="Band "/>
                <text variable="publisher"/>
                <text variable="publisher-place"/>
                <text macro="year-date"/>
              </group>
              <group delimiter=" ">
                <label variable="page" form="short"/>
                <text variable="page"/>
              </group>
            </else-if>
            <!-- Abschlussarbeiten (Diplom, Studienarbeit, Dissertation, Habilitation) -->
            <else-if type="thesis">
              <group delimiter=", ">
                <text variable="publisher"/>
                <text variable="publisher-place"/>
                <text variable="genre"/>
                <text macro="year-date"/>
              </group>
            </else-if>
            <!-- Webseite / Internet-Link -->
            <else-if type="webpage post-weblog" match="any">
              <group delimiter=", ">
                <text variable="URL"/>
                <text macro="year-date"/>
              </group>
            </else-if>
            <!-- Bücher, Normen, Prospekte & Rest -->
            <else>
              <group delimiter=", ">
                <text variable="volume" prefix="Band "/>
                <text variable="publisher"/>
                <text variable="publisher-place"/>
                <text macro="year-date"/>
              </group>
            </else>
          </choose>
        </group>
      </group>
    </layout>
  </bibliography>
</style>
