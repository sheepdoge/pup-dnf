build:
	docker build -t sheepdoge/pup-dnf .

test: build
	docker run sheepdoge/pup-dnf /bin/bash -c "./test.sh"

interactive: build
	docker run -it sheepdoge/pup-dnf /bin/bash
