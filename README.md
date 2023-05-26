## Installation

Clone this repository as a bare repo.

```shell
git clone --bare --jobs 8 git@github.com:noamkadosh/.dotfiles.git $HOME/.dotfiles.git/
```

Checkout `main`.

```shell
/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME checkout main
```

Update submodules.
```shell
/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME submodule update --init
```

To ignore untracked files and avoid too much noise:
```shell
/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME config --local status.showUntrackedFiles no
````

Then, run the install script.

```shell
source $HOME/.config/install.sh
```
