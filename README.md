# Ambiente de Aula - Análise e Transformação de Dados

Este repositório contém os arquivos e configurações necessários para o ambiente da aula de Análise e Transformação de Dados. Para facilitar a configuração, foram criados scripts que automatizam o download das ferramentas necessárias.

## Pré-requisitos

Os scripts de configuração tentarão instalar o Docker (em sistemas Ubuntu). No entanto, é recomendado que você tenha permissão de administrador (ou `sudo`) em sua máquina.

## 1. Configuração Inicial (Faça apenas uma vez)

Siga as instruções abaixo de acordo com o seu sistema operacional.

### Windows

1.  **Execute o script `setup.bat`:** Dê um clique duplo no arquivo `setup.bat`. O script irá baixar as ferramentas necessárias e fará pausas para que você instale cada uma.
2.  **Instale o Zulu JDK:** O script baixará o arquivo `zulu-jdk17.msi`. Execute este instalador para instalar o Java e siga os passos do assistente.
3.  **Instale o Docker Desktop:** Após a instalação do Java, o script abrirá a página de download do Docker. Baixe e instale o Docker Desktop. Reinicie o computador se for solicitado.


### Linux (Ubuntu) / macOS

1.  **Execute o script de configuração:**
    *   Abra um terminal nesta pasta.
    *   Dê permissão de execução ao script com o comando: `chmod +x setup.sh`
    *   Execute o script: `./setup.sh`
2.  O script fará o download das ferramentas. Para usuários **Ubuntu**, ele tentará instalar o Docker automaticamente (pedirá sua senha `sudo`). Para **outros sistemas**, ele solicitará que você instale o Docker manualmente.

## 2. Gerenciando o Ambiente de Serviços (Docker)

Após a configuração inicial, use os comandos abaixo para iniciar ou parar os serviços de banco de dados (PostgreSQL) e Metabase.

### Para Iniciar o Ambiente

Abra um terminal (PowerShell, Terminal, etc.) nesta pasta e execute o comando abaixo. Os serviços continuarão rodando em segundo plano.

```bash
docker-compose up -d
```

### Para Parar o Ambiente

Quando terminar de usar os serviços, para liberar os recursos da sua máquina, execute no mesmo terminal:

```bash
docker-compose down
```

## 3. Acessando as Ferramentas

*   **Apache Hop:**
    *   **Windows:** Navegue até a pasta `apache-hop` e execute `hop-gui.bat`.
    *   **Linux/macOS:** Navegue até a pasta `apache-hop` e execute `./hop-gui.sh`.
*   **Metabase:**
    *   Com o ambiente Docker iniciado (passo `docker-compose up -d`), acesse [http://localhost:3000](http://localhost:3000) no seu navegador.