FROM golang:onbuild as Builder

ARG PLATFORM_ARCH

# Move to working directory /build
WORKDIR /build
# Copy the code into the container
COPY . .
RUN CGO_ENABLED=0 go build -o main

FROM alpine:latest

COPY --from=Builder /build/main app/main
COPY static/ app/static/
EXPOSE 8000
WORKDIR /app
ENTRYPOINT [ "./main" ]