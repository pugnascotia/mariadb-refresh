IMAGE = pugnascotia/mariadb-refresh

build:
	test -e mantra || (curl -o mantra -sL https://github.com/pugnascotia/mantra/releases/download/0.0.1/mantra && chmod +x mantra)
	docker build -t $(IMAGE) .

release: build
	docker push $(IMAGE)

all: build

clean:
	$(RM) mantra
	docker rmi $(IMAGE)
