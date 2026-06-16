# Use an official Node.js runtime as a parent image
FROM node:20-slim

# Install pnpm globally
RUN npm install -g pnpm

# Set the working directory in the container
WORKDIR /app

# Copy package files, lockfile, AND the patches directory
COPY package.json pnpm-lock.yaml* ./
COPY patches ./patches

# Install dependencies (now it will find the htmlparser patch file!)
RUN pnpm install

# Copy the rest of your application code
COPY . .

# Expose the port the proxy listens on
EXPOSE 8080

# Start the application
CMD ["pnpm", "start"]
