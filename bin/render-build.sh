#!/usr/bin/env bash
# exit on error
set -o errexit

bundle install
# Perform database migrations
bundle exec rails db:migrate