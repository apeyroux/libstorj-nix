{ pkgs ? import <nixpkgs> {} } :

with pkgs;

stdenv.mkDerivation {
  name = "libstorj";
  src = fetchFromGitHub {
    owner = "Storj";
    repo = "libstorj";
    rev = "v1.0.1";
    sha256 = "0wc7q789nzfipw3g7npglyx6yib18jw8xq9cx28pipsf63v5siba";
  };

  buildInputs = [ libmicrohttpd bsdbuild autoconf m4 automake nettle
                  json_c libuv libtool pkgconfig perlPackages.DataHexDump curl ];
  
  preConfigure = ''
     ./autogen.sh
  '';

  postFixup = ''
    patchelf --add-needed $out/lib/libstorj.so.0 $out/bin/storj
  '';
}
