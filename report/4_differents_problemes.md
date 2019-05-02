# Différents problèmes

On souhaite donc voir comment est-ce que l'on procède pour réaliser un
unikernel. Nous avons dit dans la partie précédente que les unikernels étaient
des systèmes légers où l'où incluait que le strict nécessaire. Comment est-ce
que l'on fait pour choisir les composants absoluments nécessaires ?

La majorité des unikernels, pour éviter d'avoir à prendre en charge une liste
importante de périphériques à gérer via une multitude de pilotes de
périphériques, partent du principe qu'ils seront lancés au sein d'une machine
virtuelle gérée par un hyperviseur, en l'occurrence Xen. Cependant, cela induit
un surcoût du fait que la machine hôte doit émuler les différents périphériques.
Comment est-ce que les diverses solutions proposées se débrouillent pour limiter
ce surcoût ?

Si l'on souhaite déployer une application existante dans un unikernel, comment
est-ce qu'on s'y prend pour transormer un système d'exploitation classique en
unikernel ? Est-ce que l'on essaie de partir de quelque chose d'existant que
l'on va transformer, ou au contraire partir de zéro dans le but d'avoir une
maîtrise complète et de s'assurer de n'avoir que le strict nécessaire ?

Les unikernels possèdent un noyau minimaliste. Est-ce que les différentes
solutions tentent de déléguer le maximum de travail aux applications ? Quel est
l'impact d'avoir un système n'ayant ni le support de plusieurs processus, ni MMU
(*Memory Management Unit*), etc. ? Est-ce qu'il y a un système de fichiers ? Si
oui, comment les gèrent-ils ? Quelles ont les modifications à apporter aux
différentes applications afin de pouvoir les faire fonctionner convenablement au
sein d'un unikernel ?

D'un point de vue sécurité, le fait de tourner au sein d'une machine virtuelle
permet d'assurer une certaine étenchéitée. Est-ce que les différents auteurs
proposant des solutions d'unikernels portent attention à d'autres aspects pour
assurer une certaine sécurité ?

Nous verrons dans la partie suivant quelles sont les principales solutions
d'unikernels à l'heure actuelle et comment est-ce qu'elles répondent aux
différents problèmes soulevés tout au long de cette partie.
