FROM ubuntu:latest

RUN mkdir /app
WORKDIR /app

RUN apt-get update

RUN apt-get install -y curl git mysql-client
RUN curl -fsSL https://deb.nodesource.com/setup_15.x | bash -

RUN apt-get install -y nodejs

COPY config.ts .
COPY process.ts .
COPY rds.sql .
COPY table_migrate.sql .
COPY package.json .
COPY package-lock.json .
COPY tsconfig.json .
COPY runfile.sh .

RUN npm install -g ts-node
RUN npm install -g typescript

RUN npm install --save-dev @types/node
RUN npm install --save-dev mysql2
RUN npm install --save-dev mysql2-promise
RUN npm install --save-dev node-ipv4

CMD bash runfile.sh
