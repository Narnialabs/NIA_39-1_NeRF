FROM nvidia/cuda:11.3.0-cudnn8-devel-ubuntu18.04

LABEL purpose = 'ubuntu environment 18.04v' \
      last_modified = '22.11.02 / 20:01'

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ Asia/Seoul
ENV PYTHONIOENCODING UTF-8
ENV LC_CTYPE C.UTF-8

WORKDIR /root
RUN apt-get update && apt-get install -y netcat
RUN apt update --fix-missing

RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install -y python3.8 python3-pip


# Update symlink to point to latest
RUN rm /usr/bin/python3 && ln -s /usr/bin/python3.8 /usr/bin/python3
RUN python3 -m pip install --upgrade pip
RUN python3 --version
RUN pip3 --version

RUN apt install yum git curl wget vim zsh net-tools sudo gcc -y
RUN apt-get -y install libgl1-mesa-glx
RUN apt install -y colmap ffmpeg zip

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
RUN echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
RUN echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc
RUN echo "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=111'" >> ~/.zshrc
RUN echo "syntax on\\nfiletype indent plugin on\\nlet python_version_2=1\\nlet python_highlight_all=1\\nset tabstop=8\\nset softtabstop=4\\nset autoindent\nset nu">>~/.vimrc
RUN sudo chsh -s $(which zsh)
RUN apt update

# 파이토치 라이브러리 설치
RUN pip install torch==1.11.0+cu113 torchvision==0.12.0+cu113 torchaudio==0.11.0 --extra-index-url https://download.pytorch.org/whl/cu113
