import logging
import json
import requests
from datetime import datetime

class LokiHandler(logging.Handler):
    def __init__(self, loki_url):
        super().__init__()
        self.loki_url = loki_url

    def emit(self, record):
        # Format the log record into the structure expected by Loki
        log_entry = {
            "streams": [
                {
                    "stream": {
                        "level": record.levelname,
                        "logger": record.name
                    },
                    "values": [
                        [f"{int(datetime.now().timestamp() * 1e9)}", self.format(record)]
                    ]
                }
            ]
        }

        # Send the log record to Loki
        response = requests.post(self.loki_url, data=json.dumps(log_entry), headers={'Content-type': 'application/json'})
        if response.status_code not in [200, 204]:
            print(f"Failed to send log to Loki: {response.text}")

########################################
loki_url = "http://lnqlstinfra1.ms.com:3100/loki/api/v1/push"  # Your Loki URL

# Set up Python logging
logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

# Create and add the Loki handler
loki_handler = LokiHandler(loki_url)
logger.addHandler(loki_handler)

# Optional: Set the format of the log messages
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
loki_handler.setFormatter(formatter)

#####################################
logger.info("This is an info message")
logger.debug("This is a debug message")
