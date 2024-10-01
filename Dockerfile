FROM rasa/rasa:3.6.2-full

USER root
WORKDIR /app
COPY . /app
RUN rasa train

USER 1001
CMD ["rasa", "run", "--enable-api", "--port", "$PORT"]