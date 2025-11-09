{
  pkgs,
  ...
}:

let
  emacs-package =
    with pkgs;
    (emacsPackagesFor emacs-pgtk).emacsWithPackages (epkgs: [
      epkgs.vterm
      (epkgs.treesit-grammars.with-grammars (grammars: [
        grammars.tree-sitter-nu
        grammars.tree-sitter-tsx
        grammars.tree-sitter-typescript
      ]))
      epkgs.jinx
      epkgs.lsp-bridge
    ]);
in
{
  home.packages = with pkgs; [
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
      ]
    ))
  ];

  programs.emacs = {
    enable = true;
    package = emacs-package;
    extraConfig = ''
      (setq standard-indent 2)
    '';
  };

  services.emacs = {
    enable = true;
    package = emacs-package;

    defaultEditor = true;
    # socketActivation.enable = true;

    client.enable = true;
  };

  # using emacs theme
  stylix.targets.emacs.enable = false;
}
