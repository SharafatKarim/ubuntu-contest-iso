#!/bin/bash

set -eux

source vars.sh

cd $ADMIN_SCRIPTS_DIR

homedir="/home/$ADMIN_USER"
if [[ -d "$homedir" ]]; then
	for file in *; do
		cp -rv $file "$homedir/"
		chown -R -c -v $ADMIN_USER:$ADMIN_USER "$homedir/$file"
		chmod -R -v 750 "$homedir/$file"
	done
else
	echo "Notice: $homedir directory does not exist. Skipping copy_admin_scripts."
fi

cd -
