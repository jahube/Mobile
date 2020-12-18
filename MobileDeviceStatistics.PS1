$user = "affected@user.com"

#long INFO
Get-MobileDeviceStatistics -mailbox $user |FT DeviceType,DeviceOS,Status,deviceAccessState,DeviceAccessstateReason,deviceaccesscontrolrule,clientType,devicePolicyapplied

#short INFO
Get-MobileDeviceStatistics -mailbox $user |ft *son,*ate,*fri*,*lied,*us,*imei*,*type,*os

# read devices
$MD = Get-mobiledevice -Mailbox $user
 
# remove Blocked
Set-CASMailbox -identity $user -ActiveSyncBlockedDeviceIDs $Null

# remove existing (if needed)
# Set-CASMailbox -identity $user -ActiveSyncAllowedDeviceIDs $Null

# try to add all user devices
foreach ($M in $MD) { $id = $M.DeviceID;
Try { Set-CASMailbox -identity $user -ActiveSyncAllowedDeviceIDs @{add=$id}
} catch { Write-Host $Error[0] }}

<#
 -----------

clearing the blocked should solve it + check below

	
Check DeviceAccessStateReason
	 
	AadBlockDueToAccessPolicy / Security defaults using Native mail client + IMAP + blocking basic authentication
                                    Use Outlook Mobile or deactivate Security defaults

	conditional access policy / Company security defaults


	global it EAC in office 365
                                    EAC / Mobile / Check default quarantine action

	external is intune

also can happen  after factory reset

Outlook APP uses modern authentication
#>