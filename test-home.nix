{ ... }:

{
  home.username = "testuser";
  home.homeDirectory = "/home/testuser";
  home.stateVersion = "23.11";

  programs.ratty.enable = true;
  programs.ratty.package = null;

  programs.ratty.config = {
    window.width = 1920;
    theme.normal.red = "#ff0000";
  };
}
