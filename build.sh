#!/bin/sh

echo "Downloading large expert models"
wget -P bin/model/patch_experts/ https://www.dropbox.com/s/7na5qsjzz8yfoer/cen_patches_0.25_of.dat
wget -P bin/model/patch_experts/ https://www.dropbox.com/s/k7bj804cyiu474t/cen_patches_0.35_of.dat
wget -P bin/model/patch_experts/ https://www.dropbox.com/s/ixt4vkbmxgab1iu/cen_patches_0.50_of.dat
wget -P bin/model/patch_experts/ https://www.dropbox.com/s/2t5t1sdpshzfhpj/cen_patches_1.00_of.dat

echo "Build container"
docker build --no-cache -t openface-arm:2.2.0 .