function containerdev-start {
  [[ -d .containerdev ]] || [[ -d .containerdev-public ]] && return 1
  mkdir .containerdev
  echo 'FROM registry.fedoraproject.org/fedora:latest' >> .containerdev/Dockerfile
  echo 'MAINTAINER Rick Elrod <relrod@redhat.com>' >> .containerdev/Dockerfile
  echo >> .containerdev/Dockerfile
  echo 'RUN dnf -y install \' >> .containerdev/Dockerfile
  echo '    vim git \' >> .containerdev/Dockerfile
  echo '    ' >> .containerdev/Dockerfile
  echo >> .containerdev/Dockerfile
  echo 'VOLUME /project' >> .containerdev/Dockerfile
  echo >> .containerdev/Dockerfile
  echo 'WORKDIR /project' >> .containerdev/Dockerfile
}

function containerdev {
  if [[ ! -d .containerdev ]] && [[ ! -d .containerdev-public ]]; then
    echo 'Run containerdev-start first, to start a containerdev project.'
    return 1
  fi
  runargs=''
  if [[ -f .containerdev/runargs ]]; then
    runargs="$(cat .containerdev/runargs)"
  elif [[ -f .containerdev-public/runargs ]]; then
    runargs="$(cat .containerdev-public/runargs)"
  fi
  podman run -it --rm -v .:/project:Z \
    $runargs \
    project-$(basename $(pwd))
}

function containerdev-build {
  dockerfile='.containerdev-public/Dockerfile'
  if [[ -f .containerdev/Dockerfile ]]; then
    dockerfile=.containerdev/Dockerfile
  fi
  podman build -t project-$(basename $(pwd)) -f $dockerfile
}
