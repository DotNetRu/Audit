function Test-XmlFile
{
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true, Mandatory = $true, ValueFromPipelineByPropertyName = $true)]
        [alias('Fullname')]
        [string] $XmlFile,

        [Parameter(Mandatory = $true)]
        [string] $SchemaFile,

        [scriptblock] $ValidationEventHandler = { Write-Error $args[1].Exception }
    )

    begin
    {
        $schemaReader = New-Object System.Xml.XmlTextReader $SchemaFile
        $schema = [System.Xml.Schema.XmlSchema]::Read($schemaReader, $ValidationEventHandler)
    }

    process
    {
        $result = $true
        try
        {
            $xml = New-Object System.Xml.XmlDocument
            $xml.Schemas.Add($schema) | Out-Null
            $xml.Load($XmlFile)
            $xml.Validate({
                throw ([PsCustomObject] @{
                        SchemaFile = $SchemaFile
                        XmlFile    = $XmlFile
                        Exception  = $args[1].Exception
                    })
                })
        }
        catch
        {
            Write-Error $_
            $result = $false
        }

        $result
    }

    end
    {
        $schemaReader.Close()
    }
}
