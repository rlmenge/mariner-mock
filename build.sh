#! /bin/bash
DEFAULT_BASE_IMAGE_NAME="mariner-mock-base"
DEFAULT_MOCK_IMAGE_NAME="mariner-mock"

print_help () {
    echo "Required:"
    echo "-t: tar, path to mariner container image .tar.gz"
    echo " - XOR -"
    echo "-i: image, name of imported mariner container image"
}

while getopts ":t:i:" arg; do
    case $arg in
        i) IMAGE=$OPTARG; break;;
        t) docker import $OPTARG $DEFAULT_BASE_IMAGE_NAME; IMAGE=$DEFAULT_BASE_IMAGE_NAME; break;;
    esac
done

if [ -z $IMAGE ]
then
    print_help
    exit 1
fi

echo "Building Dockerfile with image: ${IMAGE}"
docker build --build-arg image_name=${IMAGE} -t $DEFAULT_MOCK_IMAGE_NAME .
