Set-StrictMode -version Latest
$ErrorActionPreference = 'Stop'

. (Join-Path $PSScriptRoot Test-XmlFile.ps1)

$dbPath = Join-Path $PSScriptRoot '../db' -Resolve
$schemaPath = Join-Path $PSScriptRoot '../schemas' -Resolve

Describe 'Verification' {

    Context 'XML Schema' {

        $entities = Get-ChildItem -Path $dbPath -Filter '*.xml' -File -Recurse |
            ForEach-Object {
                $file = $_
                [xml]$entity = $file | Get-Content -Raw -Encoding UTF8
                $type = $entity.DocumentElement.LocalName
                @{
                    Name = $entity.SelectSingleNode('//Id/text()').Value
                    Type = $type
                    DataPath = $file.FullName
                    SchemaPath = Join-Path $schemaPath "$type.xsd"
                }
            }

        It '<Type> <Name> should be valid' -TestCases $entities {
            param($DataPath, $SchemaPath)

            $DataPath |
            Test-XmlFile -SchemaFile $SchemaPath |
            Should Be  $true
        }
    }

}
