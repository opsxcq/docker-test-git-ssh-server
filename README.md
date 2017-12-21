# Git server in a container for your integration tests !

## Running

This container uses port `22` as the entry point for the SSH connection. And
uses as a parameter for the entrypoint, your accepted keys for the ssh
connection.

Here an example using a local key for authentication.

```
docker run --rm -it -p 2288:22 strm/test-git-ssh-server 'ssh-rsa AAAAB3...very very long key....ysx opsxcq@host'
```

> If you prefer to use a password authentication, the **git** user has
> **secret** as it's password.

## Repository configuration

For example, if you are running your container locally mapping the port `22` to
`2288`, the following will configure your repository

```
$ git init
$ echo Hello world > README.md
$ git add README.md
$ git commit -a -m 'Initial commit'
$ git remote add origin ssh://git@localhost:2288/repo.git
```
