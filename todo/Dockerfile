FROM ruby:3.2
RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /todo
COPY Gemfile /todo/Gemfile
COPY Gemfile.lock /todo/Gemfile.lock
RUN bundle install

COPY . .

EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]