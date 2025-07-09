<!DOCTYPE html>
<html>
<head>
    <title>Upload de Imagem</title>
</head>
<body>
    <h1>Teste de Upload de Imagem</h1>

    <?php if(session('success')): ?>
        <p style="color: green;"><?php echo e(session('success')); ?></p>
        <img src="<?php echo e(session('path')); ?>" style="max-width: 300px;">
    <?php endif; ?>

    <?php if(session('error')): ?>
        <p style="color: red;"><?php echo e(session('error')); ?></p>
    <?php endif; ?>

    <form action="<?php echo e(route('upload.image')); ?>" method="POST" enctype="multipart/form-data">
        <?php echo csrf_field(); ?>
        <label for="foto">Escolha uma imagem:</label>
        <input type="file" name="foto" id="foto" required>
        <button type="submit">Enviar</button>
    </form>
</body>
</html>
<?php /**PATH C:\Users\Gabriel\app-lembrete\backend\resources\views/upload-form.blade.php ENDPATH**/ ?>