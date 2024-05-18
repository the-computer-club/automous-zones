
{
  outputs = {self, ...}:
  let
    policy = import ./policy.nix { inherit self; };
  in
  {
    lib = import ./lib.nix;

    flakeModules.asluni.wireguard.networks =
    rec {
      asluni = import ./luninet.nix;
      unallocatedspace = asluni;
    };
  };
}
