# UniK

La solution qui nous semble la plus intéressante à tester est Unik, de part par
le fait qu'elle soit relativement bien documentée, et d'autre part par le fait
qu'elle permet de compiler et d'inclure des applications à un nombre
relativement correct d'unikernels, ce qui est parfait pour expérimenter.

Pour commencer, nous avons installé UniK sur notre machine en suivant la
documentation, et nous avons pris la décision de cibler initialement QEMU du
fait de sa présence sur la machine. Cependant, nous n'étions pas en mesure de
construire des images et nous avons pu constater par la suite que l'intégration
n'était pas complète à l'heure actuelle. Nous avons donc finalement fait le
choix de cibler VirtualBox.

## Un exemple concret

Nous trouvons qu'il est intéressant de pouvoir illustrer nos propos avec un
exemple concret. Nous avons donc décidé d'écrire un serveur web avec le langage
go, qui nous permet de le faire de manière assez rapide. Ce choix d'exemple
offre l'avantage de montrer la communication réseau entre l'hôte et
l'application et nous permet de détailler la manière dont fonctionne UniK.

Nous compilons notre code en local sur ma machine et testons si la page
s'affiche bien dans le navigateur pour tester si notre serveur est fonctionnel,
ce qui est le cas.

Nous lançons donc la commande pour construire l'image pour VirtualBox. En cas
d'erreur lors du build, il est possible de récupérer les logs depuis de démon
UniK. Dans notre exemple, nous avons choisis de partir sur la base de
l'unikernel rump pour y greffer notre serveur web. Au final, l'image ne fait que
39Mo.

Une fois l'image créée, nous pouvons créer autant d'instances que nous
souhaitons de cette image.

UniK permet de récupérer la liste des différentes images créées ainsi que des
différentes instances lancées, avec leur adresses IP. Pour récupérer l'adresse
IP, lors de la création d'une instance pour VirtualBox, le démon UniK va envoyer
en UDP une requête à un listener, qui va lui répondre.

Nous avons donc plusieurs instances de notre serveur web qui fonctionnent
parfaitement. On pourrait imaginer la possibilité d'y intégrer un
*load-balancer* pour répartir équitablement la charge sur les différentes
instances lancées.

Nous avons pu effectuer quelques tests sur notre application en go avec une base
avec l'unikernel rump. Nous avons pu en déduire que l'application continuait à
répondre aux requêtes même si l'application paniquait ou tentait de faire un
`Exit`. En outre, le fait qu'il soit relativement aisé de récupéré les logs
propres à une instance avec UniK peut être pratique pour debuger une
application.

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

Lors de certains de nos tests, le listener déployé par UniK au sein d'une
nouvelle VM dans VirtualBox semblait planter de temps en temps, nous obligeant à
redémarrer la machine virtuelle en question manuellement, ce qui ne serait pas
envisageable dans un environement de production.

Nous avons pu constater dans une conférence donnée par Idit Levine en
2016^[https://www.youtube.com/watch?v=wcZWg3YtvnY], que l'API de docker est en
mesure de communiquer avec celle de UniK et qu'il était possible d'intégrer des
unikernels créées par UniK à Kubernetes^[https://kubernetes.io/], qui est un
orchestrateur de conteneurs qui est de plus en plus utilisé.

## Conclusion

Bien que le projet n'est pas encore tout à fait mature pour être lancé en
production, il est prometeur et semble s'adapter aux besoins actuels, qui sont
notament le fait de pouvoir s'intégrer à des solutions d'orchestrations tels que
Kubernetes.

Il est relativement simple à prendre en main et rend le monde des unikernels
beaucoup plus accessible qu'auparavant.
