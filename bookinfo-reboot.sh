#!/bin/bash

set -eEo pipefail

THIS_SCRIPT_DIR="$(cd $(dirname ${BASH_SOURCE}); pwd)"
INTERVAL=${INTERVAL:-"1200"}
DEBUG="${DEBUG:-false}"
if [ "${DEBUG}" == "true" ];
then
    SET_DEBUG="-x"
else
    SET_DEBUG="+x"
fi
set ${SET_DEBUG}

function restartPods {
  if [ $# -lt 2 ]; then
    echo "usage: ${0} <namespace-array> <deployment-array>"
    return 1
  fi

  namespaces=("${!1}")
  deployments=("${!2}")
  for namespace in "${namespaces[@]}"; do
    for deployment in "${deployments[@]}"; do
      echo "restarting deployment/${deployment}.${namespace}"
      kubectl rollout restart deployment ${deployment} -n ${namespace} || true
      kubectl rollout status deployment ${deployment} -n ${namespace} || true
    done
  done
}

allNamespaces=($(kubectl get namespaces -o jsonpath='{$.items[*].metadata.name}'))
deployments=("productpage-v1" "details-v1" "reviews-v1" "reviews-v2" "reviews-v3" "ratings-v1")
restartPods allNamespaces[@] deployments[@]
