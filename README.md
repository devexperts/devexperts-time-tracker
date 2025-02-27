# DEVEXPERTS TIME TRACKER FOR JIRA

Devexperts Time Tracker for Jira is a comprehensive time-tracking solution developed by [Devexperts](https://devexperts.com/), comprising:
- Jira plugin [Devexperts Time Tracker for Jira](https://marketplace.atlassian.com/apps/1236146)
- Dockerized standalone web application
- Dockerized standalone backend service

This package contains everything you need to set up, configure, and run the Devexperts Time Tracker For Jira application and backend service. It also includes detailed instructions for integrating the solution with an existing Jira instance by creating an application link, installing and configuring the Jira plugin, and initializing the environment.

Follow the steps below to properly set up and run the application.

## Contents

- `.env` - Environment variables file. *Provide your own values for the variables following the instructions in this file.*
- `docker-compose.yaml` - Docker Compose configuration file.
- `docker-compose.no-ssl.yaml` - Additional Docker Compose configuration file for running without SSL certificates.
- `timetracker.sh` - Shell script for Linux/macOS/Windows systems.
- `proxy/`
    - `nginx.conf.template` - Template for creating an Nginx configuration file with SSL certificates.
    - `privkey.pem` - Private key file. *Provide your own key file and update the environment variable 'PRIVATE_KEY_PEM' with the file name.*
    - `fullchain.pem` - Full chain certificate file. *Provide your own certificate file and update the environment variable 'FULL_CHAIN_PEM' with the file name.*
- `ui-nginx/`
    - `nginx.conf` - Nginx configuration file.
    - `mime.types` - Nginx MIME types file.
    - `conf.d/`
        - `default.conf` - Nginx default configuration file.
- `link-creation/`
    - `run.sh` - Shell script for creating an application link between Jira and the Time Tracker App.
    - `run2.sh` - Shell script for finalizing the application link creation.
    - `OAuthClient-1.0.jar` - OAuth client JAR file used by scripts.
- `custom_images/` - Folder containing images for the web application. If you want to use your own images, replace the existing ones.
- `README.md` - Instructions for using the deployment package.
- `log4j.properties` - Log4j configuration file for the Jira plugin.
- `LICENSE` - License file.

## Prerequisites

- Ensure you have Docker and Docker Compose installed on your system.
- Ensure that ports 8080, 8081, 6006 and 5432 are free on your system.
- A working Jira instance where you have administrator access.

## Local Run Notes

- Jira in Docker: If you are running Jira inside a Docker container, ensure that Jira and the web application are on the same Docker network (such as backend). Additionally, use host.docker.internal instead of localhost in the URL when configuring the environment, so that containers can communicate properly.

## Setup Instructions

### Step 1: Ensure the Web Application starts successfully
1. **Start the Web Application**
    - Open a terminal and navigate to the deployment directory. 
    - Run one of the following commands based on your setup:
      - With SSL:
      ```sh
      ./timetracker.sh init
      ./timetracker.sh start
      ```
      - Without SSL:
      ```sh
      ./timetracker.sh init-no-ssl
      ./timetracker.sh start-no-ssl
      ```
    - Verify that all required containers are running using: `docker ps`

2. **Verify the Web Application is Running**
    - Open your browser and go to:
      - With SSL: https://your-webapp-domain
      - Without SSL: http://localhost:8081
    - Ensure the page loads without errors (login/authentication issues can be ignored for now).
    - Check container logs for any issues: `docker logs -f jtt-webapp`

### Step 2: Install and Configure Devexperts Time Tracker for Jira Plugin
- Log in to your Jira instance as an administrator.
- Navigate to **Jira Administration > Manage apps**.
- Click on **Find new apps** or **Find new add-ons** and search for **Devexperts Time Tracker for Jira**.
- Install the plugin from the Atlassian Marketplace.
- Once installed, click **Configure** and set the required parameters:
    - `Panel Title` - Set the title of the time tracking panel on the Jira issue page (e.g., **Devexperts Time Tracker**).
    - `Host` - Set the host name of the server running the Time Tracker application (e.g., `http://time-tracker.example.com`).
    - `Port` - Set the port number of the host (e.g., `80`).
    - `Websocket Address` - Set the address of the WebSocket server (should match the `Host` pattern: `wss://{..}/ws/sse/rtt`).
    - `Custom Parameters (comma separated)` - Optional; leave empty if not needed.

### Step 3: Create an Application Link in Jira

This step creates a secure connection between the Jira instance and the Time Tracker App.
For more information, refer to the Atlassian documentation: https://developer.atlassian.com/server/jira/platform/oauth

1. **Generate the OAuth keys:**
    - Follow [Atlassian’s guide](https://developer.atlassian.com/server/jira/platform/oauth/#generate-an-rsa-public-private-key-pair) to generate an RSA public/private key pair.
    - Save both keys for later use.

2. **Configure Jira:**
    - Log in as a Jira administrator.
    - Navigate to **Jira Administration > Applications > Application Links**.
    - Click **Create new link** and enter the URL of the Jira Time Tracker App (as set in `JTT_WEBAPP_HOST` in `.env`).
    - If prompted, select **Atlassian product** as the Application Type.
    - Click **Continue**, ignoring any warnings about receiving no response.
    - Enter the **Application Name** (e.g., *Time Tracking App*), set **Application Type** to **Generic Application**, and check **Create incoming link**.
    - Enter the **Consumer Key** and ensure it matches `OAUTH_CONSUMER_KEY` in `.env`.
    - Enter the **Public Key** from your generated keys and complete the setup.

3. **Run the setup scripts:**
    - Open a terminal and navigate to the `link-creation` directory.
    - Run:
      ```sh
      ./run.sh OAUTH_CONSUMER_KEY JIRA_URL PRIVATE_KEY
      ```
      *Paste the content of the private key file without the PEM delimiters.*
      Example:
      ```sh
      ./run.sh CONSUMER_KEY http://jira.example.com MIIBCAQ8A...
      ```
    - Follow the authorization URL output by the script, log in to Jira, and authorize the link.
    - Copy the verification code displayed after authorization.
    - Run the second script to complete the process:
      ```sh
      ./run2.sh VERIFICATION_CODE
      ```
    - After script finishes, it will output the access token.

### Step 4: Configure Environment Variables

Update the `.env` file with required details before running the application:

```ini
VERSION_NUMBER: Build version
OAUTH_CONSUMER_KEY: Set the OAuth consumer key generated in Step 2.
OAUTH_ACCESS_TOKEN: Set the OAuth access token generated in Step 2.
OAUTH_PRIVATE_KEY: Set the OAuth private key generated in Step 2 (without PEM delimiters).
OAUTH_SECRET: Set the OAuth secret (VERIFICATION_CODE) generated in Step 2.
JIRA_URL: Jira instance URL with http prefix (e.g., http://jira.example.com)
JTT_WEBAPP_HOST: Host of the Time Tracker application without http prefix (e.g., time-tracker.example.com)
LOG_LEVEL: Log level (DEBUG, INFO, WARN, ERROR)

# Proxy Configuration (only if using SSL)
FULL_CHAIN_PEM= # Certificate file name
PRIVATE_KEY_PEM= # Private key file name
```

### Step 5: Start the Services

Run the setup script with the appropriate command:
```sh
./timetracker.sh init           # Initialize the setup (run once)
./timetracker.sh init-no-ssl    # Initialize without SSL (run once)
./timetracker.sh start          # Start all services
./timetracker.sh start-no-ssl   # Start all services without SSL
./timetracker.sh stop           # Stop services
./timetracker.sh restart        # Restart the web application
./timetracker.sh update         # Update and restart the web application
```

## Notes

- The project runs with a **containerized PostgreSQL 13 database** by default. Administrators can configure an external database by updating `POSTGRES_` variables in `docker-compose.yaml`.
- Ensure the Docker daemon is running before executing the scripts.
- If using SSL, ensure certificates are configured correctly in the `proxy` directory.
- To enable separate logs for the Jira plugin, append `log4j.properties` settings to the existing Jira log configuration.
- Run `./timetracker.sh update` to pull the latest version and restart services.
