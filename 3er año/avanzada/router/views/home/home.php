<?php
require_once(__DIR__ . '/../layouts/header.php');
?>


<button type="button" id="agregar_proyeto" class="btn btn-light">Agregar Proyecto</button>

<div class="container" id="tabla__container">
  <table id="tabla" class="table table-dark table-striped" style="width:100%;">
    <thead>
      <tr>
        <th>Id</th>
        <th>Nombre</th>
        <th>Fecha inicio</th>
        <th>Fecha Finalizacion</th>
        <th>Acciones</th>
      </tr>
    </thead>
    <tbody>

    </tbody>
  </table>

</div>

<?php
require_once(__DIR__ . '/../layouts/footer.php');
?>