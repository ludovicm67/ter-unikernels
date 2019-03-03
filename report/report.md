# Introduction

Aujourd'hui de plus en plus de services sont proposés aux utilisateurs. Le nombre
de ressources à traiter est également fortement croissante et c'est ainsi que de
nouveaux centres de données sont construits au fur et à mesure partout dans le
monde.

Au départ, une machine physique était attribuée à un service particulier.
Lorsque la demande augmentait, on ajoutait simplement une nouvelle machine
dédiée uniquement à ce service.

Cependant le nombre de services proposés ne cessant de croître, il n'est plus
possible de se contenter de ne faire tourner qu'un seul service par machine,
notamment pour des raisons budgétaires et pour un déploiement beaucoup plus
rapide.

Les fournisseurs de services souhaitent gagner en qualité pour faire face à la
concurrence. Cette qualité se traduit notamment par une démultiplication des
données à travers le globe, afin de rapprocher le contenu des utilisateurs
finaux pour diminuer les temps de latence et d'être plus robuste en cas de
panne, du fait qu'il y aura toujours une machine présente pour prendre le
relais. On arrive donc à gagner en souplesse en étant capable d'adapter l'offre
et la demande en temps réel.

Pour ces fournisseurs, pouvoir faire tourner un grand nombre de services sur une
même machine permettrait d'économiser le nombre de machines et de mieux les
rentabiliser, du fait que l'on utilisera pleinement les ressources d'une machine
au lieu de n'utiliser qu'un faible pourcentage sur plusieurs machines.

Pour satisfaire tous ces points, la virtualisation répond parfaitement à ces
attentes. En effet, virtualiser des systèmes sur une seule machine permettrait
d'exécuter indépendamment un grand nombre de services.

La virtualisation répond à un besoin d'isolation. En effet, si l'on souhaite
lancer un grand nombre de services différents sur une même machine physique, un
service ne doit pas compromettre un des autres services tournant sur la machine.
Les systèmes d'exploitation traditionnels répondent déjà en partie à ce besoin
d'isolation, en virtualisant la mémoire et en isolant le matériel avec la
séparation de l'espace utilisateur de l'espace système via les appels système.
En virtualisation de système d'exploitation, le besoin d'isolation va encore
plus loin puisqu'il faut arriver à isoler la mémoire entre chacun des systèmes
d'exploitation ainsi que les opérations de lectures et d'écritures.  Virtualiser
ainsi un système d'exploitation est un peu comme si l'on créait des machines
virtuelles à l'intérieur d'une seule et même machine physique; c'est la raison
pour laquelle on parle justement de machines virtuelles, ou VM pour *virtual
machines* en anglais.

Enfin, on peut dire que la virtualisation offre une certaine sécurité, du fait
de cette isolation, et qu'il est plus facile de gérer une machine virtuelle
compromise qu'une machine physique; on peut en recréer une plus rapidement en
clônant une VM de base par exemple. Virtualiser offre également une certaine
tolérance aux pannes, puisqu'il est possible de dupliquer ou migrer très
simplement des machines virtuelles qui tourneraient sur un matériel défaillant
par exemple. Enfin, certaines entreprises ont besoin de faire tourner certaines
applications qui seraient obsolètes (applications *legacy*) : utiliser la
virtualisation permettrait à ces entreprises de continuer à utiliser ces
applications sans sacrifier la sécurité de leur parc informatique. On constate
donc que la virtualisation offre une réelle souplesse dans la gestion des
services.

Aujourd'hui, d'autres solutions que la virtualisation de systèmes d'exploitation
traditionnels ont émergé [@madhavapeddy2013; @zhang2018]. On utilise par exemple
aujourd'hui de plus en plus le mécanismes des conteneurs : au lieu de
virtualiser complètement un système d'exploitation, on fait tourner directement
l'application sur la machine hôte, en interceptant les appels systèmes, offrant
ainsi une alternative beaucoup plus légère et rapide que la virtualisation
classique.

