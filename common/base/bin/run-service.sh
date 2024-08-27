#!/bin/bash
set -e

pkgName=$SERVICE_PACKAGE_NAME
pkgVersion=$SERVICE_PACKAGE_VERSION
name=$(echo "$pkgName" | tr -d '@/' | tr '/' '-')

npm pack "$pkgName@$pkgVersion"
ls
echo "__dirname $PWD"

tar -zxvf "$name-$pkgVersion.tgz"
mv ./package/* ./
rm -rf ./package
rm -rf "$name-$pkgVersion.tgz"

yarn install
yarn start
# GATEWAY_PORT=9010 MICRO_PORT=8010 yarn start
