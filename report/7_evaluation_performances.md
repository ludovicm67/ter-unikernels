# Évaluation des performances

Les différents auteurs utilisent diverses métriques afin de comparer leur
solutions, comme on peut le constater dans la table \ref{table_eval_metrics}.

<!-- https://tex.stackexchange.com/questions/3243/why-should-a-table-caption-be-placed-above-the-table -->

: Différentes métriques utilisés pour évaluer les performances de différents
unikernels \label{table_eval_metrics}

| Unikernel | Métriques utilisées |
|-----------|---------------------|
| OSv       | performances de l'application, taille du tas, réseau, changements de contexte |
| KylinX    | temps de boot, utilisation mémoire, communication inter-pVM, mise à jour de l'environement d'exécution (bibliothèques), performances d'applications |
| MirageOS  | temps de boot, threads, réseau, stockage, performances d'application |
| Jitsu | débits, latences réseau, latence démarrage du service, puissance utilisée / autonomie, sécurité |
| LightVM | nombre d'hôtes lancés, temps de création, temps de boot, temps de migration, utilisation CPU, empreinte mémoire |

