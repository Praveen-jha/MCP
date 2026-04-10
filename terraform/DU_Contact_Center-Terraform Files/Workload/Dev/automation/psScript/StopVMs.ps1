workflow ict-platform-ccai-dev-aa-rb-vm-stop { # workflow name must matach with Stop runbook name.
    param (
        [Parameter(Mandatory = $true)]
        [String] $resourceGroupName,

        [Parameter(Mandatory = $true)]
        [String] $vmNames
    )

    $vmNamesArray = $vmNames -split ','

    foreach -parallel ($vmName in $vmNamesArray) {
        InlineScript {
            Write-Output "Stopping VM: $using:vmName in Resource Group: $using:resourceGroupName"
            try {
                Connect-AzAccount -Identity -ErrorAction Stop
                Stop-AzVM -ResourceGroupName $using:resourceGroupName -Name $using:vmName -Force -ErrorAction Stop
                Write-Output "Successfully stopped VM: $using:vmName"
            } catch {
                Write-Output "Failed to stop VM: $using:vmName. Error: $_"
            }
        }
    }
}