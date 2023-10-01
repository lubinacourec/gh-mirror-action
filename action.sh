#! /bin/sh -l

REMOTE="${1}"
MIRROR="${2}"

if [ -z "${REMOTE}" ]; then
  echo Please specify an origin
  exit 1
fi

if [ -z "${MIRROR}" ]; then
  echo 'Please specify a github repo to mirror to ("user/repo")'
  exit 1
fi
echo "mirroring ${REMOTE} to github.com/${MIRROR}"
git clone --bare "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${MIRROR}.git" . || exit 1
git config --global --add safe.directory /github/workspace || exit 1
git remote add --mirror=fetch mirror "${REMOTE}" || exit 1
git fetch mirror +refs/heads/*:refs/remotes/origin/* || exit 1
git push --force --mirror --prune origin || exit 1
