run-cli:
	./go-web-server/k8s.sh

run-k8s:
	cd go-web-server && kubectl apply -f go-web-server.yaml

run-server:
	cd go-web-server && minikube service goserver