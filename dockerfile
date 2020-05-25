FROM mhart/alpine-node:latest

RUN mkdir /app

WORKDIR /app

COPY / .

RUN npm install

HEALTHCHECK --interval=5m --timeout=3s \
CMD curl -f http://hostname:27017 || exit 1

CMD npm start

