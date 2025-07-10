# Use a base image with Node.js installed
FROM node:14-alpine

# Set the working directory in the container
WORKDIR /react-hooks-frontend/


# Install MySQL client
#RUN apt-get update && apk add --no-cache mysql-client
RUN apk add --no-cache mysql-client


# Copy package.json
COPY package*.json ./

## Optional: Set environment variables (these can be overridden at runtime)

ARG REACT_APP_BACKEND_URL
ENV REACT_APP_BACKEND_URL=${REACT_APP_BACKEND_URL}


# Install dependencies
RUN npm install

# Copy the source code
COPY . .

# Expose port 3000
EXPOSE 3000

# Command to run
ENTRYPOINT ["npm","start"]

