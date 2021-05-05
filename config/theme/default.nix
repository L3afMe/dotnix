rec {
  lightTheme = true;
  borderWidth = "2";
  cornerRadius = "0";

  colors = 
    if lightTheme
    then import ./theme-light.nix
    else import ./theme-dark.nix;
}
