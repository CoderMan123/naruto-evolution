[![Build](https://github.com/douglasparker/naruto-evolution/actions/workflows/build.yml/badge.svg)](https://github.com/douglasparker/naruto-evolution/actions/workflows/build.yml)
[![Release](https://github.com/douglasparker/naruto-evolution/actions/workflows/release.yml/badge.svg)](https://github.com/douglasparker/naruto-evolution/actions/workflows/release.yml)

> :warning: This project is no longer maintained. We recommend the following [fork](https://github.com/Aeiwik/naruto-evolution).

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

```sh
sudo apt install git git-lfs
git lfs install
```

**Configure Git**

```powershell
git config --global user.name "Full Name"
git config --global user.email "email@address.com"
git config --global pull.rebase true
git config --global submodule.recurse true
git config --global diff.submodule log
```

### Project Setup

1) **Clone the repository:**

```sh
git clone https://github.com/lavenblade/naruto-evolution.git
```

2) **Initialize and checkout submodules:**

```sh
git submodule update --init --recursive
```
