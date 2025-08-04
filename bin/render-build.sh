#!/usr/bin/env bash

# Exit on error
set -o errexit

bundle install
bin/rails assets:precompile
bin/rails assets:clean

echo "DATABASE_URL=$DATABASE_URL"

# If you have a paid instance type, we recommend moving
# database migrations like this one from the build command
# to the pre-deploy command:
bin/rails db:migrate