FROM node:24.1.0-alpine
WORKDIR /app

# Copy package.json and install only production dependencies in one layer
COPY /apps/payment-gateways/dist/package*.json ./

# Install production dependencies
RUN npm i && \
    npm i mysql core-js

# Copy built application
COPY /apps/payment-gateways/dist/main.js ./

EXPOSE 3333
CMD ["node", "main.js"]