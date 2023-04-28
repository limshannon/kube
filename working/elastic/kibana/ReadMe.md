1. password update on configmap file
2. create secret key 
  * elasticsearch-pw-elastic
  * elasticsearch-pw-kibana, key:password, value:
  * sres-artifactory

3. expose service
```
oc expose service kibana --hostname=kibana.apps.kcs4-prod-ewd.k8s.boeing.com
```
