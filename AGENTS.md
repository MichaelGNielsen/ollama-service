# Ollama Service — Gemma 4 256k

This repo manages a local Ollama service running Gemma 4 models on port **11434**. Base models from the Ollama registry are used directly with full native context.

## Port & Environment

- Ollama listens on `0.0.0.0:11434` — always set `OLLAMA_HOST=0.0.0.0:11434` before running any `ollama` command.
- The service runs as user `ollama` via systemd (`ollama.service`).
- Key env vars in the unit: `OLLAMA_KEEP_ALIVE=-1` (models never unload), `OLLAMA_NUM_PARALLEL=8`, `OLLAMA_MAX_LOADED_MODELS=2`.

## Models

Base models from the registry: `gemma4`, `gemma4:12b`, `gemma4:26b`, `gemma4:31b`. No custom Modelfiles — use the base images directly for full native context (256K+).

## Scripts

| Script | Purpose |
|---|---|
| `benchmark.sh` | Token throughput benchmark against all 4 models |

Script targets port 11434.

## Common Commands

```bash
# list loaded models
curl -s http://127.0.0.1:11434/api/tags | grep -o '"name":"[^"]*"'

# generate (non-streaming)
curl -X POST http://127.0.0.1:11434/api/generate \
  -H "Content-Type: application/json" \
  -d '{"model":"gemma4","prompt":"Hej, svar med ordet test","stream":false}'

# check loaded models in GPU
ollama ps

# run interactively
ollama run gemma4:31b
```

## Structure

Root directory — no build system, no tests, no linting. A single shell script for benchmarking.
