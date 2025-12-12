FROM rust:1.90-alpine AS builder
WORKDIR /build
COPY . .
RUN apk update
RUN apk add --no-cache musl-dev

# Install NPM Dependencies
RUN apk add --no-cache nodejs npm
RUN npm i vite pnpm -g

# Install project dependencies (force clean install without prompts)
RUN pnpm i --no-frozen-lockfile --force
# Build the project
# This will build both the frontend and the backend
RUN npm run "build:frontend"
RUN cargo build --release
RUN strip target/release/tavern_docker_example

FROM alpine:latest
RUN mkdir -p /app
COPY --from=builder /build/target/release/tavern_docker_example /app/tavern_docker_example
RUN chmod +x /app/tavern_docker_example
WORKDIR /app
EXPOSE 3698
ENTRYPOINT ["/app/tavern_docker_example"]