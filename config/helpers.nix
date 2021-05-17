{ lib }:
rec {
  getPkg = program: program.pkg or program;

  getBin = program:
  let
    pkg = getPkg program;

    binName =
      if builtins.hasAttr "pkg" program
      then program.binName or (getBinName program.pkg)
      else (getBinName pkg);

    # This is way more complicated that in needs to be
    args = with lib.lists;
      let
        # Get args or empty list
        args =
          if builtins.hasAttr "pkg" program
          then program.args or []
          else [];

        # Flatten will turn "" into [ "arg" ]
        argsList = flatten args;

        # Ensure all args are strings
        argsStrs = forEach argsList (x: toString x);
      in
        # Join all args to a single string
        if builtins.length args != 0
        then " ${builtins.concatStringsSep " " args}"
        else "";
  in
    "${pkg}/bin/${binName}${args}";

  getBinName = pkg:
    pkg.meta.mainProgram or pkg.pname;

  getPkgBin = pkg:
    "${pkg}/bin/${getBinName pkg}";
}

