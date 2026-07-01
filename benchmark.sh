#!/bin/bash

# ==========================================================
#  Ollama Service Benchmark v1.3
# ==========================================================

OLLAMA_URL="http://127.0.0.1:11434/api/generate"

# Juster eventuelt navnene herunder, så de matcher dit 'ollama list' output præcist
MODELS=("gemma4" "gemma4:12b" "gemma4:26b" "gemma4:31b")

echo "=========================================================="
echo " Starting Ollama Service Benchmark on NUC5 (Port 11434)"
echo "=========================================================="
printf "%-20s | %-12s | %-15s\n" "Modelnavn" "Status" "Tokens / sek"
echo "----------------------------------------------------------"

for MODEL in "${MODELS[@]}"; do
    PROMPT="Skriv en kort Python-funktion, der beregner det glidende gennemsnit (SMA)."
    
    # Kør opsamling af både HTTP statuskode og respons
    RESPONSE=$(curl -s -w "\nHTTP_STATUS:%{http_code}" -X POST "$OLLAMA_URL" \
        -H "Content-Type: application/json" \
        -d "{
            \"model\": \"$MODEL\",
            \"prompt\": \"$PROMPT\",
            \"stream\": false,
            \"options\": {
                \"num_predict\": 64,
                \"temperature\": 0.0
            }
        }")

    HTTP_STATUS=$(echo "$RESPONSE" | grep "HTTP_STATUS" | cut -d':' -f2)
    RAW_BODY=$(echo "$RESPONSE" | grep -v "HTTP_STATUS")

    # Udtræk variable
    EVAL_COUNT=$(echo "$RAW_BODY" | grep -o '"eval_count":[0-9]*' | cut -d':' -f2)
    EVAL_DURATION=$(echo "$RAW_BODY" | grep -o '"eval_duration":[0-9]*' | cut -d':' -f2)

    if [ "$HTTP_STATUS" -eq 200 ] && [ ! -z "$EVAL_COUNT" ] && [ "$EVAL_DURATION" -gt 0 ]; then
        TOKENS_PER_SEC=$(echo "scale=2; $EVAL_COUNT / ($EVAL_DURATION / 1000000000)" | bc)
        printf "%-20s | %-12s | %-15s\n" "$MODEL" "Succes" "$TOKENS_PER_SEC t/s"
    else
        printf "%-20s | %-12s | %-15s\n" "$MODEL" "FEJL (HTTP $HTTP_STATUS)" "N/A"
        echo "--> RAW ERROR RESP: $RAW_BODY"
        echo "----------------------------------------------------------"
    fi

    sleep 1
done

echo "Service-benchmark færdig!"
