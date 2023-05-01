# Test-Dockerfile, kann auch wieder gelöscht werden, wenn notwendig
# FROM nginx:alpine
# COPY . /usr/share/nginx/html

FROM ruby:3.2
RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /todo
COPY /todo/Gemfile /todo/Gemfile
COPY /todo/Gemfile.lock /todo/Gemfile.lock
RUN bundle install

EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]