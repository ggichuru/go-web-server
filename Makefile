run-cli:
	./k8s.sh

run-k8s:
	kubectl apply -f go-web-server.yaml

run-server:
	minikube service goserver