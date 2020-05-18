function Set-SDPVolumes {
    param(
        [parameter(ValueFromPipelineByPropertyName, Mandatory)]
        [Alias('id')]
        [string] $objectid,
        [parameter()]
        [string] $name,
        [parameter()]
        [int] $sizeInGB,
        [parameter()]
        [string] $Description,
        [parameter()]
        [string] $VolumeGroupName,
        [parameter()]
        [switch] $ReadOnly,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    begin {
        $endpoint = "volumes"
    }

    process {
        if ($sizeInGB) {
            [string]$size = ($sizeInGB * 1024 * 1024)
            Write-Verbose "$sizeInGB GB converted to $size"
        }


        if ($VolumeGroupName) {
            Write-Verbose "Working with Volume Group name $VolumeGroupName"
            $vgstats = Get-SDPVolumeGroups -name $VolumeGroupName
            if (!$vgstats) {
                Return "No volumegroup named $VolumeGroupName exists."
            } else {
                $vgpath = ConvertTo-SDPObjectPrefix -ObjectPath volume_groups -ObjectID $vgstats.id -nestedObject
            }
        }
        
        $o = New-Object psobject
        if ($name) {
            $o | Add-Member -MemberType NoteProperty -Name name -Value $name
        }

        if ($size) {
            $o | Add-Member -MemberType NoteProperty -Name size -Value $size
        }
        
        if ($vgpath) {
            $o | Add-Member -MemberType NoteProperty -Name volume_group -Value $vgpath
        }
        
        if ($VMWare) {
            $o | Add-Member -MemberType NoteProperty -Name vmware_support -Value $true
        }

        if ($Description) {
            $o | Add-Member -MemberType NoteProperty -Name description -Value $Description
        }

        if ($ReadOnly) {
            $o | Add-Member -MemberType NoteProperty -Name read_only -Value $true
        }

        $body = $o

        $endpointURI = $endpoint + '/' + $objectid
        if ($PSBoundParameters.Keys.Contains('Verbose')) {
            $results = Invoke-SDPRestCall -endpoint $endpointURI -method PATCH -body $body -k2context $k2context -Verbose 
        } else {
            $results = Invoke-SDPRestCall -endpoint $endpointURI -method PATCH -body $body -k2context $k2context 
        }
        return $results
    }

}

