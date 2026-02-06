# Use Node 22 Alpine image
FROM node:22-alpine

# Install bash and git (needed for some npm packages) and build tools
RUN apk add --no-cache bash git python3 make g++ libc6-compat

# Set working directory
WORKDIR /app

# Copy package files first for caching
COPY package*.json ./

# Optional: Update npm to latest
RUN npm install -g npm@11.6.4

# Set npm registry and retry options (more reliable installs)
RUN npm config set registry https://registry.npmjs.org/ \
    && npm install --fetch-retries=5 --fetch-retry-mintimeout=2000

# Copy Prisma schema separately to take advantage of Docker layer caching
COPY prisma ./prisma/

# Copy the rest of the project
COPY . .

# Create uploads folder
RUN mkdir -p uploads

# Build the project
RUN npm run build

# Expose application port
EXPOSE 3000

# Run migrations before starting the app
CMD ["npm", "run", "start:migrate:prod"]
