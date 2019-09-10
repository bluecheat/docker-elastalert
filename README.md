
## Elastalert Docker Image (elasticsearch >=7.0 version)

Docker image with Elastalert on Ubuntu18.04 

DockerHub - https://quay.io/repository/itsinil/elastalert

```
es_username: elastic
es_password: changeme
```

# Volumes

- /opt/logs       - Elastalert and Supervisord logs will be written to this directory.
- /opt/config     - Elastalert (elastalert_config.yaml) and Supervisord (elastalert_supervisord.conf) configuration files.
- /opt/rules      - Contains Elastalert rules.


# Environment

- ELASTICSEARCH_HOST - IP or hostname for your Elasticsearch host. Defaults to `elasticsearch`.
- ELASTICSEARCH_PORT - Port for your Elasticsearch host. Defaults to `9200`.
- ELASTICSEARCH_USER - Name of user to log into Ealsticsearch with. Leave undefined for no authentication.
- ELASTICSEARCH_PASSWORD - Password to log into Elasticsearch with. Leave undefined for no authentication.
- SLACK_WEBWOOK_URL - WEBWOOK URL to receive slack notification settings.
- SLACK_USERNAME - USERNAME to receive slack notification settings. Defaults to `alert`
- SLACK_CHANNEL - - CHANNEL to receive slack notification settings.  Defaults to `#alert`
- SLACK_EMOJI -  - EMOJI to receive slack notification settings.  Defaults to `:emoji:`