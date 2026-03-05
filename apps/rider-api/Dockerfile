FROM node:24.1.0-alpine
WORKDIR /app

COPY package*.json ./
COPY nx.json ./
COPY tsconfig.base.json tsconfig.json ./
COPY apps ./apps
COPY libs ./libs

RUN npm ci

EXPOSE 3000
CMD ["node", "-r", "ts-node/register/transpile-only", "-r", "tsconfig-paths/register", "apps/rider-api/src/main.ts"]
