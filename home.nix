{ config, pkgs, ... }:
let
    name = "Caleb Abrams";
    email = "abramscma@gmail.com";
in
{
  home.username = "cabrams";
  home.homeDirectory = "/home/cabrams";
 
  home.stateVersion = "24.05"; # Please read the comment before changing.
 
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "IosevkaTerm" ]; })
  ];
 
  programs = {
     eza.enable = true;
     bat.enable = true;
     yazi.enable = true;
     ripgrep.enable = true;
     zoxide.enable = true;
     neovim.enable = true;

     git = {
        enable = true;
        userName = "${name}";
        userEmail = "${email}";
     };
 
     fish = {
        enable = true;
        functions = {
            fish_prompt = {
                body = ''
                  string join "" -- (set_color red) "[" (set_color yellow) $USER (set_color green) "@" (set_color blue) $hostname (set_color magenta) " " $(prompt_pwd) (set_color red) ']' (set_color normal) "\$ "
                '';
            };
        };
        shellAliases = {
           ls = "eza --icons --group-directories-first";
           vim = "sudo nvim";
           rebuild = "sudo nixos-rebuild switch --flake ~/.dotfiles";
        };
     };
 
     wezterm = {
        enable = true;
        extraConfig = ''
            return {
                font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Medium", stretch = "Normal", style = "Normal" }),
 
                font_size = 16.0,
 
                color_scheme = "Catppuccin Frappe",
                use_fancy_tab_bar = true,
                tab_bar_at_bottom = true,
 
                hide_mouse_cursor_when_typing = false,
                enable_scroll_bar = false,
 
                leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 },
 
                keys = {
                    {
                      mods   = "LEADER",
                      key    = "s",
                      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
                    },
                    {
                      mods   = "LEADER",
                      key    = "v",
                      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
                    },
                    {
                      mods   = "LEADER",
                      key    = "c",
                      action = wezterm.action.CloseCurrentPane { confirm = true }
                    },
                    {
                      mods = 'LEADER',
                      key = 'h',
                      action = wezterm.action.ActivatePaneDirection 'Left',
                    },
                    {
                      mods = 'LEADER',
                      key = 'l',
                      action = wezterm.action.ActivatePaneDirection 'Right',
                    },
                    {
                      mods = 'LEADER',
                      key = 'k',
                      action = wezterm.action.ActivatePaneDirection 'Up',
                    },
                    {
                      mods = 'LEADER',
                      key = 'j',
                      action = wezterm.action.ActivatePaneDirection 'Down',
                    },
                },
             }
        '';
     };
 
  };
 
  home.file = {
  };
 
  home.sessionVariables = {
    EDITOR = "nvim";
  };
 
  programs.home-manager.enable = true;
}
