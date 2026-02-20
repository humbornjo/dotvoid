# yamao's Dotfiles

Main dotfiles repository [link](https://github.com/humbornjo/dotfiles)

## Proxy

[Clash-Meta](https://hub.docker.com/r/yikyo/clash.meta)

```bash
sudo mkdir -p /etc/.clash.meta.d

sudo cp config.yaml /etc/.clash.meta.d/

# core
docker run --name clash -d \
    -p 7890:7890 \
    -p 7891:7891 \
    -p 7892:7892 \
    -p 9090:9090 \
    -v /etc/.clash.meta.d:/etc/.clash.meta.d \
    yikyo/clash.meta

# dashboard
docker run -p 9091:80 --name yacd -d haishanh/yacd
```

## Docker

```bash
sudo mkdir -p /etc/docker
echo '{ "registry-mirrors": [ "https://dockerproxy.net" ] }' | sudo tee /etc/docker/daemon.json
sudo sv restart docker
```

## Kubernetes

`k3d` requires config file to pull images in China Mainland

```bash
k3d cluster create --config k3d-config.yaml
```

[config](https://k3d.io/v5.6.3/usage/configfile/) file is like follows:

```yaml
# k3d-config.yaml
apiVersion: k3d.io/v1alpha5
kind: Simple
metadata:
  name: k3d-default
registries:
  config: |
    mirrors:
      "docker.io":
        endpoint:
          - https://dockerproxy.net
```

## Hardware

- Laptop: macbook air (14-inch, 2022, Apple M2 Chip, 16GB RAM)
- Mouse: Logitech MX Master 3S
- Keyboard:
  - Logitech MX Keys M
  - HHKB Professional Bluetooth
