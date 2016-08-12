#!/bin/bash
set -o pipefail

grep -Rl '{{backend_url}}' /var/www | xargs sed -i "s#{{backend_url}}#$BACKEND_URL#g"

#http-server /var/www -p 80
nginx -g 'daemon off;'
