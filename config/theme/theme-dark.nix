rec {
  # Main
  foreground ={
    normal = "F5E9DA";
    alt = "FAF4ED";
  };
  background = {
    normal =  "575279";
    alt = "232136";
  };

  # Accents
  black = {
    light =  "232136";
    dark = "575279";
  };
  red = {
    light =  "B4637A";
    dark = "D7827E";
  };
  yellow = {
    light =  "EA9D34";
    dark = "F6C177";
  };
  magenta = {
    light =  "907AA9";
    dark = "C4A7E7";
  };
  blue = {
    light =  "286983";
    dark = "CECAED";
  };
  cyan = {
    light =  "56959F";
    dark = "9CCFD8";
  };
  green = {
    light =  "569F84";
    dark = "9CD8C3";
  };
  white = {
    light =  "F2E9DE";
    dark = "FAF4ED";
  };

  colors16 = [
    # Normal
    background.normal
    red.normal
    green.normal
    yellow.normal
    blue.normal
    magenta.normal
    cyan.normal
    foreground.normal

    # Bright
    background.alt
    red.bright
    green.bright
    yellow.bright
    blue.bright
    magenta.bright
    cyan.bright
    foreground.alt
  ];
}
