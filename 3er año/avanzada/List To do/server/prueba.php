<?php


if (password_verify("Fran12@", "$2y$10$PtLkwtPdAeWfX11mVmJLle/z14rLzSzqaLXPFWyro5DvSBKTrzg/m")) {
  echo 'Son iguales';
} else {
  echo "no anda";
}
