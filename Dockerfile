# Use uma imagem base do Debian
FROM debian:stable-slim

# Atualize os pacotes do sistema
RUN apt-get update

# Instale as dependências necessárias para o GBPCEFwr64.deb
RUN apt-get install -y wget gpg libnss3 libnspr4 libatk1.0-0 libc6 libcairo2 libdbus-1-3 libdbus-glib-1-2 libfontconfig1 libfreetype6 libgcc1 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk2.0-0 libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxtst6 zlib1g zenity python3

# Baixe o arquivo GBPCEFwr64.deb diretamente do link
RUN wget -O /GBPCEFwr64.deb https://cloud.gastecnologia.com.br/cef/warsaw/install/GBPCEFwr64.deb

# Extraia o conteúdo do pacote GBPCEFwr64.deb
RUN dpkg-deb -R /GBPCEFwr64.deb /tmp/warsaw
RUN mv /tmp/warsaw/DEBIAN/postinst /tmp/warsaw/DEBIAN/postinst.backup
RUN echo '#!/bin/sh' > /tmp/warsaw/DEBIAN/postinst
RUN echo 'exit 0' >> /tmp/warsaw/DEBIAN/postinst
RUN chmod 755 /tmp/warsaw/DEBIAN/postinst
RUN dpkg-deb -b /tmp/warsaw /GBPCEFwr64-fixed.deb

# Instale o pacote GBPCEFwr64-fixed.deb
RUN dpkg -i /GBPCEFwr64-fixed.deb
RUN apt-get install -y -f

# Remova os arquivos GBPCEFwr64.deb e GBPCEFwr64-fixed.deb
RUN rm /GBPCEFwr64.deb /GBPCEFwr64-fixed.deb

# Instale o Chromium diretamente dos repositórios do Ubuntu
RUN apt-get install -y chromium

# Crie um usuário não privilegiado
RUN useradd -m chromeuser

# Defina o usuário padrão para o novo usuário
USER chromeuser

# Defina o comando padrão para iniciar o Chromium (pode ser alterado conforme necessário)
CMD ["chromium", "--no-sandbox"]
