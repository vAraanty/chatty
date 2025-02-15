.PHONY: rails console test

# Default shell command prefix
DOCKER_SH := docker compose exec web sh
DOCKER_RAILS := docker compose exec web rails
DOCKER_ATTACH := docker compose attach web

# Commands
rails:
	${DOCKER_RAILS} $(filter-out $@,$(MAKECMDGOALS))

c:
	${DOCKER_RAILS} c

test:
	${DOCKER_RAILS} test

sh:
	${DOCKER_SH}

attach:
	${DOCKER_ATTACH}

# Forward all other targets
%:
	@: 
