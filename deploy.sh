docker build -t ethomatos/multi-client:latest -t ethomatos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ethomatos/multi-server:latest -t ethomatos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ethomatos/multi-worker:latest -t ethomatos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ethomatos/multi-client:latest
docker push ethomatos/multi-server:latest
docker push ethomatos/multi-worker:latest

docker push ethomatos/multi-client:$SHA
docker push ethomatos/multi-server:$SHA
docker push ethomatos/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=ethomatos/multi-server:$SHA
kubectl set image deployments/client-deployment client=ethomatos/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ethomatos/multi-worker:$SHA
