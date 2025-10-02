FROM alpine

# Install test dependencies
RUN apk add --no-cache bash ruby bats git npm python3
RUN gem install bashcov
RUN npm install -g https://github.com/ztombol/bats-support
RUN npm install -g https://github.com/ztombol/bats-assert

# Setup test environment
WORKDIR /app
ENV BATS_LIB_PATH=/usr/local/lib/node_modules
ENV ESSENSHELL_PATH=/app
VOLUME ["/app"]
