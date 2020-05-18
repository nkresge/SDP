function Get-SDPStatsSystem {
    param(
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )
    $endpoint = "stats/system"

    if ($PSBoundParameters.Keys.Contains('Verbose')) {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -Verbose -k2context $k2context
    } else {
        $results = Invoke-SDPRestCall -endpoint $endpoint -method GET -parameterList $PSBoundParameters -k2context $k2context
    }
    return $results
}
