# Seneste brug

## Installerede modeller

```
ollama list

NAME                              ID              SIZE      MODIFIED       
ornith:35b                        5a470e0f652c    21 GB     2 minutes ago     
gemini-3-flash-preview:latest     ebade0d31690    -         26 minutes ago    
deepseek-v4-pro:cloud             22bfd5026abd    -         26 minutes ago    
nemotron-3-super:cloud            be3943c5a818    -         36 minutes ago    
gemini-3-flash-preview:cloud      ebade0d31690    -         38 minutes ago    
glm-5.2:cloud                     ce8fd6f94793    -         39 hours ago      
qwen3.6:latest                    07d35212591f    23 GB     46 hours ago      
gemma4:31b                        6316f0629137    19 GB     3 days ago        
llama3.3:latest                   a6eb4748fd29    42 GB     3 days ago              
qwen3-coder:latest                06c1097efce0    18 GB     4 days ago        
loading_ctf/elona_coder:latest    344d863d53b6    8.9 GB    4 days ago        
gemma4:latest                     89b70054091c    9.6 GB    12 days ago       
```

## Aktuelt loadede modeller

```
Ingen modeller loadet i øjeblikket.
```

## Kommandoer

```bash
# pull model
ollama pull gemma4:31b

# list alle modeller
OLLAMA_HOST=127.0.0.1:11434 ollama list

# se loadede modeller i GPU
OLLAMA_HOST=127.0.0.1:11434 ollama ps

# kør interaktivt
OLLAMA_HOST=127.0.0.1:11434 ollama run gemma4:31b

# check Environment
systemctl show ollama --property=Environment >ollama.env

...
# viser 
OLLAMA_HOST=0.0.0.0:11434 
OLLAMA_KEEP_ALIVE=-1 
OLLAMA_NUM_PARALLEL=8 
OLLAMA_MAX_LOADED_MODELS=2

```
