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

  public static function getFormLogin()
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
  public static function getHome()
  {
    echo json_encode('<h1>Profesaki rompiste todo</h1>', JSON_HEX_TAG | JSON_HEX_QUOT);
  }

  private static function transform($result)
  {
    $table = [
      'title' => [],  // Arreglo para las columnas
      'body' => []    // Arreglo para los registros
    ];
    // Verifica que $result sea un objeto válido
    if ($result && $result->num_rows > 0) {
      $firstRow = $result->fetch_assoc();
      $table['title'] = array_keys($firstRow);

      // Reinicia el puntero del resultado
      $result->data_seek(0);
      while ($row = $result->fetch_assoc()) {
        $table['body'][] = array_values($row);
      }
    }

    return $table;
  }


  public static function getTable($data)
  {
    $field = self::transform($data);
    $args = '<table id="table">' .
      self::getTitle($field['title']) .
      self::getBody($field['body']) .
      '</table>';
    return $args;
  }

  private static function getTitle($titles)
  {
    $thead = '<thead>
  <tr>';
    foreach ($titles as $title) {
      $thead .= '<th>' . $title . '</th>';
    }
    $thead .= '<th>Acciones</th>';
    $thead .= '</tr></thead>';
    return $thead;
  }

  private static function getBody($body)
  {
    $tbody = '';
    foreach ($body as $arg) {
      $tbody .= '<tr>';
      foreach ($arg as $registerValue) {
        $tbody .= '<td>' . $registerValue . '</td>';
      }
      $tbody .= '<td> <div>';
      if (isset($_POST['user_id'])) {
        $tbody .= '<button class="btn btn-success mx-1">Ver proyecto</button>';
      }
      $tbody .= '<button class="btn btn-secondary mx-1">Modificar</button>
    <button class="btn btn-danger mx-1">Eliminar</button>
    </div></td>';
      $tbody .= '</tr>';
    }
    return $tbody;
  }
}
