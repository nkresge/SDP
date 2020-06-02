function Remove-SDPVolumeGroup {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [array] $objectid,
        [parameter()]
        [string] $name,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    <#
        .SYNOPSIS

        .EXAMPLE 

        .DESCRIPTION

        .NOTES
        Authored by J.R. Phillips (GitHub: JayAreP)

        .LINK
        https://www.github.com/JayAreP/K2RF/

    #>
    
    begin {
        $endpoint = "volume_groups"
    }

    process {
        # Special Ops

        if ($name) {
            $volgrpname = Get-SDPVolumeGroup -name $name
            if (!$volgrpname) {
                return "No volume with name $name exists."
            } elseif (($volgrpname | measure-object).count -gt 1) {
                return "Too many replies with $name"
            } else {
                $objectid = $volgrpname.id
            }
        }

        ## Make the call

        $endpointURI = $endpoint + '/' + $objectid

        $results = Invoke-SDPRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results
    }
}
