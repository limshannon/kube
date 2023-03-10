# 01 Deploy a simple web server running in a container on a Kubernetes cluster

### Create a Kubernetes deployment
Create the Deployment resource
```
oc create deployment web-server --image=sres.web.boeing.com:5000/boeing-image-examples/base-images/rhel-atomic-test:175718
oc get deployments
oc get replicasets
oc get pods
```

### Create a Kubernetes service. Expose server port
```
oc expose deployment web-server --port=8000
oc get services
```
#### Set dns, Create an OpenShift route 
```
oc expose service web-server --hostname=lemonade-web-server.apps.kcs4-prod-ewd.k8s.boeing.com
oc get routes
curl -s http://lemonade-web-server.apps.kcs4-prod-ewd.k8s.boeing.com
```

## Clean up
```
oc delete route web-server
oc delete service web-server
oc delete deployment web-server

```


# 02 Declarative management - Kubernetes native approach

  - web-server.yaml

### 
```
oc create -f web-server.yaml
oc get deployments
oc get service
oc get route
curl -s http://paal-web-server.apps.kcs4-td-ewd.k8s.boeing.com
```
### Clean up
```
oc delete -f web-server.yaml
```

# 03 Declarative management - OpenShift approach
 - web-server-template-openshift.yaml
 
## Deployment
```
oc process -f web-server-template-openshift.yaml -p HOSTNAME=paal-web-server -p KCS_ENVIRONMENT=apps.kcs4-td-ewd.k8s.boeing.com -p IMAGE_VERSION=175718 | oc create -f - 
```
```
oc process -f web-server-template-openshift2.yaml \
-p HOSTNAME=lemonade2-web-server -p KCS_ENVIRONMENT=apps.kcs4-td-ewd.k8s.boeing.com\
 | oc create -f -
```

## Cleaning up
```
oc process -f web-server-template-openshift.yaml -p HOSTNAME=paal-web-server -p KCS_ENVIRONMENT=apps.kcs4-td-ewd.k8s.boeing.com -p IMAGE_VERSION=175718 | oc delete -f -
 ```
