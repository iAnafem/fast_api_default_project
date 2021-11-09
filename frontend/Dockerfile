# Dockerfile for dev
FROM node:latest

EXPOSE 3000

RUN mkdir /frontend

COPY ./ ./frontend/

WORKDIR /frontend

RUN npm install --no-progress --ignore-optional

CMD npm start
