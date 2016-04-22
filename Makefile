.PHONY: docs deploy-docs

docs:
	# first, gem install jazzy
	jazzy \
		--clean \
		-x -target,HIPWebApp \
		--min-acl=public \
		--author Hipmunk \
		--author_url https://hipmunk.com \
		--github_url https://github.com/Hipmunk/HIPWebApp \
		--github-file-prefix https://github.com/Hipmunk/HIPWebApp/tree/master \
		--module HIPWebApp \
		--root-url https://hipmunk.github.com/HIPWebApp 

deploy-docs: docs
	# first, pip install ghp-import
	ghp-import docs \
		-n -p \
		-m "Update docs" \
		-r origin \
		-b gh-pages
