all: clone-github # clone-gitlab

.DEFAULT_GOAL := all

.PHONY: clone-github
clone-github:
	cd github && ./cloneall.sh

.PHONY: clone-gitlab
clone-gitlab:
	cd gitlab && ./cloneall.sh group luciotbc
