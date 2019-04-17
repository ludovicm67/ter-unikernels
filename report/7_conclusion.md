# Conclusion

Les unikernels offrent des avantages certains, tels que de très bonnes
performances avec une sécurité plus importante que lors de l'utilisation de
conteneurs comme Docker ^[https://www.docker.com/] par exemple, tout en ayant
une faible empreinte mémoire.

Cependant, construire une image spécifique pour chaque application est très
coûteux en terme de temps, du fait que chaque applciation a ses propres besoins,
mais cela tend à devenir plus abordable suite à des projets comme UniK. Un autre
problème est que l'on est amené à recompiler tout l'ensemble lorsque l'on
souhaite effectuer des changements, étant donné que l'on intègre que le strict
minimum pour lancer le binaire de l'application, et non ceux pour effectuer les
changements.
  
Aujourd'hui il existe d'autres systèmes concurrents aux unikernels, tels que les
lambdas proposés par Amazon (AWS Lambda ^[https://aws.amazon.com/fr/lambda/])
par exemple [@krol2017; @spillner2018], qui permettent d'exécuter des fonctions
de manière indépendante, et de pouvoir adapter les ressources nécessaires à la
demande en temps réel.
