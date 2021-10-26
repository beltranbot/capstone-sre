#!/bin/bash
echo "NODE_ENV=$NODE_ENV" >> /etc/environment
echo "APP_PORT=$APP_PORT" >> /etc/environment
echo "DB_DIALECT=$DB_DIALECT" >> /etc/environment
echo "DB_HOST=$DB_HOST" >> /etc/environment
echo "DB_PASSWORD=$DB_PASSWORD" >> /etc/environment
echo "DB_USERNAME=$DB_USERNAME" >> /etc/environment
echo "DB_DATABASE=$DB_DATABASE" >> /etc/environment
echo "DB_PORT=$DB_PORT" >> /etc/environment
echo "JWT_KEY=$JWT_KEY" >> /etc/environment
