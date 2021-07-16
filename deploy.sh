docker build -t martinstaebler/multi-client:latest -t martinstaebler/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t martinstaebler/multi-server:latest -t martinstaebler/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t martinstaebler/multi-worker:latest -t martinstaebler/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push martinstaebler/multi-client:latest
docker push martinstaebler/multi-server:latest
docker push martinstaebler/multi-worker:latest

docker push martinstaebler/multi-client:$SHA
docker push martinstaebler/multi-server:$SHA
docker push martinstaebler/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=martinstaebler/multi-client:$SHA
kubectl set image deployments/server-deployment server=martinstaebler/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=martinstaebler/multi-worker:$SHA