default:: full
dockerexe=docker
name=sample
port=9009

full:kill build live run

#region Commands
build:
	@$(info Build the Docker file)
	@$(dockerexe) build -t $(name) --no-cache .
	@-yes|rm -r .ipynb_checkpoints/

live:
	@$(info Running the Docker file)
	#This exposes port 9000 from the host machine to port 8888 within the docker machine
	@$(dockerexe) run -p $(port):8888 -ti $(name) /bin/bash

kill:
	@$(info Killing all the Dockerfiles)
	@-$(dockerexe) kill $(name)
	@-$(dockerexe) rm -f $(name)
	@-$(dockerexe) rmi -f $(name)

run:
	@$(info Running the juypter notebook)
	@jupyter lab --ip=127.0.0.1 --port=$(port)
#endregion
