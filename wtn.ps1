Param (
    [string]$Message,
    [string]$ChatId
)

# Параметры бота
$tokenFilePath = "bot_token.txt"
$botToken = Get-Content -Path $tokenFilePath -Raw
$botToken = $botToken.Trim()  # Убираем лишние пробелы и переносы строк

# URL API Telegram
$apiUrl = "https://api.telegram.org/bot$botToken/sendMessage"

# Проверка, что параметры Message и ChatId заданы
if (-not $Message) {
    Write-Host "Ошибка: Не указан текст сообщения."
    exit
}

if (-not $ChatId) {
    Write-Host "Ошибка: Не указан chat_id."
    exit
}

# Формируем тело запроса вручную
$body = @{
    chat_id = $ChatId
    text    = $Message
} | ConvertTo-Json -Depth 3

try {
    # Устанавливаем кодировку для запроса в UTF-8
    $utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $false
    $bodyBytes = [Text.Encoding]::UTF8.GetBytes($body)
    $bodyUtf8 = [System.Text.Encoding]::UTF8.GetString($bodyBytes)

    # Отправка запроса
    $response = Invoke-RestMethod -Uri $apiUrl -Method Post -ContentType "application/json; charset=utf-8" -Body $bodyUtf8 -Headers @{ "Accept-Encoding" = "utf-8" }

    if ($response.ok) {
        Write-Host "Сообщение успешно отправлено."
    } else {
        Write-Host "Не удалось отправить сообщение. Ошибка:" $response.description
    }
}
catch {
    Write-Host "Произошла ошибка при отправке сообщения:" $_.Exception.Message
}
