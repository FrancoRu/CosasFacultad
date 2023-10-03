<?php require_once 'layout/header.php' ?>

<main class="flex-grow-1 bg-light p-3" style="margin-top: 60px;">
    <div class="container-fluid">
        <div class="row justify-content-center">
            <div class="col-md-4 signup-container">
                <div class="text-center">
                    <h2 class="mb-4">Sign Up</h2>
                </div>
                <?php if (isset($error_message)) : ?>
                <div class="alert alert-danger" role="alert">
                    <?php echo $error_message; ?>
                </div>
                <?php endif; ?>
                <form action="/signup" method="post">
                    <input type="hidden" name="action" value="signup">
                    <?php require_once 'util/inputForm.html'?>
                    <div class="form-group">
                        <label for="signup_confirm_password">Confirm Password:</label>
                        <input type="password" id="signup_confirm_password" name="confirm_password" class="form-control"
                            placeholder="Confirm password" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary btn-block" style="margin-top: 10px">Sign
                            Up</button>
                    </div>
                </form>
                <p class="mt-3 text-center">Already have an account? <a href="/login">Log in</a></p>
            </div>
        </div>
    </div>
</main>
<?php require_once 'layout/footer.php' ?>