{
  mkShell,
  lib,
  darwin,
  inotify-tools,
  stdenv,
  statix,
  deadnix,
  glibcLocales,
  xc,
  overmind,
}:
mkShell {
  packages =
    [
      deadnix
      glibcLocales
      xc
      overmind
      statix
    ]
    ++ lib.optionals stdenv.isLinux [
      inotify-tools
    ]
    ++ lib.optionals stdenv.isDarwin [
      darwin.apple_sdk.frameworks.CoreFoundation
      darwin.apple_sdk.frameworks.CoreServices
    ];

  shellHook = ''
    export LANG=en_US.UTF-8
  '';
}
