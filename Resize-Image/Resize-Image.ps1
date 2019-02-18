
function Resize-Image
{
    Param (
        [Parameter(Mandatory =$true)]
        [string]$Path = '',

        [Parameter(Mandatory =$true)]
        [int]$Width,

        [Parameter(Mandatory =$true)]
        [int]$Height,

        [Parameter(Mandatory =$true)]
        [string]$Format)

    Write-Host -ForegroundColor Green "IMG Shrink v1.0.0 - Resize-Image"

    $curDir = Get-Location
    
    # Need to add validation of parameters, nuget.exe, ImageProcessor package

    try {

    .\nuget.exe install ImageProcessor | Out-Null

    $bytes = [System.IO.File]::ReadAllBytes('./ImageProcessor.2.7.0.100/lib/net452/ImageProcessor.dll')
    [System.Reflection.Assembly]::Load($bytes) | Out-Null

    cd $Path

    $files = Get-ChildItem

    Write-Host "Backing up images..."

    $timeFormat = [System.DateTime]::Now.ToString('yyyyMMddHHmmss')
    $backupFolder = "backup_$timeFormat"
    mkdir $backupFolder  | Out-Null
    copy-item -Path "*.$Format"  -Destination $backupFolder  | Out-Null


    $imageFactory = New-Object ImageProcessor.ImageFactory false
    $size= New-Object System.Drawing.Size $Width, $Height

    foreach ($file in $files) {
        if ($file.Name -like "*.$Format") {
            $fname = $file.Name
            write-host "Resizing $fname ..." 
          
            $imageFactory.Load($Path + "\$fname") | Out-Null
            $imageFactory.Resize($size) | Out-Null
            $imageFactory.Save($Path + "\$fname") | Out-Null
        }
        
    }

    $imageFactory.Dispose()

    } catch {
        Write-Host -ForegroundColor Red $_.Exception.Message
        Write-Host -ForegroundColor Red $_.Exception.ItemName
        Break
    }
    

    cd $curDir

    Write-Host -ForegroundColor Green "Done!"

}
