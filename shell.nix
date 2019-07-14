{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  erlang = beam.packages.erlangR22;
  ls = callPackage elixirLS {
    inherit (erlang) hex rebar3;
    elixir = erlang.elixir_1_8;
  };
in
  mkShell {
    buildInputs = [ erlang.elixir_1_9 ls ];
  }
