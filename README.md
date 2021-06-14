# Plugin Substituidor de variáveis para Drone CI

[![Build Status](https://cloud.drone.io/api/badges/gou-dev/semantic-release/status.svg)](https://cloud.drone.io/gou-dev/semantic-release)

Este plugin para o Drone, permite que você realize a substituição de variaveis em arquivos. 
A substituição é realizada com base nas variaveis populadas até o momento do step. 

## Drone Pipeline
```yaml
steps:

- name: envsubst
  image: plugindrone/envsubst
  settings:
    file: 
    - "arquivo1"
    - "arquivo2"
    - "arquivo3"
```
Imporante, o Drone passa a lista de arquivos através de uma variável chamada ${DRONE_FILE}. Toda a lista de arquivos vem separada por virgula, por exemplo:
DRONE_FILE=arquivo1,arquivo2,arquivo3

O entrypoint utiliza uma expressão através do comando sed para separar esses arquivos baseado na virgula, então você deve evitar a utilização de virgulas no nome dos seus arquivos, pois certamente o parse deles vai acabar falhando.

## Executando o plugin manualmente

```
docker run --rm \
  -e PLUGIN_FILE="caminho-relativo-do-arquivo" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  goudev/envsubst
```