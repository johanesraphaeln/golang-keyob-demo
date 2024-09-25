# Stage 1: Build the Go app
FROM golang:1.21 AS builder

# Set the working directory
WORKDIR /app

# Copy the go.mod and go.sum files
COPY go.mod ./

# Download dependencies
RUN go mod download

# Copy the rest of the application source code
COPY . .

# Build the Go app
RUN go build -o myapp .

# Stage 2: Create a minimal image
FROM alpine:latest

# Set the working directory in the minimal image
WORKDIR /root/

# Copy the binary from the builder stage
COPY --from=builder /app/myapp .

# Expose the port your app runs on
EXPOSE 8080

# Command to run the executable
CMD ["./myapp"]
