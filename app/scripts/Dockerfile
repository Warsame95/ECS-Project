
FROM node:20 AS frontend

WORKDIR /app/web

RUN npm install -g pnpm

COPY web/package.json web/pnpm-lock.yaml ./

RUN pnpm install --frozen-lockfile

COPY web/ .

RUN pnpm release   # outputs to ../server/router/frontend/dist


FROM golang:1.25 AS backend

WORKDIR /app

COPY go.mod go.sum .

RUN go mod download

COPY . .
COPY --from=frontend /app/server/router/frontend/dist ./server/router/frontend/dist


RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main ./bin/memos/main.go

FROM alpine:3.18

WORKDIR /app

COPY --from=backend /app/main .

COPY scripts/entrypoint.sh .


EXPOSE 8081

RUN mkdir -p /var/opt/memos
VOLUME /var/opt/memos


ENTRYPOINT ["./entrypoint.sh","./main"]

