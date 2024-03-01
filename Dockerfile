FROM node:18.17-bullseye-slim

WORKDIR /webelight
COPY . .
RUN npm install
RUN npm run 
USER node


CMD [ "node" , "index.js" ]