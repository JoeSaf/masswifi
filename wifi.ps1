Write-Host "`n📡 Saved WiFi Networks & Passwords`n" -ForegroundColor Cyan

(netsh wlan show profiles) | Select-String "\:(.+)$" | ForEach-Object {
    $name = $_.Matches.Groups[1].Value.Trim()
    
    Write-Host "🔹 $name" -ForegroundColor Yellow
    
    (netsh wlan show profile name="$name" key=clear) | Select-String "Key Content\W+:\W+(.+)$" | ForEach-Object {
        $pass = $_.Matches.Groups[1].Value.Trim()
        Write-Host "   🔑 $pass" -ForegroundColor Green
    }

    Write-Host ""
}

Write-Host "✅ Done.`n"
