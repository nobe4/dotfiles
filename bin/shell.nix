with import <nixpkgs> {};

let
  # Same filetype -> package map as bin/use.
  rules = [
    { glob = ".rb";   packages = [ ruby ruby-lsp ]; }
    { glob = ".go";   packages = [ go gopls golangci-lint golangci-lint-langserver ]; }
    { glob = ".sh";   packages = [ bash-language-server shellcheck ]; }
    { glob = ".c";    packages = [ clang-tools ]; }
    { glob = ".lua";  packages = [ lua-language-server ]; }
    { glob = ".md";   packages = [ marksman ]; }
    { glob = ".nix";  packages = [ nixd ]; }
    { glob = ".py";   packages = [ python3 python3Packages.python-lsp-server ]; }
    { glob = ".ts";   packages = [ nodejs typescript-language-server ]; }
    { glob = ".css";  packages = [ vscode-langservers-extracted ]; }
    { glob = ".html"; packages = [ vscode-langservers-extracted emmet-language-server ]; }
    { glob = ".json"; packages = [ vscode-langservers-extracted ]; }
    { glob = ".yaml"; packages = [ yaml-language-server ]; }
  ];

  # Impure: read the actual filenames in the current directory tree.
  cwd = builtins.getEnv "PWD";
  hasMatch = glob:
    builtins.pathExists (cwd)
       && lib.any (f: lib.hasSuffix glob f) allFiles;

  # Recursively list files, skipping the usual noise directories.
  allFiles =
    let
      skip = [ ".git" "node_modules" "result" ".direnv" ];
      go = dir:
        lib.concatLists (lib.mapAttrsToList (name: type:
          let path = dir + "/${name}";
          in if type == "directory"
             then (if lib.elem name skip then [] else go path)
             else [ name ]
        ) (builtins.readDir dir));
    in go (/. + cwd);
in
mkShell {
  packages = lib.concatMap (r: lib.optionals (hasMatch r.glob) r.packages) rules;
}
