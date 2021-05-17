{ conf, lib }:
with conf.theme.colors; 
{
  batConfig = {
    target = ".config/bat/config";
    text = ''
      --theme="nix"
      --map-syntax ".ignore:Git Ignore"
    '';
  };

  batColorscheme = {
    target = ".config/bat/themes/nix/nix.tmTheme";
    text = ''
      <!--> Syntax: XML <-->
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
        <key>name</key>
        <string>Nix</string>
        <key>settings</key>
        <array>
          <dict>
            <key>settings</key>
            <dict>
              <key>background</key>
              <string>#000000</string>
              <key>caret</key>
              <string>#000000</string>
              <key>foreground</key>
              <string>#000000</string>
              <key>invisibles</key>
              <string>#000000</string>
              <key>lineHighlight</key>
              <string>#000000</string>
              <key>selection</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Comment</string>
            <key>scope</key>
            <string>comment</string>
            <key>settings</key>
            <dict>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>String</string>
            <key>scope</key>
            <string>string</string>
            <key>settings</key>
            <dict>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Number</string>
            <key>scope</key>
            <string>constant.numeric</string>
            <key>settings</key>
            <dict>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Built-in constant</string>
            <key>scope</key>
            <string>constant.language</string>
            <key>settings</key>
            <dict>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>User-defined constant</string>
            <key>scope</key>
            <string>constant.character, constant.other</string>
            <key>settings</key>
            <dict>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Variable</string>
            <key>scope</key>
            <string>variable</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string></string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Keyword</string>
            <key>scope</key>
            <string>keyword</string>
            <key>settings</key>
            <dict>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Storage</string>
            <key>scope</key>
            <string>storage</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string></string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Storage type</string>
            <key>scope</key>
            <string>storage.type</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string>italic</string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Class name</string>
            <key>scope</key>
            <string>entity.name.class</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string>underline</string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Inherited class</string>
            <key>scope</key>
            <string>entity.other.inherited-class</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string>italic underline</string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Function name</string>
            <key>scope</key>
            <string>entity.name.function</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string></string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Function argument</string>
            <key>scope</key>
            <string>variable.parameter</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string>italic</string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Tag name</string>
            <key>scope</key>
            <string>entity.name.tag</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string></string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Tag attribute</string>
            <key>scope</key>
            <string>entity.other.attribute-name</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string></string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Library function</string>
            <key>scope</key>
            <string>support.function</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string></string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Library constant</string>
            <key>scope</key>
            <string>support.constant</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string></string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Library class&#x2f;type</string>
            <key>scope</key>
            <string>support.type, support.class</string>
            <key>settings</key>
            <dict>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Library variable</string>
            <key>scope</key>
            <string>support.other.variable</string>
            <key>settings</key>
            <dict>
              <key>fontStyle</key>
              <string></string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Invalid</string>
            <key>scope</key>
            <string>invalid</string>
            <key>settings</key>
            <dict>
              <key>background</key>
              <string>#000000</string>
              <key>fontStyle</key>
              <string></string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
          <dict>
            <key>name</key>
            <string>Invalid deprecated</string>
            <key>scope</key>
            <string>invalid.deprecated</string>
            <key>settings</key>
            <dict>
              <key>background</key>
              <string>#000000</string>
              <key>foreground</key>
              <string>#000000</string>
            </dict>
          </dict>
        </array>
        <key>colorSpaceName</key>
        <string>sRGB</string>
        <key>semanticClass</key>
        <string>theme.nix</string>
      </dict>
      </plist>
    '';
  };
}