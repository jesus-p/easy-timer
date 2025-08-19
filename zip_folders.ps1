$folders = @("components", "images", "source")
$manifestfile = "manifest"
$outputZip = "easytimer.zip"

# Remove existing zip if exists
if (Test-Path $outputZip) {
    Remove-Item $outputZip
}

# Create a new zip file and add contents
Add-Type -AssemblyName System.IO.Compression.FileSystem

function Add-ToZip {
    param ($zipPath, $items)

    $zip = [System.IO.Compression.ZipFile]::Open($zipPath, [System.IO.Compression.ZipArchiveMode]::Update)

    foreach ($item in $items) {
        if (Test-Path $item -PathType Container) {
            # Add folder contents recursively
            $files = Get-ChildItem -Path $item -Recurse
            foreach ($file in $files) {
                $entryName = $file.FullName.Substring((Get-Item $item).FullName.Length + 1)
                $zip.CreateEntryFromFile($file.FullName, "$item/$entryName") | Out-Null
            }
        } elseif (Test-Path $item -PathType Leaf) {
            # Add file
            $zip.CreateEntryFromFile((Resolve-Path $item).Path, (Split-Path $item -Leaf)) | Out-Null
        }
    }

    $zip.Dispose()
}

Add-ToZip $outputZip ($folders + $manifestfile)

Write-Output "Created zip file: $outputZip"