---

# Flask App Production Environment with Gunicorn and Docker on Debian 12

This project sets up a Flask application connected to a MySQL database in a production environment using Docker and Gunicorn on a host with Debian 12. Gunicorn serves the Flask application, ensuring a production-ready deployment for handling multiple requests concurrently.

## Project Structure

- **`app.py`**: The Flask application that connects to a MySQL database and provides API endpoints for retrieving employee data【178†source】.
- **`Dockerfile`**: Defines the Docker image setup, including installing dependencies, configuring Gunicorn, and copying application files into the container.
- **`entrypoint.sh`**: Entrypoint script to initialize MySQL, set up the database, and launch Gunicorn to serve the Flask app.
- **`init.sql`**: SQL script to initialize the MySQL database schema and add sample data.
- **`app.yml`**: Ansible playbook for installing Docker locally, building the Docker image, and running the container.

## File Details

### `app.py`

This Flask application connects to a MySQL database and provides API endpoints. The application reads MySQL configurations from environment variables, which can be customized as needed:

- **MySQL Configuration**:
  - `MYSQL_DATABASE_HOST`: Defaults to `127.0.0.1`
  - `MYSQL_DATABASE_USER`: Defaults to `db_user`
  - `MYSQL_DATABASE_PASSWORD`: Defaults to `Passw0rd`
  - `MYSQL_DATABASE_DB`: Defaults to `employee_db`

- **Routes**:
  - `/`: A welcome message.
  - `/how_are_you`: A simple message to confirm the app is running.
  - `/read_from_database`: Connects to the MySQL database to retrieve employee names from the `employees` table.

### `Dockerfile`

Defines the Docker image with Gunicorn serving the Flask application:

1. **Base Image**: Uses Python as the base image to support Flask and MySQL libraries.
2. **Install Dependencies**: Installs required system packages, Python libraries, and Gunicorn for production deployment.
3. **Set Up Environment**: Configures environment variables for MySQL connection.
4. **Copy Files**: Adds `app.py`, `entrypoint.sh`, and `init.sql` to the container.
5. **Entrypoint**: Sets `entrypoint.sh` to run when the container starts, launching Gunicorn to serve the Flask app.

### `entrypoint.sh`

The entrypoint script initializes the MySQL database and starts Gunicorn【179†source】:

1. **Start MySQL**: Launches MySQL within the container and waits until it’s fully up.
2. **Initialize Database**: Executes `init.sql` to set up the database schema and populate it with sample data.
3. **Run Gunicorn**: Starts Gunicorn, serving the Flask application in production mode.

### `init.sql`

SQL script that:

- **Creates Database**: Sets up `employee_db`.
- **Creates Table**: Defines the `employees` table with columns for `id`, `name`, `position`, and `salary`.
- **Inserts Sample Data**: Adds initial employee records for testing purposes.

### `app.yml`

The Ansible playbook automates the setup of Docker on the local machine, builds the Docker image, and runs the container:

1. **Install Docker**: Installs Docker and Docker Compose on the local machine.
2. **Build Docker Image**: Builds the image based on the `Dockerfile`.
3. **Run Docker Container**: Starts the container, with Gunicorn serving the Flask app and MySQL running inside the same container.

## Prerequisites

- Ansible installed on the local machine.
- `sudo` access on the local machine to install Docker and manage services.

## Setup and Deployment

1. **Prepare the Application Files**:
   Ensure all required files (`app.py`, `Dockerfile`, `entrypoint.sh`, `init.sql`, and `app.yml`) are in the project directory on the local machine.

2. **Run the Ansible Playbook**:
   Deploy the application with:

   ```bash
   ansible-playbook app.yml
   ```

   This will:
   - Install Docker on your local machine (if not already installed).
   - Build the Docker image using the provided `Dockerfile`.
   - Start the Flask app served by Gunicorn within a Docker container.

3. **Access the Application**:
   Once the playbook completes, open a web browser and go to:

   ```
   curl http://localhost:5000
   ```

   This connects to the Flask app served by Gunicorn inside the Docker container.

4. **Stopping the Container**:
   If you need to stop the application, run:

   ```bash
   docker stop my_flask_mysql_container
   ```

---

This setup provides a production-ready environment for the Flask app, using Docker and Gunicorn to handle multiple requests effectively and ensure reliability in a production setting.