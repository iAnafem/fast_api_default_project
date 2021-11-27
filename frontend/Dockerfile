# Dockerfile for dev
FROM node:latest

RUN mkdir /frontend

COPY ./ ./frontend/

WORKDIR /frontend

RUN npm install --no-progress --ignore-optional

ENV NODE_ENV=development

EXPOSE 3000

