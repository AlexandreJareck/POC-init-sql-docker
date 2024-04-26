## Para construir a imagem, executar o seguinte comando:
 - docker build -t <nomeimagem> .

## Para executar:
 - docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=YourStrong!Passw0rd' --user 10001:0 -p 1433:1433 --name <nomecontainer> <nomeimagem>

--user 10001:0 Define Permissões de acesso para usuario.
