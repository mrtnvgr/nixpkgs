{
  stdenvNoCC,
  lib,
  fetchzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  name = "auburn-sounds-selene";
  version = "1.0.0";

  src = fetchzip {
    url = "https://www.auburnsounds.com/downloads/Selene-FREE-${finalAttrs.version}.zip";
    hash = "sha256-BRk9RBqhUzFILisNzEcZ2D50ulCKI3NvwDH3sLVFv/w=";
  };

  doNotBuild = true;

  installPhase = let
    mkInstaller = format: ''
      mkdir -p $out/lib/${format}
      cp -r "Linux-64b-${lib.toUpper format}-FREE/Auburn Sounds Selene.${format}" $out/lib/${format}
    '';
    mkInstallers = formats: lib.concatStringsSep "\n" (map mkInstaller formats);
  in ''
    runHook preInstall

    pushd Linux
      ${mkInstallers [ "clap" "lv2" "vst3" ]}
    popd

    runHook postInstall
  '';

  meta = {
    description = "Versatile algorithmic reverberation with a pristine adaptive sound";
    homepage = "https://www.auburnsounds.com/products/Selene.html";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "x86_64-linux" ];
    license = lib.licenses.unfree;
    maintainers = [ lib.maintainers.mrtnvgr ];
  };
})
