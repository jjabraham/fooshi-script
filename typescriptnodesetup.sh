#!/bin/bash
# Node Typescript project setup

echo 'Setting up node + typescript project'
echo '------------------------------------'

echo '############# Intitialise git ##################'
git init
touch .gitignore

mkdir src

echo '############# Intitialise npm ##################'
npm init -y

echo '############# install typescript ##################'
npm install typescript --save-dev
npm install @types/node --save-dev

npx tsc --init --rootDir src --outDir build \
--esModuleInterop --resolveJsonModule --lib es6 \
--module commonjs --allowJs true --noImplicitAny true

echo '############# intstall ts-node-dev ##################'
npm install --save-dev ts-node-dev


echo '############# intstall linting libraries ##################'
npm install --save-dev rimraf

npm install --save-dev eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
touch .eslintrc
touch .eslintignore

npx husky-init && npm install
npx husky add .husky/pre-commit "npm run lint"

npm install --save-dev --save-exact prettier
touch .prettierignore

npm install --save-dev eslint-config-prettier

echo '############# writing to .eslintrc ##################'
echo '{
    "root": true,
    "parser": "@typescript-eslint/parser",
    "plugins": [
        "@typescript-eslint"
    ],
    "extends": [
        "eslint:recommended",
        "plugin:@typescript-eslint/eslint-recommended",
        "plugin:@typescript-eslint/recommended",
        "prettier"
    ],
    "rules": { }
}' > .eslintrc


echo '############# writing to .eslintignore ##################'
echo 'node_modules
build' > .eslintignore

echo '############# writing to .gitignore ##################'
echo 'node_modules
build' > .gitignore

echo '############# writing to .prettierrc.json ##################'
echo {}> .prettierrc.json

echo '############# writing to .prettierignore ##################'
echo 'node_modules
build' > .prettierignore


echo '###### update "scripts" in package.json'

npx npm-add-script \
  -k "test" \
  -v "echo \"Error: no test specified\"" \
  --force

npx npm-add-script \
  -k "start" \
  -v "npm run build && node build/index.js" \
  --force

npx npm-add-script \
  -k "start:dev" \
  -v "tsnd --transpile-only --ignore-watch node_modules src/index.ts" \
  --force

npx npm-add-script \
  -k "build" \
  -v "rimraf ./build && tsc" \
  --force

npx npm-add-script \
  -k "lint" \
  -v "eslint --ext .ts --debug && npx prettier --write --no-error-on-unmatched-pattern src/" \
  --force
