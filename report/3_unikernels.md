# Unikernels

Les unikernels pourraient être décrits simplement comme étant un système
d'exploitation créé à partir d'un assemblage de briques de LEGO, chacune de ces
briques étant une bibliothèque élémentaire permettant une tâche de base, comme
par exemple la partie réseau, ou bien la communication IPC, etc. Un système
construit de cette manière à partir de bibliothèques de base s'appelle une
*library OS* ou *libOS*. Le but de cette architecture et d'exécuter un maximum
de code dans l'espace utilisateur directement, et de n'avoir qu'un noyau
minimaliste. Les premiers systèmes d'exploitations de ce type étaient Exokernel
[@engler1995] et
Nemesis^[https://www.cl.cam.ac.uk/research/srg/netos/projects/archive/nemesis/]
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
