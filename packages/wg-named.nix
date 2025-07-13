{ lib, buildPythonApplication, fetchFromGitHub }:
buildPythonApplication rec {
  src = fetchFromGitHub {
    owner = "Skarlett";
    repo = "wgnamed";
    rev = "master";
    sha256 = "";
  };
  pname = "wgnamed";
  version = "0.1.0";
}
