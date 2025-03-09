{
  # Garbage collect the Nix store
  nix.gc = {
    automatic = false;
    # Change how often the garbage collector runs (default: weekly)
    frequency = "weekly";
  };
}
