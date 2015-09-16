# github-opml

Create an opml file with references to all repositories starred by a GitHub user


## Running

One-liner:

    curl -O https://raw.githubusercontent.com/jojomi/github-opml/master/bin/linux64/github-opml && chmod +x github-opml && ./github-opml starred jojomi --output=starred-releases.opml

After cloning the repository:

    bin/linux64/github-opml starred jojomi --output=starred-releases.opml



## Running Yourself

Since these binaries are precompiled by someone you (probably) don't know, you should inspect the code and run or compile it yourself. Clone the repository, change to the main directory and execute:

    go get ./... && go run *.go starred jojomi --output=starred-releases.opml


## Updating Code

In case of a change to GitHub's API or if you want to implement new features, follow this plan:

1. **fork** repository
1. **implement** the change/feature
1. **test** intensively
1. **build** for major platforms for ease of use for users without a go environment setup: `./build.sh`
1. send **pull request**