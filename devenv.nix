{ pkgs, ... }: {
  packages = [ pkgs.git ];

  # Keep these versions the same as .tool-versions.
  languages.erlang = {
    enable = true;
    package = pkgs.beam.interpreters.erlang_29;
  };

  languages.elixir = {
    enable = true;
    package = pkgs.beam.packages.erlang_29.elixir_1_20;
  };

  enterShell = ''
    elixir --version
  '';
}
