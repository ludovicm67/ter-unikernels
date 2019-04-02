# Introduction

Aujourd'hui de plus en plus de services sont proposés aux utilisateurs. Le
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
effet il y aura toujours une machine présente pour prendre le relais. On gagne
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
compromise qu'une machine physique; on peut en recréer une plus rapidement en
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

# Unikernels

Les unikernels pourraient être décrits simplement comme étant un système
d'exploitation créé à partir d'un assemblage de briques de LEGO, chacune de ces
briques étant une bibliothèque élémentaire permettant une tâche de base, comme
par exemple la partie réseau, ou bien la communication IPC, etc. Un système
construit de cette manière à partir de bibliothèques de base s'appelle une
*library OS* ou *libOS*. Un des premiers libOS était Exokernel [@engler1995]
dans les années 1990s.

Le principe des unikernels est qu'au lieu de lancer un système d'exploitation
classique composé d'un grand nombre d'applications, il va se charger de ne faire
tourner que le binaire d'une application, et donc de ne faire tourner qu'un seul
processus [@zhang2018]. On va ainsi uniquement utiliser les briques dont
l'application a réellement besoin pour fonctionner.

Pour éviter d'avoir à supporter l'ensemble des périphériques possibles, dans les
cas des unikernels on va partir du principe qu'il tournera dans une machine
virtuelle, et que ce sera à l'hyperviseur de s'occuper du matériel et d'en faire
l'abstraction. Un hyperviseur est un programme qui permet la gestion (création,
lancement, ...) des VM.

On se retrouve donc avec une image extrêmement légère, et comme il y a un lien
de corrélation entre la taille des images et le temps de boot du fait du temps
de chargement de l'ensemble en mémoire [@manco2017], ce qui fait que les
unikernels peuvent démarrer beaucoup plus rapidement que les systèmes
traditionnels. De plus, ils garantissent davantage de sécurité : il n'est même
pas possible de se connecter sur la machine, puisqu'ils tournent directement au
sein d'une machine virtuelle et n'incluent que le strict nécessaire pour faire
tourner l'unique application. En outre, ils ne dépendent que d'un nombre très
restreint de bibliothèques, limitant le nombre de failles et bugs possibles, ce
qui limite fortement la surface d'attaque [@manco2017].

Cependant, obtenir ces gains de performances tout en garantissant une certaine
sécurité nécessite beaucoup de temps de configuration, étant donné qu'il faut
spécialiser le plus possible le système pour l'application souhaitée.

# Différentes solutions

Nous allons désormais regarder quelles sont les principales solutions
d'unikernels à l'heure actuelle et les comparer entre elles.

L'ensemble des solutions étudiées jusqu'à présent dans le cadre de ce travail se
basent toutes sur le même hyperviseur : Xen. Il s'agit donc d'une référence
essentielle, crédible et fiable dans le domaine de la virtualisation. Cependant
un nombre important de solutions n'hésitent pas à réimplémenter certaines
parties de Xen, comme le XenStore [@manco2017].

KylinX [@zhang2018] offre un mécanisme de pVM, pour *process-like VM*. Ce
procédé permet de réaliser des `fork` en instanciant une nouvelle machine
virtuelle. La machine ayant fait l'appel à `fork` sera mise en pause le temps de
la création de la pVM et recevra ensuite un moyen de la contacter.

LightVM [@manco2017], une nouvelle solution de virtualisation permet de démarrer
une machine virtuelle presque aussi rapidement qu'un `fork` ou un `exec` sur
Linux et serait deux fois plus rapide que Docker, une solution permettant de
lancer des conteneurs.

Tinyx [@manco2017], une solution de *build* automatisée permet de créer des
images de machines virtuelles Linux minimalistes en utilisant une approche
particulièrement originale. En effet, il va tenter de retirer une à une les
différentes options de boot en testant si l'application continue toujours de
fonctionner comme souhaitée avec l'aide d'un jeu de test. Si un des tests ne
passe plus, l'option est réactivée, car essentielle.

