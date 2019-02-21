# KylinX

> A Dynamic Library Operating System for Simplified and Efficient Cloud
> Virtualization

## Contexte

Il s'agit du premier article de recherche que j'ai étudié dans le cadre de mon
sujet de TER.  Il s'agit de la seule ressource fournie dans le sujet.

## Pourquoi le lire ?

Étant donné pour seule référence, il s'agit d'un papier indispensable pour se
lancer dans le domaine et bien démarrer le sujet de TER.

Le but de cette lecture est de pouvoir repérer les différentes notions qu'il
faudra pouvoir être en mesure d'aborder tout le long de ce TER.

## Éléments retenus

Ce papier m'a vraiment été utile pour rechercher les éléments essentiels pour
aborder le monde de la virtualisation et notamment des unikernels.

Dès la première ligne il était question de « LibOS », pour *library OS*.  Ne
connaissant pas ce terme, j'ai pris l'initiative de me renseigner.  J'ai pu
trouver qu'il s'agit en fait d'un système que l'on construirait un peu comme si
l'on assemblait des briques de LEGO, par exemple une brique pour la couche
réseau, une autre pour la communication IPC, ...  le but étant de spécialiser le
plus possible l'OS pour faire tourner une seule application; puisqu'à la fin il
suffira d'y greffer le binaire à notre OS assemblé.

Le but est donc de parvenir à avoir une application par VM.

J'ai pu voir dans ce papier de recherche que les unikernels ne pouvaient
exécuter qu'un seul processus. Pour contourner ce problème, les auteurs à
l'origine de KylinX ont proposés l'abstraction des pVM, pour *process-like VM*.
Cela consiste à faire comme si l'hyperviseur était un système d'exploitation, et
que chaque instance de VM représenterait un processus. Une VM peut donc cette
fois-ci être en mesure de pouvoir faire des `fork`, ce qui créera une nouvelle
instance de VM pour le « nouveau processus ». On a également la notion de « root
pVM »; il s'agit de la VM parente, celle qui fait appel à un `fork`.

KylinX permet de lier des librairies à chaud, il s'agit donc d'un libOS
dynamique.

L'avantage de KylinX est le fait qu'étant ultra spécialisé, il n'a pas besoin de
toute la stack habituelle des systèmes d'exploitations classiques.

Il est donc beaucoup plus léger que ces derniers, et est plus sécurisé, le fait
qu'il se base sur un nombre relativement restreints de librairies limite
fortement le nombre de bugs et de failles disponibles.

Le fait d'être léger offre également des gains de performances non négligeables.

Dans ce papier de recherche est rapidement abordé le fait que les conteneurs
seraient moins sécurisés que les VM, le fait est qu'ils utilisent l'API du
système d'exploitation hôte, exposant ainsi un nombre important d'appels
systèmes, ce qui augmente fortement la surface d'attaque de l'hôte.  Cependant
ils seraient plus performants que des OS classiques.

Il est aussi question rapidement des picoprocess; il s'agirait en quelque sorte
de conteneurs implémentant un LibOS entre l'hôte et l'invité.

# Critiques

Ce papier bien qu'introduisant vraiment beaucoup de notions ne semble pas
fournir une vision parfaitement objective; je ne trouve pas spécialement de
points négatifs à utiliser des unikernels.
