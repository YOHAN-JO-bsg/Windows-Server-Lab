# =====================================================================
# Script Name: HTTP_80_ALLOW.ps1
# Description: IIS 전용 웹 트래픽(HTTP 80) 인바운드 방화벽 규칙 자동 수립 스크립트
# Author: YOHAN
# Target OS: Windows Server 2022
# =====================================================================

$RuleName = "HTTP_80_ALLOW"
$Port = 80

Write-Host "Checking for existing firewall rule: $RuleName..." -ForegroundColor Cyan

# 동일한 이름의 방화벽 규칙이 이미 존재하는지 검증
$ExistingRule = Get-NetFirewallRule -DisplayName $RuleName -ErrorAction SilentlyContinue

if ($ExistingRule) {
    Write-Host "Firewall rule '$RuleName' already exists. Ensuring it is Enabled." -ForegroundColor Yellow
    Enable-NetFirewallRule -DisplayName $RuleName
} else {
    Write-Host "Creating new Inbound Firewall Rule: $RuleName (TCP Port $Port)" -ForegroundColor Green
    # 마우스로 클릭했던 작업을 PowerShell 코드로 완전 자동화
    New-NetFirewallRule -DisplayName $RuleName `
                        -Direction Inbound `
                        -Action Allow `
                        -Protocol TCP `
                        -LocalPort $Port `
                        -Profile Any `
                        -Description "Custom infrastructure rule for IIS Web Server HTTP traffic."
}

# 최종 반영 상태 출력 검증
Get-NetFirewallRule -DisplayName $RuleName | Select-Object DisplayName, Enabled, Action, Protocol, LocalPort
