# mariner-mock
A tool for a reproducible builds of Mariner RPM packages. 

## Quick start
Clone this repo and perform the following

## Start the docker container

First, you must build a mariner-mock image from a base mariner container image...
### Using an existing mariner container image:

`./build.sh -i <existing-mariner-image-name>`

### Using a mariner container image .tar:

`./build.sh -t /path/to/mariner-container-image.tar.gz`

### Then... 
`sudo docker run --privileged -v </local/path/to/>mariner-mock:/mockfiles -it mariner-mock:latest /bin/bash` 

## Start an x86 mock build
`mock -r /etc/mock/mariner-1-x86_64.cfg --init `

`mock -r /etc/mock/mariner-1-x86_64.cfg --no-cleanup-after --rpmbuild-opts=--noclean  <srpm>`

## Start an aarch64 mock build
`sudo dnf install qemu-user-static`

`mock -r /etc/mock/mariner-1-aarch64.cfg --init`

`mock -r /etc/mock/mariner-1-aarch64.cfg --no-cleanup-after --rpmbuild-opts=--noclean  <srpm>`

## Useful tips

### Adding custom .repo files
The Dockerfile will copy in *.repo from this repository root into /etc/yum.repos.d inside the mariner-mock container image.

A common use case is if you want to [locally host a repository](https://github.com/hbeberman/rpmrepo) for a set of Mariner RPMS you are actively working on. In this case, you would make a file called localhost.repo:

```
# localhost.repo
[selfhost-repo]
name=Selfhost Build Repo (out/RPMS)
baseurl=http://<your-ip>:8000
enabled=1
gpgcheck=0
sslverify=0
```
And then when the mariner-mock image is built (by calling build.sh) localhost.repo would be copied in and ready to use within mariner-mock containers. 
### Enter the chroot
Chroots are mounted at` /var/lib/mock/<name of cfg>`. Inside the chroot, rpmbuild runs at `/root/builddir/build ` 

Note that in the above commands to run mock, we use
- `--no-cleanup-after`: ensures that the chroot is not removed  
- `--rpmbuild-opts=--noclean`: Passes the –noclean flag to rpmbuild, perserving the rpmbuild directories.  
 
Once the build is complete, you can enter the chroot using  
`mock -r /etc/mock/mariner-1-<your arch>.cfg --shell `

From here you can explore the files under `build` or run additional rpmbuilds directly. 
  
### Understanding results
Results are found in `/var/lib/mock/<your config>/results`
The rpms can be found here as well as logging.
Result log files are organized the following way:
- state.log shows high level commands mock is running 
- root.log shows the packages mock installed in the chroot  
- build.log is the output of rpmbuild on the src.rpm in the chroot

### Dockerfile and file management
The provided dockerfile creates symlinks to the .tpl and .cfgs within the container at `/etc/mock/`. Therefore, changes made to those files outside of the container will be reflected to the files within the container.

Additionally, the command given to start the container links the `mariner-mock` folder to `/mockfiles` within the container (`-v </local/path/to/>mariner-mock:/mockfiles`). Thus, any files (such as srpms) added to `mariner-mock` outside the container, will be present within the container at `/mockfiles`

### Local repo
You can modify the mariner-1.tpl to use a local repo when calling dnf. To do so, modify the dnf.conf string value to include the self-host repo file info as such:
```
config_opts['dnf.conf'] = """

[main]
keepcache=1
... 
<needed dnf info>
...
user_agent={{ user_agent }}

[selfhost-repo]
name=Selfhost Build Repo (out/RPMS)
baseurl=http://<Host IP Address>:8000
enabled=1
gpgcheck=0
sslverify=0
"""
```
