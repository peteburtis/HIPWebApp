.PHONY: docs

docs:
	# first, gem install jazzy
	jazzy -x -target,HIPWebApp --min-acl=public
