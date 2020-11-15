<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <!-- contrainte : un élément fermeture ne peut contenir de texte -->
        <sch:rule context="fermeture">
            <sch:assert test="not(text())">Un élément <sch:name/> ne peut contenir de texte</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <!-- contrainte : vérifier que l'ouverture a toujours un début et une fin -->
        <sch:rule context="ouverture">
            <sch:assert test="@debut and @fin">Un élément <sch:name/> a toujours un début et une fin</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <!-- observation : les points de vente sont ouverts tous les jours, devraient prendre des vacances -->
        <sch:rule context="pdv">
            <sch:report test='./ouverture[@saufjour=""]' role="warn">
                les points de vente sont ouverts tous les jours, devraient prendre des vacances</sch:report>
        </sch:rule>
    </sch:pattern>
    <sch:pattern>
        <!-- observation : les noms des villes devraient être tous en majuscule pour la consistance -->
        <sch:rule context="ville">
            <sch:report test='not(./text() eq upper-case(./text()))' role="warn">
                les noms des villes devraient être tous en majuscule pour la consistance</sch:report>
        </sch:rule>
    </sch:pattern>
</sch:schema>