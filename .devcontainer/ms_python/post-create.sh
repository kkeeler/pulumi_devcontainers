# Convenience workspace directory for later use
WORKSPACE_DIR=$(pwd)

# Workaround dubious ownership issue.
git config --global --add safe.directory ${WORKSPACE_DIR}

pip install -r ${WORKSPACE_DIR}/requirements.txt


echo "Finished Post Creation Happy Coding!"
