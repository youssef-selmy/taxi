FROM node:24.1.0-alpine AS builder
WORKDIR /workspace

COPY package*.json ./
COPY nx.json ./
COPY tsconfig.base.json tsconfig.json ./
COPY apps ./apps
COPY libs ./libs

RUN npm ci
RUN npx nx build payment-gateways --configuration=production

FROM node:24.1.0-alpine
WORKDIR /app

COPY --from=builder /workspace/apps/payment-gateways/dist/ ./
RUN npm install --omit=dev

EXPOSE 3333
CMD ["node", "main.js"]
