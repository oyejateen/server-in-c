# Custom HTTP Server in C

## Overview

This project implements a custom HTTP server using C, designed to handle simple HTTP requests such as serving static files, echoing back parts of the URL, and handling user-agent queries. This server is built using basic socket programming and is intended as a learning tool or a simple, lightweight HTTP server for specific use cases.

## Features

- **Serving static files**: Handles GET requests to serve files from a specified directory.
- **Echo service**: Echoes back the text provided in the URL.
- **User-Agent handling**: Responds with the User-Agent header sent by the client.
- **Basic error handling**: Returns appropriate HTTP status codes for various errors (e.g., 404 Not Found, 500 Internal Server Error).

## Building the Server

### Prerequisites

- A C compiler (e.g., `gcc`)
- Basic knowledge of socket programming in C

### Instructions

1. **Clone the repository (if applicable)**:
   ```sh
   git clone <repository_url>
   cd <repository_directory>
   ```

2. **Compile the server**:
   ```sh
   gcc -o http_server http_server.c
   ```

3. **Run the server**:
   ```sh
   ./http_server --directory <directory_path>
   ```
   Replace `<directory_path>` with the path to the directory you want to serve files from.

## Code Explanation

### Argument Parsing

The `parse_args` function uses `getopt_long` to parse command-line arguments. It requires a `--directory` argument to specify the directory to serve files from.

### Main Function

1. **Socket creation**:
   ```c
   server_fd = socket(AF_INET, SOCK_STREAM, 0);
   ```

2. **Set socket options**:
   ```c
   setsockopt(server_fd, SOL_SOCKET, SO_REUSEPORT, &reuse, sizeof(reuse));
   ```

3. **Bind the socket to a port**:
   ```c
   bind(server_fd, (struct sockaddr *)&serv_addr, sizeof(serv_addr));
   ```

4. **Listen for incoming connections**:
   ```c
   listen(server_fd, connection_backlog);
   ```

5. **Accept and handle connections**:
   The server uses `accept` to wait for incoming connections. For each connection, it forks a new process to handle the request. The child process handles the request and sends a response back to the client.

### Request Handling

- **Root (`/`)**: Responds with a simple message.
- **Echo (`/echo/`)**: Echoes back the part of the URL following `/echo/`.
- **Files (`/files/`)**: 
  - **GET**: Reads and serves the requested file from the specified directory.
  - **POST**: Writes the request body to the specified file in the directory.
- **User-Agent**: Parses the headers to find and respond with the `User-Agent` header.

### Error Handling

Appropriate HTTP status codes and messages are returned for various error conditions, such as file not found or internal server errors.

## Contributing

If you wish to contribute to this project:

1. **Fork the repository**.
2. **Create a new branch** for your feature or bugfix:
   ```sh
   git checkout -b feature-name
   ```
3. **Make your changes**.
4. **Commit your changes**:
   ```sh
   git commit -m "Description of changes"
   ```
5. **Push to the branch**:
   ```sh
   git push origin feature-name
   ```
6. **Create a pull request**.

Please ensure your code follows the existing style and includes comments where necessary. Contributions are welcome, especially in the areas of improving functionality, fixing bugs, and enhancing documentation.
