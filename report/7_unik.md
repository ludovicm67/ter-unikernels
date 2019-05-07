# UniK

Il serait bien de pouvoir tester différentes solutions d'unikernels afin de
comparer leurs performances entre elles, ainsi qu'avec les solutions
traditionnelles telles que les conteneurs et les machines virtuelles. Ceci nous
permettra de nous donner un ordre de grandeur sur plusieurs aspects à propos de
ces solutions.

La solution qui nous semble la plus intéressante à tester est UniK, d'une part
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
Go, qui nous permet de le faire de manière assez rapide. Ce choix d'exemple
offre l'avantage de montrer la communication réseau entre l'hôte et
l'application et nous permet de détailler la manière dont fonctionne UniK.

Nous compilons notre code en local sur ma machine et testons si la page
s'affiche bien dans le navigateur pour tester si notre serveur est fonctionnel,
ce qui est le cas.

Nous lançons donc la commande pour construire l'image pour VirtualBox. En cas
d'erreur lors du build, il est possible de récupérer les logs depuis de démon
UniK. Dans notre exemple, nous avons choisi de partir sur la base de
l'unikernel rump pour y greffer notre serveur web. Finalement, l'image ne fait
que 39 Mo.

Une fois l'image créée, nous pouvons créer autant d'instances que nous
souhaitons de cette image.

UniK permet de récupérer la liste des différentes images créées ainsi que des
différentes instances lancées, avec leurs adresses IP. Pour récupérer l'adresse
IP, lors de la création d'une instance pour VirtualBox, le démon UniK va envoyer
en UDP une requête à un *listener*, qui va lui répondre.

Nous avons donc plusieurs instances de notre serveur web qui fonctionnent
parfaitement. On pourrait imaginer la possibilité d'y intégrer un
*load-balancer* pour répartir équitablement la charge sur les différentes
instances lancées.

Nous avons pu effectuer quelques tests sur notre application en Go avec une base
avec l'unikernel rump. Nous avons pu découvrir que l'application continuait à
répondre aux requêtes même si l'application paniquait manuellement ou tentait de
faire un `Exit`, du fait que les différents `syscall` n'y sont pas implémentés.
Cependant, lorsque nous souhaitions effectuer des test de performances,
l'ensemble crashait subitement de manière non déterministe. En outre, le fait
qu'il soit relativement aisé de récupérer les logs propres à une instance avec
UniK peut être pratique pour *debug* une application.

Nous souhaitions également tester la présence d'un système de fichier. Pour
cela, nous avons ajouté un dossier dans lequel se trouve une image, et nous
l'avons servi depuis le serveur web. Nous avons pu constater que l'image est
belle est bien accessible depuis le navigateur web : un système de fichier est
donc bien intégré dans notre cas. L'analyse des logs de *debug* du démon UniK
lors de la création de l'image nous confirme l'inclusion du système de fichier.

Il aurait pu être intéressant de tester la découverte de services : est-ce qu'il
serait possible de lancer une instance d'unikernel avec un serveur d'API et une
autre instance d'unikernel avec une application qui y effectue des requêtes ?
Autrement dit, est-ce qu'il y aurait la possibilité de faire de la découverte de
service et récupérer dynamiquement l'adresse IP du serveur d'API depuis une
autre instance ? Nous n'avons malheureusement pas eu le temps de tester cela
lors de ce travail.

## Évaluation des performances

Pour évaluer les performances de différentes solutions, nous avons effectué une
démarche similaire à ce que l'on a fait précédemment pour avoir un serveur web
écrit en Go sur une base rump, afin d'obtenir d'autres images d'unikernels. Nous
sommes parvenus à créer en plus de l'image précédente, une image avec un serveur
web écrit en Java sur une base rump et sur une base OSv. Cependant nous n'étions
pas en mesure de pouvoir accéder au serveur web depuis l'hôte dans le cas du
serveur web en Java sur une base rump.

Nous ne sommes pas parvenus à trouver un moyen propre pour évaluer la
consommation mémoire de chacune des solutions testées, mais nous avons réussi à
obtenir des résultats pertinents concernant la taille des images ainsi que le
temps de réponse d'un serveur web.

### Taille des images

: Taille des images des différentes solutions testées \label{table_images_mem}

| Langage | Type | Base | Taille de l'image (en Mo)|
| ------- | ---- | ---- | -----------------:|
| Go | unikernel | rump | 39|
| Java | unikernel | rump | 241|
| Java | unikernel | OSv | 90|
| Go | conteneur Docker | `golang:1.12` | 788|
| Java | conteneur Docker | `openjdk:7` | 880|
| Go | VM | Debian 9 | 1 600|
| Java | VM | Debian 9 | 1 900|

