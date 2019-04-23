# UniK

La solution qui me semble la plus intéressante à tester est Unik, de part par le
fait qu'il soit relativement bien documenté, et d'autre part par le fait qu'il
permet de compiler et inclure des applications à un nombre relativement correct
d'unikernels, ce qui est parfait pour expérimenter.

Pour commencer, j'ai installé UniK sur ma machine en suivant la documentation,
et j'ai pris la décision de cibler initialement QEMU. Cependant, je n'ai pas
réussi à construire d'image et j'ai pu constater par la suite que l'intégration
n'était pas complète à l'heure actuelle. J'ai donc fait le choix de cibler
VirtualBox.

## Un exemple concret

Je trouve qu'il est intéressant de pouvoir illustrer mes propos avec un exemple
concret. J'ai donc décidé d'écrire un serveur web avec le langage go, qui me
permet de le faire de manière assez rapide. Ce choix d'exemple offre l'avantage
de montrer la communication réseau entre l'hôte et l'application et me permets
de détailler la manière dont fonctionne UniK.

Je compile mon code en local sur ma machine pour tester s'il est fonctionnel, ce
qui est le cas.

Je lance donc la commande pour construire l'image pour VirtualBox. En cas
d'erreur lors du build, il est possible de récupérer les logs depuis de démon
UniK. Dans mon exemple, j'ai choisis de partir sur la base de l'unikernel rump
pour y greffer mon serveur web. Au final, l'image ne fait que 39Mo.

Une fois l'image créée, je peux créer autant d'instances que je souhaite de
cette image.

UniK permet de récupérer la liste des différentes images créées ainsi que des
différentes instances lancées, avec leur adresses IP. Pour récupérer l'adresse
IP, lors de la création d'une instance pour VirtualBox, le démon UniK va envoyer
en UDP une requête à un listener, qui va lui répondre.

J'ai donc plusieurs instances de mon serveur web qui fonctionnent parfaitement.
On pourrait imaginer la possibilité d'y intégrer un *load-balancer* pour
répartir équitablement la charge sur les différentes instances lancées.

J'ai pu effectuer quelques tests sur avec mon application en go sur une base
rump. J'ai pu en déduire que l'application continuait à répondre aux requêtes
même si l'application paniquait ou tentait de faire un `Exit`. J'ai pu constater
qu'il était relativement aisé de récupéré les logs propres à une instance avec
UniK, ce qui peut être pratique pour debuger une application.

Il serait intéressant de tester d'intégrer des images au sein du serveur web, de
construire à nouveau une image avec UniK et voir comment est-ce que sont gérés
les fichiers et si ça fonctionne. Un autre point qui serait intéressant à voir,
serait la découverte de services : est-ce qu'il serait possible de lancer une
instance d'unikernel avec un serveur d'API et une autre instance d'unikernel
avec une application qui y effectue des requêtes ? autrement dit, est-ce qu'il y
aurait la possiblité de faire de la découverte de service et récupérer
dynamiquement l'adresse IP du serveur d'API depuis une autre instance ?

## Maturité

Le projet est relativement fonctionnel dans son ensemble et propose un certain
choix en terme de cibles de déploiements et en base d'unikernel pour construire
les images. Cependant certaines de ces cibles semblent être moins prises en
charge que d'autres, comme QEMU par exemple.

Lors de certains de mes tests, le listener déployé par UniK au sein d'une
nouvelle VM dans VirtualBox semblait planter de temps en temps, m'obligeant à
redémarrer la machine virtuelle en question manuellement, ce qui ne serait pas
envisageable dans un environement de production.

J'ai pu constater dans une conférence donnée par Idit Levine en
2016^[https://www.youtube.com/watch?v=wcZWg3YtvnY], que l'API de docker est en
mesure de communiquer avec celle de UniK et qu'il était possible d'intégrer des
unikernels créées par UniK à Kubernetes^[https://kubernetes.io/], un
orchestrateur de conteneurs.

## Conclusion

Bien que le projet n'est pas encore tout à fait mature pour être lancé en
production, il est prometeur et semble s'adapter aux besoins actuels, qui sont
notament le fait de pouvoir s'intégrer à des solutions d'orchestrations tels que
Kubernetes.

Il est relativement simple à prendre en main et rend le monde des unikernels
beaucoup plus accessible qu'auparavant.
