from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI()

# --- Simulação de Banco de Dados ---
# Em um cenário real, isso viria de um banco de dados ou consultaria a Microsoft.
# Aqui, definimos manualmente qual é a versão "Segura" para teste.
LATEST_DOTNET_VERSION = "8.0.2" 
VULNERABILITY_MSG = "Sua versão possui vulnerabilidades críticas (CVE-2024-XXXX). Atualize imediatamente."

# Modelo de dados que esperamos receber do computador do usuário
class AgentRequest(BaseModel):
    current_version: str
    os: str

@app.post("/check-compliance")
def check_version(agent: AgentRequest):
    """
    Recebe a versão atual do agente e compara com a versão segura.
    """
    print(f"Recebi uma verificação de: {agent.os} rodando versão {agent.current_version}")
    
    # Compara strings de versão
    if agent.current_version < LATEST_DOTNET_VERSION:
        return {
            "status": "outdated",
            "required_version": LATEST_DOTNET_VERSION,
            "message": VULNERABILITY_MSG,
            "action": "upgrade"
        }
    
    return {
        "status": "compliant", 
        "message": "Sistema seguro e atualizado."
    }

@app.get("/")
def read_root():
    return {"Projeto": "WinPatch QA Suite", "Status": "Online"}