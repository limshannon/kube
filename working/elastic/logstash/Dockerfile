ARG APP_IMAGE=registry.web.boeing.com/container/boeing-images-build/base/ubuntu20:latest
FROM ${APP_IMAGE}

ENV TZ=Asia/Seoul

ENV DEBIAN_FRONTEND=noninteractive NOTVISIBLE="in users profile"
ENV HOME=/root LANG=C.UTF-8 LC_ALL=C.UTF-8

ENV APT_OPTS="-o Acquire::AllowInsecureRepositories=true -o Acquire::AllowDowngradeToInsecureRepositories=true --allow-unauthenticated"
ENV PIP_OPTS="--upgrade --no-cache-dir"

ENV PYTHONPATH=.
ENV PYTHONWARNINGS="ignore:Unverified HTTPS request"
ENV PORT=8888 NB_PREFIX=/ NB_TOKEN='' NB_PASSWD=''
ENV HOME=/root

ENV VENV_PATH=/venv/bin WORKSPACE_PATH=/workspace
ENV PATH=${VENV_PATH}:$PATH

ARG SRES_BEMSID
ARG SRES_API_KEY
ARG SRES_URL=sres.web.boeing.com

ARG APT_CODE_NAME=focal
ARG APT_MIRROR=https://sres.web.boeing.com/artifactory/debian-remote
ARG PIP_MIRROR=https://${SRES_BEMSID}:${SRES_API_KEY}@sres.web.boeing.com/artifactory/api/pypi/pypi-remote/simple
ARG PIP_TRUST_HOST=sres.web.boeing.com

RUN echo "# Change APT Mirror: ${APT_MIRROR}" \
	&& { \
		echo "deb ${APT_MIRROR} ${APT_CODE_NAME} main restricted universe multiverse"; \
		echo "deb ${APT_MIRROR} ${APT_CODE_NAME}-updates main restricted universe multiverse"; \
		echo "deb ${APT_MIRROR} ${APT_CODE_NAME}-backports main restricted universe multiverse"; \
   } > /etc/apt/sources.list \
	&& { \
		echo "machine ${SRES_URL}"; \
		echo "login ${SRES_BEMSID}"; \
		echo "password ${SRES_API_KEY}"; \
   } > /etc/apt/auth.conf.d/sres.conf \
   && { \
      echo "Acquire::https {"; \
      echo "  Verify-Peer false;"; \
      echo "  Verify-Host false;"; \
      echo "};"; \
   } > /etc/apt/apt.conf.d/mirror.conf

RUN apt update -yq ${APT_OPTS} \
   && apt install -yq ${APT_OPTS} \
      bzip2 \
      ca-certificates \
      fonts-nanum \
      jq \
      python3 \
      python3-pip \
      python3-venv \
      tzdata \
      libpq-dev libpython3-dev \
      git \
	  procps findutils tar gzip curl locales \
   && echo && echo "# Clean Cache & Temp" \
   && apt autoremove -yq \
   && rm -rf /tmp/* /var/cache/* /var/lib/apt/lists/* /var/tmp/* \
   && locale-gen 'en_US.UTF-8' 

RUN echo "# pip 저장소 설정" \
   && pip3 config --user set global.trusted-host ${PIP_TRUST_HOST} \
   && pip3 config --user set global.index-url ${PIP_MIRROR}

RUN echo "# jupyter 설치" \
   && python3 -m venv --copies ${VENV_PATH} \
   && pip3 install ${PIP_OPTS} \
      pip install --upgrade pip\
      setuptools \
      wheel \
      cython \
   && pip3 install ${PIP_OPTS} \
      autopep8 \
      bash_kernel \
      jupyter \
      jupyter_contrib_nbextensions \
      jupyterlab \
      jupyterthemes \
      notebook \
      qgrid \
      sshkernel \
      pyxlsb \
   && pip3 install ${PIP_OPTS} \
      bs4 \
      html5lib \
      lxml \
   && pip3 install ${PIP_OPTS} \
      minio \
      tqdm \
      xlrd \
      xlsxwriter \
      openpyxl \
      memory_profiler  
 

RUN pip3 install ${PIP_OPTS} \
      numpy \
      pandas \
      seaborn \
      bokeh \
      dask[complete] \
      matplotlib \
      pyLDAvis \
	  jsonschema[format-nongpl]\
	  ipywidgets \
	  jupyterterminals


RUN pip3 install ${PIP_OPTS} sqlalchemy psycopg2

RUN echo && echo "# Install Jupyter Kernel" \
   && python3 -m sshkernel install \
   && python3 -m bash_kernel.install \
   \
   && echo && echo "# Set nbextension enable" \
   && jupyter contrib nbextension install --user \
   && jupyter nbextension install --py widgetsnbextension --user \
   && jupyter nbextensions_configurator enable --user \
#   && jupyter nbextension enable --py --sys-prefix qgrid \
   && jupyter nbextension enable --py --sys-prefix widgetsnbextension --user --py \
   && jupyter serverextension enable --py jupyterlab --sys-prefix

RUN mkdir -p ${WORKSPACE_PATH} \
   && chmod -R 777 ${VENV_PATH} ${WORKSPACE_PATH}

ENV HOME=${WORKSPACE_PATH}
WORKDIR ${WORKSPACE_PATH}

CMD ["bash", "-c", "\
jupyter lab \
   --no-browser \
   --allow-root \
   --ip=0.0.0.0 \
   --port=${PORT} \
   --notebook-dir=${WORKSPACE_PATH} \
   --ServerApp.token=${NB_TOKEN} \
   --ServerApp.base_url=${NB_PREFIX} \
   --ServerApp.password=${NB_PASSWD} \
   --ServerApp.allow_origin='*' \
   --ServerApp.iopub_data_rate_limit=10000000 \
"]

RUN echo $HOME
RUN cd $HOME

# Provide a non-root user to run the process. for logstash
RUN groupadd --gid 1000 logstash && \
    adduser --uid 1000 --gid 1000 \
       --home /usr/share/logstash --no-create-home \
      logstash

# Add Logstash itself.
RUN \
curl -Lo - https://artifacts.elastic.co/downloads/logstash/logstash-8.6.2-linux-$(arch).tar.gz | \
    tar zxf - -C /usr/share && \
    mv /usr/share/logstash-8.6.2 /usr/share/logstash && \
chown --recursive logstash:logstash /usr/share/logstash/ && \
    chown -R logstash:root /usr/share/logstash && \
    chmod -R g=u /usr/share/logstash && \
    mkdir /licenses/ && \
    mv /usr/share/logstash/NOTICE.TXT /licenses/NOTICE.TXT && \
    mv /usr/share/logstash/LICENSE.txt /licenses/LICENSE.txt && \
find /usr/share/logstash -type d -exec chmod g+s {} \; && \
ln -s /usr/share/logstash /opt/logstash

WORKDIR /usr/share/logstash
ENV ELASTIC_CONTAINER true
ENV PATH=/usr/share/logstash/bin:$PATH
 
USER 1000

EXPOSE 9600 5044

