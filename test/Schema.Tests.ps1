Set-StrictMode -version Latest
$ErrorActionPreference = 'Stop'

BeforeAll {

    . $PSScriptRoot\Test-XmlFile.ps1
}

function Get-TestEntities()
{
    $dbPath = Join-Path $PSScriptRoot '../db' -Resolve
    $schemaPath = Join-Path $PSScriptRoot '../schemas' -Resolve

    Get-ChildItem -Path $dbPath -Filter '*.xml' -File -Recurse |
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
}

$TestEntities = Get-TestEntities

Describe 'Verification' {

    Context 'XML Schema' {

        It '<Type> <Name> should be valid' -TestCases $TestEntities {
            param($DataPath, $SchemaPath)

            $DataPath |
            Test-XmlFile -SchemaFile $SchemaPath |
            Should -Be $true
        }
    }

}
