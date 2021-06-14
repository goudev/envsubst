#!/bin/sh

for i in $(echo ${PLUGIN_FILE} | sed 's/,/ /g'); do
    if [ -f "$i" ]; then
        cat ${PLUGIN_FILE} > /tmp/.tmpfile
        envsubst < /tmp/.tmpfile > ${PLUGIN_FILE}
        if [ ! $? = 0 ]; then
            echo "###### ERRRO ########"
            echo "Não foi possível gravar no arquivo $i para substituir as variáveis.";
            echo "Verifique a permissão no arquivo e tente novamente."
            echo
            echo "ls -la $i" 
            exit 2; 
        fi
    else
        echo "###### ERRRO ########"
        echo "O arquivo (${PLUGIN_FILE}) não foi localizado ou não pode ser lido.";
        echo "Você está executando esse plugin dentro de um container, lembre-se que o caminho informado deve ser relativo."
        echo
        echo "Você está executando esse build no diretório (pwd)"
        echo
        echo "Esses são os arquivo desse diretório: "
        ls -lha
        exit 2;
    fi
done