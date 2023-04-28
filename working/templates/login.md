# Login to Docker Resporitory SRES
```
C:\Users\fv631f\ooc>docker login sres.web.boeing.com:5000 --username 3472487
```


```
cat .\password.txt | docker login sres.web.boeing.com:5000 --username 3472487 --password-stdin
Login Succeeded
```


```
curl.exe -LO https://dl.k8s.io/v1.26.0/bin/windows/amd64/kubectl.exe.sha256
```
https://sres.web.boeing.com/ui/#/artifacts/browse/tree/General/docker-releases/boeing-images

# Add secret to KCS for each project

* DOCKER_REGISTRY_SERVER
* DOCKER_USER :BEMSID
* DOCKER_PASSWORD: use the SRES API KEY as a docker-password
* DOCKER_EMAIL 

```
oc create secret docker-registry sres-artifactory --docker-server=sres.web.boeing.com:5000 --docker-username=3472487 --docker-password=*** --docker-email=sumin.lim@boeing.com
oc secrets link default sres-artifactory --for=pull
```
