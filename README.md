# Chrome-caixa

Chrome-caixa é uma maneira de acessar o internet banking da Caixa sem instalar o GBPCEFwr(Warsaw).

## Inicialização

Da inicialização do docker (pode ser necessário utilizar root):

- Primeiro é necessário buildar a imagem configurada no Dockerfile:

$ `docker build -t chrome-caixa .`

- Em seguida executar a imagem docker com display:

$ `sudo docker run -it --rm --net host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" --volume="/run/dbus:/run/dbus" chrome-caixa`
