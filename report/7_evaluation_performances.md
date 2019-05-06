# Évaluation des performances

Les différents auteurs utilisent diverses métriques afin de comparer leurs
solutions, comme on peut le constater dans la table \ref{table_eval_metrics}.

La majorité des solutions étudiées se comparent avec des conteneurs Docker
[@boettiger2015] et des machines virtuelles faisant tourner un système
d'exploitation classique.

<!-- https://tex.stackexchange.com/questions/3243/why-should-a-table-caption-be-placed-above-the-table -->

: Différentes métriques utilisées pour évaluer les performances de différents
unikernels \label{table_eval_metrics}

| Unikernel | Métriques utilisées |
|-----------|---------------------|
| OSv       | performances de l'application, taille du tas, réseau, changements de contexte |
| KylinX    | temps de boot, utilisation mémoire, communication inter-pVM, mise à jour de l'environnement d'exécution (bibliothèques), performances d'applications |
| MirageOS  | temps de boot, threads, réseau, stockage, performances d'application |
| Jitsu | débits, latences réseaux, latence démarrage du service, puissance utilisée / autonomie, sécurité |
| LightVM | temps d'instanciation, temps de migration, utilisation CPU, empreinte mémoire |

La table \ref{table_eval_metrics} est une vision d'ensemble des différentes
métriques utilisées par chacune des différentes solutions que nous avons
mentionnées dans ce rapport. Nous constatons que les métriques les plus
utilisées concernent les performances de l'application (temps de lancement,
temps de réponse), le temps de boot et l'utilisation de ressources telles que la
consommation mémoire ou CPU. Nous allons détailler ces métriques dans la suite
de cette partie.

Cependant reprendre les chiffres obtenus dans les différents papiers de
recherche n'a pas spécialement de sens, étant donné qu'ils utilisent chacun une
configuration différente pour effectuer les différents tests. Le but de cette
partie est donc véritablement de voir ce qui est mesuré et comment.

## OSv

Ils utilisent `Memaslap` pour mesurer les performances de Memcached, un serveur
de stockage clé-valeur et `SPECjvm2008` pour mesurer les performances
d'application dans la JVM.

Les performances réseaux ont quant à elles été mesurées avec `Netperf`, et la
taille du tas avec `JVM balloon`.

## KylinX

Le papier de recherche ne décrit pas spécifiquement quels outils ont été
utilisés pour faire les différentes mesures. Nénmoins, la mesure de la
communication inter-pVM a été faire en mesurant la latence de communication
entre la pVM mère et la pVM fille, possiblement avec un `ping`.

## MirageOS

## Jitsu

La mesure des débits est fait avec `iperf` [@tirumala2003], les latences réseaux
avec `ping`, la latence de démarrage de service en regardant combien de temps
cela prends avant que ça ne réponde aux différentes requêtes. Un point
intéressant est qu'ils utilisent une Cubieboard, qui est un nano-ordinateur,
pour mesurer la puissance utilisée ainsi que pour tester l'autonomie. Pour
mesurer la sécurité de leur solution, ils ont pris la liste des dernières
vulnérabilités connues et ont pu regarder à chaque fois si leur solution était
ou non vulnérable.

## LightVM

Il n'est pas précisé la manière dont sont évalués le temps d'instanciation ainsi
que l'emprunte mémoire. Ils utilisent cependant `iostat` pour mesurer
l'utilisation du CPU.
