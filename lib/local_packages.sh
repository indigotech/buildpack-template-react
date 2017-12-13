
yarn_build_locals() {
  local build_dir=${1:-}
  cd $build_dir/packages
  find * -prune -type d | ( while IFS= read -r d; do
    (
      cd $d
      yarn

      local has_build=$(read_json "./package.json" ".scripts[\"build\"]")
      if [ -n "$has_build" ]; then
        yarn run build
      fi
    )
  done )

  cd ../common
  yarn && yarn build
}

npm_build_locals() {
  local build_dir=${1:-}
  cd $build_dir/packages
  find * -prune -type d | ( while IFS= read -r d; do
    (
      cd $d
      npm install
      npm run build --if-present
    )
  done )

  cd ../common
  npm install && npm run build
}