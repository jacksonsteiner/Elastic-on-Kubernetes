kubectl create -f ./crds.yaml
kubectl apply -f ./operator.yaml
kubectl apply -f ./elasticsearch.yaml
kubectl apply -f ./kibana.yaml
kubectl apply -f ./apm-server.yaml