{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "trans-cmatrix";
  version = "1.0.0";

  src = pkgs.fetchFromGitHub {
    owner = "dylan-park";
    repo = "trans-cmatrix";
    rev = "master"; # specify the branch or commit
    sha256 = "sha256-Cu+CX4Sx4OYmDabu4DfD4JTXgNCyyAIB4lO8vXzmHYg=";
  };

  buildInputs = [ pkgs.ncurses pkgs.autoconf pkgs.automake pkgs.libtool ]; # Add necessary build dependencies

  # Define the build phases
  buildPhase = ''
    autoreconf -i
    ./configure --prefix=$out
    make
  '';

  installPhase = ''
    make install
  '';
}
