docker build -t lukaromih/multi-client:latest -t lukaromih/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lukaromih/multi-server:latest -t lukaromih/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lukaromih/multi-worker:latest -t lukaromih/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lukaromih/multi-client:latest
docker push lukaromih/multi-server:latest
docker push lukaromih/multi-worker:latest

docker push lukaromih/multi-client:$SHA
docker push lukaromih/multi-server:$SHA
docker push lukaromih/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lukaromih/multi-client:$SHA
kubectl set image deployments/server-deployment server=lukaromih/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lukaromih/multi-worker:$SHA