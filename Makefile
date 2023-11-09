build-image:
	docker build -t go-web-server_dev .

run-container:
	docker run -it --rm -p 8010:8010 -v .:/go/src/go-web-server go-web-server_dev