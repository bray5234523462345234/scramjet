# Use an official Node.js runtime as a parent image
FROM node:20-slim

# Install pnpm globally
RUN npm install -g pnpm

# Set the working directory in the container
WORKDIR /app

# Copy package files, lockfile, and the workspace catalog configuration
COPY package.json pnpm-lock.yaml* pnpm-workspace.yaml* ./
COPY patches ./patches

# Install dependencies
RUN pnpm install

# Copy the rest of your application code
COPY . .

# Build the production bundle (compiles files and resolves the extensions)
RUN pnpm run build

# Expose the port the proxy listens on
EXPOSE 8080

# Environment variable to make sure it binds to all network interfaces
ENV HOST=0.0.0.0
ENV PORT=8080

# Start the built production app
CMD ["pnpm", "run", "start"]
