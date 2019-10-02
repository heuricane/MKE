# Basic Powershell script to sort images

# Objects we manually change go in the beginning

$drive = “C:\”

# simple array of filetypes
$FileTypes = (‘*.png’,’*.bmp’,’*.jpg’,’*.jpeg’)

# Move to drive with pictures
Set-Location -Path $drive

# Gather all the pictures into object array

$objArray = @()
Foreach ($type in $FileTypes){
    $objArray += Get-ChildItem -Recurse -Filter $type
}

# Collect objects name and size into hashtable

$hashtable = @{}
Foreach ($object in $objArray)
{
    $name = $object.FullName
    $length = $object.Length
    $hashtable.Add($name,$length)
}
# Displays table of files&sizes
$hashtable.GetEnumerator() | Out-GridView

# Create Folders for pics

If (!('C:\temp')){New-Item -Path "c:\" -Name "temp" -ItemType "directory"}
Set-Location c:\temp

New-Item -Name "png" -ItemType "directory"
New-Item -Name "jpg" -ItemType "directory"


# Sort Pics into Folders

$objArray | %{If ($_.FullName -like ‘*png’){Copy-Item $_.FullName png }}
$objArray | %{If ($_.FullName -like ‘*jpg’){Copy-Item $_.FullName jpg }}