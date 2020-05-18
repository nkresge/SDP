function Get-SDPVgCapacityPolicies {
    param(
        [parameter()]
        [Alias("CriticalThreshold")]
        [int] $critical_threshold,
        [parameter()]
        [Alias("ErrorThreshold")]
        [int] $error_threshold,
        [parameter()]
        [Alias("FullThreshold")]
        [int] $full_threshold,
        [parameter()]
        [int] $id,
        [parameter()]
        [Alias("IsDefault")]
        [bool] $is_default,
        [parameter()]
        [string] $name,
        [parameter()]
        [Alias("NumSnapshots")]
        [int] $num_snapshots,
        [parameter()]
        [Alias("SnapshotOverheadThreshold")]
        [int] $snapshot_overhead_threshold,
        [parameter()]
        [Alias("WarningThreshold")]
        [int] $warning_threshold,
        [parameter()]
        [string] $k2context = "k2rfconnection"
    )

    $endpoint = "vg_capacity_policies"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results
}