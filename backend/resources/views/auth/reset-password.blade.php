<!-- resources/views/auth/reset-password.blade.php -->

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <title>Redefinir Senha</title>
    <style>
        body {
            margin: 0;
            background-color: #f6f9fc;
            font-family: Arial, sans-serif;
        }
        .header {
            background-color: #34495E;
            color: white;
            padding: 16px;
            text-align: left;
        }
        .container {
            padding: 24px;
        }
        .title {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 12px;
        }
        .subtitle {
            margin-bottom: 24px;
        }
        input[type="email"],
        input[type="password"] {
            width: 100%;
            padding: 12px;
            border-radius: 20px;
            border: 1px solid #ccc;
            margin-bottom: 16px;
            box-sizing: border-box;
        }
        .btn {
            width: 100%;
            background-color: #34495E;
            color: white;
            padding: 14px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="header">
        <h3>← Voltar</h3>
    </div>

    <div class="container">
        <div class="title">Esqueceu a Senha</div>
        <div class="subtitle">Digite a nova senha abaixo</div>

        <form method="POST" action="{{ route('password.update') }}">
            @csrf

            <input type="hidden" name="token" value="{{ $token }}">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Nova senha" required>
            <input type="password" name="password_confirmation" placeholder="Confirmar senha" required>

            <button class="btn" type="submit">Trocar</button>
        </form>
    </div>
</body>
</html>
