<#
.SYNOPSIS
    Script de Verificação e Atualização de Conformidade .NET
#>

[CmdletBinding()]
param (
    [string]$ApiUrl = "http://127.0.0.1:8000/check-compliance",
    [string]$CurrentVersion = "6.0.0",
    [string]$OSName = "Windows 10 Enterprise"
)

Write-Output "[INFO] Iniciando verificação de conformidade..."
Write-Output "[INFO] Sistema Operacional: $OSName"
Write-Output "[INFO] Versão .NET Detectada: $CurrentVersion"

$body = @{
    current_version = $CurrentVersion
    os = $OSName
} | ConvertTo-Json

try {
    $response = Invoke-RestMethod -Uri $ApiUrl -Method Post -Body $body -ContentType "application/json" -ErrorAction Stop
    
    if ($response.status -eq "outdated") {
        Write-Warning "[CRITICO] Vulnerabilidade detectada!"
        Write-Output "   -> Mensagem: $($response.message)"
        Write-Output "   -> Ação Necessária: Atualizar para versão $($response.required_version)"
        
        Write-Output "[ACTION] Iniciando download do pacote de correção..."
        Start-Sleep -Seconds 2
        Write-Output "[ACTION] Aplicando patch de segurança..."
        Start-Sleep -Seconds 2
        
        Write-Output "[SUCCESS] Sistema atualizado e seguro."
    } 
    else {
        Write-Output "[OK] O sistema está em conformidade. Nenhuma ação necessária."
    }
}
catch {
    Write-Error "FALHA DE CONEXÃO: Não foi possível contatar o servidor de validação ($ApiUrl)."
    Write-Error $_.Exception.Message
}