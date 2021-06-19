[![Release (Live)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release.yml/badge.svg?branch=master)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release.yml)
[![Release (Beta)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release-beta.yml/badge.svg?branch=master)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release-beta.yml)
[![Release (Alpha)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release-alpha.yml/badge.svg?branch=develop)](https://github.com/lavenblade/naruto-evolution/actions/workflows/release-alpha.yml)
[![Manual Deployment](https://github.com/lavenblade/naruto-evolution/actions/workflows/manual-deployment.yml/badge.svg)](https://github.com/lavenblade/naruto-evolution/actions/workflows/manual-deployment.yml)


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
winget install git
winget install git-lfs
```

**Linux Installation**

Install using your distributions package manager.

- **Debian / Ubuntu:**
`sudo apt install git git-lfs`

- **CentOS / Fedora:**
`yum install git git-lfs`

- **Arch / Manjaro:**
`pacman -Syu git git-lfs`

### Clone Project
1) **Clone the repository:**
```sh
git clone https://github.com/lavenblade/naruto-evolution.git
```

2) **Switch to preferred branch:**
   * `master`: This is the current release branch and automatically deploys to the beta testing environment.
   * `develop`: This is the current development branch and automatically deploys to the alpha testing environment.

```sh
git checkout <branch>
```

3) **Initialize and checkout submodules:**
```sh
git submodule init
git submodule update --recursive
```