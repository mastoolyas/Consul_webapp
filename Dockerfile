FROM python:3.7-alpine3.9
WORKDIR /usr/src/app
EXPOSE 8000
RUN apk add curl
#copy requirments for both apps
COPY ./consul/requirements.txt . 
RUN pip install -qr requirements.txt
COPY consul /bin/exec/
ADD ./consul/exec/entry-point.sh /bin/
COPY ./consul/exec/envconsul /bin/
#entry point change with books/name insted of secret/API_USER
COPY flask-api/ ./
#RUN python run_app.py move to entry-point
RUN chmod u+x /bin/entry-point.sh
CMD ["/bin/entry-point.sh"]
