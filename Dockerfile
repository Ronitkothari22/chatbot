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

# Use Rasa 3.6.20
FROM rasa/rasa:3.6.20-full

USER root
WORKDIR /app
COPY . /app
RUN rasa train

# Set environment variable to silence SQLAlchemy warning
ENV SQLALCHEMY_SILENCE_UBER_WARNING=1

# Create an entrypoint script
RUN echo '#!/bin/bash\n\
if [ "$1" = "/bin/bash" ]; then\n\
    exec rasa run --enable-api --cors "*" --port $PORT\n\
else\n\
    exec "$@"\n\
fi' > /entrypoint.sh && chmod +x /entrypoint.sh

USER 1001

# Expose the port on which Rasa will run
EXPOSE 10000

# Use the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Default command (will be overridden by Render, but included for completeness)
CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "$PORT"]