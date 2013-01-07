genpkg simplifies installation and update for unpackaged JavaScript files.

## Usage Example
```bash
$ genpkg install https://raw.github.com/azer/sjcl/master/sjcl.js node_modules
Package "sjcl" saved successfully.

$ ls node_modules/sjcl
sjcl.js package.json

$ genpkg update
Checking for updates...
Package sjcl is already up to date
Done.
```

## Installation

```bash
$ npm install genpkg
```

## Tests

```bash
make test
```
