# Use mongo 7.0.2 as the base image
FROM mongo:7.0.2

# If you have custom scripts or configurations, COPY them into the image
# For example, to add a custom MongoDB config file:
# COPY mongodb.conf /etc/mongo/mongodb.conf
COPY healthcheck /usr/local/bin/

# If you need to run any commands to prepare your custom image, you can use RUN commands here
# For example, to install additional packages or tools:
# RUN apt-get update && apt-get install -y <your-package>

# No ENTRYPOINT or CMD is necessary, as we're inheriting from the mongo image
HEALTHCHECK CMD ["healthcheck"]