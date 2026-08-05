{
  lib,
  stdenv,
  fetchurl,
  nodejs,
  makeWrapper,
}:

stdenv.mkDerivation rec {
  pname = "purs-tidy";
  version = "0.11.1";

  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-+bX+NntwZw7YYgO1kkSGSLnpXb8imgPB2QCjRH6hsoE=";
  };

  nativeBuildInputs = [ makeWrapper ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/${pname}
    cp -r bundle bin package.json $out/lib/${pname}/

    makeWrapper ${nodejs}/bin/node $out/bin/${pname} \
      --add-flags $out/lib/${pname}/bin/index.js

    runHook postInstall
  '';

  meta = {
    description = "A syntax tidy-upper (formatter) for PureScript";
    homepage = "https://github.com/natefaubion/purescript-tidy";
    license = lib.licenses.mit;
    mainProgram = "purs-tidy";
    platforms = nodejs.meta.platforms;
  };
}
