'Hello world' | Set-Content .\test.pdf

@"
[ZoneTransfer]
ZoneId=3
"@ | Set-Content -Path .\test.pdf -Stream Zone.Identifier
