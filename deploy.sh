docker build -t leandrosoares/multi-client:latest -t leandrosoares/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t leandrosoares/multi-server:latest -t leandrosoares/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t leandrosoares/multi-worker:latest -t leandrosoares/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push leandrosoares/multi-client:latest
docker push leandrosoares/multi-server:latest
docker push leandrosoares/multi-worker:latest

docker push leandrosoares/multi-client:$SHA
docker push leandrosoares/multi-server:$SHA
docker push leandrosoares/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=leandrosoares/multi-server:$SHA
kubectl set image deployments/client-deployment server=leandrosoares/multi-client:$SHA
kubectl set image deployments/worker-deployment server=leandrosoares/multi-worker:$SHA