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
gains en performances principalement sur la partie réseau. Les auteurs ont
cherchés à réutiliser un maximum de composants déjà existants. Par exemple, le
système de fichier utilisé est
ZFS^[https://www.freebsd.org/doc/handbook/zfs.html], récupéré depuis FreeBSD,
qui permet de s'assurer de l'intégrité des données et propose un mécanisme de
snapshots et de gestion de volumes. Sont aussi supportés ramfs, dans le cas où
l'on souhaiterait booter sans disque, ainsi que devfs, un système de fichier
simple pour visualiser les périphériques. Ils ont également récupéré les
fichiers de header C depuis le projet `musl libc`^[https://www.musl-libc.org/],
le VFS (=Virtual File System) depuis le projet
Prex^[https://github.com/tworaz/prex], et les drivers ACPI depuis le projet
ACPICA^[https://www.acpica.org/]. Concernant la partie réseau, elle a également
été importé au départ de FreeBSD, mais elle a été longuement réécrite.

Drawbridge^[https://www.microsoft.com/en-us/research/project/drawbridge/#!publications]
[@porter2011] qui est un prototype de recherche conçu par l'équipe de recherche
de Microsoft, qui permet de lancer des applications de manière sandboxées au
sein d'un Windows 7 modifié sous forme de libOS.

Rumprun^[https://github.com/rumpkernel/rumprun], un unikernel dans lequel on
intègre un binaire d'application C, C++, Erlang, Go, Java, JavaScript, Python,
Ruby ou Rust par exemple à un kernel appelé `rump`^[http://rumpkernel.org/]. Ce
qui permet de créer des applications bootables, légères et portables.

UniK^[https://github.com/solo-io/unik] qui permet de compiler des applciations
sous forme d'image bootable légère plutôt que sous forme de binaire.

UniK supporte les types d'unikernels suivants :

  - AWS Firecracker : pour compiler et lancer une application en GO,

  - rump : pour compiler et lancer une application en Python, Node.js ou en Go,

  - OSv : pour compiler et lancer une application en Java, en Node.js, C ou en
    C++,

  - IncludeOS : pour compiler et lancer une application en C++,

  - MirageOS : pour compiler et lancer une application en OCaml.

Ainsi que les fournisseurs suivants : AWS Firecracker, Virtualbox, AWS, Google
Cloud, vSphere, QEMU, UKVM, Xen, OpenStack, Photon Controller.

Le fait de prendre en charge un grand nombre de types d'unikernels permet de
générer des unikernels pouvant faire tourner des applications écrites dans un
nombre variés de langages. Le fait qu'il supporte autant de fournisseurs fait de
UniK un projet prometteur.
