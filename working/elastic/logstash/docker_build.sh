if ! [ -d ./base/certs ]; then
    ./downloadBoeingCerts.sh > download-certs.log;
fi

docker login sres.web.boeing.com:5000 -u $SRES_USERNAME -p $SRES_API_KEY
docker login registry.web.boeing.com -u $GITLAB_PERSONAL_ACCESS_TOKEN -p $GITLAB_PERSONAL_ACCESS_TOKEN

