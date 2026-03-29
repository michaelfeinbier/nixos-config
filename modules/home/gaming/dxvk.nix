{

  # dxvk.conf for DX9/10/11 games (translated via DXVK)
  # Steam launch options: DXVK_CONFIG_FILE=/home/michael/.config/dxvk.conf mangohud %command%
  home.file.".config/dxvk.conf".text = ''
    dxgi.maxDeviceMemory = 9216
    dxgi.maxSharedMemory = 9216
  '';

  # DiabloIV uses DX12 (VKD3D-Proton, not DXVK) - dxvk.conf has no effect
  # VKD3D has no memory budget override; use VKD3D_CONFIG=no_upload_hvv to reduce VRAM pressure
  # Steam launch options: VKD3D_CONFIG=no_upload_hvv mangohud %command%
}