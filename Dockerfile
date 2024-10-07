
# FROM rasa/rasa:3.6.20-full

# USER root
# WORKDIR /app
# COPY . /app
# RUN rasa train

# # Set environment variable to silence SQLAlchemy warning
# ENV SQLALCHEMY_SILENCE_UBER_WARNING=1

# # Create an entrypoint script
# RUN echo '#!/bin/bash' > /entrypoint.sh && \
#     echo 'if [ "$1" = "/bin/bash" ]; then' >> /entrypoint.sh && \
#     echo '    PORT="${PORT:-5005}"' >> /entrypoint.sh && \
#     echo '    exec rasa run --enable-api --cors "*" --port $PORT' >> /entrypoint.sh && \
#     echo 'else' >> /entrypoint.sh && \
#     echo '    exec "$@"' >> /entrypoint.sh && \
#     echo 'fi' >> /entrypoint.sh && \
#     chmod +x /entrypoint.sh

# USER 1001

# # Expose the port on which Rasa will run
# EXPOSE 5005

# # Use the entrypoint script
# ENTRYPOINT ["/entrypoint.sh"]

# # Default command (will be overridden by Render, but included for completeness)
# CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "5005"]


#port error
# FROM rasa/rasa:3.6.20-full
# USER root
# WORKDIR /app
# COPY . /app
# RUN rasa train
# # Set environment variable to silence SQLAlchemy warning
# ENV SQLALCHEMY_SILENCE_UBER_WARNING=1
# # Create an entrypoint script
# RUN echo '#!/bin/bash' > /entrypoint.sh && \
#     echo 'if [ "$1" = "/bin/bash" ]; then' >> /entrypoint.sh && \
#     echo '    PORT="${PORT:-5005}"' >> /entrypoint.sh && \
#     echo '    exec rasa run --enable-api --cors "*" --port $PORT' >> /entrypoint.sh && \
#     echo 'else' >> /entrypoint.sh && \
#     echo '    exec "$@"' >> /entrypoint.sh && \
#     echo 'fi' >> /entrypoint.sh && \
#     chmod +x /entrypoint.sh
# USER 1001
# # Expose the port on which Rasa will run
# EXPOSE $PORT
# # Use the entrypoint script
# ENTRYPOINT ["/entrypoint.sh"]
# # Default command (will be overridden by Render, but included for completeness)
# CMD ["rasa", "run", "--enable-api", "--cors", "*", "--port", "$PORT"]



FROM rasa/rasa:3.6.20-full
USER root
WORKDIR /app
COPY . /app
RUN rasa train

# Set environment variable to silence SQLAlchemy warning
ENV SQLALCHEMY_SILENCE_UBER_WARNING=1

# Create an entrypoint script
RUN echo '#!/bin/bash' > /entrypoint.sh && \
    # Check if we are in the bash shell
    echo 'if [ "$1" = "/bin/bash" ]; then' >> /entrypoint.sh && \
    # Render will pass the port as an environment variable, so no need to specify it here
    echo '    exec rasa run --enable-api --cors "*"' >> /entrypoint.sh && \
    echo 'else' >> /entrypoint.sh && \
    # If we are not in bash, just run the provided command
    echo '    exec "$@"' >> /entrypoint.sh && \
    echo 'fi' >> /entrypoint.sh && \
    chmod +x /entrypoint.sh

USER 1001

# Expose the port that Render will use via its environment variable (handled by Render)
EXPOSE $PORT

# Use the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]

# Default command (can be overridden by Render)
CMD ["rasa", "run", "--enable-api", "--cors", "*"]
