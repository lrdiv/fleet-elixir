FROM elixir:latest

# Install postgres client to use pg_isready command
RUN apt-get update
RUN apt-get install -y nodejs npm inotify-tools postgresql-client

# Copy app files and entrypoint script to container
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install dependencies
RUN mix local.hex --force
RUN mix local.rebar --force
RUN mix deps.get --force

# Compile the project
RUN mix do compile

# Start the server
ENTRYPOINT [ "./entrypoint.sh" ]
CMD [ "mix", "phx.server" ]
