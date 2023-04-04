{ inputs, pkgs, libs, ... }:

{
  
  programs.alacritty = {
    enable = true;

    settings = {
      import = [ "~/.config/alacritty/themes/themes/blood_moon.yaml" ];
      window.opacity = 0.90;

      font = {
        normal = {
          #family = "UbuntuMono Nerd Font"; # Another decent choice
          family = "ComicCode Nerd Font";
          style = "Bold";
        };

        size = 12.0;
      };

    };

  };



}
