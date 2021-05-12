let
  basePath = ".config/nvim/queries";
in
{
  nixHighlights = {
    target = "${basePath}/nix/highlights.scm";
    text = ''
      
    '';
    };
    
  nixInjections = {
    target = "${basePath}/nix/injections.scm";
    text = ''
      ((app [
          ((identifier) @_func)
          (select (identifier) (attrpath (attr_identifier) @_func . ))
        ]) (indented_string) @bash
          (#match? @_func "(writeShellScript(Bin)?)"))

      ; #!/bin/sh shebang highlighting
      ((indented_string) @bash @_code
        (#lua-match? @_code "\s*#!\s*/bin/sh"))

      ; Bash strings
      ((indented_string) @bash @_code
        (#lua-match? @_code "\s*## Syntax: bash"))

      ; Lua strings
      ((indented_string) @lua @_code
        (#lua-match? @_code "\s*\\-\- Syntax: lua"))
    '';
  };
}
