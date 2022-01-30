# Inception
docker-composeを用いて`nginx` + `WordPress(php-fpm)` + `mariadb` の3つのコンテナを接続し、WordPressの実行環境を作成する。


## 実行環境
```bash
# OS
＄grep -H "" /etc/*version ; grep -H "" /etc/*release
/etc/debian_version:buster/sid
/etc/lsb-release:DISTRIB_ID=Ubuntu
/etc/lsb-release:DISTRIB_RELEASE=18.04
/etc/lsb-release:DISTRIB_CODENAME=bionic
/etc/lsb-release:DISTRIB_DESCRIPTION="Ubuntu 18.04.6 LTS"
/etc/os-release:NAME="Ubuntu"
/etc/os-release:VERSION="18.04.6 LTS (Bionic Beaver)"
/etc/os-release:ID=ubuntu
/etc/os-release:ID_LIKE=debian
/etc/os-release:PRETTY_NAME="Ubuntu 18.04.6 LTS"
/etc/os-release:VERSION_ID="18.04"
/etc/os-release:HOME_URL="https://www.ubuntu.com/"
/etc/os-release:SUPPORT_URL="https://help.ubuntu.com/"
/etc/os-release:BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
/etc/os-release:PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
/etc/os-release:VERSION_CODENAME=bionic
/etc/os-release:UBUNTU_CODENAME=bionic

#docker
$ docker version
 docker version
Client:
 Version:           20.10.7
 API version:       1.41
 Go version:        go1.13.8
 Git commit:        20.10.7-0ubuntu5~18.04.3
 Built:             Mon Nov  1 01:04:14 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server:
 Engine:
  Version:          20.10.7
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.8
  Git commit:       20.10.7-0ubuntu5~18.04.3
  Built:            Fri Oct 22 00:57:37 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.5.5-0ubuntu3~18.04.1
  GitCommit:        
 runc:
  Version:          1.0.1-0ubuntu2~18.04.1
  GitCommit:        
 docker-init:
  Version:          0.19.0
  GitCommit:

# docker-compose
$ docker-compose version
docker-compose version
docker-compose version 1.29.2, build 5becea4c
docker-py version: 5.0.0
CPython version: 3.7.10
OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019
```

## 使い方
```bash
$ git clone https://github.com/public-jun/Inception.git

# 起動コマンド
$ make
```
`/home`配下に新しいディレクトリを作成し`/etc/hosts`に新しいhostnameを追加するため、`管理者権限`が必要です
```bash
# 停止コマンド
$ make clean
```
```bash
# 停止 && ボリューム削除
$ make fclean
```
```bash
# コンテナ一覧
$ make ps
```
```bash
# logを確認
$ make logs
```


## 構成図
![inception.drawio](https://github.com/public-jun/Inception/blob/main/Untitled%20Diagram.svg)
