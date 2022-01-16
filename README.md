[![Release (Live)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release.yml/badge.svg?branch=master)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release.yml)
[![Release (Beta)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release-beta.yml/badge.svg?branch=master)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release-beta.yml)
[![Release (Alpha)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release-alpha.yml/badge.svg?branch=develop)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release-alpha.yml)
[![Manual Deployment](https://github.com/lavenblade/naruto-evolution/actions/workflows/manual-deployment.yml/badge.svg)](https://github.com/lavenblade/naruto-evolution/actions/workflows/manual-deployment.yml)

[![Open in Visual Studio Code](https://open.vscode.dev/badges/open-in-vscode.svg)](https://open.vscode.dev/lavenblade/naruto-evolution)


# Naruto Evolution

A fan inspired online game based on the Naruto Universe.

## Setup Development Environment

### Prerequisites

Before you can setup a development environment, you need to make sure that you have the following dependencies installed.
- [Git](https://git-scm.com/)
- [Git LFS](https://git-lfs.github.com/)

**Windows Installation**

Install using the Windows package manager.

```powershell
winget install Git.Git
winget install GitHub.GitLFS
git lfs install
```

**Linux Installation**

Install using your distributions package manager.

- **Debian / Ubuntu:**
```sh
sudo apt install git git-lfs
git lfs install
```

- **CentOS / Fedora:**
```
yum install git git-lfs
git lfs install
```

- **Arch / Manjaro:**
```
pacman -Syu git git-lfs
git lfs install
```

**Configure Git**

```powershell
git config --global user.name "Full Name"
git config --global user.email "email@address.com"
git config --global pull.rebase true
```

### Clone Project

1) **Clone the repository:**

```sh
git clone https://github.com/IllusiveBIair/Naruto-Evolution.git
```

2) **Switch to preferred branch:**

```sh
git checkout develop
```

- **release**: This is the current release branch and automatically deploys to the beta testing environment.

- **develop**: This is the current development branch and automatically deploys to the alpha testing environment.

3) **Initialize and checkout submodules:**

```sh
git submodule init
git submodule update --recursive
```
