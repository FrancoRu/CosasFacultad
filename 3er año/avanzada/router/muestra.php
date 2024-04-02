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
      $tbody .= '<button class="btn btn-success mx-1" >Delete</button>
                   <button class="btn btn-secondary mx-1" >Finished</button>
                 </div></td> </tr>';
    }
    return $tbody;
  }
}
