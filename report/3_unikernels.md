# Unikernels

![Architecture d'un système Linux classique^[Source :
<https://www.linux-india.org/characteristics-and-architecture-of-linux-oprating-system/>]\label{linux_archi}](img/linux_archi.png){width=400px}

La figure \ref{linux_archi} nous montre l'architecture d'un système Linux
classique. On y retrouve toute la partie matérielle (CPU, RAM, disques, réseau,
...). Dessus, nous avons le noyau Linux, qui tourne dans l'espace noyau qui
est un mode privilégié, qui va se charger de la gestion des processus, de la
mémoire, du système de fichier, des différents pilotes de périphériques et de
toute la couche protocolaire réseau. Les applications quant à elles, tournent
dans l'espace utilisateur qui est un mode non privilégié. Pour accéder aux
différentes ressources, l'application doit effectuer des appels système
(`syscall`). Ici, le noyau Linux permet une couche d'abstraction entre les
applications et le matériel.

![Architecture d'un système d'exploitation
bibliothèque\label{libos}](img/libos.svg){width=240px}

Les unikernels quant à eux pourraient être décrits simplement comme étant un
système d'exploitation créé à partir d'un assemblage de briques de LEGO, chacune
de ces briques étant une bibliothèque élémentaire permettant une tâche de base,
par exemple la partie réseau, ou bien la communication IPC, etc. Un système
construit de cette manière à partir de bibliothèques de base s'appelle un
système d'exploitation bibliothèque ou encore *library OS* ou *libOS* en
anglais. Le but de cette architecture que l'on retrouve sur la figure
\ref{libos} est d'exécuter un maximum de code dans l'espace utilisateur
directement, et de n'avoir qu'un noyau minimaliste. Cette architecture permet
également aux applications et aux librairies d'accéder directement au matériel
si elles le souhaitent. Les premiers systèmes d'exploitation de ce type étaient
Exokernel [@engler1995] et
Nemesis^[<https://www.cl.cam.ac.uk/research/srg/netos/projects/archive/nemesis/>]
dans les années 1990s.

Le principe des unikernels est qu'au lieu de lancer un système d'exploitation
classique composé d'un grand nombre d'applications, il va se charger de ne faire
tourner que le binaire d'une application, et donc de ne faire tourner qu'un seul
processus [@zhang2018] au sein d'un seul espace mémoire. On va ainsi uniquement
utiliser les briques dont l'application a réellement besoin pour fonctionner.

Pour éviter d'avoir à prendre en charge l'ensemble des périphériques possibles,
dans les cas des unikernels on va partir du principe qu'il tournera dans une
machine virtuelle, et que ce sera à l'hyperviseur de s'occuper du matériel et
d'en faire l'abstraction. Un hyperviseur est un programme qui permet la gestion
(création, lancement, ...) des VM.

On se retrouve donc avec une image beaucoup plus légère. Il y a un lien de
corrélation entre la taille des images et le temps de démarrage (*boot time*)
suite au temps de chargement de l'ensemble en mémoire [@manco2017], ce qui fait
que les unikernels peuvent démarrer beaucoup plus rapidement que les systèmes
traditionnels. De plus, ils garantissent davantage de sécurité : il n'est même
pas possible de se connecter sur la machine, puisqu'ils tournent directement au
sein d'une machine virtuelle et n'incluent que le strict nécessaire pour faire
tourner l'unique application. En outre, ils ne dépendent que d'un nombre très
restreint de bibliothèques, limitant le nombre de failles et *bugs* possibles,
ce qui limite fortement la surface d'attaque [@manco2017].

Cependant, obtenir ces gains de performances tout en garantissant une certaine
sécurité nécessite beaucoup de temps de configuration, étant donné qu'il faut
spécialiser le plus possible le système pour l'application souhaitée.

![Isolation et spécialisation avec les
unikernels\label{iso_spe_uni}](./img/isolation_et_specialisation_avec_unikernels.svg)

La figure \ref{iso_spe_uni}^[Figure faite à partir d'un schéma publié par
[Docker](https://blog.docker.com/2016/01/unikernel/)] nous montre en (a) ce qui
se fait de manière classique : lancer un gestionnaire de conteneurs dans une VM.
L'ensemble des conteneurs se partagent le même noyau. Si l'on souhaite isoler
les différents services, on peut lancer une VM par conteneur, comme en (b). Cela
introduit hélas un surcoût en termes de ressources, dû au fait que l'on doive
dupliquer à chaque fois le noyau. Le fait de travailler avec des noyaux
spécialisés pour l'application, les unikernels (c), permet de limiter ce
surcoût, tout en assurant une isolation forte.
