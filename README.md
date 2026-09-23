# Auto configuração de sistema operacional

![debian-logo](https://www.debian.org/Pics/debian-logo-1024x576.png)

Este repositório contém minha configuração personalizada do Debian, partindo sempre de uma instalação "minimal" (ou seja, apenas o kernel e os pacotes essenciais, sem software pré-instalado). Os scripts aqui presentes facilitam a configuração do Desktop Environment GNOME e a instalação da coleção de programas que uso diariamente.

Os "shell scripts" apresentados são divididos em três partes principais:
1. **Configuração inicial:**
   - Configuração do gerenciador de pacotes **Flatpak** e sua loja **Flathub**.
   - Configuração do firewall **UFW** para garantir a segurança do sistema.
   - *(Esta etapa está posicionada no início porque exige a inserção da senha do usuário e é essencial para o sistema estar seguro desde o início).*
2. **Instalação dos pacotes e aplicativos essenciais:**
   - Instalação de todos os softwares necessários para o uso diário do sistema.
3. **Instalação de pacotes via "Distrobox":**
   - Utilização do "Distrobox" para instalar aplicativos provenientes do repositório do **Arch Linux**.

Adicionalmente o repositório também contem minha configuração da aplicação **"DOOM EMACS"** que uso para tomar notas acadêmicas.