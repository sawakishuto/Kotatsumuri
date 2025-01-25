# syntax = docker/dockerfile:1

# This Dockerfile is optimized for production builds.
# To build and run:
# docker build -t my-app .
# docker run -d -p 3000:3000 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app

# Specify the Ruby version
ARG RUBY_VERSION=3.1.6
FROM ruby:$RUBY_VERSION-slim AS base

# Set working directory
WORKDIR /rails

# Install essential packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
    curl \
    libjemalloc2 \
    libvips \
    postgresql-client \
    build-essential && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set environment variables for bundler and Rails
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# Build stage
FROM base AS build

# Install additional build tools for gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y git libpq-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Copy gem dependencies and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3 && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git

# Copy application code
COPY . .

# Precompile application bootsnap files
RUN bundle exec bootsnap precompile app/ lib/

# Final stage
FROM base

# Copy built application and gems from the build stage
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Ensure non-root user for runtime security
RUN groupadd --system --gid 1000 rails && \
    useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash rails && \
    chown -R rails:rails /rails/db /rails/log /rails/storage /rails/tmp
USER 1000:1000

# Set entrypoint to prepare the database
ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Expose the Rails server port
EXPOSE 3000

# Default command to start the server
CMD ["./bin/rails", "server"]
