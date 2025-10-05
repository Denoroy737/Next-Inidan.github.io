#!/usr/bin/env sh

# ---------------------------------------------------
# 1969 GitHub Repo Creator (Plumbing Method)
# Works on modern Git (Linux/macOS/WSL)
# ---------------------------------------------------

_() {
  YEAR="1969"

  echo "GitHub Username: "
  read -r USERNAME
  echo "Repository name to create: "
  read -r REPO
  echo "GitHub Access token (or use gh auth login): "
  read -r ACCESS_TOKEN

  # validate inputs
  [ -z "$USERNAME" ] && echo "Username missing" && exit 1
  [ -z "$REPO" ] && echo "Repo name missing" && exit 1

  # create temp folder
  [ ! -d "$YEAR" ] && mkdir "$YEAR"
  cd "$YEAR" || exit

  git init

  echo "Hello from 1969!" > README.md
  git add README.md

  # Create tree object
  TREE_HASH=$(git write-tree)

  # Create manual commit with 1969 timestamp
  cat > commit.txt <<EOF
tree $TREE_HASH
author $USERNAME <${USERNAME}@example.com> -1 +0000
committer $USERNAME <${USERNAME}@example.com> -1 +0000

Initial commit from 1969
EOF

  COMMIT_HASH=$(git hash-object -t commit -w commit.txt)

  # Point branch to this commit
  git update-ref refs/heads/main $COMMIT_HASH

  # Add remote and push
  if [ -n "$ACCESS_TOKEN" ]; then
    git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/${REPO}.git"
  else
    git remote add origin "https://github.com/${USERNAME}/${REPO}.git"
  fi

  git branch -M main
  git push -u origin main -f

  cd ..
  rm -rf "$YEAR"

  echo
  echo "Done! Check your repository: https://github.com/${USERNAME}/${REPO}"
}

_ # run the function
unset -f _
