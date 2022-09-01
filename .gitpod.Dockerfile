FROM gitpod/workspace-full
USER gitpod

RUN sudo install-packages ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config

RUN cd $HOME && git clone https://github.com/neovim/neovim.git

RUN cd $HOME/neovim && git checkout release-0.7 && sudo make -j4 && sudo make CMAKE_BUILD_TYPE=Release && sudo make install
