#!/bin/bash

SCRIPT=$(readlink -f "$0")
BASEDIR=$(dirname "$SCRIPT")
WORKDIR=$(pwd)

PROJECT_NAME=$1
PACKAGE_NAME=$2

if [ -z "$PROJECT_NAME" ]; then
  echo "Please provide a project name"
  exit 1
fi
if [ -z "$PACKAGE_NAME" ]; then
  PACKAGE_NAME="com.${PROJECT_NAME}"
fi

# npx react-native init "$PROJECT_NAME" --package-name="$PACKAGE_NAME"

file_path="${WORKDIR}/.tools/update-version.sh"
# 检查文件是否存在
if [ -f "$file_path" ]; then
  # 替换 PROJECT_NAME
  sed -i '' -E "s|PROJECT_NAME=\"[^\"]+\"|PROJECT_NAME=\"$PROJECT_NAME\"|g" "$file_path"
  # 替换 RNDIR_NAME
  sed -i '' -E "s|RNDIR_NAME=\"[^\"]+\"|RNDIR_NAME=\"$PROJECT_NAME\"|g" "$file_path"
fi
