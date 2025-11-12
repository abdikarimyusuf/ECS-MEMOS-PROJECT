# 🏗️ Stage 1 — Build the frontend
FROM node:20-alpine AS frontend
WORKDIR /app
COPY web ./web
# Ensure parent directory exists

RUN cd web && npm install && npm run release && ls -la dist

# 🧰 Stage 2 — Build the Go backend
FROM golang:1.25-alpine AS backend
WORKDIR /app
COPY . .
RUN go mod download
RUN  go build -o memos ./cmd/memos

# 🪶 Stage 3 — Final lightweight image
FROM alpine:3.19
WORKDIR /app

# Copy built Go binary and frontend files
COPY --from=backend /app/memos .
COPY --from=frontend /app/web/dist ./web/dist

EXPOSE 8081
ENTRYPOINT ["./memos"]


