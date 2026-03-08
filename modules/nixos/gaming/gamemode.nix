{
  programs.gamemode = {
    enable = true;
    settings = {
      general = {
        softrealtime = "auto";
        renice = 15;
      };
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 0;
        nv_powermizer_mode = 1;
      };
      custom = {
        start = "cpupower frequency-set -g performance";
        end = "cpupower frequency-set -g powersave";
      };
    };
  };
}