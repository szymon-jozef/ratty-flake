{
  description = "Flake for ratty";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ratty = {
      url = "github:orhun/ratty";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      ratty,
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" ] (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        desktopFile = pkgs.writeText "ratty.desktop" ''
          [Desktop Entry]
          Name=Ratty
          Exec=ratty
          Icon=ratty
          Type=Application
          Categories=Utility;
          Terminal=false
        '';
        runtimeLibs = with pkgs; [
          wayland
          libxkbcommon
          vulkan-loader
          xorg.libX11
          xorg.libXcursor
          xorg.libXi
          xorg.libXrandr
        ];
      in
      {
        meta = with pkgs; {
          license = licenses.mit;
          platforms = platforms.linux;
          mainProgram = "ratty";
        };

        packages = {
          default = pkgs.rustPlatform.buildRustPackage {
            pname = "ratty";
            version = "0-unstable-${builtins.substring 0 8 ratty.rev}";

            src = ratty;

            nativeBuildInputs = with pkgs; [
              pkg-config
              makeWrapper
            ];

            buildInputs =
              with pkgs;
              [
                fontconfig
              ]
              ++ runtimeLibs;

            cargoLock = {
              lockFile = "${ratty}/Cargo.lock";
            };

            postInstall = # bash
              ''
                wrapProgram $out/bin/ratty \
                --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath runtimeLibs}

                install -Dm644 ${desktopFile} $out/share/applications/ratty.desktop
              '';
          };
        };
      }
    );
}
