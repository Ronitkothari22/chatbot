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

# Use Rasa 3.6.20 instead of 3.6.2
FROM rasa/rasa:3.6.20-full

USER root
WORKDIR /app
COPY . /app
RUN rasa train

# Set environment variable to silence SQLAlchemy warning
ENV SQLALCHEMY_SILENCE_UBER_WARNING=1

# Set environment variable for the port
ENV PORT 10000

USER 1001

# Expose the port on which Rasa will run
EXPOSE $PORT

# Set the entrypoint to "rasa"
ENTRYPOINT ["rasa"]

# Start Rasa server
CMD ["run", "--enable-api", "--cors", "*", "--port", "$PORT"]