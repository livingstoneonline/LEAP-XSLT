git fetch --all
git checkout gh-pages
git pull
git push
git checkout dev
git merge gh-pages
git push
git checkout stage
git merge dev
git push
git checkout prod
git merge stage
git push
git checkout gh-pages
