# Différentes solutions

La majorité des solutions étudiées dans le cadre de ce travail se basent toutes
sur le même hyperviseur : Xen [@barham2003]. Il s'agit donc d'une référence
essentielle, crédible et fiable dans le domaine de la virtualisation. Cependant
un nombre important de solutions n'hésitent pas à réimplémenter certaines
parties de Xen, comme le XenStore [@manco2017], dans le but de limiter le
surcoût occasionné par le fait de passer par de la virtualisation.

## Unikernels

Pour commencer, nous allons voir comment font les solutions principales
d'unikernel pour répondre aux différentes problématiques soulevées précédemment.

### ClickOS

ClickOS [@martins2014], un système d'exploitation sur mesure pour du traitement
réseau. Les machines virtuelles sont légères, démarrent rapidement et
n'utilisent que très peu de mémoire.

### Drawbridge

Drawbridge^[<https://www.microsoft.com/en-us/research/project/drawbridge/#!publications>]
[@porter2011] qui est un prototype de recherche conçu par l'équipe de recherche
de Microsoft, qui permet de lancer des applications de manière isolées au sein
d'un Windows 7 modifié sous forme de *libOS*, ce qui peut être intéressant d'un
point de vue sécurité.

### HaLVM

HaLVM, pour *Ha*skell *L*ightweight *V*irtual *M*achine, permet de lancer du
code Haskell dans un environnement minimal directement sur un hyperviseur Xen.
On retrouve grandement l'aspect système d'exploitation bibliothèque (libOS), par
le fait que l'on peut choisir ou non les différents composants dont on a
besoin, par exemple un système de fichier avec Halfs (*Ha*skel*l* *F*ile
*S*ystem) et la stack TCP/IP complète avec HaNS (*Ha*skell *N*etwork *S*tack).

### IncludeOS

IncludeOS [@bratterud2015] est un *libOS* minimal, à l'état de projet de
recherche, fait pour faire tourner du code C++ sur du matériel virtualisé.

### KylinX

KylinX [@zhang2018] offre un mécanisme de pVM, pour *process-like VM*. Ce
procédé permet de réaliser des `fork` en instanciant une nouvelle machine
virtuelle. La machine ayant fait l'appel à `fork` sera mise en pause le temps de
la création de la pVM et recevra ensuite un moyen de la contacter, ceci permet
de répondre au besoin de prendre en charge plusieurs processus.

### LING

LING^[<http://erlangonxen.org/>] est un unikernel basé sur Erlang/OTP. Erlang
est un langage de programmation qui permet de construire des applications temps
réel évolutives tout en assurant de la haute disponibilité. OTP (=*Open Telecom
Platform*) est composé d'un système d'exécution Erlang ainsi que d'un ensemble
de bibliothèques et composants pour Erlang.

L'unikernel est capable d'interpréter les fichiers `.beam`, qui sont le résultat
de la compilation d'un programme Erlang en code objet. Il est donc aisé
d'intégrer une application à LING, pour la faire tourner dans une machine
virtuelle légère sur Xen, et donc de la déployer en production.

### MirageOS

![Exemple d'une application HTTP sur MirageOS (extrait de la doc. de
MirageOS^[<https://mirage.io/wiki/technical-background>])\label{mirage-app}](img/mirage-app.png)

L'avantage de MirageOS [@madhavapeddy2013_2], une solution d'unikernel utilisant
le langage OCaml, est qu'il offre de bonnes couches d'abstractions. L'exemple
que l'on a en figure \ref{mirage-app} nous montre les différentes dépendances
dont on peut avoir besoin lors du développement ainsi que du déploiement d'une
application MirageOS.

En effet, lors de la phase de développement, les développeurs sont généralement
sur un système de style Unix. La bibliothèque Cohttp a besoin d'une
implémentation TCP, qui est fournie par la bibliothèque UnixSocket. Une fois que
le développement est terminé, toute la partie Unix est retirée et on recompile
l'application en utilisant cette fois-ci le module MirNet, afin d'établir une
liaison directe avec le pilote réseau Xen.

### OSv

OSv [@kivity2014], un OS conçu pour le *cloud* qui peut uniquement être lancée
depuis un hyperviseur, capable de faire tourner une unique application avec des
gains en performances principalement sur la partie réseau. Les auteurs ont
cherché à réutiliser un maximum de composants déjà existants. Par exemple, le
système de fichier utilisé est ZFS [@zhang2010], récupéré depuis FreeBSD, qui
permet de s'assurer de l'intégrité des données et propose un mécanisme de
*snapshots* et de gestion de volumes. Sont aussi supportés ramfs, dans le cas où
l'on souhaiterait démarrer sans disque, ainsi que devfs, un système de fichier
simple pour visualiser les périphériques. Ils ont également récupéré les
fichiers de *header* C depuis le projet `musl
libc`^[<https://www.musl-libc.org/>], le VFS (=Virtual File System) depuis le
projet Prex^[<https://github.com/tworaz/prex>], et les drivers ACPI depuis le
projet ACPICA^[<https://www.acpica.org/>]. Concernant la partie réseau, elle a
également été importé au départ de FreeBSD, mais elle a été longuement réécrite.

### Rumprun

Rumprun^[<https://github.com/rumpkernel/rumprun>], un unikernel dans lequel on
intègre un binaire d'application C, C++, Erlang, Go, Java, JavaScript, Python,
Ruby ou Rust par exemple à un kernel appelé `rump`^[<http://rumpkernel.org/>].
Cela permet de créer des applications *bootables*, légères et portables.

### runtime.js

Runtime.js^[<http://runtimejs.org>] est un unikernel
open source^[<https://github.com/runtimejs/runtime>], sur lequel on peut greffer
une application JavaScript, pour déployer cette dernière de manière légère et
immuable. Il utilise un modèle d'entrée/sortie non bloquant basé sur des
évènements inspiré de NodeJS, ce qui permet de gérer plusieurs tâches
simultanément. KVM est le seul hyperviseur pris en charge à l'heure actuelle.

Il y a deux composants principaux. Le premier est le noyau du système
d'exploitation, qui est écrit en C++, et qui permet la gestion des ressources
telles que le CPU et la mémoire ainsi que de faire tourner le moteur JavaScript
V8. Le second composant est une bibliothèque JavaScript qui gère l'ensemble du
système ainsi que les différents périphériques virtualisés.

À l'heure actuelle, ce projet n'est désormais plus maintenu et n'est pas fait
pour tourner en production.

## Outils

Dans cette partie, nous allons étudier quelques outils intéressants faisant
partie de l'écosystème des unikernels.

### Jitsu

Jitsu [@madhavapeddy2015] est un serveur DNS qui utilise les unikernels pour
servir des applications à la demande. Les auteurs ont fait quelques
optimisations sur Xen, notamment pour le faire fonctionner sous ARM.

![Principe de fonctionnement de Jitsu (extrait du dépôt GitHub du
projet)^[Source :
<https://github.com/mirage/jitsu>]\label{jitsu_fig}](img/jitsu.jpg){width=300px}

Cette solution permet de *booter* des unikernels à la demande suite à une simple
requête DNS, comme on peut le voir sur la figure \ref{jitsu_fig}. Par exemple
cela permet de démarrer une VM lorsque l'on souhaite accéder à une page web.

Concernant l'aspect sécurité, ils ont pris la liste des dernières vulnérabilités
et ont pu constater que nombreuses d'entre elles affectent les systèmes réseaux
embarqués, le noyau Linux et Xen. Les applications déployées avec Jitsu ne sont
que sensibles aux vulnérabilités de Xen ainsi que de quelques unes de Linux, le
reste étant complètement éliminé grâce au mécanisme d'isolation.

### LightVM

LightVM [@manco2017], une nouvelle solution de virtualisation, permet de
démarrer une machine virtuelle presque aussi rapidement qu'un `fork` ou un
`exec` sur Linux et serait deux fois plus rapide que Docker [@anderson2015], une
solution permettant de lancer des conteneurs. Il propose une refonte complète du
plan de contrôle de l'hyperviseur Xen, grâce à des opérations distribuées ayant
des interactions réduites au minimum, dans le but de gagner en performances.

### Tynix

Tinyx [@manco2017], une solution de *build* automatisée permet de créer des
images de machines virtuelles Linux minimalistes en utilisant une approche
particulièrement originale. En effet, il va tenter de retirer une à une les
différentes options de *boot* en testant si l'application continue toujours de
fonctionner comme souhaité avec l'aide d'un jeu de test. Si un des tests ne
passe plus, l'option est réactivée, car essentielle. Cette manière de procéder
permet de rajouter les options de *boot* uniquement nécessaires à l'application.

### UniK

UniK^[<https://github.com/solo-io/unik>] est un outil open source écrit en Go
qui permet de compiler des applications sous forme d'image *bootable* légère
plutôt que sous forme de binaire. UniK permet de construire des images pour AWS
Firecracker, Virtualbox, AWS, Google Cloud, vSphere, QEMU, UKVM, Xen, OpenStack,
Photon Controller et en lancer des instances.

UniK se charge de compiler l'application et de greffer le binaire à une base
d'unikernel existante, tel que rump, OSv, IncludeOS ou MirageOS par exemple, que
l'on peut préférer en fonction du langage dans lequel est écrit l'application.

Le fait de prendre en charge un grand nombre de types d'unikernels permet de
générer des unikernels pouvant faire tourner des applications écrites dans un
nombre varié de langages.

## Conclusion

Concernant le choix des composants à inclure, certaines solutions offrent la
possibilité de tester pour nous ce qu'il faut inclure ou non, tel que Tinyx par
exemple pour les options de *boot*.

Pour la gestion de plusieurs processus, il y a plusieurs manières de faire. Par
exemple KylinX implémente un mécanisme de *pVM*, alors que runtime.js se base
sur le fait que JavaScript soit un langage évènementiel avec des entrées/sorties
non bloquantes pour supporter le multi tâches, ce qui évite d'avoir à modifier
son application.

Certains n'hésitent pas à réécrire certaines parties de Xen, comme LightVM qui
est une réécriture du plan de contrôle de l'hyperviseur, afin de gagner en
performances.

Les unikernels étant spécialisés, ils ne peuvent pas forcément faire tourner
n'importe quelle application. Certains par exemple ne font que tourner des
programmes en OCaml, comme MirageOS, d'autres permettent de faire tourner
quelques programmes en provenance de langages différents, comme c'est le cas par
exemple avec rumprun, qui permet de faire tourner des applications écrites en C,
C++, Erlang, Go, Java, JavaScript, Python, Ruby ou Rust. Le choix de MirageOS de
ne supporter que OCaml est surtout motivé par le fait qu'il s'agisse d'un langage
de haut niveau, il y a moins de risques de soucis avec la gestion de la mémoire
et on limite le nombre de lignes de code.

Quant à la sécurité, contraindre l'utilisation d'un langage de haut niveau comme
le fait MirageOS permet de limiter les attaques dues à une mauvaise gestion de
la mémoire par exemple. Les auteurs de certaines solutions, par exemple Jitsu,
ont pris la liste des dernières vulnérabilités connues et ont pu voir toutes
celles qui pourraient impacter leur solution. Finalement l'ensemble des
unikernels, par leur spécialisation, limitent drastiquement la surface
d'attaque.
