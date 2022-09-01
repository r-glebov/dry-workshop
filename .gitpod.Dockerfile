FROM gitpod/workspace-full
USER gitpod

RUN sudo install-packages ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config

RUN _ruby_version=ruby-2.7.3 \
    && printf "rvm_gems_path=/home/gitpod/.rvm\n" > ~/.rvmrc \
    && bash -lc "rvm reinstall ruby-${_ruby_version} && rvm use ruby-${_ruby_version} --default && gem install rails" \
    && printf "rvm_gems_path=/workspace/.rvm" > ~/.rvmrc \
    && printf '{ rvm use $(rvm current); } >/dev/null 2>&1\n' >> "$HOME/.bashrc.d/70-ruby"

RUN cd $HOME && git clone https://github.com/neovim/neovim.git
#RUN cd $HOME/neovim && git checkout release-0.7 && make CMAKE_BUILD_TYPE=RelWithDebInfo install
RUN cd $HOME/neovim && git checkout release-0.7 && sudo make -j4 && sudo make CMAKE_BUILD_TYPE=Release && sudo make install
