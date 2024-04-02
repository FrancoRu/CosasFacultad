<?php require_once 'layout/header.php' ?>
<main class="flex-grow-1 bg-light p-3" style="margin-top: 60px;">
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-md-4 login-container">
                <div class="text-center">
                    <h2 class="mb-4">Login</h2>
                </div>
                <?php if (isset($error_message)) : ?>
                <div class="alert alert-danger" role="alert">
                    <?php echo $error_message; ?>
                </div>
                <?php endif; ?>
                <form action="/home" method="post">
                    <input type="hidden" name="action" value="login">
                    <?php require_once 'util/inputForm.html'?>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px">Log in</button>
                    </div>
                </form>
                <p class="mt-3 text-center">Don't have an account? <a href="/signup">Sign up</a></p>
            </div>
        </div>
    </div>
</main>
<?php require_once 'layout/footer.php' ?>