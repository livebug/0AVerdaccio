# 设置要筛选和删除的文件和文件夹的目录路径
$folderPath = "E:\0AVerdaccio\storage"
# 设置要筛选和删除的文件和文件夹的修改日期阈值（以天为单位）
# $daysThreshold = 30
# 2024年4月27日 22:42:34
# 获取当前日期和指定的日期阈值之间的日期
$thresholdDate = [Datetime]::ParseExact('2024/04/28 00:10', 'yyyy/MM/dd HH:mm', $null)

echo 删除temp_storage
rm -Force -r temp_storage/
echo 新建temp_storage
mkdir temp_storage/
echo 复制文件
# 筛选
Get-ChildItem -Path $folderPath -Recurse -File | Where-Object { $_.LastWriteTime -gt $thresholdDate }  |  ForEach-Object { 
    $_.FullName
    # 拷贝文件并保持相应的目录结构
    $fileRelativePath = (Resolve-Path -Path $_.FullName  -Relative)

    # Copy-Item -Path $_.FullName -Destination temp_storage/ -Recurse -Force
    $destination =  (Split-Path -Path $fileRelativePath)
    $destinationDirectory = (Join-Path -Path "temp_storage\" -ChildPath $destination)
    if (!(Test-Path -Path $destinationDirectory)) {
        New-Item -ItemType Directory -Path $destinationDirectory -Force
    }
    Copy-Item -Path $_.FullName -Destination $destinationDirectory -Force
}
# 筛选并删除文件
# Get-ChildItem -Path $folderPath -Recurse -File | Where-Object { $_.LastWriteTime -lt $thresholdDate } | Remove-Item -Force

# 筛选并删除空文件夹
# Get-ChildItem -Path $folderPath -Recurse -Directory | Where-Object { $_.LastWriteTime -lt $thresholdDate -and @(Get-ChildItem -Path $_.FullName -File).Count -eq 0 } | Remove-Item -Force -Recurse


# 打包最大100MB
bz.exe c -v:100MB  ./release/storage.zip .\temp_storage\storage 