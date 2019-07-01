#! /bin/sh

set -xe

# Update this whenever the latest Node.js LTS version changes (~ every year).
# Do not forget to add this version to .travis.yml config also.
LATEST_LTS_VERSION="10"

# We want this command to succeed whether or not the Node.js version is the
# latest (so that the build does not show as failed), but _only_ the latest
# should be used to publish the module.
if [ "$TRAVIS_NODE_VERSION" != "$LATEST_LTS_VERSION" ]; then
  echo "Node.js v$TRAVIS_NODE_VERSION is not latest LTS version -- will not deploy with this version."
  exit 0
fi

# Ensure the tag matches the one in package.json, otherwise abort.
PACKAGE_TAG=v"$(jq -r .version package.json)"
#if [ "$PACKAGE_TAG" != "$TRAVIS_TAG" ]; then
#  echo "Travis tag (\"$TRAVIS_TAG\") is not equal to package.json tag (\"$PACKAGE_TAG\"). Please push a correct tag and try again."
#  exit 1
#fi

mkdir out
docker run --rm -v $(pwd)/out:/out  -v $(pwd)/protos:/protos pseudomuto/protoc-gen-doc
cp out/index.html  ../index.html
#cat out/index.html

# Get all repo branches
git config remote.origin.fetch refs/heads/*:refs/remotes/origin/*
git fetch --unshallow

# Delete unnecessary files
rm -rf ../dapi-grpc/* .nyc_output
rm -f .editorconfig .eslintignore .eslintrc .gitignore .travis.yml

# Create or checkout branch
if [ -n "$(git rev-parse --quiet --verify origin/gh-pages)" ]; then
  git checkout -f gh-pages
else
  git checkout --orphan gh-pages
  git rm -rf .
fi

# Put spec file back into folder and check for changes
cp ../index.html .

# Add all files (spec and static html page)
git add -A
git commit -m "Travis-built spec for version \"${VERSION}\""

git remote add origin-grpc-docs https://${GH_TOKEN}@github.com/thephez/dapi.git > /dev/null 2>&1
git push -u origin-grpc-docs gh-pages