# Définition du problème

La virtualisation offre une réelle souplesse comme nous avons pu le voir.
Cependant, virtualiser un système d'exploitation traditionnel peut s'avérer
plutôt lourd. Pour contourner cette lourdeur, le mécanisme des conteneurs peut
s'avérer être particulièrement efficace. Du fait qu'ils tournent directement sur
la machine hôte, on économise ainsi toute la couche de la virtualisation d'un
système complet, et on peut donc faire tourner un nombre nettement plus élevé de
machines du fait que les ressources nécessaires en matière de stockage, de
mémoire et de calcul sont moindres par rapport à l'utilisation massive de
machines virtuelles.

Cependant l'utilisation des conteneurs peut s'avérer être problématique sur les
questions de sécurité, notamment du fait qu'ils tournent directement sur l'hôte
[@madhavapeddy2013] et que le nombre d'appels système ne cesse de croître
[@manco2017] : aujourd'hui un noyau Linux en compte environ 400. L'API des
appels système permet aux conteneurs d'interagir avec le système d'exploitation
hôte et offre une gestion des processus, des threads, de la mémoire, du réseau,
du système de fichiers, de la comunication IPC, etc. Le fait que les conteneurs
tournent directement sur l'hôte nécessite également une homogénéité entre le
système d'exploitation hôte et invité, ce qui peut être limitant.

Ce que l'on souhaiterait, ce serait d'avoir d'une part la possibilité d'avoir
une isolation forte qui permettrait de garantir une certaine sécurité, et
d'autre part, avoir quelque chose de très léger, que l'on peut déployer en masse
de manière adaptative, qui soit extrêmement rapide pour servir et s'adapter
continuellement à la demande et ainsi faire face à la concurrence, tout en
offrant une qualité de service sûre.

Cela fait quelques années que des équipes de chercheurs se posent la question et
une solution semble émerger : les unikernels.

Que sont les unikernels ? En quoi diffèrent-ils des solutions actuellement
utilisées ? Comment arrivent-ils à offrir des gains réels en performances sans
sacrifier la sécurité, chose que l'on arrivait pas à satisfaire simultanément
jusqu'à présent avec des conteneurs et des VM traditionnelles ?

# Les unikernels, késako ?

Les unikernels pourraient être décrits simplement comme étant un système
d'exploitation créé à partir d'un assemblage de briques de LEGO, chacune de ces
briques étant une bibliothèque élémentaire pour faire une tâche de base, comme
par exemple la partie réseau, ou bien la communication IPC, etc. Un système
construit de cette manière à coup de bibliothèques de base s'appelle une
*library OS* ou *libOS*.

Le principe des unikernels est qu'au lieu de lancer un système d'exploitation
classique composé d'un grand nombre d'applications, il va se charger de ne faire
tourner que le binaire d'une application, et donc de ne faire tourner qu'un seul
processus [@zhang2018]. On va ainsi uniquement utiliser les briques dont
l'application a réellement besoin pour fonctionner.

Pour éviter d'avoir à supporter l'ensemble des périphériques possibles, dans les
cas des unikernels on va partir du principe qu'il tournera dans une machine
virtuelle, et que ce sera à l'hyperviseur de s'occuper du matériel et d'en faire
l'abstraction.

On se retrouve donc avec une image extrêmement légère, et comme il y a un lien
de corrélation entre la taille des images et le temps de boot du fait du temps
de chargement de l'ensemble en mémoire [@manco2017]; de ce fait, les unikernels
peuvent démarrer beaucoup plus rapidement que les systèmes traditionnels. De
plus, ils garantissent davatnage de sécurité étant donné qu'ils tournent
directement au sein d'une machine virtuelle et n'incluent que le strict
nécessaire pour faire tourner l'unique application, ce qui fait qu'il n'est même
pas possible de se connecter sur la machine. En outre, ils ne dépendent que d'un
nombre très restreint de bibliothèques, limitant le nombre de failles et bugs
possibles, ce qui limite fortement la surface d'attaque [@manco2017].

