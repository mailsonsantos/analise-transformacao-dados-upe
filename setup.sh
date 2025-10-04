#!/bin/bash

echo "======================================================================="
echo "       Configurador de Ambiente - Análise e Transformação de Dados     "
echo "======================================================================="
echo
echo "Este script ira baixar e configurar as ferramentas necessarias para a aula."

# URLs
HOP_URL="https://dlcdn.apache.org/hop/2.15.0/apache-hop-client-2.15.0.zip"
JDK_URL="https://cdn.azul.com/zulu/bin/zulu17.48.15-ca-jdk17.0.10-linux_x64.tar.gz"
DOCKER_DOCS_URL="https://docs.docker.com/engine/install/"

# Nomes dos arquivos
HOP_ZIP="apache-hop.zip"
JDK_TAR="zulu-jdk17.tar.gz"

# --- Verificar dependencias ---
for cmd in wget unzip; do
  if ! command -v $cmd &> /dev/null; then
    echo "ERRO: O comando '$cmd' nao foi encontrado. Por favor, instale-o e execute o script novamente."
    echo "Em sistemas baseados em Debian/Ubuntu, use: sudo apt update && sudo apt install $cmd"
    exit 1
  fi
done

# --- Download Apache Hop ---
echo
echo "[1/4] Baixando o Apache Hop..."
wget -q --show-progress -O "$HOP_ZIP" "$HOP_URL"
if [ $? -ne 0 ]; then
    echo "ERRO: Nao foi possivel baixar o Apache Hop. Verifique sua conexao."
    exit 1
fi

# --- Download Zulu JDK 17 ---
echo
echo "[2/4] Baixando o Zulu JDK 17..."
wget -q --show-progress -O "$JDK_TAR" "$JDK_URL"
if [ $? -ne 0 ]; then
    echo "ERRO: Nao foi possivel baixar o Zulu JDK. Verifique sua conexao."
    exit 1
fi

# --- Extrair Arquivos ---
echo
echo "[3/4] Extraindo arquivos..."

echo "     - Extraindo Apache Hop..."
mkdir -p apache-hop
unzip -q "$HOP_ZIP" -d hop-temp
mv hop-temp/*/* apache-hop/
rm -rf hop-temp

echo "     - Extraindo Zulu JDK..."
mkdir -p zulu-jdk-17
tar -xzf "$JDK_TAR" -C zulu-jdk-17 --strip-components=1

# --- Limpeza ---
rm "$HOP_ZIP" "$JDK_TAR"

# --- Instalacao Docker ---
echo
echo "[4/4] Verificando a instalacao do Docker..."

if command -v docker &> /dev/null; then
    echo "Docker ja esta instalado. Otimo!"
else
    # Verifica se o sistema e Ubuntu
    if [ -f /etc/os-release ] && grep -q "Ubuntu" /etc/os-release; then
        echo "Docker nao encontrado. Tentando instalar para Ubuntu..."
        echo "Voce precisara fornecer sua senha de superusuario (sudo)."
        
        sudo apt-get update
        sudo apt-get install -y ca-certificates curl gnupg
        sudo install -m 0755 -d /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        sudo chmod a+r /etc/apt/keyrings/docker.gpg
        
        echo \
          "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
          $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
          sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        
        sudo apt-get update
        sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

        echo "Adicionando seu usuario ao grupo do Docker..."
        sudo usermod -aG docker $USER
        echo "IMPORTANTE: Para usar o Docker sem 'sudo', voce precisa fazer logout e login novamente."

    else
        echo "ATENCAO: O script nao pode instalar o Docker automaticamente no seu sistema operacional."
        echo "Por favor, instale o Docker manualmente seguindo as instrucoes em:"
        echo "$DOCKER_DOCS_URL"
        echo
        read -p "Pressione [Enter] para continuar apos instalar o Docker..."
    fi
fi

echo
echo "======================================================================="
echo "                       Configuracao Concluida!"
echo "======================================================================="
echo
echo "Proximos passos:"
echo " 1. Se voce instalou o Docker agora (e esta no Ubuntu), faca LOGOUT e LOGIN novamente."
ECHO " 2. Volte para esta pasta em um terminal e execute:"
ECHO "    docker-compose up -d"
ECHO " 3. Para usar o Hop, execute ./hop-gui.sh na pasta apache-hop."
echo
