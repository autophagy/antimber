{
  lib,
  stdenv,
  fetchurl,
  nodejs_22,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "pi-coding-agent";
  version = "0.84.3";

  src = fetchurl {
    url = "https://registry.npmjs.org/@earendil-works/pi-coding-agent/-/pi-coding-agent-${version}.tgz";
    hash = "sha256-0H3EF/eKFNrDdqh4tlVrUZYfEY95dx7jdTM9xRNWvHU=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/${pname}
    cp -r dist package.json $out/lib/${pname}/

    makeWrapper ${nodejs_22}/bin/node $out/bin/pi \
      --add-flags $out/lib/${pname}/dist/bundle/cli.js

    runHook postInstall
  '';

  meta = {
    description = "Minimal, extensible terminal coding agent harness (BYOK, multi-provider)";
    homepage = "https://pi.dev/";
    license = lib.licenses.mit;
    mainProgram = "pi";
    platforms = nodejs_22.meta.platforms;
  };
}