Cependant, obtenir ces gains de performances tout en garantissant une certaine
sécurité nécessite beaucoup de temps, étant donné qu'il faut arriver à
spécialiser le plus possible le système pour l'application souhaitée.

# Les différentes solutions

Nous allons désormais regarder quelles sont les principales solutions
d'unikernels à l'heure actuelle, et essayer de les comparer entre elles.

## Solutions étudiées

Un point commun à relever est que l'ensemble des solutions étudiées jusqu'à
présent dans le cadre de ce travail se basent toutes sur le même hyperviseur :
Xen. Il s'agit donc d'une référence essentielle, crédible et fiable dans le
domaine de la virtualisation.  Cependant un nombre important de solutions
n'hésitent pas à ré-implémenter certaines parties de Xen, comme [@manco2017] qui
ont ré-implémenté le XenStore.

KylinX [@zhang2018] offre un mécanisme de pVM, pour *process-like VM*. Ce
procédé permet de réaliser des `fork` en instanciant une nouvelle machine
virtuelle. La machine ayant fait l'appel à `fork` sera mise en pause le temps de
la création de la pVM et recevra ensuite un moyen de la contacter.

LightVM [@manco2017], une nouvelle solution de virtualisation permet de démarrer
une machine virtuelle presque aussi rapidement qu'un `fork` ou un `exec` sur
Linux et serait deux fois plus rapide que Docker, une solution permettant de
lancer des conteneurs.

Tinyx [@manco2017], une solution de build automatisée permet de créer des images
de machines virtuelles Linux minimalistes en utilisant une approche
particulièrement originale. En effet, il va tenter de retirer une à une les
différentes options de boot en testant si l'application continue toujours de
fonctionner comme souhaitée avec l'aide d'un jeu de test. Si un des tests ne
passe plus, l'option est réactivée, car essentielle.

## Solutions restantes à étudier

Je pense regarder dans un premier temps, jusqu'à mi-avril continuer à regarder
d'autres solutions tout en approfondissant celles que j'ai pu trouver jusqu'à
présent. Voici certaines des solutions que je souhaiterais étudier prochainnement :

  - Jitsu [@madhavapeddy2015] qui utilise les unikernels pour servir des
    applications. Les auteurs ont fait quelques optimisations sur Xen, notamment
    pour le faire fonctionner sous ARM.

  - OSv [@kivity2014], en vérifiant si la solution ne serait pas trop axée pour
    la JVM.

  - les exokernels [@engler1995], puisque ce serait de cela que s'inspireraient
    les unikernels. Dans la même mesure, des alternatives telles que les lambda
    d'Amazon par exemple [@krol2017; @spillner2018] permettrait de voir ce qui
    se fait à côté.

Ensuite, de début/mi-avril jusqu'à début mai, je compte regarder en détail la
partie concernant l'évaluation des performances en comparant les différentes
solutions entre elles, puis enfin, en mai, je compte finaliser la rédaction du
rapport final qui sera à rendre pour le 12 mai normalement.

# Évaluation des performances

Dans cette partie il faudra énumérer les limites des différentes solutions
étudiées, et évaluer leurs performances, vérifier si les gains en performances
n'impactent pas la sécurité, être critique sur les résultats présentés dans les
divers papiers.

Une présentation idéale serait sous forme d'un tableau récapitulatif, offrant
ainsi aux lecteurs une vision d'ensemble directe sans avoir à lire l'ensemble de
ce rapport.

Ci-dessous un exemple de tableau :

| Solution          | Temps de boot
|-------------------|---------------
| KylinX (pVM fork) | 1.3 ms
| LightVM           | 4 ms

# Conclusion

Faire le bilan de l'ensemble, parler de l'avenir des unikernels, orientations
dans le monde de la recherche et les différentes pistes à creuser.
