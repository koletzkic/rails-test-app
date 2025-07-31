FROM ruby:3.2

WORKDIR /app

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set environment variables
ENV BUNDLER_VERSION=2.4.22
ENV RAILS_ENV=development

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v $BUNDLER_VERSION && bundle install

COPY . .
RUN pwd
RUN ls -la bin

# Expose port and start server
EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0"]