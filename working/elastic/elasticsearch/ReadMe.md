```
C:\Users\fv631f> kubectl get pods -n elk
NAME                   READY   STATUS    RESTARTS   AGE
elasticsearch-node-0   1/1     Running   0          82m

C:\Users\fv631f>oc get service
NAME                     TYPE        CLUSTER-IP        EXTERNAL-IP   PORT(S)             AGE
elasticsearch            ClusterIP   192.168.188.    <none>        9200/TCP,9300/TCP   80m
elasticsearch-nodeport   NodePort    192.168.207.    <none>        9200:30920/TCP      80m

C:\Users\fv631f>oc expose service elasticsearch-nodeport --hostname=elasticsearch.apps.kcs4-prod-ewd.k8s.boeing.com
route.route.openshift.io/elasticsearch-nodeport exposed

```