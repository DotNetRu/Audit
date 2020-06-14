Set-StrictMode -version Latest
$ErrorActionPreference = 'Stop'

Describe 'Storage verification' {

    Context 'All data files in storage' {

        BeforeAll {

            $dbPath = Join-Path $PSScriptRoot '../db' -Resolve

            function Get-AllDBFile()
            {
                Get-ChildItem -Path $dbPath -Filter '*.xml' -File -Recurse
            }
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

            $unixFiles | Should -BeNullOrEmpty
        }

        It 'Should have UTF-8 with BOM encoding' {
            filter Test-Utf8WithBOMEncoding()
            {
                $file = $_
                $buffer = [System.IO.File]::ReadAllBytes($file.FullName)

                ($buffer.Length -ge 3) -and
                ($buffer[0] -eq 0xEF) -and
                ($buffer[1] -eq 0xBB) -and
                ($buffer[2] -eq 0xBF)
            }

            $badFiles =
                Get-AllDBFile |
                Where-Object { -not ($_ | Test-Utf8WithBOMEncoding) } |
                ForEach-Object { Resolve-Path $_.FullName -Relative }

            $badFiles | Should -BeNullOrEmpty
        }
    }
}
