{ stdenv, fetchFromGitHub, lib, postgresql }: 

stdenv.mkDerivation {
  name = "pg_hashids";
  version = "1.2.1";
  src = fetchFromGitHub {
    owner = "iCyberon";
    repo = "pg_hashids";
    rev = "16907249ccbc300b31c89c3eccd6042c5674505f";
    sha256 = "1780mf42hyhbfmx3vwa9k3fkx50fwbmp8cj231fmyr3hp0k3896v";
  };
  USE_PGXS = "1";
  buildInputs = [ postgresql ];
  buildPhase = "make";
  installPhase = ''
    mkdir -p $out/bin    # For buildEnv to setup proper symlinks. See #22653
    mkdir -p $out/{lib,share/postgresql/extension}

    cp *.so      $out/lib
    cp *.sql     $out/share/postgresql/extension
    cp *.control $out/share/postgresql/extension
  '';

  meta = with lib; {
    description = "PostgreSQL extension for generating short unique ids from integers";
    homepage = "https://github.com/iCyberon/pg_hashids";
    maintainers = [ ];
    platforms = postgresql.meta.platforms;
    license = licenses.mit;
  };
}
