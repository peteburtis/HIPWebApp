.PHONY: docs deploy-docs

# compile the docs using jazzy
docs:
	# prereq: gem install jazzy
	jazzy \
		--clean \
		-x -target,HIPWebApp \
		--min-acl=public \
		--author Hipmunk \
		--author_url https://hipmunk.com \
		--github_url https://github.com/Hipmunk/HIPWebApp \
		--github-file-prefix https://github.com/Hipmunk/HIPWebApp/tree/master \
		--module HIPWebApp \
		--module-version 1.0 \
		--skip-undocumented \
		--root-url https://hipmunk.github.com/HIPWebApp 
	cp -r doc_assets docs/

# Uploads docs to your origin/gh-pages branch
deploy-docs: docs
	# prereq: pip install ghp-import
	ghp-import docs \
		-n -p \
		-m "Update docs" \
		-r origin \
		-b gh-pages
