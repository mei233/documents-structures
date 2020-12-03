declare namespace local = "normalize";

declare function local:normalization-mot($texte as xs:string*) as xs:string* {
let $lowercaseMot := lower-case($texte)
let $removePon := fn:replace($lowercaseMot, "[\.,\?!_;]","")
let $tokenize := tokenize($removePon,' ')
return $tokenize
};

declare function local:frequence-mot($words as xs:string*) as element(mot)* {
for $word in fn:distinct-values($words)
let $item :=
    element mot {
        attribute frequency {fn:count($words[. eq $word])},
        $word}
return $item
};


let $sent :="LE PETIT chat CHAT dort?! le petit chat dort. LE petit chat;"
let $normaliedSent := local:normalization-mot($sent)
let $result := <dictionnaire>{local:frequence-mot($normaliedSent) }</dictionnaire>
return $result

