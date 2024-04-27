# ����Ҫɸѡ��ɾ�����ļ����ļ��е�Ŀ¼·��
$folderPath = "E:\0AVerdaccio\storage"
# ����Ҫɸѡ��ɾ�����ļ����ļ��е��޸�������ֵ������Ϊ��λ��
# $daysThreshold = 30
# 2024��4��27�� 22:42:34
# ��ȡ��ǰ���ں�ָ����������ֵ֮�������
$thresholdDate = [Datetime]::ParseExact('2024/04/28 00:10', 'yyyy/MM/dd HH:mm', $null)

echo ɾ��temp_storage
rm -Force -r temp_storage/
echo �½�temp_storage
mkdir temp_storage/
echo �����ļ�
# ɸѡ
Get-ChildItem -Path $folderPath -Recurse -File | Where-Object { $_.LastWriteTime -gt $thresholdDate }  |  ForEach-Object { 
    $_.FullName
    # �����ļ���������Ӧ��Ŀ¼�ṹ
    $fileRelativePath = (Resolve-Path -Path $_.FullName  -Relative)

    # Copy-Item -Path $_.FullName -Destination temp_storage/ -Recurse -Force
    $destination =  (Split-Path -Path $fileRelativePath)
    $destinationDirectory = (Join-Path -Path "temp_storage\" -ChildPath $destination)
    if (!(Test-Path -Path $destinationDirectory)) {
        New-Item -ItemType Directory -Path $destinationDirectory -Force
    }
    Copy-Item -Path $_.FullName -Destination $destinationDirectory -Force
}
# ɸѡ��ɾ���ļ�
# Get-ChildItem -Path $folderPath -Recurse -File | Where-Object { $_.LastWriteTime -lt $thresholdDate } | Remove-Item -Force

# ɸѡ��ɾ�����ļ���
# Get-ChildItem -Path $folderPath -Recurse -Directory | Where-Object { $_.LastWriteTime -lt $thresholdDate -and @(Get-ChildItem -Path $_.FullName -File).Count -eq 0 } | Remove-Item -Force -Recurse


# ������100MB
bz.exe c -v:100MB  ./release/storage.zip .\temp_storage\storage 