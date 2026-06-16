# Use an official Node.js runtime as a parent image
FROM node:20-slim

# Install pnpm globally
RUN npm install -g pnpm

# Set the working directory in the container
WORKDIR /app

# Copy package files, lockfile, AND the workspace catalog configuration
COPY package.json pnpm-lock.yaml* pnpm-workspace.yaml* ./
COPY patches ./patches

# Install dependencies
RUN pnpm install

# Copy the rest of your application code
COPY . .

# Expose the port the proxy listens on
EXPOSE 8080

# Start the application
CMD ["pnpm", "start"]
