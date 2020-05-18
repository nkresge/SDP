function Remove-K2RFTemplate {
    param(
        [parameter(ValueFromPipelineByPropertyName)]
        [Alias('id')]
        [array] $objectid,
        [parameter()]
        [string] $k2context = 'k2rfconnection'
    )

    ## Special Ops
    begin {
        Write-Verbose "Removing..."
        $endpoint = ENDPOINTNAME
    }

    process {
        ## Make the call
        $endpointURI = $endpoint + '/' + $objectid
        $results = Invoke-K2RFRestCall -endpoint $endpointURI -method DELETE -k2context $k2context
        return $results.hits
    }
}