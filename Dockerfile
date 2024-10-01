FROM rasa/rasa:3.6.2-full

USER root
WORKDIR /app
COPY . /app
RUN rasa train

USER 1001

# Expose the port on which Rasa will run
EXPOSE 5005

# Start Rasa server
CMD ["rasa", "run", "--enable-api", "--port", "5005", "--cors", "*"]
