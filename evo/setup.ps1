<#
.SYNOPSIS
    Super-Framework Bootstrap Setup
    Run this script inside any project to setup BMAD + Superpowers + AG Kit.

.DESCRIPTION
    This script will:
    1. Check prerequisites (git, node)
    2. Create directory structure
    3. Copy sync script to scripts/
    4. Install BMAD Method
    5. Add git submodules for upstream repos
    6. Run first sync (copies GEMINI.md, policies, skills, agents, workflows)

.EXAMPLE
    # From any project root:
    .\evo\setup.ps1
#>

param(
    [switch]$SkipBMAD
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

Write-Host ""
Write-Host "===============================" -ForegroundColor Magenta
Write-Host "  Super-Framework Setup v6" -ForegroundColor Magenta
Write-Host "  BMAD + Superpowers + AG Kit" -ForegroundColor Magenta
Write-Host "===============================" -ForegroundColor Magenta
Write-Host ""
Write-Host "  Project: $ProjectRoot" -ForegroundColor Gray
Write-Host ""

# -----------------------------------------------
# Step 1: Check Prerequisites
# -----------------------------------------------
Write-Host "[1/5] Checking prerequisites..." -ForegroundColor White

try {
    $gitVersion = git --version 2>&1
    Write-Host "  -> git: $gitVersion" -ForegroundColor Green
}
catch {
    Write-Host "  -> ERROR: git not found." -ForegroundColor Red
    exit 1
}

try {
    $nodeVersion = node --version 2>&1
    Write-Host "  -> node: $nodeVersion" -ForegroundColor Green
}
catch {
    Write-Host "  -> WARNING: node not found. BMAD install will be skipped." -ForegroundColor Yellow
    $SkipBMAD = $true
}

if (-not (Test-Path (Join-Path $ProjectRoot ".git"))) {
    Write-Host "  -> Initializing git repo..." -ForegroundColor Cyan
    Push-Location $ProjectRoot
    git init 2>&1 | Out-Null
    Pop-Location
    Write-Host "  -> Git repo initialized" -ForegroundColor Green
}
Write-Host ""

# -----------------------------------------------
# Step 2: Copy sync script to scripts/
# -----------------------------------------------
Write-Host "[2/5] Copying sync script..." -ForegroundColor White

$scriptsDir = Join-Path $ProjectRoot "scripts"
if (-not (Test-Path $scriptsDir)) {
    New-Item -ItemType Directory -Path $scriptsDir -Force | Out-Null
}

$syncScriptSrc = Join-Path $ScriptDir "sync-super-framework.ps1"
$syncScriptDst = Join-Path $scriptsDir "sync-super-framework.ps1"

if (Test-Path $syncScriptSrc) {
    Copy-Item $syncScriptSrc $syncScriptDst -Force
    Write-Host "  -> sync-super-framework.ps1 -> scripts/" -ForegroundColor Green
}
else {
    Write-Host "  -> ERROR: sync-super-framework.ps1 not found in evo/" -ForegroundColor Red
    exit 1
}
Write-Host ""

# -----------------------------------------------
# Step 3: Install BMAD Method
# -----------------------------------------------
Write-Host "[3/5] Installing BMAD Method..." -ForegroundColor White

if ($SkipBMAD) {
    Write-Host "  -> Skipping BMAD install" -ForegroundColor Yellow
}
else {
    $bmadCheck = Join-Path $ProjectRoot "_bmad"
    if (Test-Path $bmadCheck) {
        Write-Host "  -> BMAD already installed (_bmad/ exists)" -ForegroundColor Yellow
    }
    else {
        Write-Host "  -> Running npx bmad-method install..." -ForegroundColor Cyan
        Push-Location $ProjectRoot
        npx bmad-method install 2>&1
        Pop-Location
        Write-Host "  -> BMAD installed" -ForegroundColor Green
    }
}
Write-Host ""

# -----------------------------------------------
# Step 4: Add git submodules
# -----------------------------------------------
Write-Host "[4/5] Adding git submodules..." -ForegroundColor White

$submodules = @(
    @{ Name = "bmad-method";     Url = "https://github.com/bmad-code-org/BMAD-METHOD.git";    Path = "_upstream/bmad-method" },
    @{ Name = "superpowers";     Url = "https://github.com/obra/superpowers.git";              Path = "_upstream/superpowers" },
    @{ Name = "antigravity-kit"; Url = "https://github.com/vudovn/antigravity-kit.git";        Path = "_upstream/antigravity-kit" }
)

Push-Location $ProjectRoot
foreach ($sub in $submodules) {
    $subPath = Join-Path $ProjectRoot $sub.Path
    if (Test-Path $subPath) {
        Write-Host "  -> $($sub.Name) already exists" -ForegroundColor Yellow
    }
    else {
        Write-Host "  -> Adding $($sub.Name)..." -ForegroundColor Cyan
        git submodule add $sub.Url $sub.Path 2>&1 | Out-Null
        Write-Host "  -> $($sub.Name) added" -ForegroundColor Green
    }
}
Pop-Location
Write-Host ""

# -----------------------------------------------
# Step 5: Run first sync
# -----------------------------------------------
Write-Host "[5/5] Running first sync..." -ForegroundColor White
Write-Host ""

& $syncScriptDst -SkipSubmoduleUpdate

Write-Host ""
Write-Host "===============================" -ForegroundColor Green
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "===============================" -ForegroundColor Green
Write-Host ""
Write-Host "  Your super-framework is ready." -ForegroundColor White
Write-Host "  Update: .\scripts\sync-super-framework.ps1" -ForegroundColor Gray
Write-Host "  Customize: evo\GEMINI.md + evo\policies\" -ForegroundColor Gray
Write-Host ""
