# ========= Homebrew ========== #
echo "=============== Installing Homebrew =============="
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# ========= Curl ========== #
echo "=============== Installing Curl =============="
brew install curl

# ========= Git ========== #
echo "=============== Installing Git =============="
brew install git
# show git date with ISO standard and local time
git config --global log.date iso-local

# ========= vim ========== #
echo "=============== Installing vim =============="
brew install vim

# ========= rsync ========== #
brew install rsync

# ========= Ag ========== #
echo "=============== Installing Ag =============="
brew install the_silver_searcher

# ========= Settings repo ========== #
echo "=============== Copying settings repo from https://github.com/k-a-u-s-h-i-k/settings.git =============="
git clone https://github.com/k-a-u-s-h-i-k/settings.git ~/.settings
cd ~/.settings
#switch to the coop branch
git checkout coop


# ========= Zsh ========== #
echo "=============== Installing zsh =============="
brew install zsh

# ========= Oh-my-zsh ========== #
echo "=============== Installing Oh-my-zsh =============="
curl https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh > oh.sh
chmod +x oh.sh
./oh.sh
rm -f ./oh.sh
#Add additional plugins for ZSH not found in oh-my-zsh
git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/marzocchi/zsh-notify.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/notify
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# ========= Setting up soft links ========== #
echo "=============== Setting up soft links =============="
ln -s ~/.settings/vimrc ~/.vimrc
echo "\"Add your custom vim settings to this file" > ~/.myvimrc
echo "#Add your custom zsh settings to this file" > ~/.myzshrc
mv ~/.zshrc ~/.zshrc.orig.ohmyzsh
ln -s ~/.settings/zshrc ~/.zshr

# ========= Setting up cscope ========== #
echo "=============== Setting up cscope =============="
if [ ! -d ~/.vim ]; then
	mkdir ~/.vim #if ~/.vim dir doesn't exist, create it
fi
if [ ! -d ~/.vim/plugin ]; then
	mkdir ~/.vim/plugin #if plugin dir doesn't exist, create it
fi
cd ~/.vim/plugin
curl -O http://cscope.sourceforge.net/cscope_maps.vim
cd - # go back to the previous directory

# ========= Install wget ========== #
echo "=============== Install wget =============="
brew install wget

echo "=============== Downloading badwolf theme ====================="
if [ ! -d ${HOME}/.vim/colors ]; then
    mkdir ${HOME}/.vim/colors
fi
cd ${HOME}/.vim/colors
curl -O https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim
cd -

echo "=============== Setting up Makefile ftplugin ==============="
if [ ! -d ~/.vim/ftplugin ]; then
	mkdir ~/.vim/ftplugin
fi
cd ~/.vim/ftplugin
#do not expand tabs in a makefile
echo "setlocal noexpandtab" > make.vim
cd -

output "=============== Setup Go directories ==============="
if [ ! -d ~/.go-dirs ]; then
    mkdir ~/.go-dirs
fi

#open vim once to install Plug
vim +qall
#open vim now to install all plugins
vim "+PlugInstall --sync" +qall

output "=============== Install custom font ==============="
mkdir /tmp/powerline
cd /tmp/powerline
git clone https://github.com/powerline/fonts.git
cd fonts
#install all fonts
./install.sh

wget -P ${HOME}/.local/share/fonts https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/MesloLGS%20NF%20Regular.ttf


# ========= Install powerlevel10k theme ========== #
echo "=============== Install powerlevel10k theme, the best theme ever! =============="
brew install romkatv/powerlevel10k/powerlevel10k
echo 'source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
echo "RESTART terminal and run: p10k configure"

