# Makefile for The Editor.
#
# @author Benjamin starostka Jakobsen

editor = starostka/editor
editor-dev = starostka/editor:dev

all-build = build-editor
all-push = push-editor
all-clean = clean-editor

all: $(all-build) $(all-push) $(all-clean)

login:
	docker login

build-editor:
	echo "--- Building $(editor) image ---"
	cd editor && docker build -t $(editor) .

push-editor: login
	echo "--- Pushing $(editor) image ---"
	docker push $(editor)

clean-editor:
	echo "--- Removing $(editor) image ---"
	docker image rm -f $(editor)