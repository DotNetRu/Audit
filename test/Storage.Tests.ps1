Set-StrictMode -version Latest
$ErrorActionPreference = 'Stop'

$dbPath = Join-Path $PSScriptRoot '../db' -Resolve

Describe 'Storage verification' {

    Context 'All data files in storage' {

        function Get-AllDBFile()
        {
            Get-ChildItem -Path $dbPath -Filter '*.xml' -File -Recurse
        }

        It 'Should have windows like end of file' {
            filter Select-UnixEndOfLine()
            {
                $file = $_
                $content = $file | Get-Content -Raw
                if ($content -match '[^\r]\n')
                {
                    $file
                }
            }

            $unixFiles =
                Get-AllDBFile |
                Select-UnixEndOfLine |
                ForEach-Object { Resolve-Path $_.FullName -Relative }

            $unixFiles | Should BeNullOrEmpty
        }
    }
}
