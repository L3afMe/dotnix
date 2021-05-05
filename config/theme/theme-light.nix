rec {
  # Main
  foreground ={
    normal =  "575279";
    alt = "232136";
  };
  background = {
    normal = "F5E9DA";
    alt = "FAF4ED";
  };

  # Accents
  black = {
    normal =  "232136";
    bright = "575279";
  };
  red = {
    normal =  "B4637A";
    bright = "D7827E";
  };
  yellow = {
    normal =  "EA9D34";
    bright = "F6C177";
  };
  magenta = {
    normal =  "907AA9";
    bright = "C4A7E7";
  };
  blue = {
    normal =  "286983";
    bright = "CECAED";
  };
  cyan = {
    normal =  "56959F";
    bright = "9CCFD8";
  };
  green = {
    normal =  "569F84";
    bright = "9CD8C3";
  };
  white = {
    normal =  "F2E9DE";
    bright = "FAF4ED";
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
