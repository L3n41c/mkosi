#!/bin/bash

set -ex

sudo add-apt-repository --yes ppa:jonathonf/python-3.6
sudo apt --yes update
sudo apt --yes install python3.6 debootstrap systemd-container squashfs-tools

testimg()
{
	img="$1"
	sudo python3.6 ./mkosi --default ./mkosi.files/mkosi."$img"
	test -f mkosi.output/"$img".raw
	rm mkosi.output/"$img".raw
}

# Only test ubuntu images for now, as semaphore is based on Ubuntu
for i in ./mkosi.files/mkosi.ubuntu*
do
	imgname="$(basename "$i" | cut -d. -f 2-)"
	testimg "$imgname"
done
