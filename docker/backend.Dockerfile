FROM alpine:latest

ARG PB_VERSION=0.28.2

RUN apk add --no-cache \
	unzip \
	ca-certificates

# download and unzip PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/

COPY backend/pb_migrations /pb/pb_migrations
COPY backend/main.go /pb/main.go

COPY backend/init-pb.sh /pb/init-pb.sh
RUN chmod +x /pb/init-pb.sh

WORKDIR /pb
EXPOSE 8090

# start PocketBase
CMD ["/pb/init-pb.sh"]