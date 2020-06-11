FROM openjdk:8-jre-alpine
RUN apk -v --update --no-cache add \
        bash  \
        && \
    rm -rf /var/cache/apk/*

WORKDIR /app
ARG APP_PORT=9096
ADD target/spring-boot-template.tar.gz /build
RUN adduser -D -g '' -h /app -u 10001 app \
    && mv /build/config /app/config \
    && mv /build/lib /app/lib \
    && mv /build/bin /app/bin \
    && mv /build/jvm.options /app/jvm.options  \
    && mv /build/boot /app/boot  \
	&& chown -R app:app /app
USER app
ENV APP_PORT=${APP_PORT}
EXPOSE ${APP_PORT}
CMD ["/bin/bash", "bin/startup.sh"]