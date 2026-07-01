#!/bin/bash

# ==========================================================
#  Ollama Service Cleanup Script
#  Frigør plads fra gamle Docker Ollama installationer
# ==========================================================

echo "Stopper eventuelle rester af Ollama Docker containere..."
docker ps -a --filter "name=ollama" -q | xargs -r docker stop
docker ps -a --filter "name=ollama" -q | xargs -r docker rm

echo "Sletter gamle Ollama Docker volumes (frigør ca. 100GB)..."
if docker volume ls -q | grep -q "^ollama_ollama_data$"; then
    docker volume rm ollama_ollama_data
    echo "[OK] ollama_ollama_data slettet."
else
    echo "[!] ollama_ollama_data ikke fundet."
fi

if docker volume ls -q | grep -q "^ollama$"; then
    docker volume rm ollama
    echo "[OK] ollama volume slettet."
else
    echo "[!] ollama volume ikke fundet."
fi

echo ""
echo "Vil du køre en generel Docker oprydning? (sletter ubrugte images og cache)"
echo "Kør manuelt: docker system prune -a --volumes"

echo ""
echo "Nuværende diskplads brugt af Docker:"
docker system df
