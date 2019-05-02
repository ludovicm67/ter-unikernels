#!/bin/zsh

# ETAPE 1 :
#   ajout dans /etc/modules-load.d/modules.conf la ligne suivante :
#     options loop max_loop=64
#
# ETAPE 2 :
#   redémarrer le système
#
# ETAPE 3 :
#   lancer ce script, pour créer les loop devices

for i in {34..64}; do
  mknod -m0660 /dev/loop$i b 7 $i
  chown root.disk /dev/loop$i
done
