A flake for [ratty](https://github.com/orhun/ratty) terminal 3d emulator.

**By no means I'm the author of this program! I just made the nix flake for easy installation and configuration on nixos machines**

# Installation
*Be weary that compilation probably take a while*
Add this to your profile:
`nix profile add github:szymon-jozef/ratty-flake`
or just run it once
`nix run github:szymon-jozef/ratty-flake`

--- 

You can also put this in your own home flake:
```nix
{
    inputs = {
        ratty.url = "github:szymon-jozef/ratty-flake";
    };

    outputs = {ratty, ...}:
    {
        modules = [
            ratty.homeManagerModules.default
        ];
    };
}
```

# Configuration
It comes with home-manager module, so you can configure it like this:
```nix
programs.ratty = {
    enable = true;

    config = {
        window = {
            width = 1920;
            height = 1080;
        };
    }
};
```

It covers all options since [this commit](https://github.com/orhun/ratty/commit/dfc5e43eb4623b23ebc39640cb780a17b4d13515)
For reference check [ratty configuration file](https://github.com/orhun/ratty/blob/main/config/ratty.toml) and `flake.nix`
