# ---------- Stage 1: Build ----------
FROM node:20-alpine AS builder

WORKDIR /app

# Copy dependency files first (better caching)
COPY package*.json ./

# Install all dependencies (including dev)
RUN npm install

# Copy full source code
COPY . .


# ---------- Stage 2: Production ----------
FROM node:20-alpine

WORKDIR /app

# Copy only required files from builder
COPY --from=builder /app .

# Remove dev dependencies
RUN npm prune --omit=dev

# Set environment
ENV NODE_ENV=production

# Expose port
EXPOSE 3000

# Start app
CMD ["node", "app.js"]
