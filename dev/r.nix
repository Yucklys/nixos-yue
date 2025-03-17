{ config, pkgs, inputs, ... }:

with pkgs;
let
  R-packages = rWrapper.override{ packages = with rPackages; [ dplyr
                                                               xts
                                                               rmarkdown
                                                             ]; };
  
  Rstudio-packages = rstudioWrapper.override {
    packages = with pkgs.rPackages; [ dplyr
                                 devtools
                                 rmarkdown
                                 tidyverse
                                 tinytex
                               ]; };
in
{
  environment.systemPackages = with pkgs; [
    R-packages
    Rstudio-packages
 ];
}
