{pkgs, ...}: {
  users.users.pmlogist = {
    name = "pmlogist";
    home = "/Users/pmlogist";
  };

  services.nix-daemon.enable = true;
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  homebrew = {
    enable = true;
    onActivation.autoUpdate = true;
    onActivation.cleanup = "zap";
    taps = [
      "homebrew/cask-fonts"
      "koekeishiya/formulae"
    ];
    brews = [
      "docker"
      "docker-compose"
      "colima"
      "stow"
      "jq"
      "fzf"
      "yabai"
      "skhd"
      "n"
      "ripgrep"
      "lazygit"
      "exa"
      "fd"
      "typewritten"
    ];
    casks = [
      "protonmail-bridge"
      "visual-studio-code"
      "slack"
      "affinity-photo"
      "affinity-designer"
      "affinity-publisher"
      "alfred"
      "discord"
      "kitty"
      "font-iosevka"
      "font-symbols-only-nerd-font"
      "font-iosevka-ss05"
      "firefox"
      "figma"
      "rapidapi"
      "discord"
      "the-unarchiver"
      "mpv"
      "tableplus"
      "alfred"
      "mos"
      "bartender"
      "obsidian"
      "macpass"
    ];
  };
}
