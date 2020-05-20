function Build-MenuFromArray {
    param(
        [Parameter(Mandatory)]
        [array]$array,
        [Parameter()]
        [string]$message = "Select item"
    )

    Write-Host '------'
    $menu = @{}
    for (
        $i=1
        $i -le $array.count
        $i++
    ) { Write-Host "$i. $($array[$i-1])" 
        $menu.Add($i,($array[$i-1]))
    }
    Write-Host '------'
    [int]$mntselect = Read-Host $message
    $menu.Item($mntselect)
    Write-Host `n`n
}

if ($PSVersionTable.PSEdition -eq 'Desktop') {
    $PSPaths = $env:PSModulePath.Split(';')
} elseif ($PSVersionTable.PSEdition -eq 'Core') {
    $PSPaths = $env:PSModulePath.Split(':')
}

$installDirectory = Build-MenuFromArray -array $PSPaths -message "Select Install location"

if (Get-Module sdp) {
    Remove-Module sdp
}

$fullpath = $installDirectory + '/sdp/' 

$moduleInfo = Test-ModuleManifest -Path ./SDP/sdp.psd1

$fullfolder = $fullpath + $moduleInfo.Version.Major + '.' + $moduleInfo.Version.Minor

if (Get-Item $fullfolder) {
    Remove-Item -Path $fullfolder -Recurse
}

if (!(Get-Item $fullpath -ErrorAction SilentlyContinue)) {
    New-Item $fullpath -ItemType directory
}

if (!(Get-Item $fullfolder -ErrorAction SilentlyContinue)) {
    New-Item $fullfolder -ItemType directory
}

Copy-Item ./SDP/* -Destination $fullfolder

Import-Module sdp

Get-Module sdp