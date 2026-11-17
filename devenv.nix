{ pkgs, ... }: {
  packages = [ pkgs.git ];

  languages.erlang.enable = true;
  languages.elixir.enable = true;

  enterShell = ''
    elixir --version
  '';
}
