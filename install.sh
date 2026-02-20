# Void Linux
#
# Install void linux with void-installer first.
# INFO: In my case, bios failed to detect the bootloader installed by
# void-installer. So I copy efi file to `BOOT/BOOTX64.efi` manually.

sudo xbps-install -u xbps
sudo xbps-install -Syu

# If not configuring a optimum mirror, do the following:
sudo xbps-install xmirror
sudo xmirror -s https://repo-fastly.voidlinux.org/

# Genisis
sudo xbps-install fish-shell git make stow eza bat vim neovim curl wget

# Install dotfiles
mkdir -p ~/.config
mkdir -p ~/Repository && pushd ~/Repository
GIT_LFS_SKIP_SMUDGE=1 git clone git@github.com:humbornjo/dotvoid.git dotfiles && \
	cd dotfiles && git checkout void-linux

# stow all configs under .config except nvim
rm -rf ~/.config/fish && stow -t ~/.config -d .config/ .

# stow all configs under ~
stow -t ~ .

# AstroNvim
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
git clone --depth 1 https://github.com/AstroNvim/template ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim # AstroNvim initialize

# stow nvim
rm -rf ~/.config/nvim/init.lua ~/.config/nvim/lua && stow -t ~/.config/nvim -d ./.config/nvim .

# enable NOPASSWD wheel group with `sudo visudo`
# check `/etc/sudoers.d/wheel` and enable `NOPASSWD: ALL`

sudo xbps-install tealdeer
sudo xbps-install starship
sudo xbps-install unzip
sudo xbps-install tmux
sudo xbps-install yazi
sudo xbps-install fd
sudo xbps-install tokei
sudo xbps-install fzf
sudo xbps-install direnv
sudo xbps-install zoxide
sudo xbps-install ripgrep
sudo xbps-install tree
sudo xbps-install btop
sudo xbps-install netcat
sudo xbps-install iotop
sudo xbps-install procs
sudo xbps-install fastfetch
sudo xbps-install trash-cli
sudo xbps-install android-tools # adb & fastboot

# programming language
npm install -g bun
sudo xbps-install yarn
sudo xbps-install pnpm
sudo xbps-install uv
sudo xbps-install gcc
sudo xbps-install cmake
sudo xbps-install rustup
sudo xbps-install chicken
fish_add_path /usr/local/go/bin

# refer to :checkhealth snacks
sudo xbps-install ghostscript
sudo xbps-install ImageMagick

# fnm node version manager
curl -fsSL https://fnm.vercel.app/install | bash
fish_add_path $HOME/.local/share/fnm

sudo xbps-install jq yq
sudo xbps-install pgcli

# git
sudo xbps-install github-cli
sudo xbps-install lazygit
sudo xbps-install delta
sudo xbps-install bottom
sudo xbps-install git-lfs
go install github.com/arl/gitmux@latest

#docker
sudo xbps-install docker
sudo ln -s /etc/sv/docker /var/service/
sudo usermod -aG docker $USER

# network management
sudo usermod -aG network $USER

# kubernetes
sudo xbps-install k3d
sudo xbps-install k9s
sudo xbps-install kubectl
sudo xbps-install lazydocker
sudo xbps-install kubernetes-helm

# kubectx and kubens
sudo git clone https://github.com/ahmetb/kubectx /opt/kubectx
sudo ln -s /opt/kubectx/kubectx /usr/local/bin/kubectx
sudo ln -s /opt/kubectx/kubens /usr/local/bin/kubens

sudo xbps-install cowsay lolcat-c fortune-mod

# fish plugin manager
rm $HOME/.config/fish/functions/fisher.fish $HOME/.config/fish/completions/fisher.fish
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | \
	source && fisher install jorgebucaran/fisher
fisher install jorgebucaran/fisher
fisher install edc/bass franciscolourenco/done
chsh -s /usr/bin/fish

# lazyssh
git clone https://github.com/Adembc/lazyssh.git
pushd lazyssh
make build && sudo mkdir -p /opt/lazyssh && sudo mv ./bin/lazyssh /opt/lazyssh/lazyssh
sudo ln -s /opt/lazyssh/lazyssh /usr/local/bin/lazyssh
popd

# sesh
go install github.com/joshmedeski/sesh/v2@latest

# tpm (follow the official tutorial to init)
# INFO: Below git config could screw tpm install, disable it temporarily
# [url "git@github.com:"]
#	  insteadOf = https://github.com/
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.config/tmux/tmux.conf
