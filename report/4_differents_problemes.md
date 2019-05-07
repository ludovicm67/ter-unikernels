# Différents problèmes

## Composants

On souhaite donc voir comment l'on procède pour réaliser un unikernel. Nous
avons dit dans la partie précédente que les unikernels étaient des systèmes
légers où l'on incluait que le strict nécessaire. Comment est-ce que l'on fait
pour choisir les composants absolument nécessaires ? En effet, garder un nombre
trop important de composants ferait perdre l'avantage de passer par un
unikernel, et en retirer trop peut empêcher l'application de tourner
convenablement.

## Plusieurs processus

Certaines applications ont besoin de lancer plusieurs processus, notamment en
faisant des `fork` par exemple. Comment est-ce qu'il est possible d'envisager de
les faire fonctionner au sein d'un unikernel, sachant que par *design* un
unikernel n'est fait que pour faire tourner qu'un seul processus ? Est-ce qu'il
y a besoin d'effectuer des modifications à son application pour espérer la faire
tourner ?

## Performances

La majorité des unikernels, pour éviter d'avoir à prendre en charge une liste
importante de périphériques à gérer via une multitude de pilotes de
périphériques, partent du principe qu'ils seront lancés au sein d'une machine
virtuelle gérée par un hyperviseur, en l'occurrence Xen. Cependant, cela induit
un surcoût du fait que la machine hôte doit émuler les différents périphériques.
Comment est-ce que les diverses solutions proposées se débrouillent pour limiter
ce surcoût ? Si les performances sont mauvaises, il sera difficile d'envisager
d'utiliser une telle solution en production.

## Spécialisation

Les unikernels sont, comme nous l'avons vu, spécialisés. Cela implique que l'on
a dû faire un certain nombre de concessions, notamment en ne prennent qu'un
nombre très restreint de langages en charge. Quels choix ont pu être faits ? Et
pourquoi ?

## Sécurité

Du point de vue de la sécurité, le fait de tourner au sein d'une machine
virtuelle permet d'assurer une certaine étanchéité. Est-ce que les différents
auteurs proposant des solutions d'unikernels portent attention à d'autres
aspects pour assurer une sécurité encore plus importante ?

Nous verrons dans la partie suivante quelles sont les principales solutions
d'unikernels et les différents outils associés à l'heure actuelle et comment ils
répondent aux différents problèmes soulevés tout au long de cette partie.
