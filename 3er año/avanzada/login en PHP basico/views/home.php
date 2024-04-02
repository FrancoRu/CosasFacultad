<?php require_once 'layout/header.php' ?>
<main class="flex-grow-1 bg-light p-3" style="margin-top: 60px;"">
    <div class=" container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="text-center">
                <h1>Welcome <?php echo $_SESSION['username'] ?></h1>
                <button class="btn btn-primary text-center" id="linkButton" style="margin-top: 10px">log out</button>
            </div>
        </div>
    </div>
    </div>
</main>

<script>
// Agrega un evento de clic al botón para redirigir al usuario
document.getElementById("linkButton").addEventListener("click", function() {
    window.location.href = "/logout"; // Reemplaza "/" con la URL de la página a la que quieres redirigir
});
</script>
<?php require_once 'layout/footer.php' ?>