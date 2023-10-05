FROM alpine

# Install test dependencies
RUN apk add --no-cache bash ruby bats git npm python3
RUN gem install bashcov
RUN npm install -g https://github.com/ztombol/bats-support
RUN npm install -g https://github.com/ztombol/bats-assert

# Setup test environment
RUN adduser -D essenuser
USER essenuser
WORKDIR /home/essenuser
COPY . .
ENV BATS_LIB_PATH=/usr/local/lib/node_modules

# Expose test results
EXPOSE 8000
