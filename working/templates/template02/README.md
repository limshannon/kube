```
docker build -t sres.web.boeing.com:5000/3472487/kcs-tutorial-2:0.1 .
```

```
docker run -d -p 8000:8000 --name mywebserver --rm sres.web.boeing.com:5000/3472487/kcs-tutorial-2:0.1
```
check the localhost:8000 on the browser or curl

```
docker push sres.web.boeing.com:5000/3472487/kcs-tutorial-2:0.1
```

