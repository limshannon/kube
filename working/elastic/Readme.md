===== 1. extract & reset password  ======

kubectl exec -it elasticsearch-node-0 -n elk -- bin/elasticsearch-setup-passwords auto -b
kubectl exec -it elasticsearch-node-0 -n bketc-elk -- bin/elasticsearch-setup-passwords auto -b


===== 2. Register es secret to kube ====== 
kubectl create secret generic elasticsearch-pw-elastic -n elk --from-literal password=aDfTrERv7VYDWdD7kqM1
kubectl create secret generic elasticsearch-pw-kibana -n elk --from-literal password=sD0yrTE6j63RdPg0VqY_

kubectl create secret generic elasticsearch-pw-elastic -n bketc-elk --from-literal password=3A8FB328Nf3SwfEL2H6w
kubectl create secret generic elasticsearch-pw-kibana -n bketc-elk --from-literal password=W4nwkqFWyDAu14yLgfzS

  
sudo docker exec -it es01 /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana --url "https://127.0.0.1:9200"
kubectl exec -it elasticsearch-node-0 -n elk /usr/share/elasticsearch/bin/elasticsearch-create-enrollment-token -s kibana --url "https://elasticsearch.apps.kcs4-prod-ewd.k8s.boeing.com/"


>>>bketc-elk
Changed password for user apm_system
PASSWORD apm_system = kZSqgjKJDXifMlRAkvcN

Changed password for user kibana_system
PASSWORD kibana_system = W4nwkqFWyDAu14yLgfzS

Changed password for user kibana
PASSWORD kibana = W4nwkqFWyDAu14yLgfzS

Changed password for user logstash_system
PASSWORD logstash_system = E2N5M9F2TeinFLWidGXX

Changed password for user beats_system
PASSWORD beats_system = QFjSDNh0XOxNa97FTzVv

Changed password for user remote_monitoring_user
PASSWORD remote_monitoring_user = iVmJwdu6Xe6HLUZS1EXS

Changed password for user elastic
PASSWORD elastic = 3A8FB328Nf3SwfEL2H6w



>>>
Changed password for user apm_system
PASSWORD apm_system = Tmjj0RctgpoFsFOBDnuh

Changed password for user kibana_system
PASSWORD kibana_system = fic7hRHEEYamJvQn5kCj

Changed password for user kibana
PASSWORD kibana = fic7hRHEEYamJvQn5kCj

Changed password for user logstash_system
PASSWORD logstash_system = OoGBwiqM6aziWSbicpyM

Changed password for user beats_system
PASSWORD beats_system = uDvqrPGjB9rJtU7VFZSC

Changed password for user remote_monitoring_user
PASSWORD remote_monitoring_user = p15CmQ68mPheYHvUYsX6

Changed password for user elastic
PASSWORD elastic = i42E6eAQZyMwYwfFabAl




output >>> secret/elasticsearch-pw-elastic created

===== 3. check es server


curl -u USER:PASSWORD https://ELASTICSEARCH_URL/my_index/_doc -XPOST -H 'Content-Type: application/json' -d '{
    "title": "One", "tags": ["ruby"]
}'
curl -u elastic:m2y6bDHis0T3AooBXljP https://192.168.234.94:9200  -XPOST -H 'Content-Type: application/json' 
curl -u elastic:aDfTrERv7VYDWdD7kqM1 https://192.168.207.113:9200 -XPOST -H 'Content-Type: application/json' 

curl -u elastic:m2y6bDHis0T3AooBXljP http://elasticsearch.apps.kcs4-prod-ewd.k8s.boeing.com/
curl -u elastic:m2y6bDHis0T3AooBXljP http://192.168.234.94:9200


kubectl exec <pod-name> -- ls /  
kubectl exec -it elasticsearch-node-0 -- ls / 


https://kubernetes.io/ko/docs/tutorials/hello-minikube/

=====
https://github.com/Jpub/15_DandK/blob/master/step07/init-container/init-sample.yml


=======4.\

oc get service

oc expose service elasticsearch-nodeport --hostname=elasticsearch.apps.kcs4-prod-ewd.k8s.boeing.com
oc expose service kibana --hostname=kibana.apps.kcs4-prod-ewd.k8s.boeing.com

oc expose service elasticsearch-nodeport --hostname=bketc-elasticsearch.apps.kcs4-prod-ewd.k8s.boeing.com
oc expose service kibana --hostname=bketc-kibana.apps.kcs4-prod-ewd.k8s.boeing.com

====== 5. 

sh-5.0$ bin/elasticsearch-create-enrollment-token -s kibana --url "https://172.0.0.3:9200"

ERROR: [xpack.security.enrollment.enabled] must be set to `true` to create an enrollment token

Unable to retrieve version information from Elasticsearch nodes. security_exception: 
[security_exception] Reason: missing authentication credentials for REST request [/_nodes?filter_path=nodes.*.version%2Cnodes.*.http.publish_address%2Cnodes.*.ip]
<-- 이게 된거임

Readiness probe failed: HTTP probe failed with statuscode: 503

https://www.ibm.com/docs/en/sle/10.2.0?topic=elasticsearch-enabling-https


