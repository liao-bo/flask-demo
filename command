curl -H "Content-Type: application/json" -X POST  --data '{"hostname":"sh-testserver"}' http://127.0.0.1:5000/app/api/v1.0/timezone

kubectl rolling-update rc-flask-demo -f demo-replicat.yaml

kubectl scale deployment  deploy-flask-demo --replicas=2

kubectl rollout history deploy-flask-demo
kubectl rollout undo deployment deploy-flask-demo --to-revision=4
kubectl rollout pause deployment
kubectl rollout resume deployment


docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-ingress-controller:0.8.3
docker pull registry.cn-hangzhou.aliyuncs.com/flask-demo/flask-demo:1.0
                                                                    2.0
                                                                    git-update
docker pull registry.cn-hangzhou.aliyuncs.com/architect/pod-infrastructure:latest



kubectl label nodes <node-name> <label-key>=<label-value>

apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: tomcat-deploy
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: tomcat-app
    spec:
      nodeSelector:
        cloudnil.com/role: dev #指定调度节点为带有label标记为：cloudnil.com/role=dev的node节点
      containers:
      - name: tomcat
        image: tomcat:8.0
        ports:
        - containerPort: 8080


curl -H "host: helloworld.mmm" http://10.0.2.101/demo2