Jitsu [@madhavapeddy2015] qui utilise les unikernels pour servir des
applications. Les auteurs ont fait quelques optimisations sur Xen, notamment
pour le faire fonctionner sous ARM.

OSv [@kivity2014], un OS conçu pour le cloud qui peut uniquement être lancée
depuis un hyperviseur, capable de faire tourner une unique application avec des
gains en performances principalement sur la partie réseau. Les auteurs ont cherchés à réutiliser un maximum de composants déjà existants. Par exemple, le système de fichier utilisé est ZFS, récupéré depuis FreeBSD, qui permet de s'assurer de l'intégrité des données et propose un mécanisme de snapshots et de gestion de volumes. Sont aussi supportés ramfs, dans le cas où l'on souhaiterait booter sans disque, ainsi que devfs, un système de fichier simple pour visualiser les périphériques. Ils ont également récupéré les fichiers de header C depuis le projet `musl libc`, le VFS (=Virtual File System) depuis le projet Prex, et les drivers ACPI depuis le projet ACPICA. Concernant la partie réseau, elle a également été importé au départ de FreeBSD, mais elle a été longuement réécrite.

Drawbridge (https://www.microsoft.com/en-us/research/project/drawbridge/#!publications) qui est un prototype de recherche conçu par l'équipe de recherche de Microsoft, qui permet de lancer des applications de manière sandboxées au sein d'un Windows modifié sous forme de libOS.

# Différents problèmes

  - Trouver comment inclure les composants absoluments nécessaires (cf. Tynix)

# Évaluation des performances

Les chercheurs utilisent très souvent les métriques suivantes lorsqu'ils
évaluent leurs solutions :

  - le temps de boot

  - l'emprunte mémoire

  - le temps pour lancer une application

  - les performances réseau (débits)

# Conclusion

Faire le bilan de l'ensemble :

  - points positifs :

    - performances

    - sécurité

    - faible empreinte mémoire
  
  - points négatifs :

    - beaucoup de temps requis pour construire quelque chose de très spécifique,
      et ce pour une seule application
    
    - recompiler tout l'ensemble lorsque l'on souhaite effectuer des changements, vu qu'on intègre que le strict minimum pour lancer l'application, pas pour faire des changements

Parler de l'avenir des unikernels :

  - les lambdas que propose Amazon par exemple [@krol2017; @spillner2018]

  - `rumprun` : unikernel dans lequel on intègre un binaire d'application C,
    C++, Erlang, Go, Java, JS, Python, Ruby ou Rust à un kernel appelé `rump`
    (http://rumpkernel.org/). Permet de créer des applications bootables,
    légères et portables.

  - UniK (https://github.com/solo-io/unik) qui permet de compiler des
    applciations sous forme d'image bootable légère plutôt que sous forme de
    binaire.

    ```
    Supported unikernel types:
      - AWS Firecracker: UniK supports compiling GO code into AWS Firecracker MicroVMs
      - rump: UniK supports compiling Python, Node.js and Go code into rumprun unikernels
      - OSv: UniK supports compiling Java, Node.js, C and C++ code into OSv unikernels
      - IncludeOS: UniK supports compiling C++ code into IncludeOS unikernels
      - MirageOS: UniK supports compiling OCaml, code into MirageOS unikernels

    Supported providers:
      - AWS Firecracker
      - Virtualbox
      - AWS
      - Google Cloud
      - vSphere
      - QEMU
      - UKVM
      - Xen
      - OpenStack
      - Photon Controller
    ```

Orientations dans le monde de la recherche.

Les différentes pistes à creuser :

  - pourquoi pas pousser d'avantage les outils de build autmatiques tels que
    Tinyx [@manco2017] ? Cela permettrait de rendre les unikernels plus
    abordables.
