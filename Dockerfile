FROM python:3.7-alpine3.9
EXPOSE 8000
RUN apk add curl
WORKDIR /usrt/bin/
RUN curl -o ./consul.zip  -O -J -L https://releases.hashicorp.com/consul/1.6.2/consul_1.6.2_linux_amd64.zip 
RUN unzip ./consul.zip -d /usrt/bin/
WORKDIR /usr/src/app
COPY ./consul/requirements.txt . 
RUN pip install -qr requirements.txt
COPY flask-api/*.py ./
COPY flask-api/api/ ./api/
ADD ./consul/exec/ .
COPY ./consul/*.py ./
RUN chmod u+x entry-point.sh
RUN chmod u+x envconsul
ENTRYPOINT ["sh", "entry-point.sh"]
CMD ["python3", "run_app.py"]