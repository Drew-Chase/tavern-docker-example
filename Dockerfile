FROM rust:1.90-alpine AS builder
WORKDIR /build
COPY . .
RUN apk update

# Install Dependencies
RUN apk add --no-cache nodejs npm musl-dev
RUN npm i vite pnpm -g

# Install project dependencies (force clean install without prompts)
RUN pnpm i --no-frozen-lockfile --force
# Build the project
# This will build both the frontend and the backend
RUN pnpm run "build:frontend"
RUN cargo build --release
RUN strip target/release/tavern_docker_example

FROM alpine:latest
RUN mkdir -p /app
COPY --from=builder /build/target/release/tavern_docker_example /app/tavern_docker_example
RUN chmod +x /app/tavern_docker_example
WORKDIR /app
EXPOSE 3698
ENTRYPOINT ["/app/tavern_docker_example"]