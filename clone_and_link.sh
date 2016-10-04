#!/bin/bash

pushd "$HOME" > /dev/null

if [ -d ".dotfiles" ]; then
	pushd ".dotfiles" > /dev/null
	# git smart-pull # TODO
	git pull
	popd > /dev/null
else
	git clone "git@github.com:dalemanthei/dotfiles.git" ".dotfiles"
fi

echo 'Linking files...'

ls -1d .dotfiles/files/* .dotfiles/files/.* | while read f; do
	[ "$f" == '.dotfiles/files/.' ] ||
	[ "$f" == '.dotfiles/files/..' ] ||
	[ "$f" == '.dotfiles/files/.git' ] ||
	[ -d "$f" ] || # don't link directories
	ln -vsf "$f" .
done

ln -vsf ~/.dotfiles/files/.git-templates .

popd > /dev/null
