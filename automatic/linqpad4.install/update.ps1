import-module au

$releases =

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri 'https://www.linqpad.net/Download.aspx'

    $re = 'Current release versions:\s*<b>\s*([\d.]+)\s*</b>\s*/\s*<b>\s*([\d.]+)\s*</b>'

    $versionMatch = $download_page | select-string -Pattern $re
    $version = $versionMatch.Matches[0].Groups[2].Value

    $Latest = @{ URL32 = 'https://www.linqpad.net/GetFile.aspx?LINQPad4Setup.exe'; Version = $version }
    return $Latest
}

update
