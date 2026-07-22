# syntax=docker/dockerfile:1

FROM node:24-alpine

ENV NODE_ENV=production

WORKDIR /app

# A wildcard is used to ensure both package.json AND package-lock.json are copied to the docker image
COPY --chown=node:node package*.json ./

# Install only production dependencies, reproducibly from the lockfile
RUN npm ci --omit=dev && npm cache clean --force

# Copy the application source
COPY --chown=node:node index.js ./

# Run as the non-root built-in "node" user
USER node

# Inform docker which port we use
EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://127.0.0.1:8080', (res) => process.exit(res.statusCode === 200 ? 0 : 1)).on('error', () => process.exit(1))"

CMD ["npm", "start"]
