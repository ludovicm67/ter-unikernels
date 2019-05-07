# Introduction

Aujourd'hui, de plus en plus de services sont proposés aux utilisateurs. Le
nombre de ressources à traiter est également fortement croissant et c'est ainsi
que de nouveaux centres de données sont construits au fur et à mesure partout
dans le monde.

Au départ, une machine physique était attribuée à un service particulier.
Lorsque la demande augmentait, on ajoutait simplement une nouvelle machine
dédiée uniquement à ce service.

Cependant le nombre de services proposés ne cessant de croître, il n'est plus
possible de se contenter de ne faire tourner qu'un seul service par machine,
notamment pour des raisons budgétaires et pour un déploiement beaucoup plus
rapide.

Les fournisseurs de services souhaitent gagner en qualité pour faire face à la
concurrence. Cette qualité se traduit notamment par une démultiplication des
données à travers le globe : cela rapproche le contenu des utilisateurs finaux,
diminue les temps de latence, et permet d'être plus robuste en cas de panne. En
effet, il y aura toujours une machine présente pour prendre le relais. On gagne
donc en souplesse en étant capable d'adapter l'offre et la demande en temps
réel.

Pour ces fournisseurs, pouvoir faire tourner un grand nombre de services sur une
même machine permettrait d'économiser le nombre de machines et de mieux les
rentabiliser, du fait que l'on utilisera pleinement les ressources d'une machine
au lieu de n'utiliser qu'un faible pourcentage sur plusieurs machines.

La virtualisation répond parfaitement à ces attentes. En effet, virtualiser
plusieurs systèmes sur une seule machine permettrait d'exécuter indépendamment
un grand nombre de services.

La virtualisation répond à un besoin d'isolation. En effet, si l'on souhaite
lancer un grand nombre de services différents sur une même machine physique, un
service ne doit pas compromettre un des autres services tournant sur la machine.
Les systèmes d'exploitation traditionnels répondent déjà en partie à ce besoin
d'isolation, en virtualisant la mémoire et en isolant le matériel avec la
séparation de l'espace utilisateur de l'espace système via les appels système.
En virtualisation de système d'exploitation, le besoin d'isolation va encore
plus loin puisqu'il faut isoler la mémoire de chacun des systèmes d'exploitation
ainsi que les opérations de lecture et d'écriture.  Virtualiser ainsi un système
d'exploitation est un peu comme si l'on créait des machines virtuelles à
l'intérieur d'une seule et même machine physique ; c'est la raison pour laquelle
on parle justement de machines virtuelles, ou VM pour *virtual machines* en
anglais.

Enfin, on peut dire que la virtualisation offre une certaine sécurité, du fait
de cette isolation, et qu'il est plus facile de gérer une machine virtuelle
compromise qu'une machine physique ; on peut en recréer une plus rapidement en
clonant une VM de base par exemple. Virtualiser offre également une certaine
tolérance aux pannes, puisqu'il est possible de dupliquer ou migrer très
simplement des machines virtuelles qui tourneraient sur un matériel défaillant
par exemple. Enfin, certaines entreprises ont besoin de faire tourner certaines
applications obsolètes (applications *legacy*) : utiliser la virtualisation
permettrait à ces entreprises de continuer à utiliser ces applications sans
sacrifier la sécurité de leur parc informatique. On constate donc que la
virtualisation offre une réelle souplesse dans la gestion des services.

Aujourd'hui, d'autres solutions que la virtualisation de systèmes d'exploitation
traditionnels ont émergé [@madhavapeddy2013; @zhang2018]. On utilise par exemple
de plus en plus le mécanisme des conteneurs : au lieu de virtualiser
complètement un système d'exploitation, on fait tourner directement
l'application sur la machine hôte, en interceptant les appels systèmes, offrant
ainsi une alternative beaucoup plus légère et rapide que la virtualisation
classique.
