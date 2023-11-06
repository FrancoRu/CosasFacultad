<?php

if (preg_match('/^(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).+$/', 'Profesaki123@')) {
  echo 'Valido';
}
if (empty('Profesaki') || strlen('Profesaki') > 25 || strlen('Profesaki') < 5 || !is_string('Profesaki')) {
  echo 'inValido';
} else {
  echo 'Valido user';
}
