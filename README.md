# nodejs-config

Personal user-level configuration for the Node.js ecosystem.

This repository currently manages npm user configuration by installing a `~/.npmrc` file that changes the npm global install prefix to a directory under the user's home directory.

## Policy

- The npm global prefix is set to `${HOME}/.local`.
- npm global package executables are installed into `${HOME}/.local/bin`.
- This repository does not manage shell `PATH` settings.
- Shell `PATH` settings should be managed by a shell configuration repository such as `bash-config`.
- Do not commit npm registry auth tokens or other secrets to this repository.

## Managed configuration

`.npmrc`:

```ini
prefix=${HOME}/.local
````

## Install

```sh
git clone https://github.com/temeteke/nodejs-config.git
cd nodejs-config
make install
```

If `~/.npmrc` already exists and differs from the repository version, it will be backed up before being replaced.

Backup files are named like this:

```text
~/.npmrc.bak.YYYYMMDDhhmmss
```

## PATH setup

To run globally installed npm packages, make sure `${HOME}/.local/bin` is included in your `PATH`.

Example:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

If your shell configuration already adds `${HOME}/.local/bin` to `PATH`, no additional setup is required in this repository.

## Check

```sh
make check
```

Expected output example:

```console
/home/your-user/.local
/home/your-user/.local/lib/node_modules
npm: /usr/bin/npm
PATH contains /home/your-user/.local/bin
```

## Uninstall

The uninstall target removes `~/.npmrc` only if it is identical to the `.npmrc` file in this repository.

```sh
make uninstall
```

If `~/.npmrc` has been modified or contains additional settings, it will not be removed. This avoids accidentally deleting local settings or secrets.

## Notes

If you currently store npm registry auth tokens in `~/.npmrc`, running `make install` will back up the existing file and then replace it.

For npm registry authentication, prefer one of the following approaches:

* project-specific `.npmrc` files
* CI/CD secret variables
* environment variables
* another local-only configuration method

Do not commit registry tokens or other credentials to this repository.
