{
  stdenvNoCC,
  fetchFromGitLab,
  lib,
}:

stdenvNoCC.mkDerivation rec {
  pname = "ufetch";
  version = "0.3";

  src = fetchFromGitLab {
    owner = "jschx";
    repo = "ufetch";
    rev = "v${version}";
    hash = "sha256-1LtVCJrkdI2AUdF5d/OBCoSqjlbZI810cxtcuOs/YWs=";
  };

  patches = [ ./0001-optimize-packages-command.patch ];

  installPhase = ''
    runHook preInstall
    install -Dm755 ufetch-nixos $out/bin/ufetch
    runHook postInstall
  '';

  meta = {
    description = "Tiny system info for Unix-like operating systems";
    homepage = "https://gitlab.com/jschx/ufetch";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
    mainProgram = "ufetch";
    maintainers = with lib.maintainers; [ mrtnvgr ];
  };
}
