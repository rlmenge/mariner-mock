# mariner-mock
A poc of running mock builds with Mariner rpms

## Start the docker container

`docker build -t mock-tester . `

`sudo docker run --privileged -v /local/path/to/mariner-mock:/mockfiles -it mock-tester:latest /bin/bash` 

## Start the x86 mock build
`mock -r /etc/mock/mariner-1-x86_64.cfg --init `

`mock -r /etc/mock/mariner-1-x86_64.cfg --no-cleanup-after --rpmbuild-opts=--noclean  <srpm>`

## Start the aarch64 mock build
`sudo dnf install qemu-user-static`

`mock -r /etc/mock/mariner-1-aarch64.cfg --init`

`mock -r /etc/mock/mariner-1-aarch64.cfg --no-cleanup-after --rpmbuild-opts=--noclean  <srpm>`