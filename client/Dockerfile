FROM node:6.3.1-wheezy

RUN npm install -g http-server

RUN git clone --depth 1 --branch master \
  https://github.com/ushahidi/platform-client /tmp/client

ENV BACKEND_URL="{{backend_url}}"
RUN cd /tmp/client && \
  npm install && \
  npm install gulp && \
  node_modules/gulp/bin/gulp.js build && \
  mv /tmp/client/server/www /var && \
  npm cache clean && \
  rm -rf /tmp/*

COPY start.sh /

EXPOSE 8080

CMD ["/start.sh"]
