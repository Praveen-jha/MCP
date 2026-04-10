workflow ict-platform-ccai-dev-aa-rb-vm-start { # workflow name must matach with "start runbook name".
    param (
        [Parameter(Mandatory = $true)]
        [String] $resourceGroupName,

        [Parameter(Mandatory = $true)]
        [String] $vmNames
    )

    $vmNamesArray = $vmNames -split ','

    foreach -parallel ($vmName in $vmNamesArray) {
        InlineScript {
            Write-Output "Starting VM: $using:vmName in Resource Group: $using:resourceGroupName"
            try {
                Connect-AzAccount -Identity -ErrorAction Stop
                Start-AzVM -ResourceGroupName $using:resourceGroupName -Name $using:vmName -ErrorAction Stop
                Write-Output "Successfully started VM: $using:vmName"
            } catch {
                Write-Output "Failed to start VM: $using:vmName. Error: $_"
            }
        }
    }
}