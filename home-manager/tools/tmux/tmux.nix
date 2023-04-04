{ inputs, pkgs, lib, ... }:

{

  programs.tmux = {
    enable = true;

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = power-theme;
        extraConfig = ''
          set -g @tmux_power_theme 'violet'
          set -g @tmux_power_prefix_highlight_pos 'L'
          set -g @tmux_power_show_download_speed true
          set -g @tmux_power_download_speed_icon '↓'
          set -g @tmux_power_show_upload_speed true
          set -g @tmux_power_upload_speed_icon '↑'
        '';
      }

      {
        plugin = fuzzback;
        extraConfig = ''
          set -g @fuzzback-popup 1
        '';
      }

      tmux-fzf
      fzf-tmux-url
      sensible
      prefix-highlight
      net-speed

    ];


  };


}
