$server = "Server hostname or IPAddress"
$port = "8667"

$cmd = $args[0]
$arg1 = $args[1]
$arg2 = [System.Text.Encoding]::UTF8.GetBytes($args[2])

if ($cmd -eq "remlist") {
  Invoke-RestMethod -Method GET -Uri http://${server}:$port
} elseif ($cmd -eq "remind") {
  Invoke-RestMethod -Method POST -Uri http://${server}:$port -Body "{""time"":""${arg1}"",""param"":""${arg2}""}"
} elseif ($cmd -eq "remdel") {
  Invoke-RestMethod -Method DELETE -Uri http://${server}:$port -Body "{""param"":""${arg1}""}"
}
