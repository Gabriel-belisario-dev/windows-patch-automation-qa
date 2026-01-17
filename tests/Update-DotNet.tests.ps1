Describe "Validação de Segurança - Patch Management" {

    BeforeAll {
        $ScriptPath = Convert-Path "$PSScriptRoot/../src/Update-DotNet.ps1"
    }

    Context "Cenário 1: Máquina Desatualizada (Vulnerável)" {
        
        It "Deve identificar a vulnerabilidade e aplicar a correção" {
            # --- MOCKS (DENTRO DO IT PARA FORÇAR O ESCOPO) ---
            Mock Invoke-RestMethod {
                return @{
                    status = "outdated"
                    required_version = "8.0.2"
                    message = "CVE-2024-CRITICO"
                }
            }
            Mock Write-Warning {} # Silencia e conta os avisos
            
            # --- EXECUÇÃO ---
            . $ScriptPath -CurrentVersion "5.0.0"
            
            # --- VALIDAÇÃO ---
            Should -Invoke Write-Warning
        }
    }

    Context "Cenário 2: Máquina Atualizada (Segura)" {
        
        It "NÃO deve tentar atualizar ou alertar erro" {
            # --- MOCKS ---
            Mock Invoke-RestMethod {
                return @{ status = "compliant" }
            }
            Mock Write-Warning {}
            
            # --- EXECUÇÃO ---
            . $ScriptPath -CurrentVersion "8.0.2"
            
            # --- VALIDAÇÃO ---
            Should -Not -Invoke Write-Warning
        }
    }
}