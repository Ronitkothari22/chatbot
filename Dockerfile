FROM rasa/rasa:3.6.2-full

USER root
WORKDIR /app
COPY . /app
RUN rasa train

# Set environment variable to silence SQLAlchemy warning
ENV SQLALCHEMY_SILENCE_UBER_WARNING=1

USER 1001

# Expose the port on which Rasa will run
EXPOSE 5005

# Start Rasa server
ENTRYPOINT ["rasa"]
CMD ["run", "--enable-api", "--port", "5005", "--cors", "*"]