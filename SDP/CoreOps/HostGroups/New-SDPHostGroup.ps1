function New-SDPHostGroup {
    param(
        [parameter(mandatory)]
        [string] $name,
        [parameter()]
        [string] $description,
        [parameter()]
        [string] $ConnectivityType,
        [parameter()]
        [switch] $allowDifferentHostTypes,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    <#
        .SYNOPSIS
        Use this function to create a new Host Group for Silk SDP

        .EXAMPLE 
        New-SDPHostGroup -name HostGroup01 -description "Host Group for all Series 1 hosts"

        .DESCRIPTION
        This function allows for the creation of a single Host Group for Silk SDP.

        .NOTES
        Authored by J.R. Phillips (GitHub: JayAreP)

        .LINK
        https://www.github.com/JayAreP/K2RF/

    #>
    begin {
        $endpoint = "host_groups"
    }

    process{
        ## Special Ops

        $o = New-Object psobject
        $o | Add-Member -MemberType NoteProperty -Name "name" -Value $name
        if ($description) {
            $o | Add-Member -MemberType NoteProperty -Name "description" -Value $description
        }
        if ($ConnectivityType) {
            $o | Add-Member -MemberType NoteProperty -Name "connectivity_type" -Value $ConnectivityType
        }
        if ($allowDifferentHostTypes) {
            $o | Add-Member -MemberType NoteProperty -Name "allow_different_host_types" -Value $true
        }

        $body = $o
        
        try {
            Invoke-SDPRestCall -endpoint $endpoint -method POST -body $body -k2context $k2context -erroraction silentlycontinue
        } catch {
            return $Error[0]
        }
        
        return $body
    }
}
