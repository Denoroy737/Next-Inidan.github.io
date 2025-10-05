# 1. Initialize repo
git init

# 2. Add file
echo "hey, its deno here" > README.md
git add README.md

# 3. Create tree object
TREE_HASH=$(git write-tree)

# 4. Create manual commit
cat > commit.txt <<EOF
tree $TREE_HASH
author Deno <you@example.com> -1 +0000
committer Deno <you@example.com> -1 +0000

1969 commit
EOF

# 5. Write commit object
COMMIT_HASH=$(git hash-object -t commit -w commit.txt)

# 6. Point branch to commit
git update-ref refs/heads/main $COMMIT_HASH

# 7. Add remote and push
git remote add origin "https://github.com/${USERNAME}/deno.git"
git push -u origin main -f
