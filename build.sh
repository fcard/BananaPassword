ext_exists() {
  {
    for x in *.$1; do
      [ "${x%%\**}" = "$x" ] && return 0;
    done
  } 2> /dev/null
  return 1
}

git_ext_exists() {
  x=$(git status "*.$1")
  case "$x" in
    *"Untracked files"*) return 0; ;;
    *"Changes not staged"*) return 0 ;;
    *) return 1; ;;
  esac
}

ext_exists css && rm *.css
git_ext_exists css && git rm -f '*.css'

ext_exists js && rm *.js
git_ext_exists js && git rm -f '*.js'

ext_exists wasm && rm *.wasm
git_ext_exists wasm && git rm -f '*.wasm'

[ -d dist ] && git rm -rf dist
[ -d dist ] && rm -r dist

(
  cd ../banana_pass
  trunk build --release --public-url BananaPassword
)

cp ../banana_pass/dist/* .

