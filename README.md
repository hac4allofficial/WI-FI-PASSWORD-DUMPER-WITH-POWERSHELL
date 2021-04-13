WI-FI PASSWORD DUMPER WITH POWERSHELL
THIS SIMPLE COMMAND WILL HELP YOU TO SEE YOUR WIFI PASSWORD'S
WI-FI PASSWORDS =DUMP
ANDROID HOTSPOT PASSWORD =DUMP

Dump All Wi-Fi Passwords with Windows PowerShell

Command: (netsh wlan show profiles) | Select-String “\:(.+)$” | %{$name=$_.Matches.Groups[1].Value.Trim(); $_} | %{(netsh wlan show profile name=”$name” key=clear)} | Select-String “Key Content\W+\:(.+)$” | %{$pass=$_.Matches.Groups[1].Value.Trim(); $_} | %{[PSCustomObject]@{ PROFILE_NAME=$name;PASSWORD=$pass }} | Format-Table -AutoSize
