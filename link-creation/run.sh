#!/bin/bash

# Copyright (C) 2024 Devexperts Solutions IE Limited
# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

#########################################################################
echo '[LOG] Create config.properties file'

echo 'consumer_key='$1 > config.properties
echo 'jira_home='$2 >> config.properties
echo 'private_key='$3 >> config.properties

echo '[LOG] Configuration properties file created'
echo '[TEST LOG] Content of config.properties'
cat config.properties
echo '\n'
#########################################################################
echo '[LOG] Get Request token'
java -jar OAuthClient-1.0.jar requestToken $2
echo '\n'
#########################################################################
echo '[LOG] Define requestToken variable'
requestToken=$(grep request_token config.properties | cut -d= -f 2)
echo '[TEST LOG] Request token is: '$requestToken
echo '\n'
#########################################################################
echo '[LOG] END'
#########################################################################
