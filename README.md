# mariner-mock
A poc of running mock builds with Mariner rpms

`docker build -t mock-tester . `
`sudo docker run --privileged -v /local/path/to/mariner-mock:/mockfiles -it mock-tester:latest /bin/bash` 

`mock -r /etc/mock/mariner-1-x86_64.cfg --init `
`mock -r /etc/mock/mariner-1-x86_64.cfg --no-cleanup-after --rpmbuild-opts=--noclean  <srpm>`
