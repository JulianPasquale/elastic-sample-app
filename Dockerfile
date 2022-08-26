FROM ruby:3.1.1

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y build-essential 

# Set Buenos Aires time to the server
RUN cp /usr/share/zoneinfo/America/Buenos_Aires /etc/localtime

ARG NODE_VERSION=14.18.2
ARG YARN_VERSION=1.22.10

# Download Node and Yarn binaries
RUN wget -nv "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz"
RUN wget -nv "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz"
# RUN wget -nv "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc"

# Uncompress binaries
RUN mkdir -p /opt
RUN tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 --no-same-owner
RUN tar -xzf "yarn-v$YARN_VERSION.tar.gz" -C /opt/

# Link binaries to bin
# RUN ln -s "/opt/node-v$NODE_VERSION-linux-x64/bin" /usr/local/bin/node
RUN ln -s "/opt/yarn-v$YARN_VERSION/bin/yarn" /usr/local/bin/yarn
RUN ln -s "/opt/yarn-v$YARN_VERSION/bin/yarnpkg" /usr/local/bin/yarnpkg

# Cleanup
RUN rm "node-v$NODE_VERSION-linux-x64.tar.xz" "yarn-v$YARN_VERSION.tar.gz"

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./
RUN gem install bundler:2.3.9 && \
  bundle install --jobs 20 --retry 5

# Copy the main application.
COPY . ./

EXPOSE 3000

ENV RAILS_ENV=production

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD bundle exec rails server -b 0.0.0.0