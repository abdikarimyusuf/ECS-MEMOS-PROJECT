
# Stage 1: Build frontend
FROM node:20 AS frontend
WORKDIR /app/web
COPY web/package*.json ./
RUN npm install
COPY web/ .
RUN npm run release  # builds dist/

# Stage 2: Build backend
FROM golang:1.25 AS backend
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
# Copy frontend dist from previous stage
COPY --from=frontend /app/web/dist ./server/router/frontend/dist
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o memos ./cmd/memos

# Stage 3: Final image
FROM alpine:3.18
WORKDIR /app
COPY --from=backend /app/memos .
COPY --from=backend /app/server/router/frontend/dist ./server/router/frontend/dist
CMD ["./memos"]


