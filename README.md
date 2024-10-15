# DEVEXPERTS TIME TRACKER FOR JIRA

This package contains everything you need to set up, configure, and run the Devexperts Time Tracker For Jira App within Docker containers. It also includes detailed instructions for integrating the app with an existing Jira instance by creating an application link, installing and configuring the Jira plugin, and initializing the environment.

Follow the steps below to properly set up and run the application.

## Contents

- `.env` - Environment variables file. // Provide your own values for the variables following the instructions in this file
- `docker-compose.yaml` - Docker Compose configuration file.
- `timetracker.sh` - Shell script for Linux/macOS/Windows systems.
- `proxy / `
    - `nginx.conf` - Nginx configuration file.
    - `privkey.pem` - Private key file. // Provide your own key file and update the environment variable 'PRIVATE_KEY_PEM' with the file name
    - `fullchain.pem` - Full chain certificate file. // Provide your own certificate file and update the environment variable 'FULL_CHAIN_PEM' with the file name
- `ui-nginx / ` 
    - `nginx.conf` - Nginx configuration file.
    - `mime.types` - Nginx MIME types file.
    - `conf.d / `
        - `default.conf` - Nginx default configuration file.
- `link-creation / `
    - `run.sh` - Shell script for creating an application link between Jira and the Time Tracker App.
    - `run2.sh` - Shell script for finalizing the application link creation.
    - `OAuthClient-1.0.jar` - OAuth client JAR file used by scripts.
- `custom_images /` - Folder containing images for web application. If you want to use your own images, replace the existing ones.
- `README.md` - Instructions for using the deployment package.
- `log4j.properties` - Log4j configuration file for Jira plugin.
- `LICENSE` - License file.
- `Devexperts Time Tracker Manual.pdf` - User manual for the Time Tracker App.

## Prerequisites

* Ensure you have Docker and Docker Compose installed on your system.
* Obtain the necessary Docker credentials to access private Docker images and set the `DOCKER_USERNAME` and `DOCKER_PASSWORD` environment variables in the `.env` file.
* Ensure that the server host where the application will run is whitelisted for network access.

## Setup Instructions

### Step 1: Install and Configure Devexperts Time Tracker for Jira Plugin
  - Log in to your Jira instance as an administrator. 
  - Navigate to Jira Administration > Manage apps. 
  - Click on Find new apps or Find new add-ons and search for the "Devexperts Time Tracker for Jira"
  - Install the plugin from the Atlassian Marketplace. 
  - Once installed, click on the Configure button for the plugin to set the required parameters:
    - `Panel Title` - Set the title of the time tracking panel on Jira issues page    // example: Devexperts Time Tracker
    - `Host` - Set the host name of the server with Time Tracker application // example: http://time-tracker.example.com
    - `Port` - Set the port number of the host // example: 80 
    - `Websocket Address` - Set the address of the websocket server (should be similar to `Host` and match the pattern: "wss://{..}/ws/sse/rtt") // example: wss://time-tracker.example.com/ws/sse/rtt 
    - `Custom Parameters (comma separated)` - Set the custom parameters for the plugin // Leave empty if not needed

### Step 2: Create Application Link in Jira
The following steps are required to create an application link between the Jira instance and the Time Tracker App. This link is necessary for the Jira instance to communicate with the Time Tracker App and access its resources. 
For more information, refer to the Atlassian documentation: https://developer.atlassian.com/server/jira/platform/oauth
1. Generate the OAuth keys:
   - Follow the instructions on https://developer.atlassian.com/server/jira/platform/oauth/#generate-an-rsa-public-private-key-pair
   - Save the private key and public key for later use.
