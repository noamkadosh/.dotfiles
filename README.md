## Installation

Clone this repository as a bare repo, pass the recursive argument to initialize the submodules as well.

```shell
git clone --bare --recurse-submodules -j8 git@github.com:noamkadosh/.dotfiles.git $HOME/.dotfiles/
```

Then, run the install script.

```shell
source $HOME/.config/install.sh
```

To ignore untracked files and avoid too much noise:
```shell
dots config --local status.showUntrackedFiles no
````
