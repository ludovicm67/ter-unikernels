# Compte rendu de la réunion du vendredi 18 janvier 2019

## Contexte

Il s'agit de la première réunion dans le cadre du *travail d'étude et de
recherche* (pourra être abrégé sous la forme « TER » par la suite) sur les
unikernels, réalisée dans le cadre du second semestre de la première année de
master d'informatique à l'Université de Strasbourg. L'intitulé du sujet est le
suivant : « Réduire les systèmes pour mieux virtualiser ? ».

Cette réunion a eu lieu le vendredi 18 janvier 2019 à 14h30 et a durée 30
minutes environs. Elle a eu lieu le jour même consacré à notre première scéance
de travail personnel sur le sujet.

Pour cette première séance de travail personnel j'ai rencontré un *empêchement
méthodologique* : dans des exercices de ce type, j'ai tendance à imprimer
l'article en question et de le griffonner abondamment dans le but d'identifier
les points importants, ce qui n'est pas encore tout à fait clair, etc. N'ayant
pas pu imprimer l'article, j'ai dû me contenter de le lire et rédiger mes notes
sur mon ordinateur personnel, ce qui n'était pas spécialement efficace. Ce souci
devrait être réglé très prochainement.

## Travail réalisé

Pour ce début, je me suis particulièrement concentré sur la lecture du [document
à propos de
KylinX](https://www.usenix.org/system/files/conference/atc18/atc18-zhang-yiming.pdf)
mentionné dans la rubrique « référence clé » du sujet. Mon objectif de ce début
de travail consistait à me familiariser avec les différentes notions du domaine
grâce à cet article.

J'ai donc commencé par le lire une première fois en entier, dans le but d'avoir
un contexte général et repérer les grandes lignes. J'ai ensuite relu plus
spécifiquement à plusieurs reprises le début de l'article dans le but
d'identifier les éléments clés, et esssayer de les définir.

Dès la première ligne il est question de « libOS ». Ne sachant pas exactement ce
que c'était, j'ai pris la décision de regarder sur
[Wikipédia](https://en.wikipedia.org/wiki/Operating_system#Library) afin de me
faire une idée générale. J'ai pu en déduire que cela est simplement la
contraction de « library OS ». Il s'agit d'un système d'exploitation où les
différents services qui le composent sont sous forme de librairies, dans le but
de construire un noyau très spécifique pour une unique application particulière.
Cela me fait grandement penser à un système d'exploitation que l'on construirait
comme avec des briques de LEGO : IPC, réseau, ...

Le fait d'avoir un système d'exploitation spécialisé offre un certain nombre
d'avantages : il n'y a pas besoin du multi-utilisateurs étant donné que l'on ne
souhaite lancer qu'une seule application, il n'y a donc pas besoin du support
multi-applications. Le fait que l'on utilise uniquement les briques utiles pour
l'application permet de se passer d'un nombre non négligeable de librairies,
offrant un gain de rapidité (notament au démarrage) et limitant de fait le
nombre de bugs qui pourraient se trouver dans les librairies. Le système est
également nettement plus léger.

J'avais relevé également l'absence de processus multiple dans les unikernels
(partie 2.3, fin du premier paragraphe : « But on the downside, **the lack of
processes** and compile-time determined monolithicity largely reduce Unikernel’s
flexibility, efficiency, and applicability »), mais cela semble étrange et je
vais essayer d'éclaircir ce point pour la prochaine réunion.

J'avais également relevé quelques autres points concernant notament le rôle de
l'hyperviseur, etc. mais je préfère garder cela pour la seconde réunion, dès que
j'aurais davantage de matière.

## Travail à effectuer d'ici la prochaine réunion

Dans cette partie nous aborderont ce qui serait à faire d'ici la prochaine
réunion prévue le 30 janvier à 10h30.

Dans un premier temps, il faudrait retravailler tout ce qui concerne la gestion
des processus (petite confusion lors de la réunion à lever), définir clairement
le mécanisme des pVM qui semble particulièrement intéressant, et continuer à
creuser ce premier texte.

Un des avantages des unikernels est le fait d'être notament plus sécurisé que
des conteneurs. Il faudrait regarder pour quelles raisons.

Pierre David m'a également conseillé une référence [« My VM is Lighter (and
Safer) than your Container
»](http://delivery.acm.org/10.1145/3140000/3132763/p218-manco.pdf) qui semble
parfaitement adapté pour m'aider à répondre au point précédent.

Il faudrait voir pour chercher un petit panel d'articles de recherche assez
sélectif avec l'aide de Google Scholar par exemple, et s'aider de mots-clés
comme : unikernel, vm, computer, ... et d'en lire 2-3 et y extraire les
informations importantes. Lors de la prochaine réunion il sera question des
prochains papiers à lire parmi ce panel.

Pierre David m'a conseillé [JabRef](http://www.jabref.org/) pour gérer ma
bibliographie *bibtex*, que j'avais déjà brièvement déjà utilisé une fois au
cours du semestre précédent, ainsi que [Zotero](https://www.zotero.org/).
