# Use an official Ruby runtime as a base image
FROM ruby:3.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set an environment variable for the root path of the app
ENV RAILS_ROOT /app
RUN mkdir -p $RAILS_ROOT

# Set the working directory
WORKDIR $RAILS_ROOT

# Install Gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose the application port
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
