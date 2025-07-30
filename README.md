# Pocketvue

## Why
I made this project as a base for other projects so that I can start working on features quickly instead of configuring the same things again and again

## Start the project
1. Clone the repo with `git clone https://github.com/Nevimmu/base-vue-pocketbase.git`
2. Change the name of the project in the package.json
3. Run `npm install`
4. Remove the .git and `git init`

## Tag and publish a version
1. Run `commit-and-tag-version` (with `--first-release` if it's the first one)
2. Make sure you have a builder running (or use `docker buildx create --name multiarch_builder --use`)
>[!WARNING]
> Run `docker run --privileged --rm tonistiigi/binfmt --install all` so that multi architecture build works
3. Build and push the image with `docker buildx build --platform linux/amd64,linux/arm64 -t nevimmu/{project_name}:{version} -t nevimmu/{project_name}:latest --push .`
4. `git push` and voila
