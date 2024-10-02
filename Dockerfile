# FROM rasa/rasa:3.6.2-full

# USER root
# WORKDIR /app
# COPY . /app
# RUN rasa train

# # Set environment variable to silence SQLAlchemy warning
# ENV SQLALCHEMY_SILENCE_UBER_WARNING=1

# # Set environment variable for the port
# ENV PORT 5005

# USER 1001

# # Expose the port on which Rasa will run
# EXPOSE $PORT

# # Start Rasa server (shell form)
# CMD rasa run --enable-api --port $PORT --cors "*" --debug




FROM rasa/rasa:3.6.2-full

WORKDIR /app

# Copy only necessary files for training
COPY config.yml domain.yml data /app/

# Train the model during build
RUN rasa train

# Copy the rest of the application
COPY . .

# Set environment variables
ENV PORT 10000

# Switch to non-root user
USER 1001

# Expose the port Render expects
EXPOSE $PORT

# Start command
CMD rasa run --enable-api --port $PORT --cors "*"