{ pkgs, ratty }:

let
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
    libx11
    libxcursor
    libxi
    libxrandr
  ];
in
pkgs.rustPlatform.buildRustPackage {
  pname = "ratty";
  version = "0-unstable-${builtins.substring 0 8 ratty.rev}";

  src = ratty;

  meta = with pkgs.lib; {
    description = "GPU-rendered terminal emulator with inline 3D graphics";
    homepage = "https://ratty-term.org/";
    downloadPage = "https://github.com/orhun/ratty";
    changelog = "https://github.com/orhun/ratty/blob/main/CHANGELOG.md";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "ratty";
  };

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

  postInstall = ''
    wrapProgram $out/bin/ratty \
    --prefix LD_LIBRARY_PATH : ${pkgs.lib.makeLibraryPath runtimeLibs}

    install -Dm644 ${desktopFile} $out/share/applications/ratty.desktop
  '';
}