2. Jira administrator steps:
  - Login in Jira as administrator.
  - Go to Jira Administration > Applications > Application Links.
  - Click 'Create new link'.
  - Enter the URL of the Jira Time Tracker App (as set in JTT_WEBAPP_HOST in the .env file). If Application type is also required to be set, select Atlassian product.
  - Ignore the 'No response was received from the URL you entered' message and click 'Continue'.
  - Enter the Application Name that identifies the Time Tracking App. Set the Application Type to Generic Application. Check the 'Create incoming link' checkbox. The other fields can be left empty.
  - Enter the Consumer Key and set the same value in the .env file under OAUTH_CONSUMER_KEY.
  - Enter the Public Key provided during the app setup.
  - Click Continue to complete the application link configuration.
3. Running run.sh script:
  - Open a terminal. Navigate to the link-creation directory.
  - Run the `./run.sh OAUTH_CONSUMER_KEY JIRA_URL PRIVATE_KEY` command, where JIRA_URL is the URL of the Jira instance and PRIVATE_KEY is the private key provided during the app setup. // example: ./run.sh CONSUMER_KEY http://jira.example.com MIIBCAQ8A...MIIBCgKCAQEAq3
  - After script finishes, it will output the URL to authorize the application link. // example: http://jira.example.com/plugins/servlet/oauth/authorize?oauth_token=HJgjgjg
4. Jira administrator steps:
  - Login in Jira as administrator.
  - Open the URL provided by the script in a browser.
  - Click 'Allow' to authorize the application link.
  - After successful authorization, you will see a message containing the verification code. // example: You have successfully authorized 'your_application'. Your verification code is '123456'
5. Running run2.sh script:
   - Open a terminal. Navigate to the link-creation directory.
   - Run the `./run2.sh VERIFICATION_CODE` command, where VERIFICATION_CODE is the code provided during the authorization. // example: ./run2.sh 123456 
   - After script finishes, it will output the access token.

### Step 3: Configure the Environment Variables

The `.env` file contains configuration settings needed for the application. Edit this file to include the required information before running the scripts.

### Required Variables

Edit the following variables in the `.env` file:

```ini
VERSION_NUMBER= # Set the version number of the build
OAUTH_CONSUMER_KEY= # Set your OAuth consumer key
OAUTH_ACCESS_TOKEN= # Set your OAuth access token
OAUTH_PRIVATE_KEY= # Set your OAuth private key
OAUTH_SECRET= # Set your OAuth secret
JIRA_URL= # Set your Jira URL
JTT_WEBAPP_HOST= # Set the url of the current machine
FULL_CHAIN_PEM= # Set the name of the full chain certificate file in ./jtt-proxy
PRIVATE_KEY_PEM= # Set the name of the private key file in ./jtt-proxy
DOCKER_USERNAME= # Set your Docker username received in advance
DOCKER_PASSWORD= # Set your Docker password received in advance
```

### Step 4: Run `timetracker.sh` to Start the Services

1. Open a terminal.
2. Navigate to the directory containing the deployment package.
3. Run the script with one of the following commands:
  ```sh
  ./timetracker.sh init      # To initialize the setup - Run this once
  ./timetracker.sh start     # To start the services
  ./timetracker.sh stop      # To stop the services
  ./timetracker.sh restart   # To restart the web application service
  ./timetracker.sh update    # To update the web application service
  ```

## Notes
- By default, the project runs with a containerized PostgreSQL 13 database. However, if administrators prefer to use an external database, they can easily redefine the necessary environment variables (they are prefixed with POSTGRES_) in the docker-compose.yaml file for jtt-webapp service to point to their external database.
- Ensure that the Docker daemon is running before executing the scripts.
- The `proxy` service is used to handle SSL termination and forward requests to the web application service. Ensure that the certificates and keys are correctly configured in the `proxy` directory.
- Adjustments may be required based on specific deployment environments and additional requirements.
- If you want Time Tracker jira plugin to write logs to a separate file and not the main jira log file, add the content of to the `log4j.properties` file to the corresponding file in your jira installation.
- For updating the web application service, you can run the `./timetracker.sh update` command. This will pull the latest image from the repository and restart the service.