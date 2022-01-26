FROM ruby:3.1.0-alpine3.15

COPY Gemfile Gemfile.lock /app/

WORKDIR /app

# RUN apk --no-cache add --virtual \
#   && bundle install --deployment --without test development

RUN bundle install --deployment --without test development

EXPOSE 3000

ENV RACK_ENV production

COPY . /app

ENTRYPOINT ["bundle", "exec", "rake"]
