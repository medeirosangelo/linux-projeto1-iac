#!/bin/bash

echo "Criando diretórios..."

# Verificar se os diretórios já existem antes de tentar criá-los
[ ! -d /publico ] && mkdir /publico
[ ! -d /adm ] && mkdir /adm
[ ! -d /ven ] && mkdir /ven
[ ! -d /sec ] && mkdir /sec

echo "Criando grupos de usuários..."

# Verificar se os grupos já existem antes de tentar criá-los
getent group GRP_ADM >/dev/null || groupadd GRP_ADM
getent group GRP_VEN >/dev/null || groupadd GRP_VEN
getent group GRP_SEC >/dev/null || groupadd GRP_SEC

echo "Criando usuários..."

# Função para criar usuários
criar_usuario() {
    local nome=$1
    local grupo=$2
    local senha=$3
    if ! id "$nome" &>/dev/null; then
        useradd $nome -m -s /bin/bash -G $grupo
        echo "$nome:$senha" | chpasswd
        passwd -e $nome
        echo "Usuário $nome criado com sucesso."
    else
        echo "Usuário $nome já existe."
    fi
}

# Criar usuários para o grupo GRP_ADM
criar_usuario "carlos" "GRP_ADM" "Senha123"
criar_usuario "maria" "GRP_ADM" "Senha123"
criar_usuario "joao" "GRP_ADM" "Senha123"

# Criar usuários para o grupo GRP_VEN
criar_usuario "debora" "GRP_VEN" "Senha123"
criar_usuario "sebastiana" "GRP_VEN" "Senha123"
criar_usuario "roberto" "GRP_VEN" "Senha123"

# Criar usuários para o grupo GRP_SEC
criar_usuario "josefina" "GRP_SEC" "Senha123"
criar_usuario "amanda" "GRP_SEC" "Senha123"
criar_usuario "rogerio" "GRP_SEC" "Senha123"

echo "Atribuindo permissões aos diretórios..."

# Ajustar as permissões dos diretórios
chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 770 /adm
chmod 770 /ven
chmod 770 /sec
chmod 777 /publico

echo "Configuração finalizada."
