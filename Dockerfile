# FROM rasa/rasa:3.6.2-full

# USER root
# WORKDIR /app
# COPY . /app
# RUN rasa train

# # Set environment variable to silence SQLAlchemy warning
# ENV SQLALCHEMY_SILENCE_UBER_WARNING=1

# # Set environment variable for the port
# ENV PORT 10000

# USER 1001

# # Expose the port on which Rasa will run
# EXPOSE $PORT

# # Start Rasa server
# CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "$PORT"]


FROM rasa/rasa:latest-full

WORKDIR /app
COPY . /app

# Copy the start script
COPY start-rasa.sh /app/start-rasa.sh
RUN chmod +x /app/start-rasa.sh

# Set environment variable for the port
ENV PORT 10000

# Expose the port on which Rasa will run
EXPOSE $PORT

# Start Rasa server using the script
CMD ["/app/start.sh"]