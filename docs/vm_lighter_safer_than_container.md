# My VM is Lighter (and Safer) than your Container

# Contexte

Il s'agit du second papier de recherche que j'ai lu dans le cadre de ce TER.
Dans le papier précédent sur KylinX, les conteneurs, les VM et les
*picoprocess* étaient répidement présentés à la fin.

Ce papier devrait permettre de faire une bonne distinction entre une VM et un
conteneur, et trouver les avantages et inconvénients de ces derniers.

# Éléments retenus

Il y est reproché aux conteneurs le fait d'être moins sécurisés, car moins
isolés. Ils sont cependant très performants, ce qui a fait que leur usage
est fortement répandu. Il n'est pas vraiment possible de faire une abstraction
du système d'exploitation. Un problème de sécurité serait justement le fait
qu'il est difficile de sécuriser l'ensemble des appels systèmes fait par un
conteneur.

Les VM sont plus sécurisés que les conteneurs car biens plus isolés.

En effet tout est virtualisé : les périphériques, les processus, les
utilisateurs, le réseau, ... alors que les conteneurs tournent directement
sur l'hôte.

Cependant toute la stack autours est beaucoup plus lourde; de base faire
tourner un OS traditionnel complet sur un système hôte est relativement
coûteux.

Les unikernels sont des systèmes d'exploitations spécifiques pour faire
tourner un processus d'application uniquement. Ils sont entièrement
virtualisés. Le fait de ne faire tourner qu'une seule application offre une
surface d'attaque bien plus faible que pour un système d'exploitation
traditionnel qu'on ferait également tourner dans une VM. Il n'y a pas
spécialement de possibilité de se connecter sur la VM faisant tourner un
unikernel pour l'attaquer par exemple, du fait est qu'il n'embarque que le
strict nécessaire pour faire tourner l'application qu'il contient.

Un point négatif soulevé dans ce papier à propos des unikernels est le fait
qu'ils soient ultra spécifiques. Cela nécessite un temps non négligeable
pour créer l'image qui répond parfaitement à notre besoin, qui soit en
mesure de pouvoir lancer l'application souhaitée. Le fait d'effectuer un
portage d'application vers un système d'exploitation minimaliste peut donc
s'avérer relativement chronophage.

Les chercheurs de ce papier présentent LightVM, une nouvelle solution
de virtualisation basée sur Xen. Il peut démarrer une VM presque aussi
rapidement qu'un `fork`/`exec` sur Linux et serait deux fois plus rapide
que Docker, qui est une soution permettant de lancer des conteneurs.

Les points recherchés sont les suivants : une instanciation rapide, la
possibilité d'avoir un très grand nombre d'instances simultanées et le fait
de pouvoir mettre en pause/sortir de pause une VM comme cela est possible avec
les conteneurs.

Le gain de performances et de légèreté est vraiment quelque chose de très
recherché en ce moment, du fait est que cela permet de faire baisser de
manière non négligeables les coûts énergétiques des infrastructures.

D'ailleurs les chercheurs ont montré un lien de corrélation entre la taille
de l'image et le temps de boot : plus l'image est lourde, plus la VM mettra
plus de temps pour démarrer.

Dans ce papier, les chercheurs présentent Tinyx, un système de build
automatisé qui permet de créer des images de VM Linux minimalistes. Leur
approche est plutôt originale : ils essayent de retirer une à une les
différentes options de boot et testent au fur et à mesure si ça fonctionne
encore; sinon ils n'ont qu'à réactiver l'option en question.

# Critiques

Le papier ne cesse de se comparer à Docker, or il ne représente pas à
lui seul l'ensemble des solutions pour lancer des conteneurs. Je pense
par exemple à `rkt`, les LXC, etc.
