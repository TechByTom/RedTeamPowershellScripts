function Search-FullNameToSamAccount {
	# Mr.Un1k0d3r - RingZer0 Team 2017
	# Get SamAccountName using Full name search
	# dependencies ActiveDirectory module
	
	param(
		[Parameter(Mandatory=$True, ValueFromPipeline=$true)]
		[string]$Filter
	)
  
	BEGIN {
		$module = Get-Module -List ActiveDirectory
		if($module) {
			Import-Module ActiveDirectory
		} else {
			throw "[-] ERROR: ActiveDirectory cannot be imported. Aborting..."
		}
		Write-Output "[*] Searching for $($Filter)"
	}
	
	PROCESS {
        	$Users = Get-ADUser -Filter{displayName -like $Filter -and Enabled -eq $True} -Properties SamAccountName, displayName
		if($Users) {
			ForEach($user in $Users) {
				Write-Output "[+] Found: $($user.displayName) -> $($user.SamAccountName)"
			}
		} else {
			Write-Output "[-] Search filter returned nothing..."
		}
	}
	
	END {
		Write-Output "[*] Process completed..."
	}
}
