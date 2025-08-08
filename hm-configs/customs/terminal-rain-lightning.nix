{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "terminal-rain-lightning";
  version = "1.0.0";  # You can specify a version or use a commit hash

  src = pkgs.fetchFromGitHub {
    owner = "rmaake1";
    repo = "terminal-rain-lightning";
    rev = "master";  # specify the branch or commit
    sha256 = "0plw88jnhgkplapfgaq7ly63zc36h5nr9ygs9wagckhz5b3f0193";  # Replace with the actual SHA256 hash
  };

  buildInputs = [ pkgs.pipx pkgs.python3 ];  # Add necessary build dependencies

  # Define the build phases
  buildPhase = ''
    export HOME="$TMPDIR"
    export PIPX_HOME="$HOME/.local/pipx"
    export PIPX_BIN_DIR="$HOME/.local/pipx/bin"
    pipx install --editable . --pip-args="--no-cache-dir --disable-pip-version-check"
  '';

  #installPhase = ''
    ## No additional installation steps needed, pipx handles it
    #echo "Installed ${pname} using pipx"
  #'';
}
