{ 
  lib,
  maven,
  jdk,
  fetchFromGitHub,
  makeWrapper
}:

maven.buildMavenPackage rec {
  pname = "ceb2txt";
  version = "0.2.1";

  mvnHash = "sha256-If3PUV1tD91yU9omksiOFYjbIMYSoA13Q0qydCR/TTs=";

  src = fetchFromGitHub {
    owner = "iNPUTmice";
    repo = pname;
    rev = version;
    hash = "sha256-On9Yxx1mu54nKy64ieX9tSaORoIXwJ+AwfF2A1bKy3I=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm644 target/im.conversations.ceb2txt-*.jar $out/share/ceb2txt/ceb2txt.jar

    runHook postInstall
  '';

  postFixup = ''
    makeWrapper ${lib.getExe jdk} $out/bin/ceb2txt \
      --add-flags "-jar $out/share/ceb2txt/ceb2txt.jar"
  '';

  meta = {
    description = "A small tool that can convert ceb (Conversations Encrypted Backup) files to simple plain text.";
    homepage = "https://github.com/iNPUTmice/ceb2txt";
    license = lib.licenses.asl20;

  };
}
