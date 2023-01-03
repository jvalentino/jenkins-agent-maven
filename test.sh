#!/bin/bash
set -x
docker compose run --rm jenkins_agent_maven sh -c "cd workspace; ./test.sh"