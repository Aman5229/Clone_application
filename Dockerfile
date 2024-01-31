# Use the official Ruby image with Alpine Linux as the base image
FROM ruby:3.0.0-alpine

# Set the working directory to the app's path
WORKDIR /usr/src/app

# Install dependencies
RUN apk --no-cache add \
    build-base \
    postgresql-dev \
    nodejs \
    yarn

# Copy the Gemfile and Gemfile.lock into the image and install gems
COPY Gemfile* .
RUN bundle install --jobs "$(getconf _NPROCESSORS_ONLN)" --retry 5

# Copy the rest of the application code into the image
COPY . .

# Expose port 3000 to the outside world
EXPOSE 3000

# Start the Rails application
CMD ["rails", "server", "-b", "0.0.0.0"]
