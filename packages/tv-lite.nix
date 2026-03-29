{
  lib,
  stdenv,
  fetchFromGitLab,
  cmake,
  pkg-config,
  gettext,
  wxwidgets_3_2,
  gtk3,
  vlc,
  sqlite,
  curl,
  rapidjson,
  libuuid,
  libx11,
}:

stdenv.mkDerivation rec {
  pname = "tv-lite";
  version = "0.8.1";

  src = fetchFromGitLab {
    owner = "cburneci";
    repo = "tv-lite";
    rev = version;
    hash = "sha256-5OPOmMN3CUhLR9TUN0omPVFLmrsyEe4FpPLVVAhcuIk=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    gettext
  ];

  buildInputs = [
    wxwidgets_3_2
    gtk3
    vlc
    sqlite
    curl
    rapidjson
    libuuid
    libx11
  ];

  sourceRoot = "${src.name}/src";

  cmakeFlags = [
    "-DCMAKE_INSTALL_PREFIX=${placeholder "out"}"
    "-DLOCALEDIR=${placeholder "out"}/share/locale"
  ];

  postPatch = ''
    # Fix hardcoded locale path
    substituteInPlace CMakeLists.txt \
      --replace-warn 'set(LOCALEDIR "/usr/share/locale")' \
                     'set(LOCALEDIR "${placeholder "out"}/share/locale")'

    # Use cmake build directory for output instead of a sibling directory
    substituteInPlace CMakeLists.txt \
      --replace-warn 'set(CL_OUTPUT_DIRECTORY ''${CMAKE_CURRENT_LIST_DIR}/''${CL_WORKSPACE_DIRECTORY}/cmake-build-''${CONFIGURATION_NAME}/output)' \
                     'set(CL_OUTPUT_DIRECTORY ''${CMAKE_CURRENT_BINARY_DIR}/output)'
  '';

  meta = with lib; {
    description = "IPTV viewer with Sopcast and Acestream handling capabilities";
    homepage = "https://gitlab.com/cburneci/tv-lite";
    license = licenses.gpl2Plus;
    platforms = platforms.linux;
    mainProgram = "TVLite";
  };
}
