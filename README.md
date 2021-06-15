# Plugin Substituidor de variáveis para Drone CI

[![Build Status](https://cloud.drone.io/api/badges/plugindrone/envsubst/status.svg)](https://cloud.drone.io/plugindrone/envsubst)
<a href="https://github.com/plugindrone/envsubst/stargazers">
	<img src="https://img.shields.io/github/stars/plugindrone/envsubst" alt="Stars Badge"/>
</a>
<a href="https://github.com/plugindrone/envsubst/network/members">
	<img src="https://img.shields.io/github/forks/plugindrone/envsubst" alt="Forks Badge"/>
</a>
<a href="https://github.com/plugindrone/envsubst/issues">
	<img src="https://img.shields.io/github/issues/plugindrone/envsubst" alt="Issues Badge"/>
</a>
<a href="https://github.com/plugindrone/envsubst/graphs/contributors">
	<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/plugindrone/envsubst?color=2b9348">
</a>
<a href="https://github.com/plugindrone/envsubst/blob/master/LICENSE">
	<img src="https://img.shields.io/github/license/plugindrone/envsubst?color=2b9348" alt="License Badge"/>
</a>

Este plugin para o Drone, permite que você realize a substituição de variaveis em arquivos. 
A substituição é realizada com base nas variaveis populadas até o momento do step. 

* settings.file: representa os arquivos a terem as variaveis substituidas em seu conteudo;
* file_env: Parametro opicional, permite especificar um ou mais arquivos adicionais de environments que precisam ser consideradas na substituição do conteúdo.
## Drone Pipeline
```yaml
steps:

- name: envsubst
  image: plugindrone/envsubst
  settings:
  + file_env: '.env'
    file: 
    - "arquivo1"
    - "arquivo2"
    - "arquivo3"
```
Imporante, o Drone passa a lista de arquivos através de uma variável chamada ${DRONE_FILE}. Toda a lista de arquivos vem separada por virgula, por exemplo:
DRONE_FILE=arquivo1,arquivo2,arquivo3

O entrypoint utiliza uma expressão através do comando sed para separar esses arquivos baseado na virgula, então você deve evitar a utilização de virgulas no nome dos seus arquivos, pois certamente o parse deles vai acabar falhando.

Considere as mesmas resalvas para o parametro file_env caso você especifique mais de um arquivo.

## Executando o plugin manualmente

```shell
docker run --rm \
  -e PLUGIN_FILE="caminho-relativo-do-arquivo" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  plugindrone/envsubst
```