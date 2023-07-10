#!/bin/sh

set -e

PR_AMPLIFY_URL=$1

echo "URL REPASSADA ---> $PR_AMPLIFY_URL"

# wget -q --spider $B_UPR_AMPLIFY_URLRL

status_code=$(curl --write-out '%{http_code}' --silent --output /dev/null $PR_AMPLIFY_URL)

#if [ $? -ne 0 ] ; then
#  echo "URL $PR_AMPLIFY_URL nao existente"
#fi

start_time=$(date +%s)
end_time=$((start_time + 120))  # Tempo de execução de 2 minutos (120 segundos)

while [[ $(date +%s) -lt $end_time ]]; do
    response=$(curl -s -o /dev/null -w "%{http_code}" $PR_AMPLIFY_URL)
    
    if [[ "$response" -ne 200 ]]; then
      echo "HTTP code $response, retentativa em 20s...!"
      sleep 20s  # Intervalo de 20 segundos entre as iterações
    else
      if [ -z "$GITHUB_TOKEN" ]; then
        echo "Skipping comment as GITHUB_TOKEN not provided!"
      else
        curl -X POST $COMMENT_URL -H "Content-Type: application/json" -H "Authorization: token $GITHUB_TOKEN" --data '{ "body": "'"Preview branch generated at $PR_AMPLIFY_URL"'" }'
      fi
      exit 0
    fi
done

# if [[ "$status_code" -ne 200 ]] ; then
#   echo "Status do site mudou para $status_code"
# else
#   echo "Nada aconteceu <<<<< $status_code"
#   exit 0
# fi
