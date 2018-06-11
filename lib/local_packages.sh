
yarn_build_locals() {
  local build_dir=${1:-}
  if [ -d "$build_dir/packages" ]; then

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

  fi

  if [ -d "$build_dir/common" ]; then
    cd $build_dir/common
    yarn && yarn build
  fi
}

npm_build_locals() {
  local build_dir=${1:-}

  if [ -d "$build_dir/packages" ]; then
    cd $build_dir/packages
    find * -prune -type d | ( while IFS= read -r d; do
      (
        cd $d
        npm install
        npm run build --if-present
      )
    done )
  fi

  if [ -d "$build_dir/common" ]; then
    cd $build_dir/common
    npm install && npm run build
  fi
}