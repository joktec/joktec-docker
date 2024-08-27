# Use a base Node.js image
FROM node:16-alpine

# Set an environment variable
ENV NPM_TOKEN=NO_AUTH

# Install package and yarn
RUN apk add build-base && \
    apk add --no-cache python3 && \
    npm install -g yarn --force && \
    yarn config set registry https://registry.npmjs.org && \
    echo "//registry.npmjs.org/:_authToken=$$NPM_TOKEN" > ~/.npmrc && \
    echo "legacy-peer-deps=true" >> ~/.npmrc

# Set the working directory inside the container
WORKDIR /app

# Copy the rest of your application files
COPY bin/run-service.sh ./run-service.sh

# Grant permission for run-service.sh
RUN chmod +x run-service.sh

# Expose Ports
EXPOSE 9010
EXPOSE 8010
