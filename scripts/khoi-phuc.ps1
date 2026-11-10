# khoi-phuc.ps1: dung MySQL cua SQL Leaderboard tren may Windows moi (PowerShell 5.1 hoac 7).
# Ban PowerShell cua scripts/khoi-phuc.sh, cung cac buoc. Thong bao viet khong dau de PowerShell 5.1
# doc dung file khi khong co BOM.
#
#   powershell -ExecutionPolicy Bypass -File scripts\khoi-phuc.ps1
#   powershell -ExecutionPolicy Bypass -File scripts\khoi-phuc.ps1 -Tag v1.1.0
#   powershell -ExecutionPolicy Bypass -File scripts\khoi-phuc.ps1 -Repo chu/sql-leaderboard
#   powershell -ExecutionPolicy Bypass -File scripts\khoi-phuc.ps1 -KhongTai   # dung dump co san trong dist\dumps
#   powershell -ExecutionPolicy Bypass -File scripts\khoi-phuc.ps1 -TuCsv      # dung tu script goc + CSV (can Git Bash)
#
# Mat khau root doc tu mysql\.env, dua vao container qua bien moi truong MYSQL_PWD (docker exec -e MYSQL_PWD),
# khong nam tren dong lenh, khong in ra.
[CmdletBinding()]
param(
    [string]$Tag = 'v1.1.0',
    [string]$Repo = '',
    [switch]$TuCsv,
    [switch]$KhongTai
)
$ErrorActionPreference = 'Continue'   # loi cua lenh ngoai kiem bang $LASTEXITCODE

$Root  = Split-Path -Parent $PSScriptRoot
$CT    = 'sqllb-mysql'
$Dumps = Join-Path $Root 'dist\dumps'
$Dbs   = 'scm','scm_hidden_1','aivb','aivb_hidden_1','jelly','jelly_hidden_1','hr','hr_hidden_1','mkt','mkt_hidden_1'
$Compose = Join-Path $Root 'docker-compose.yml'

function Loi([string]$msg) { Write-Host "LOI: $msg" -ForegroundColor Red; exit 1 }
function Buoc([string]$msg) { Write-Host ''; Write-Host "== $msg" -ForegroundColor Cyan }
function KiemMa([string]$viec) { if ($LASTEXITCODE -ne 0) { Loi "$viec (ma thoat $LASTEXITCODE)" } }

# ------------------------------------------------------------------ 1. docker
Buoc '1. Kiem Docker'
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) { Loi 'chua cai Docker Desktop' }
docker info *> $null;            if ($LASTEXITCODE -ne 0) { Loi 'Docker Desktop chua chay' }
docker compose version *> $null; if ($LASTEXITCODE -ne 0) { Loi "thieu 'docker compose' (Compose v2)" }
Write-Host (docker --version)

$nhan = docker inspect -f '{{json .Config.Labels}}' $CT 2>$null
if ($LASTEXITCODE -eq 0 -and $nhan) {
    $duAn = (($nhan | ConvertFrom-Json).'com.docker.compose.project')
    if ($duAn -ne 'sqllb') {
        Loi "da co container $CT khong do compose project 'sqllb' tao. Dung/xoa no truoc, hoac nap tay theo README.md."
    }
}

# ------------------------------------------------------------------ 2. mysql\.env
Buoc '2. mysql\.env'
$EnvFile = Join-Path $Root 'mysql\.env'
function SinhMatKhau {
    $chu = [char[]]'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'
    $rng = [System.Security.Cryptography.RandomNumberGenerator]::Create()
    $b = New-Object byte[] 24
    $rng.GetBytes($b)
    -join ($b | ForEach-Object { $chu[$_ % $chu.Length] })
}
if (Test-Path $EnvFile) {
    $noiDung = Get-Content $EnvFile
    if (-not ($noiDung -match '^MYSQL_ROOT_PASSWORD=.') -or -not ($noiDung -match '^SQL_RUNNER_PASSWORD=.')) {
        Loi "$EnvFile thieu MYSQL_ROOT_PASSWORD hoac SQL_RUNNER_PASSWORD (mau: mysql\.env.example)"
    }
    Write-Host "Dung $EnvFile co san"
} else {
    # UTF-8 khong BOM, xuong dong LF: compose doc dung ten bien
    $txt = "MYSQL_ROOT_PASSWORD=$(SinhMatKhau)`nSQL_RUNNER_PASSWORD=$(SinhMatKhau)`n"
    [System.IO.File]::WriteAllText($EnvFile, $txt, (New-Object System.Text.UTF8Encoding($false)))
    Write-Host "Da tao $EnvFile voi mat khau ngau nhien (khong in ra; file nay khong dua vao git)"
}
$dongRoot = (Get-Content $EnvFile | Where-Object { $_ -match '^MYSQL_ROOT_PASSWORD=' } | Select-Object -First 1)
$env:MYSQL_PWD = $dongRoot.Substring('MYSQL_ROOT_PASSWORD='.Length).Trim()

