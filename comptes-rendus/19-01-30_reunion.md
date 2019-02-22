# Compte rendu de la réunion du mercredi 30 janvier 2019

## Contexte

Il s'agit de la seconde réunion dans le cadre du TER qui s'est déroulée le
mercredi 30 janvier 2019 à 9h30 (au lieu de 10h30 initialement prévu). La
réunion a durée une heure environ.

## Travail réalisé

### Panel d'articles

J'ai cherché et survolé un peu moins d'une dizaine de papiers pouvant être
intéressants dans le but de constituer un panel d'articles à étudier. Cette
réunion a permis de voir quels étaient les articles à voir en priorité à partir
de ce panel.

J'ai regroupé les articles dans Google Scholar avec des labels :

  - containers

  - performances

  - sécurité

  - solution (propose une solution)

  - travaillé (article qui ont été étudiés)

  - unikernel

en fonction des thématiques abordées. Cela me permet de m'y retrouver plus
efficacement.

### Kylinx

La première réunion ayant eu lieu lors de la première scéance de travail
personnel pour le TER, je n'avais pas eu le temps de travailler l'article sur
Kylinx de manière complète et je n'avais pas l'article en version papier. J'ai
donc retravaillé pleinement l'article sur Kylinx en annotant directement sur
papier (que c'est tellement plus efficace ainsi !), et effectivement j'avais
raison de dire que les unikernels n'étaient fait que pour exécuter qu'un seul
processus.

Dans cet article il est question du mécanisme des pVM, où l'hyperviseur
jouerait le rôle de l'OS et une instance d'unikernel serait l'équivalent d'un
processus tournant sur cet OS.

Ce qui est propre à Kylinx :

  - support des `fork` pVM

  - support de la communication IPC entre les pVM

  - peut lier des librairies à une instance en cours d'exécution

### Sécurité par rapport aux conteneurs

J'ai également étudié l'article « My VM is Lighter (and Safer) than your
Container » comme prévu, et cette réunion a été l'occasion d'en discuter.

Les unikernels tournent dans une VM. Dans une VM, tout est virtualisé : les
périphériques, les processus, les utilisateurs, le réseau, ... alors que les
conteneurs tournent directement sur l'hôte.

Containers VS unikernels :

  - containers :
  
    - pas vraiment possible de faire une abstraction de l'OS

  - unikernels :

    - virtualisation complète

    - une seule application : surface d'attaque faible

    - pas spécialement de possibilité de se logger sur la VM pour l'attaquer,
      vu qu'il n'y a que le strict minimum pour faire tourner l'application

### Rapport

J'ai également souhaité commencer à voir le plan et les éléments principaux
qu'il faudrait pour chacune des parties du rapport.

J'ai commencé par lister les points principaux qu'il faudrait que j'aborde :

  - définitions

    - virtualisation

    - VM

    - conteneurs

  - conteneurs (rapide) VS VM (sécurisé)

  - avoir les avantages des deux => unikernels

  - libOS (pour expliquer le concept d'unikernel)

  - sécurité

  - performances

Ensuite j'ai cherché à définir les différents éléments de contexte (vu que c'est
principalement là-dessus que sera accès le rapport intermédiaire) :

  - besoin : souplesse dans les centres de données :

    - plusieurs services sur une même machine

    - nombre d'instances pouvant varier en fonction de la demande

    - besoin de performances => moins de machines = gains financiers

    - abstractions par rapport au matériel (une simple configuration)

    - possibilité de migration

  - solution : conteneurs + orchestrateurs

  - problème : sécurité ! (pas de réelle isolation)

  - solution : on met dans une VM

  - problème : performances !

  - solution : unikernel ! <= avantages des deux solutions précédentes

J'ai ensuite cherché à définir une problématique.
Pour commencer, j'ai repris le sujet initial, qui est « réduire les systèmes
pour mieux virtualiser ? ». J'ai ensuite essayé de chercher l'aspect essentiel
de ce sujet, et je suis arrivé sur « performances sans sacrifier la sécurité ».

Ma problématique est donc la suivante : « En quoi les unikernels arrivent à offrir
des gains réels en performances sans sacrifier la sécurité, chose que l'on
n'arrivait pas à satisfaire simultanément jusqu'à présent avec des conteneurs et
des VM traditionnels ? »

Et enfin, je suis parvenu à construire un plan :

  1. Introduction, avec définitions virtualisation, VM, conteneurs, expliquer
       pourquoi on a besoin aujourd'hui d'avoir recours à la vurtualisation, en
       quoi est-ce qu'on a besoin d'avoir une certaine souplesse dans les
       services, ...

  2. Définition du problème : besoin de performances sans sacrifier la sécurité,
     comparer VM et conteneurs au passage, et se rendre compte que les
     unikernels pourraient parfaitement répondre à la demande

  3. Unikernel késako ? Parler de libOS (briques de LEGO, ...), but, avantages
     et inconvénients

  4. Solutions actuelles / proposées d'un point de vue performances et sécurité

  5. Évaluation des performances des différentes solutions et dire les limites
     des évaluations rencontrées

  6. Conclusion. Aborder l'avenir des unikernels, l'orientation dans le monde de
     la rechercher et les pistes à creuser

## Pour la prochaine fois

Il faudrait voir pour mettre la bibliographie dans le `git`, tout comme les
résumés des papiers étudiés jusqu'à présent.

Étudier en priorité l'article « Unikernel: Rise of the Virtual Library Operating
System ».

Il peut être intéressant de regarder les picoprocess et les lambdas.

La prochaine réunion a été programmée pour le mercredi 13 février 2019 à 14h.
