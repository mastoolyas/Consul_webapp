FROM python:3.7-alpine3.9
WORKDIR /usr/src/app
EXPOSE 8000
RUN apk add curl
#copy requirments for both apps
COPY ./consul/requirements.txt . 
RUN pip install -qr requirements.txt
#WORKDIR /usr/src/bin/exec
COPY consul ./
#WORKDIR /usr/src/bin
ADD ./consul/exec/entry-point.sh ./
COPY ./consul/exec/envconsul ./
#WORKDIR /usr/src/app
COPY flask-api/*.py ./
COPY flask-api/api/ ./api/
#RUN python run_app.py move to entry-point
#entry point change with books/name insted of secret/API_USER
RUN chmod u+x ./entry-point.sh
CMD ["./entry-point.sh"]