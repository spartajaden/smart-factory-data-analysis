# 관리자 권한 확인
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    Exit
}

$hostsFile = "$env:windir\System32\drivers\etc\hosts"
$marker = "# --- HADOOP DOCKER CLUSTER ---"
$hostsEntries = @"
127.0.0.1 namenode
127.0.0.1 datanode1
127.0.0.1 datanode2
127.0.0.1 datanode3
"@

$content = Get-Content $hostsFile -Raw
if ($content -notmatch $marker) {
    Write-Host "Adding Hadoop cluster entries to hosts file..."
    Add-Content $hostsFile "`n$marker`n$hostsEntries`n# --- END HADOOP DOCKER CLUSTER ---"
    Write-Host "Done." -ForegroundColor Green
} else {
    Write-Host "Hadoop cluster entries already exist in hosts file." -ForegroundColor Yellow
}
