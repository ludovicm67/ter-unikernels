Exokernel
=========

## Points importants

  - noyau minimaliste, la plupart fonctionne directement dans l'espace utilisateur

  - architecture modulaire, étant donné que ça se base sur les libOS

  - philosophie : utilisateur au plus proche du matériel (exposition des noms
    physiques pour éliminer des couches d'abstractions, exposition des
    allocations, exposer le matériel de manière sécurisée au travers de
    primitives de bas niveau, ...)

## Raison principale

Les noyaux monolithiques sont lourds, complexes et il y a une baisse de
performances dûes aux différentes couches d'abstraction.

Les exokernels, de part leur philosophie que l'utilisateur soit au plus proche
du matériel résoud ces problèmes.

La différence avec les micro-noyaux est le fait que les exokernels sont libre ou
non d'utiliser les abstractions, proposées via des librairies.

## Ressources

En plus de l'article de recherche :

  - https://medium.com/@vithushaaarabhi/exokernels-an-operating-system-architecture-for-application-level-resource-management-32d0daaeeab0

  - https://en.wikipedia.org/wiki/Exokernel

  - https://fr.wikipedia.org/wiki/Exo-noyau
