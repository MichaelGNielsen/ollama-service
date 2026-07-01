# Ollama Service — Gemma 4

Lokal Ollama-service der kører Google Gemma 4-modeller (4B, 12B, 26B, 31B) med fuld native kontekst. Servicen lytter på port **11434**. Kører som systemd-service under brugeren `ollama` med modeller der aldrig afloades (`OLLAMA_KEEP_ALIVE=-1`).

## Dokumentation

- [AGENTS.md](AGENTS.md) — opsætning, scripts og kommandoer
- [docs/](docs/) — detaljeret dokumentation

## Hurtig start

```bash
# se loadede modeller
curl -s http://127.0.0.1:11434/api/tags | grep -o '"name":"[^"]*"'

# curl test
curl -X POST http://127.0.0.1:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{"model":"gemma4","prompt":"Hej, svar med ordet test","stream":false}'

# check loadede modeller i ollama
ollama ps
```
