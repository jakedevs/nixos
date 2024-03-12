{ lib, stdenvNoCC, fetchFromGitHub, gtk-engine-murrine }:
stdenvNoCC.mkDerivation {
  pname = "andromeda-gtk-theme";
  version = "0-unstable-2024-03-04";

  src = fetchFromGitHub {
    owner = "EliverLara";
    repo = "Andromeda-gtk";
    rev = "250751a546dd0fa2e67eef86d957fbf993b61dfe";
    hash = "sha256-exr9j/jW2P9cBhKUPQy3AtK5Vgav5vOyWInXUyVhBk0=";
  };

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes/Andromeda-gtk
    cp -r $src/* $out/share/themes/Andromeda-gtk
    runHook postInstall
  '';

  meta = with lib; {
    description = "An elegant dark theme for gnome, mate, budgie, cinnamon, xfce";
    homepage = "https://github.com/EliverLara/Andromeda-gtk";
    license = licenses.gpl3Only;
    platforms = platforms.linux;
    maintainers = with maintainers; [ jakedevs ];
  };
}

