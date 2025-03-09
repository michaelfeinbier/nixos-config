{...}: {

  services.cliphist = {
    enable = true;
    systemdTargets = "graphical.target";
  };
}