# password setup
``` 
sh-5.0$ ./elasticsearch-setup-passwords -v auto
******************************************************************************
Note: The 'elasticsearch-setup-passwords' tool has been deprecated. This       command will be removed in a future release.
******************************************************************************

Initiating the setup of passwords for reserved users elastic,apm_system,kibana,kibana_system,logstash_system,beats_system,remote_monitoring_user.
The passwords will be randomly generated and printed to the console.
Please confirm that you would like to continue [y/N]y


Changed password for user apm_system
PASSWORD apm_system = 79sq28fAuOJEtRmy1jre

Changed password for user kibana_system
PASSWORD kibana_system = FHLg1EqmZ8MzUKpv7ePg

Changed password for user kibana
PASSWORD kibana = FHLg1EqmZ8MzUKpv7ePg

Changed password for user logstash_system
PASSWORD logstash_system = MXnLKhAnp5xxER8HVpgx

Changed password for user beats_system
PASSWORD beats_system = Qy9YjDNSHo4aCKp3HHZx

Changed password for user remote_monitoring_user
PASSWORD remote_monitoring_user = I7PWJGD8QPeg4Ish6oUR

Changed password for user elastic
PASSWORD elastic = ukLyRceDllX1xdTPQ5xu

```




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



>>> elk (2023-03-21)
C:\Users\fv631f>kubectl exec -it elasticsearch-node-0 -n elk -- bin/elasticsearch-setup-passwords auto -b
Changed password for user apm_system
PASSWORD apm_system = FzQpW0XepFeKrHh5OLD4

Changed password for user kibana_system
PASSWORD kibana_system = g02F7117ayQzUnvEcQpU

Changed password for user kibana
PASSWORD kibana = g02F7117ayQzUnvEcQpU

Changed password for user logstash_system
PASSWORD logstash_system = XDD3jOAZeF7DsKJnQgC2

Changed password for user beats_system
PASSWORD beats_system = 3Hsc7Ogba47gLyTQMQUM

Changed password for user remote_monitoring_user
PASSWORD remote_monitoring_user = xradKaqmvDHY2j7QR2s4

Changed password for user elastic
PASSWORD elastic = rdGJ85KVq5s43vG9lxOA



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


