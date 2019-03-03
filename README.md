# TER sur les unikernels

## Génération du rapport

Pour pouvoir générer le rapport, il faut installer les dépendances suivantes
lorsque l'on est sur Ubuntu 18.10 :

```sh
sudo apt install pandoc pandoc-citeproc \
texlive-xetex texlive-lang-french texlive-bibtex-extra
```

Pour générer le rapport au format pdf, il suffit de lancer la commande `make`.

Le rapport sera généré sous le nom `report.pdf`.
