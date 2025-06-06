## Nix Setup

1. If you haven't already, [install Nix](https://nixos.org/download/)
	* On POSIX systems, this is usually `curl -L https://nixos.org/nix/install | sh`
2. Run `nix flake show --allow-import-from-derivation` to verify that the flake can be read correctly by nix.
3. Build libraries: `nix build`

If you have trouble, refer to the [Nix Reference Manual](https://hydra.nixos.org/build/275163694/download/1/manual/introduction.html) for additional detail.

## Haskell Setup

Because this project uses nix, there's no need to install Stack on your system, you can run it in a shell.
1. Make sure you have the yesod command line tool declared
	* Via nix-shell:

	```
	nix-shell -p haskellPackages.yesod-bin
	```

	* Via NixOS Configuration:

	```
	environment.systemPackages = [
      pkgs.haskellPackages.yesod-bin
    ];
	```

2. Init a shell: `nix develop -c {your shell interpreter}`
3. Build libraries: `stack build`

If you have trouble, refer to the [Yesod Quickstart guide](https://www.yesodweb.com/page/quickstart) for additional detail.

## Development

Start a development server with:

```
stack exec -- yesod devel
```

As your code changes, your site will be automatically recompiled and redeployed to localhost.

## Tests

```
stack test --flag helloyesod:library-only --flag helloyesod:dev
```

(Because `yesod devel` passes the `library-only` and `dev` flags, matching those flags means you don't need to recompile between tests and development, and it disables optimization to speed up your test compile times).

## Documentation

* Check [nix.dev](https://nix.dev/) for the official documentation for the Nix ecosystem.
* Read the [Yesod Book](https://www.yesodweb.com/book) online for free
* Check [Stackage](http://stackage.org/) for documentation on the packages in your LTS Haskell version, or [search it using Hoogle](https://www.stackage.org/lts/hoogle?q=). Tip: Your LTS version is in your `stack.yaml` file.
* For local documentation, use:
	* `stack haddock --open` to generate Haddock documentation for your dependencies, and open that documentation in a browser
	* `stack hoogle <function, module or type signature>` to generate a Hoogle database and search for your query
* The [Yesod cookbook](https://github.com/yesodweb/yesod-cookbook) has sample code for various needs

## Getting Help

* Ask questions and check other forums on [NixOS Discourse](https://discourse.nixos.org/)
* Ask and contribute to the nix ecosystem on [Nix/Nixpkgs/NixOS GitHub](https://github.com/NixOS/)
* Ask questions on [Stack Overflow, using the Yesod or Haskell tags](https://stackoverflow.com/questions/tagged/yesod+haskell)
* Ask the [Yesod Google Group](https://groups.google.com/forum/#!forum/yesodweb)
* There are several chatrooms you can ask for help:
	* For IRC, try Freenode#yesod and Freenode#haskell
	* [Functional Programming Slack](https://fpchat-invite.herokuapp.com/), in the #haskell, #haskell-beginners, or #yesod channels.

## Credits and Licenses

This project includes code derived from [YesodWeb/Yesod](https://github.com/yesodweb/yesod), which is licensed under the [MIT License]([https://opensource.org/licenses/MIT](https://github.com/yesodweb/yesod/blob/master/LICENSE)).  
Additional modifications and original code in this repository are licensed under the [BSD 3-Clause License](./LICENSE).
