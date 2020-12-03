
(:Pour tester chque exercice il faut mettre commentaire sur les autres:)


(:ex01 Écrire une expression pour afficher tous les @id des juicers.:)
let $rom := doc('juicers.xml')
for $item in $rom//juicer/@id
return data($item)




(:ex02 Enrichir celle-ci en triant par le prix (donc les ids seront classés selon le prix des juicers):)
for $item in $rom//juicer
order by $item/cost
return string($item/@id)




(:ex02 Toujours à partir de cette expression, n'afficher que les juicers ayant dans leur nom la chaine Juicer.:)
for $item in $rom//juicer
order by data($item/cost)
let $check := contains($item/name,'Juicer')
return if ($check) then data($item/@id) else ''