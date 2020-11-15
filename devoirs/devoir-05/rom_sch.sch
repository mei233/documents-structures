<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2"
    xmlns:sqf="http://www.schematron-quickfix.com/validator/process">
    <sch:pattern>
        <sch:rule context="/">
            <!-- 1.Assurer vous que le document contient bien un teiHeader et un text -->
            <sch:assert test="contains(child::*,'teiHeader') and contains(child::*,'text')">le document contient bien un teiHeader et un text</sch:assert>
        </sch:rule>
    </sch:pattern>
    
    <sch:pattern>
        <!-- 2. Définir une règle abstraite qui vérifie qu'un élément contient toujours un enfant paragraphe. Appliquer sur les éléments sp et projectDesc. -->
        <sch:rule abstract="true" id="contient_paraphraphe">
            <sch:assert test="self::*[child::p]">L'élément <sch:name/> toujours a un enfant p</sch:assert>
        </sch:rule>
        <sch:rule context="sp">
            <sch:extends rule="contient_paraphraphe"/>
        </sch:rule>
        <sch:rule context="projectDesc">
            <sch:extends rule="contient_paraphraphe"/>
        </sch:rule>
    </sch:pattern>
     
    <sch:pattern abstract="true" id="div_contient_head_scene">
        <!-- 3. Créer un bloc abstrait pour vérifier que chaque div qui sont des actes contiennent un élément head et plusieurs scènes. -->
        <sch:rule context="$element">
            <sch:assert test='./count(head) = 1'>L'élément <sch:name/> ne peut contenir qu'un élément head</sch:assert>
            <sch:assert test='./count(div[@type="scene"]) > 1 '> L'élément <sch:name/> toujours contient plusieurs scenes</sch:assert>
        </sch:rule>
    </sch:pattern>
    <sch:pattern is-a="div_contient_head_scene" id="div">
        <sch:param name="element" value="div[@type='act']"/>
    </sch:pattern>
    
</sch:schema>