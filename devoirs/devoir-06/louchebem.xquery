(:louchébem:)
declare namespace local = "doc-structs";
declare function local:mot-to-loucherbem($mot as xs:string) as xs:string {
let $voyelle:="aieouy"
let $permierLetter :=substring($mot, 1, 1)
let $check := contains($voyelle, $permierLetter)
return if ($check) then "l" || $mot|| "bem" else "l"|| substring($mot,2,string-length($mot)-1)|| $permierLetter||"em"
};

(:ex01:)
(:local:mot-to-loucherbem("argot"):)

(:ex02:)
let $sent := 'argot consonne boucher'
for $word in tokenize($sent,' ')
return local:mot-to-loucherbem($word)