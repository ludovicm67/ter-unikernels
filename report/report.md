# Introduction

Dans cette partie seront définies :

  - virtualisation

  - machine virtuelle (VM)

  - conteneurs

afin de pouvoir poser le contexte de base.

[@zhang2018] semble être parfaitement adapté dans ce cas.

Il y sera également expliqué en quoi est-ce qu'on a besoin de virtualiser
aujourd'hui et pourquoi est-ce que l'on a aussi besoin d'une certaine souplesse.

# Définition du problème

Cette partie consistera à définir clairement le problème.  Dans notre cas, il
s'agit d'un besoin de performances sans sacrifier la sécurité.

Il sera aussi question de comparer les solutions actuelles, notamment les VM et
les conteneurs.

Enfin, on pourra se rendre compte que ce qui pourrait parfaitement répondre à la
demande pourraient être les unikernels.

# Les unikernels, késako ?

Il faut introduire ici la notion de *library OS*, qui consiste à construire un
noyau de système d'exploitation avec l'aide de différentes librairies, un peu
comme s'il s'agissait de briques de LEGO.

Il sera notamment question du but même d'une telle solution, de ses avantages et
enfin, de ses inconvénients (par exemple le fait que c'est quelque chose qui
demande beaucoup de temps à mettre en place puisqu'il s'agit que quelque chose
de très spécifique pour chacune des solutions.

# Les différentes solutions

Dans cette partie il faudra détailler les différentes solutions proposées
trouvées dans les différents papiers de recherche.

## D'un point de vue performances

On va d'abord se focaliser sur l'aspect performances...

## D'un point de vue sécurité

...et puis voir comment les différentes solutions font pour garantir l'aspect
sécurité.

# Évaluation des performances

Dans cette partie il faudrait voir pour énumérer les limites des différentes
solutions étudiées tout au long du semestre lors de ce travail de recherche, et
voir pour évaluer les performances, si les gains en performances n'impactent pas
la sécurité, être critique sur les résultats présentés dans les divers papiers.

# Conclusion

Faire le bilan de l'ensemble, parler de l'avenir des unikernels, orientations
dans le monde de la recherche et les différentes pistes à creuser.

