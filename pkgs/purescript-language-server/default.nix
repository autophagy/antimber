{
  lib,
  buildNpmPackage,
  fetchurl,
}:

let
  version = "0.18.5";
  packageLock = fetchurl {
    url = "https://raw.githubusercontent.com/nwolverson/purescript-language-server/v${version}/package-lock.json";
    hash = "sha256-UnVvTh9EZvQDX+zFIvvpm7vBSrYHo67yHYSE5h0/fDk=";
  };
in
buildNpmPackage rec {
  pname = "purescript-language-server";
  inherit version;

  src = fetchurl {
    url = "https://registry.npmjs.org/${pname}/-/${pname}-${version}.tgz";
    hash = "sha256-K0pVq07nHdo/n+spBDfc8riwgzRMq4SQCJ1sqrEjNB0=";
  };

  postPatch = ''
    cp ${packageLock} package-lock.json
  '';

  npmDepsHash = "sha256-rWeLLxjaTBJx+TnKiXn6/QDwee0kcrjYGLNGijFR2s8=";

  npmFlags = [ "--ignore-scripts" ];

  dontNpmBuild = true;

  meta = {
    description = "Language Server Protocol server for PureScript wrapping purs ide";
    homepage = "https://github.com/nwolverson/purescript-language-server";
    license = lib.licenses.mit;
    mainProgram = "purescript-language-server";
  };
}
