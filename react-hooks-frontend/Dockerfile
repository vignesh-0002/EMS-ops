# Use a base image with Node.js installed
FROM node:14-alpine

# Set the working directory in the container
WORKDIR /react-hooks-frontend/

# Copy package.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the source code
COPY . .

# Expose port 3000
EXPOSE 3000

# Command to run
ENTRYPOINT ["npm","start"]

