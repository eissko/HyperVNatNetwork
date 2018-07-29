$MySwitchName="MyNatSwitch"
$NetNatName="MyNatNetwork"
$Gw="10.1.1.1"
$Net="10.1.1.0/24"

New-VMSwitch -SwitchName $MySwitchName -SwitchType Internal -Verbose
$ifIndex=(Get-NetIPInterface | where-object {$_.InterfaceAlias -like "*$MySwitchName*"}).ifIndex
New-NetIPAddress -IPAddress $GW -PrefixLength 24 -InterfaceIndex $ifIndex -Verbose
New-NetNat -Name $NetNatName -InternalIPInterfaceAddressPrefix $Net -Verbose

##inside vm
## $ifIndex=(Get-NetAdapter).ifIndex
##New-NetIPAddress -IPAddress 10.1.1.100 -DefaultGateway 10.1.1.1 -PrefixLength 24 -InterfaceIndex $ifIndex 
##get-NetFirewallRule | Where-Object {$_.DisplayName -like "File and Printer Sharing (Echo Request - ICMPv4-In)" | Enable-NetFirewallRule
##Set-DnsClientServerAddress -ServerAddresses 10.1.1.1 -InterfaceIndex $ifIndex
#