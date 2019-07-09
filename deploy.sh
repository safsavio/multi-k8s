docker build -t safsavio/multi-client:latest -t safsavio/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t safsavio/multi-server:latest -t safsavio/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t safsavio/multi-worker:latest -t safsavio/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push safsavio/multi-client:latest
docker push safsavio/multi-server:latest
docker push safsavio/multi-worker:latest

docker push safsavio/multi-client:$SHA
docker push safsavio/multi-server:$SHA
docker push safsavio/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=safsavio/multi-server:$SHA
kubectl set image deployments/client-deployment client=safsavio/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=safsavio/multi-worker:$SHA