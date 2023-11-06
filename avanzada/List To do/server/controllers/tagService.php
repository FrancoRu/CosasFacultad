<?php

class TagService
{
  private static $instance;

  private function __construct()
  {
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new TagService();
    }
    return self::$instance;
  }
  public function getFormLogin()
  {
    $form = '<form id="loginForm">
    <label for="username">Usuario</label>
    <input
      type="text"
      name="username"
      required
      minlength="5"
      maxlength="25" />

    <label for="password">Contraseña</label>
    <input
      type="password"
      name="password"
      required
      minlength="5"
      maxlength="25" />
    <input type="submit" value="Ingresar" class="app-button" />
  </form>';
    echo json_encode($form, JSON_HEX_TAG | JSON_HEX_QUOT);
  }
  public function getHome()
  {
    echo json_encode('<h1>Profesaki rompiste todo</h1>', JSON_HEX_TAG | JSON_HEX_QUOT);
  }
}
