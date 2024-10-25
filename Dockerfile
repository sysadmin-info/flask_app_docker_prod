FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    openssh-server sudo python3 python3-pip mysql-server libmysqlclient-dev && \
    mkdir /var/run/sshd && echo 'root:root' | chpasswd

# Allow root login over SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Install Python dependencies
RUN pip3 install flask mysql-connector-python gunicorn

# Copy initialization SQL script
COPY init.sql /docker-entrypoint-initdb.d/init.sql

# Copy app.py into the container
COPY app.py /app/app.py

# Set the working directory
WORKDIR /app

# Expose necessary ports
EXPOSE 22 5000

# Use JSON-form CMD for better signal handling
CMD ["sh", "-c", "service mysql start && sleep 10 && mysql -u root -e 'source /docker-entrypoint-initdb.d/init.sql' && gunicorn --bind 0.0.0.0:5000 app:app && /usr/sbin/sshd -D"]