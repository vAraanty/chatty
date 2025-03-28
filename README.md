# Chatty - Modern Messaging Platform with Rails 8

> ⚠️ Note: This is a small learning project and not production-ready. It was created to gain hands-on experience with Rails 8, Turbo, TurboStreams, Websockets, and integrations such as Auth0, OpenSearch, Stripe, and more. While functional, it's meant for educational purposes and may contain bugs or areas for improvement.

## Overview

Chatty is a modern messaging application built with Rails 8 that demonstrates real-time chat functionality with Hotwire (Turbo and Stimulus), user authentication with Auth0, search functionality with OpenSearch, and subscription management with Stripe.

## Features

- **Real-time messaging**: Send and receive messages instantly using Turbo Streams and WebSockets
- **User authentication**: Secure login/signup flow using Auth0
- **User search**: Find users via OpenSearch integration with fuzzy search capabilities
- **Subscription management**: Tiered subscription model using Stripe for payment processing
- **User profiles**: Customizable user profiles with avatar support
- **Modern UI**: Clean and responsive design using TailwindCSS

## Tech Stack

- **Rails 8**: Latest version of the Ruby on Rails framework
- **Hotwire**: Modern, HTML-over-the-wire approach with Turbo and Stimulus
- **Auth0**: Authentication and authorization platform
- **OpenSearch**: Search and analytics engine
- **Stripe**: Payment processing platform
- **TailwindCSS**: Utility-first CSS framework
- **Docker**: Containerization for development and deployment
- **Solid Queue**: Background job processing
- **Solid Cache**: Database-backed caching
- **Solid Cable**: Database-backed Action Cable adapter

## Prerequisites

- Docker and Docker Compose
- Ruby 3.3+
- Node.js and Yarn
- Auth0 account
- Stripe account
- OpenSearch instance (or use the included Docker service)

## Development Setup

1. Clone the repository
```
git clone https://github.com/vAraanty/chatty.git
cd chatty
```

2. Create .env file from the example
```
cp .env.example .env
```

3. Configure environment variables in .env file
```
STRIPE_API_KEY=your_stripe_api_key
OPENSEARCH_INITIAL_ADMIN_PASSWORD=your_opensearch_password
```

4. Start the development environment with Docker Compose
```
docker-compose up
```

5. Access the application at http://localhost:3000

## Make Shortcuts

The project includes helpful Make shortcuts for common tasks:

- `make rails [command]`: Run Rails commands in the container
- `make c`: Start Rails console
- `make test`: Run the test suite
- `make sh`: Access the container shell
- `make attach`: Attach to the running container

## Architecture

The application follows a clean architecture approach with:

- **Models**: Core data structures with validations and business logic
- **Controllers**: Handle HTTP requests and responses
- **Transactions**: Service objects for complex business logic using dry-transaction
- **Contracts**: Input validation using dry-validation
- **Policies**: Authorization rules with Pundit
- **Views**: HTML templates with modern Turbo/Stimulus enhancements

## Features in Detail

### Authentication Flow

The app uses Auth0 for authentication with OmniAuth integration. The flow includes:
- Login/Signup via Auth0
- User creation in the local database
- Session management
- Logout functionality

### Real-time Messaging

Messages are broadcasted in real-time using Turbo Streams over WebSockets:
- Messages appear instantly for all participants
- Conversations update in real-time
- File attachments supported

### Search Functionality

The app leverages OpenSearch for efficient user discovery:
- Fuzzy search capabilities
- Real-time search results with debouncing
- Integration with the Searchable concern for easy model indexing

### Subscription Management

Subscription handling with Stripe includes:
- Tiered subscription plans
- Free trial support
- Webhook integration for subscription lifecycle events
- Subscription management portal

## Known Issues and Limitations

- This is a learning project and not intended for production use
- Some features may be incomplete or simplified
- Error handling could be improved in certain areas
- Test coverage is not comprehensive

## License

This project is available as open source under the terms of the MIT License.

## Acknowledgements

- Rails team for Rails 8
- Auth0 for authentication
- Stripe for payment processing
- OpenSearch for search functionality
- Hotwire team for Turbo and Stimulus