La table \ref{table_images_mem} nous montre la taille des différentes images que
nous avons pu créer avec UniK. Nous pouvons constater que la taille varie en
fonction de la base d'unikernel utilisée, par exemple un serveur web en Java
nécessitera 241 Mo sur une base rump alors qu'il nécessitera que 90 Mo sur une
base OSv. De même, la taille dépend également du langage utilisé, par exemple
sur une base rump, un serveur web ne nécessite que 39 Mo s'il est écrit en Go,
alors qu'il pèse 241 Mo s'il est écrit en Java.

En conteneurisant l'application pour Docker, nous obtenons une taille plus
importante, de l'ordre de 788 Mo pour le serveur web en Go et 880 Mo pour celui en
Java, ce qui revient à la même conclusion que nous avons pu faire lors de la
comparaison sur une même base d'unikernel.

Nous avons également installé deux Debian 9 avec les outils nécessaires pour
créer et lancer le même serveur web en Java et en Go respectivement sur ces VM.
On peut observer qu'un serveur web en Java génère une plus grande taille d'image
qu'en Go. Les images sont nettement plus lourdes dans le cas d'une VM sous
Debian 9 qu'avec les unikernels.

### Temps de réponse

Étant donné que nous avons créé un serveur web pour nos différents tests, nous
allons comparer avec l'aide de `curl` le temps de réponse d'une simple page web
affichant une ligne de texte. Dans le but d'avoir des résultats significatifs,
nous avons lancé à chaque fois 10 000 simulations.

<!-- {echo "time"; for i in {1..10000}; curl -s -w "%{time_total}\n" -o /dev/null http://192.168.1.42:1234} | sed 's/,/./' | mlr --ofs space --itsv stats1 -a mean,min,max,median -f time -->

: Temps de réponse (en ms) aux requêtes \label{table_req_time}

| Solution | Temps moyen | Temps minimal | Temps maximal | Temps médian |
| -------- | -----------:| -------------:| -------------:| ------------:|
| Go sur base rump | 3.128 | 0.470 | 15.453 | 2.385 |
| Java sur base OSv | 1.172 | 0.488 | 21.485 | 0.771 |
| Go sur conteneur Docker | 0.349 | 0.296 | 3.888 | 0.341 |
| Java sur conteneur Docker | 0.383 | 0.260 | 10.235 | 0.359 |
| Go sur VM Debian 9 | 0.715 | 0.559 | 7.155 | 0.705 |
| Java sur VM Debian 9 | 1.102 | 0.676 | 20.548 | 0.909 |

On constate sur le tableau \ref{table_req_time} que l'on a des temps de réponse
similaires pour le serveur web écrit en Java, qu'on soit sur une base
d'unikernel OSv ou dans une VM Debian 9. Le serveur web écrit en Go quant à lui
répond plus rapidement que celui en Java lorsqu'il est sur Debian 9, et met plus
de temps à répondre que toutes les autres solutions lorsqu'il est greffé sur une
base rump.

Les conteneurs offrent le meilleur temps de réponse, du fait qu'il y a moins de
couches d'abstraction, contrairement au unikernels ou les systèmes
d'exploitation, qui eux, tournent dans un environnement virtualisé.

## Maturité

Le projet est relativement fonctionnel dans son ensemble et propose un certain
choix en termes de cibles de déploiements et en base d'unikernel pour construire
les images. Cependant certaines de ces cibles semblent être moins prises en
charge que d'autres, comme QEMU par exemple.

Lors de certains de nos tests, le *listener* déployé par UniK au sein d'une
nouvelle VM dans VirtualBox plantait de temps en temps, nous obligeant soit à
redémarrer la machine virtuelle en question manuellement, soit à la détruire
pour que le démon la crée à nouveau, ce qui ne serait pas envisageable dans un
environnement de production.

Nous avons pu constater dans une conférence donnée par Idit Levine en
2016^[<https://www.youtube.com/watch?v=wcZWg3YtvnY>], que l'API de Docker est en
mesure de communiquer avec celle d'UniK et qu'il était possible d'intégrer des
unikernels créées par UniK à Kubernetes
[@bernstein2014]^[<https://kubernetes.io/>], qui est un orchestrateur de
conteneurs qui est de plus en plus utilisé.

## Conclusion

Bien que le projet n'est pas encore tout à fait mature pour être lancé en
production, il est prometteur et semble s'adapter aux besoins actuels, qui sont
notamment le fait de pouvoir s'intégrer à des solutions d'orchestrations tels
que Kubernetes.

Il est relativement simple à prendre en main et rend le monde des unikernels
beaucoup plus accessible qu'auparavant.

Concernant les performances obtenues, nous pouvons voir que là où l'on gagne le
plus à utiliser des unikernels est sur la taille des images. Les temps de
réponses sont cependant moins élevés que ceux des conteneurs, mais il s'agit
d'un compromis à faire pour avoir une sécurité renforcée. Ainsi, utiliser des
unikernels permettrait de faire des économies sur l'espace disque. La mesure de
la consommation mémoire ainsi que les ressources CPU utilisées auraient pu être
d'excellents indicateurs, mais nous ne sommes pas parvenus à effectuer des
mesures de manière fiable.
