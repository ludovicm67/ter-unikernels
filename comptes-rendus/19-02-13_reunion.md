# Compte rendu de la réunion du mercredi 13 février 2019

## Contexte

Il s'agit de la troisième réunion dans le cadre du TER qui s'est déroulée le
mercredi 13 février 2019 de 14h et a durée une heure environs.

## Travail réalisé

Mise en place de toute la stack pour générer un beau rapport à partir de
fichiers markdown. Une difficulté était d'arriver à intégrer correctement la
bibliographie dans le rendu avec la présentation souhaitée (l'utilisation des
numéros entre crochets comme dans les articles de recherche au lieu de citer à
chaque fois la liste des auteurs en plein milieu du texte).

J'ai également rédigé les résumés des deux premiers articles étudiés afin que
l'on puisse faire un point sur le fond et la forme.

En plus de cela, j'ai travaillé sur les articles suivants :

  - Unikernel: Rise of the Virtual Library Operating System (acmqueue)

  - OSv: Optimizing the Operating System for Virtual Machines

  - Jitsu: Just-In-Time Summoning of Uniernels (seulement une passe très rapide)

## Points abordés

En faisant le point sur les articles étudiés pour cette scéance, je me suis
rendu compte que je commençais à avoir une bonne base concernant les mécanismes
et concepts essentiels à propos des unikernels, puisque les différents points
relevés se retrouvent dans la majorité des papiers.

Le papier de l'acmqueue semble vraiment être un article introductif pour entrer
dans le monde des unikernels : il aurait pu être le papier de référence pour le
sujet.

Concernant l'article sur OSv, il faudrait voir s'il ne s'agirait pas de quelque
chose de trop spécifique; la première figure montrant que les applications
tourneraient toutes dans la JVM.

J'ai pu montrer ce que j'ai pu faire pour la génération du rapport. Le rendu est
très satisfaisant. Il a été spécifié qu'il n'est cependant pas obligatoire de
présenter sous forme de deux colonnes, qu'il faudrait numéroter les sections, et
concernant la formulation remplacer « chercheurs » par « auteurs » et qu'il
faudrait privilégier la tournure « Dans [1] » au lieu de « le papier [1] »
lorsqu'une référence est faite vers un papier de recherche.

Il a également été dit qu'il faudrait voir pour essayer de présenter
concrètement les résultats obtenus dans les différentes solutions. Il faudrait
donc voir pour ajouter une section « évaluation » dans le résumé de chacun des
articles, et voir pour le rendre sous forme de tableau, dans le but d'avoir une
vue d'ensemble très rapide. Dans cette section, il sera également bien vu
d'aborder les métriques qui peuvent être atypiques, qui reviennent souvent ou
voire des métriques qui sembleraient pertinentes mais absentes dans l'article
étudié. Il faut vraiment essayer d'analyser la manière dont les auteurs
procèdent pour obtenir ces métriques et voir quels sont les critères. Les
principales métriques seraient tout ce qui concernent les temps et la facilité
de la solution mise en place.

J'avais un doute sur le fait qu'il faille vraiment parler en détail des
optimisations faites sur les hyperviseurs directement (majoritèrement sur Xen);
la réponse s'avère être positive. Je vais donc repasser rapidement sur
l'ensemble des articles pour essayer de détailler davantage ce point.

## Pour la prochaine fois

Pour la prochaine réunion, que l'on a programmée pour le lundi 25 février 2019 à
16h05, je compte travailler principalement sur le rapport intermédiaire. Le but
étant de pouvoir montrer quelque chose de quasiment terminé, afin de voir ce
qu'il faudrait améliorer pour le jour du rendu, qui est fixé pour le 3 mars.
Pour rappel, il faut avoir au minimum cinq pages de contenu dans ce rapport, qui
détailleront en grand partie la présentation de la problématique dans son
contexte.
