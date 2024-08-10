#!/bin/bash

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
WORKDIR=$(pwd)

PROJECT_NAME=$1
PACKAGE_NAME=$2

read -r -p "Enter project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  PROJECT_NAME="TaroRN"
fi

if [ -d "$PROJECT_NAME" ]; then
  echo "$PROJECT_NAME already exists"
  exit 1
fi

read -r -p "Enter package name: " PACKAGE_NAME
if [ -z "$PACKAGE_NAME" ]; then
  echo "Please provide a package name"
  exit 1
fi

# clone template
git_exists=$(which git)

if [ -z "$git_exists" ]; then
  echo "git not found"
  exit 1
fi

git clone https://github.com/qnnp-me/taro-rn-template.git "$PROJECT_NAME"
rm -rf "$PROJECT_NAME/.git"

npx react-native init "$PROJECT_NAME" --package-name="$PACKAGE_NAME"

file_path="${WORKDIR}/.tools/update-version.sh"
# 检查文件是否存在
if [ -f "$file_path" ]; then
  # 替换 PROJECT_NAME
  sed -i '' -E "s|PROJECT_NAME=\"[^\"]+\"|PROJECT_NAME=\"$PROJECT_NAME\"|g" "$file_path"
  # 替换 RNDIR_NAME
  sed -i '' -E "s|RNDIR_NAME=\"[^\"]+\"|RNDIR_NAME=\"$PROJECT_NAME\"|g" "$file_path"
fi
