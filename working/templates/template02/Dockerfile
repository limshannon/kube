FROM sres.web.boeing.com:5000/boeing-images/base/rhel7:7.6-202

LABEL maintainer=sumin.lim@boeing.com 

RUN mkdir /home/webserver \
 && chmod 755 /home/webserver \
 && chown 0:0 /home/webserver

COPY index.html /home/webserver/index.html

WORKDIR /home/webserver

EXPOSE 8000

CMD ["python", "-m", "SimpleHTTPServer", "8000"]

