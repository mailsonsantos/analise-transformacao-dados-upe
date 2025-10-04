@echo off
setlocal

echo =======================================================================
echo            Configurador de Ambiente - Análise e Transformação de Dados
echo =======================================================================
echo.
echo Este script ira baixar e configurar as ferramentas necessarias para a aula.

:: URLs
set HOP_URL=https://dlcdn.apache.org/hop/2.15.0/apache-hop-client-2.15.0.zip
set JDK_URL=https://cdn.azul.com/zulu/bin/zulu17.48.15-ca-jdk17.0.10-win_x64.msi
set DOCKER_URL=https://www.docker.com/products/docker-desktop/

:: Nomes dos arquivos
set HOP_ZIP=apache-hop.zip
set JDK_MSI=zulu-jdk17.msi

:: --- Download Apache Hop ---
echo.
echo [1/4] Baixando o Apache Hop...
curl -L -o %HOP_ZIP% %HOP_URL%
if %errorlevel% neq 0 (
    echo ERRO: Nao foi possivel baixar o Apache Hop. Verifique sua conexao.
    goto :eof
)

:: --- Extrair Apache Hop ---
echo.
echo [2/4] Extraindo o Apache Hop...
mkdir apache-hop
tar -xf %HOP_ZIP% -C apache-hop --strip-components=1
del %HOP_ZIP%

:: --- Download Zulu JDK 17 Installer ---
echo.
echo [3/4] Baixando o instalador do Zulu JDK 17 (.msi)...
curl -L -o %JDK_MSI% %JDK_URL%
if %errorlevel% neq 0 (
    echo ERRO: Nao foi possivel baixar o instalador do Zulu JDK.
    goto :eof
)
echo.
echo      ATENCAO: O instalador do Java foi baixado como '%JDK_MSI%'.
echo      Execute este arquivo para instalar o Java e siga o assistente.
echo.
pause

:: --- Instrucoes Docker ---
echo.
echo [4/4] Instalacao do Docker.
echo O script agora abrira o seu navegador para que voce possa baixar e
echo instalar o Docker Desktop. Siga as instrucoes no site.

echo.
echo      ATENCAO: Apos instalar o Docker, talvez seja necessario reiniciar o PC.

echo.
pause
start %DOCKER_URL%

echo.
echo =======================================================================
echo                       Configuracao Concluida!
echo =======================================================================
echo.
echo Proximos passos:
ECHO  1. Execute o arquivo '%JDK_MSI%' que foi baixado para INSTALAR o Java.
ECHO  2. Instale o Docker Desktop (a partir da pagina que abriu).
ECHO  3. Reinicie o computador se for solicitado por alguma das instalacoes.
ECHO  4. Apos tudo instalado, volte para esta pasta em um terminal e execute:
ECHO     docker-compose up -d
ECHO  5. Para usar o Hop, execute o arquivo hop-gui.bat na pasta apache-hop.
echo.

endlocal
pause

:: --- Descompactar Dados.zip se presente ---
if exist "Dados.zip" (
    echo.
    echo [^+] Encontrado 'Dados.zip' - descompactando para .\Dados ...
    powershell -Command "Expand-Archive -LiteralPath 'Dados.zip' -DestinationPath '.' -Force"
    if %errorlevel% equ 0 (
        echo [^+] Descompactacao concluida.
    ) else (
        echo [!] Falha ao descompactar Dados.zip. Verifique se o PowerShell esta disponivel.
    )
) else (
    echo [i] Arquivo 'Dados.zip' nao encontrado; nada a descompactar.
)