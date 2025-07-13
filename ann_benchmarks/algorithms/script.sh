#!/usr/bin/env bash
set -euo pipefail

exclude=(pgvector pgvecto_rs pgvectorscale qdrant weaviate opensearchknn \
         elasticsearch elastiknn milvus faiss faiss_hnsw vespa)

for dir in */; do
  alg=${dir%/}
  file="${dir}config.yml"

  if [[ -f "$file" ]] && [[ ! " ${exclude[*]} " =~ " ${alg} " ]]; then
    sed -E -i.bak 's/^([[:space:]]*)disabled:[[:space:]]*false/\1disabled: true/' "$file"
    rm -f "${file}.bak"
    echo "Updated $file"
  else
    echo "Skipped $file"
  fi
done
