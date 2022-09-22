FROM alpine:latest as builder
RUN echo " now builder's time"
WORKDIR /build
COPY ./test ./test
RUN echo " Building App"

FROM alpine:latest as unitest
WORKDIR /unitest
COPY --from=builder /build/test ./test
RUN echo " now testing" >> ./test


FROM alpine:latest as security
WORKDIR /sectest
COPY --from=unitest /unitest/test ./sectest
RUN echo " security testing" >> ./sectest


FROM alpine:latest as myapp
WORKDIR /srccode
COPY --from=security /sectest/sectest ./appuplogs
RUN echo " running app" >> ./appuplogs