# ------------------------------------------------------------------ 3. nguon du lieu
if ($TuCsv) {
    Buoc '3. Kiem CSV cho -TuCsv'
    $thieu = $false
    foreach ($d in 'du-lieu','aivb\du-lieu','hr\du-lieu','jelly\du-lieu','mkt\du-lieu') {
        $n = @(Get-ChildItem (Join-Path $Root "mysql\$d") -Filter *.csv -ErrorAction SilentlyContinue).Count
        Write-Host ('  mysql\{0,-15} {1,3} file CSV' -f $d, $n)
        if ($n -eq 0) { $thieu = $true }
    }
    if ($thieu) { Loi 'thieu CSV; chep mysql\**\du-lieu\ tu may goc, hoac bo -TuCsv de nap tu dump' }
    $Bash = Join-Path $env:ProgramFiles 'Git\bin\bash.exe'
    if (-not (Test-Path $Bash)) { Loi '-TuCsv can Git Bash (Git for Windows) de chay mysql\**\02_nap_*.sh' }
} else {
    Buoc "3. Tai dump ($Tag) vao dist\dumps\"
    New-Item -ItemType Directory -Force $Dumps | Out-Null
    if (-not $KhongTai) {
        if (-not (Get-Command gh -ErrorAction SilentlyContinue)) {
            Loi 'chua cai GitHub CLI (gh); hoac tai tay 10 file *.sql.gz + SHA256SUMS vao dist\dumps\ roi chay voi -KhongTai'
        }
        $ghArgs = @('release','download',$Tag,'-p','*.sql.gz','-p','SHA256SUMS','-D',$Dumps,'--clobber')
        if ($Repo) { $ghArgs += @('-R',$Repo) }
        Push-Location $Root
        & gh @ghArgs
        $ma = $LASTEXITCODE
        Pop-Location
        if ($ma -ne 0) { Loi "gh release download $Tag that bai" }
    }
    $sums = Join-Path $Dumps 'SHA256SUMS'
    if (-not (Test-Path $sums)) { Loi "khong co $sums" }
    foreach ($db in $Dbs) { if (-not (Test-Path (Join-Path $Dumps "$db.sql.gz"))) { Loi "thieu $Dumps\$db.sql.gz" } }
    $soFile = 0
    foreach ($dong in Get-Content $sums) {
        if (-not $dong.Trim()) { continue }
        $phan = $dong -split '\s+', 2
        $ten = $phan[1].TrimStart('*').Trim()
        $thuc = (Get-FileHash -Algorithm SHA256 (Join-Path $Dumps $ten)).Hash.ToLower()
        if ($thuc -ne $phan[0].ToLower()) { Loi "SHA256 khong khop: $ten (tai lai)" }
        $soFile++
    }
    Write-Host "SHA256 khop ($soFile file)"
}

# ------------------------------------------------------------------ 4. khoi dong MySQL
Buoc '4. docker compose up -d mysql'
docker compose -f $Compose up -d mysql; KiemMa 'docker compose up'
Write-Host -NoNewline 'Cho MySQL san sang'
for ($i = 1; $i -le 120; $i++) {
    $tt = docker inspect -f '{{if .State.Health}}{{.State.Health.Status}}{{end}}' $CT 2>$null
    if ($tt -eq 'healthy') { break }
    if ($i -eq 120) {
        Write-Host ''
        Loi "qua 10 phut chua san sang; xem 'docker logs $CT'. Neu volume sqllb-mysql-data co tu truoc voi mat khau root khac thi sua mysql\.env cho khop hoac xoa volume."
    }
    Write-Host -NoNewline '.'
    Start-Sleep -Seconds 5
}
Write-Host ' ok'

