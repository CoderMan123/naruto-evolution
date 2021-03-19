![Build](https://github.com/lavenblade/project-evolution/actions/workflows/build.yml/badge.svg)
![Deploy](https://github.com/lavenblade/project-evolution/actions/workflows/deploy.yml/badge.svg)

# Project Evolution

## Setup Development Environment
### Prerequisites
Before you can setup a development environment, you need to make sure that you have the following dependancies installed.
- [Git](https://git-scm.com/)
- [Git LFS](https://git-lfs.github.com/)

#### Windows Installation
Use the download links listed above.

#### Linux Installation
Use your distrobutions package manager.

##### Debian / Ubuntu
`sudo apt install git git-lfs`

##### CentOS / Fedora
`yum install git git-lfs`

##### Arch / Manjaro
`pacman -Syu git git-lfs`

### Setup

1) Clone the repository:
```sh
git clone https://github.com/lavenblade/project-evolution.git
```

2) Switch to preferred branch:
   * v2: `master` / `develop`
   * v1: `master-v1` / `develop-v1`
```sh
git checkout <branch>
```

3) Initialize and checkout submodules:
```sh
git submodule init
git submodule update --recursive
```