FROM ruby:3.3.7

# Set environment variables
ENV APP_HOME=/app
ENV RAILS_ENV=development

# Create app directory
WORKDIR $APP_HOME

# Install bundler
RUN gem install bundler -v 2.4.22

# Copy Gemfile and install dependencies
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

# Copy application code
COPY . .

ARG SECRET_KEY_BASE
ENV SECRET_KEY_BASE=$SECRET_KEY_BASE

ARG EPPO_SDK_KEY
ENV EPPO_SDK_KEY=$EPPO_SDK_KEY

ENV EPPO_LOG="eppo=debug"

# Precompile assets (optional, for production)
RUN SECRET_KEY_BASE_DUMMY=1 bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb", "-w", "3", "--preload"]