# ------------------------------------------------------------------ 5. nap du lieu
if ($TuCsv) {
    Buoc '5. Dung tu script goc + CSV'
    $env:MSYS_NO_PATHCONV = '1'
    $buoc = @(
        @('mysql/02_nap_scm.sh', '--chi-nap', '/sqllb/03_bien_the_an_scm.sql', '/sqllb/04_bo_sung_bien_the_scm.sql'),
        @('mysql/aivb/02_nap_aivb.sh', '--chi-nap', '/sqllb/aivb/03_bien_the_an_aivb.sql', '/sqllb/aivb/04_bo_sung_bien_the_aivb.sql'),
        @('mysql/hr/02_nap_hr.sh', '--chi-nap', '/sqllb/hr/03_bien_the_an_hr.sql', '/sqllb/hr/04_bo_sung_bien_the_hr.sql'),
        @('mysql/jelly/02_nap_jelly.sh', '--chi-nap', '/sqllb/jelly/03_bien_the_an_jelly.sql', '/sqllb/jelly/04_bo_sung_bien_the_jelly.sql'),
        @('mysql/mkt/02_nap_mkt.sh', '', '/sqllb/mkt/03_bien_the_an_mkt.sql', '/sqllb/mkt/04_bo_sung_bien_the_mkt.sql')
    )
    Push-Location $Root
    foreach ($b in $buoc) {
        if ($b[1]) { & $Bash $b[0] $b[1] } else { & $Bash $b[0] }
        if ($LASTEXITCODE -ne 0) { Pop-Location; Loi "$($b[0]) that bai" }
        # 03 dung lai database bien the tu dau, nen 04 (bo sung) luon chay ngay sau 03
        foreach ($sql in $b[2..3]) {
            docker exec -e MYSQL_PWD $CT sh -c "mysql -uroot --default-character-set=utf8mb4 < $sql > /dev/null"
            if ($LASTEXITCODE -ne 0) { Pop-Location; Loi "$sql that bai" }
        }
    }
    Pop-Location
} else {
    Buoc '5. Nap 10 database tu dump'
    foreach ($db in $Dbs) {
        $file = Join-Path $Dumps "$db.sql.gz"
        Write-Host ('  {0} ({1:N1} MB nen)' -f $db, ((Get-Item $file).Length / 1MB))
        docker exec -e MYSQL_PWD $CT mysql -uroot -e "DROP DATABASE IF EXISTS $db; CREATE DATABASE $db CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci"
        KiemMa "tao database $db"
        # docker cp + giai nen trong container: PowerShell 5.1 khong chuyen du lieu nhi phan qua pipe cho lenh ngoai
        docker cp $file "${CT}:/tmp/$db.sql.gz" | Out-Null; KiemMa "docker cp $db"
        docker exec -e MYSQL_PWD $CT sh -c "gunzip -c /tmp/$db.sql.gz | mysql -uroot --default-character-set=utf8mb4 $db; ma=`$?; rm -f /tmp/$db.sql.gz; exit `$ma"
        KiemMa "nap $db"
    }
}

# ------------------------------------------------------------------ 6. user cham bai
Buoc '6. User sql_runner (mysql/05_tai_khoan_cham_bai.sql)'
# SQL_RUNNER_PASSWORD co san trong container (env_file); chi gom chu va so nen sed khong can trich dan
$quyen = docker exec -e MYSQL_PWD $CT sh -c 'sed s/@@MATKHAU@@/$SQL_RUNNER_PASSWORD/ /sqllb/05_tai_khoan_cham_bai.sql | mysql -uroot -N'
KiemMa 'chay 05_tai_khoan_cham_bai.sql'
Write-Host "  sql_runner: $(@($quyen | Where-Object { $_ -like 'GRANT*' }).Count) dong GRANT"
Write-Host '  So bang/view theo database:'
docker exec -e MYSQL_PWD $CT mysql -uroot -N -e "SELECT CONCAT('    ', table_schema, ': ', COUNT(*)) FROM information_schema.tables WHERE table_schema IN ('$($Dbs -join "','")') GROUP BY table_schema ORDER BY table_schema"
Remove-Item Env:\MYSQL_PWD

# ------------------------------------------------------------------ 7. image cong cu
Buoc '7. Build image sqllb-tools'
docker compose -f $Compose --profile tools build tools; KiemMa 'build sqllb-tools'

# ------------------------------------------------------------------ 8. huong dan
Buoc "Xong. MySQL: 127.0.0.1:3307 (trong mang docker 'sqllb': sqllb-mysql:3306)"
Write-Host @'
Chay bo kiem cho mot goi (vi du goi 1 bo HR), tu thu muc goc repo:

  docker compose run --rm tools python cong-cu/kiem_tra_goi.py `
    --goi goi-cau-hoi/hr/goi-1 --ra cong-cu/ket-qua/hr-goi-1 --host sqllb-mysql --port 3306

Dong cuoi "KIEM TRA: 0 loi" la goi dat; bao cao o cong-cu/ket-qua/hr-goi-1/bao-cao-import.json.
Mat khau sql_runner doc tu mysql\.env. Xem them cong-cu\README.md.
'@
