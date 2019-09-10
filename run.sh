#!/bin/bash

set -ex

export ELASTICSEARCH_HOST=${ELASTICSEARCH_HOST:-elasticsearch}
export ELASTICSEARCH_PORT=${ELASTICSEARCH_PORT:-9200}
export ELASTICSEARCH_TLS=${ELASTICSEARCH_TLS:-False}
export ELASTICSEARCH_TLS_VERIFY=${ELASTICSEARCH_TLS_VERIFY:-False}

export ELASTICSEARCH_USER=${ELASTICSEARCH_USER:""}
export ELASTICSEARCH_PASSWORD=${ELASTICSEARCH_PASSWORD:""}

export SLACK_WEBWOOK_URL=${SLACK_WEBWOOK_URL:-""}
export SLACK_USERNAME=${SLACK_USERNAME:-"ALERT"}
export SLACK_CHANNEL=${SLACK_CHANNEL:-#alert}
export SLACK_EMOJI=${SLACK_EMOJI:-:emoji:}
export GLOBAL_TEXT=${GLOBAL_TEXT:-""}


# config replace params
sed -i 's/${ELASTICSEARCH_HOST}/'${ELASTICSEARCH_HOST}'/' ${ELASTALERT_CONFIG}
sed -i 's/${ELASTICSEARCH_PORT}/'${ELASTICSEARCH_PORT}'/' ${ELASTALERT_CONFIG}
sed -i 's/${ELASTALERT_INDEX}/'${ELASTALERT_INDEX}'/' ${ELASTALERT_CONFIG}
sed -i 's/${RULES_DIR}/\/opt\/rules/' ${ELASTALERT_CONFIG}

# rules replace params
find ${RULES_DIR} -type f -name "*.yaml"  -exec sed -i 's#${SLACK_WEBWOOK_URL}#'${SLACK_WEBWOOK_URL}'#' {} \;
find ${RULES_DIR} -type f -name "*.yaml"  -exec sed -i 's/${SLACK_USERNAME}/'${SLACK_USERNAME}'/' {} \;
find ${RULES_DIR} -type f -name "*.yaml"  -exec sed -i 's/${SLACK_CHANNEL}/'${SLACK_CHANNEL}'/' {} \;
find ${RULES_DIR} -type f -name "*.yaml"  -exec sed -i 's/${SLACK_EMOJI}/'${SLACK_EMOJI}'/' {} \;
find ${RULES_DIR} -type f -name "*.yaml"  -exec sed -i 's#${GLOBAL_TEXT}#'${GLOBAL_TEXT}'#' {} \;

echo "Creating Elastalert index in Elasticsearch..."
elastalert-create-index \
      --host "${ELASTICSEARCH_HOST}" \
      --port "${ELASTICSEARCH_PORT}" \
      --config "${ELASTALERT_CONFIG}" \
      --index "${ELASTALERT_INDEX}"
elastalert  \
      --config "${ELASTALERT_CONFIG}"
