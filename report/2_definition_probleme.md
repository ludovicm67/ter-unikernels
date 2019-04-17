# Définition du problème

La virtualisation offre une réelle souplesse comme nous avons pu le voir.
Cependant, virtualiser un système d'exploitation traditionnel peut s'avérer
plutôt lourd. Pour éviter cette lourdeur, le mécanisme des conteneurs peut être
particulièrement efficace. Puisqu'ils tournent directement sur la machine hôte,
on économise toute la couche de la virtualisation d'un système complet. Les
ressources nécessaires en matière de stockage, de mémoire et de calcul sont
moindres par rapport à l'utilisation massive de machines virtuelles : on peut
donc faire tourner un nombre nettement plus élevé de services.

Cependant l'utilisation des conteneurs peut s'avérer problématique en termes de
sécurité, notamment du fait qu'ils tournent directement sur l'hôte
[@madhavapeddy2013] et que le nombre d'appels système ne cesse de croître au fil
des années [@manco2017] : aujourd'hui un noyau Linux en compte environ 400.
L'API des appels système permet aux conteneurs d'interagir avec le système
d'exploitation hôte et offre une gestion des processus, des *threads*, de la
mémoire, du réseau, du système de fichiers, de la communication IPC, etc. Le
fait que les conteneurs tournent directement sur l'hôte nécessite également une
homogénéité entre le système d'exploitation hôte et invité, ce qui peut être
limitant.

Ce que l'on souhaiterait, c'est d'une part avoir la possibilité d'une isolation
forte qui garantit une certaine sécurité, et d'autre part, d'être léger. Ceci
permet un déploiement en masse de manière adaptative, une rapidité pour servir
et s'adapter continuellement à la demande et ainsi faire face à la concurrence,
tout en offrant une qualité de service sûre.

Cela fait quelques années que des équipes de chercheurs se posent la question et
une solution semble émerger : les unikernels.

Que sont les unikernels ? En quoi diffèrent-ils des solutions actuellement
utilisées ? Comment arrivent-ils à offrir des gains réels en performances sans
sacrifier la sécurité, chose que l'on n'arrivait pas à satisfaire simultanément
jusqu'à présent avec des conteneurs et des VM traditionnelles ?
