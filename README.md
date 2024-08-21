**Instructions on how to build and push the docker image to a container registry:**

Build the Docker image:
docker build -t flask-mongodb-app .

Tag the Docker image:
docker tag flask-mongodb-app ramangupta21/flask-mongodb-app

Push the Docker Image to Docker Hub:
docker push ramangupta21/flask-mongodb-app

**README with Detailed Steps to Deploy the Flask Application and MongoDB on a Minikube Kubernetes Cluster:**

Prerequisites:
               Minikube installed
               Kubectl installed
               Docker installed

Steps:

   minikube start
   kubectl apply -f flask-deployment.yaml
   kubectl apply -f mongodb-statefulset.yaml
   kubectl apply -f flask-hpa.yaml
   
Access the Flask Application:
                             minikube service flask-service
                             
**Explanation of DNS Resolution Within the Kubernetes Cluster:**

DNS resolution within Kubernetes is managed by the kube-dns or CoreDNS service. This service provides DNS for all services within the cluster, allowing pods to communicate with each other using service names. When a pod tries to connect to another service, the DNS service resolves the service name to the appropriate cluster IP.
For example, the Flask application can connect to MongoDB using the service name mongodb-service, which resolves to the MongoDB pod's IP address.

**Explanation of Resource Requests and Limits in Kubernetes:**

Resource requests and limits in Kubernetes ensure that pods have sufficient resources and do not consume more than their fair share.
Requests: Minimum amount of resources required by a container.
Limits: Maximum amount of resources a container is allowed to consume.
By setting requests and limits, we ensure that the Kubernetes scheduler can make informed decisions about pod placement, and that the cluster remains stable and performs well.

**Design Choices:**

MongoDB StatefulSet: Ensures stable network identity and persistent storage.
Horizontal Pod Autoscaler: Ensures the application scales based on CPU utilization, maintaining performance under varying loads.
Resource Requests and Limits: Ensures efficient resource utilization and stability of the cluster.

**Testing Scenarios:**

Autoscaling Testing:
Simulate high CPU usage to test autoscaling:
                                            kubectl run -i --tty load-generator --image=busybox /bin/sh
                                            while true; do wget -q -O- http://flask-service:5000/; done
Database Interactions:
Use curl to send POST and GET requests:
                                       curl -X POST -H "Content-Type: application/json" -d "{\"sampleKey\":\"sampleValue\"}" http://localhost:30001/data curl http://localhost:30001/data
**Results:**

i) Autoscaling: The number of Flask pods increased when CPU utilization exceeded 70%.
ii) Database: Data was successfully inserted and retrieved from MongoDB.
