FROM python:2

RUN pip install paho-mqtt broadlink

WORKDIR /app
RUN wget https://github.com/UlrichFrank/broadlink-mqtt/archive/master.tar.gz \
  && tar -xvzf master.tar.gz \
  && mv broadlink-mqtt-master/* ./ \
  && rm -rf master.tar.gz broadlink-mqtt-master

ENV MQTT_SERVER=localhost
ENV MQTT_PORT=1883
ENV MQTT_USER=mqtt_user
ENV MQTT_PASS=password
ENV MQTT_TOPIC_PREFIX=broadlink/
ENV DEVICE_HOST=192.168.1.50
ENV DEVICE_MAC=01:23:45:67:ab:00

COPY mqtt.conf.template /app

RUN mkdir /app/config
RUN mkdir /app/data
RUN mkdir /app/data/commands
RUN mkdir /app/data/log

VOLUME [ "./config/broadlink-mqtt-bridge", "/app/config" ]
VOLUME [ "./data/broadlink-mqtt-bridge", "/app/data" ]

ENTRYPOINT ["python", "./mqtt.py"]
