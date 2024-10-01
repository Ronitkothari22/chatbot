FROM rasa/rasa:3.6.2-full

USER root
WORKDIR /app
COPY . /app
RUN rasa train

# Set environment variable to silence SQLAlchemy warning
ENV SQLALCHEMY_SILENCE_UBER_WARNING=1

# Set environment variable for the port
ENV PORT 5005

# Make sure the start script is executable
RUN chmod +x start.sh

USER 1001

# Expose the port on which Rasa will run
EXPOSE $PORT

# Start Rasa server using the shell script
CMD ["/bin/bash", "start.sh"]