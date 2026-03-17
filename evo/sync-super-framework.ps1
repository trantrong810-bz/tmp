<#
.SYNOPSIS
    Super-Framework Sync Script
    Syncs skills, agents, workflows from upstream submodules + evo/ into .agent/

.DESCRIPTION
    Updates git submodules and copies content from:
    - _upstream/antigravity-kit -> .agent/skills/agkit-*, .agent/agents/, .agent/workflows/
    - _upstream/superpowers -> .agent/skills/sp-*
    - evo/GEMINI.md -> .agent/rules/GEMINI.md
    - evo/policies/ -> .agent/policies/
    - evo/agents/ -> .agent/agents/ (custom agents overlay on AG Kit agents)
    BMAD skills (.agent/skills/bmad-*) are managed by npx bmad-method install and NOT touched.

.EXAMPLE
    .\evo\sync-super-framework.ps1
    .\evo\sync-super-framework.ps1 -SkipSubmoduleUpdate
    .\evo\sync-super-framework.ps1 -DryRun
#>

param(
    [switch]$SkipSubmoduleUpdate,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

# Paths
$UpstreamDir = Join-Path $ProjectRoot "_upstream"
$AgentDir = Join-Path $ProjectRoot ".agent"
$SkillsDir = Join-Path $AgentDir "skills"
$AgentsDir = Join-Path $AgentDir "agents"
$WorkflowsDir = Join-Path $AgentDir "workflows"
$RulesDir = Join-Path $AgentDir "rules"
$PoliciesDir = Join-Path $AgentDir "policies"
$EvoDir = Join-Path $ProjectRoot "evo"

# Upstream paths
$AgKitDir = Join-Path $UpstreamDir "antigravity-kit"
$SuperpowersDir = Join-Path $UpstreamDir "superpowers"

# Counters
$stats = @{
    AgKitSkills = 0
    AgKitAgents = 0
    AgKitWorkflows = 0
    AgKitRules = 0
    SuperpowersSkills = 0
    EvoPolicies = 0
    EvoAgents = 0
    EvoWorkflows = 0
}

# -----------------------------------------------
# Header
# -----------------------------------------------
Write-Host ""
Write-Host "===============================" -ForegroundColor Magenta
Write-Host "  Super-Framework Sync v7" -ForegroundColor Magenta
Write-Host "  BMAD + Superpowers + AG Kit" -ForegroundColor Magenta
Write-Host "===============================" -ForegroundColor Magenta
Write-Host ""

if ($DryRun) {
    Write-Host "  [DRY RUN] No changes will be made" -ForegroundColor Yellow
    Write-Host ""
}

# -----------------------------------------------
# Step 1: Update git submodules
# -----------------------------------------------
Write-Host "[1/11] Git Submodules" -ForegroundColor White
if ($SkipSubmoduleUpdate) {
    Write-Host "  -> Skipping submodule update" -ForegroundColor Yellow
}
else {
    Write-Host "  -> Updating submodules..." -ForegroundColor Cyan
    if (-not $DryRun) {
        Push-Location $ProjectRoot
        git submodule update --remote --merge 2>&1 | Out-Null
        Pop-Location
    }
    Write-Host "  -> Done" -ForegroundColor Green
}
Write-Host ""

# -----------------------------------------------
# Step 2: Ensure directories exist
# -----------------------------------------------
Write-Host "[2/11] Ensuring directories" -ForegroundColor White
$dirsToCreate = @($SkillsDir, $AgentsDir, $WorkflowsDir, $RulesDir, $PoliciesDir)
foreach ($dir in $dirsToCreate) {
    if (-not (Test-Path $dir)) {
        Write-Host "  -> Creating $($dir | Split-Path -Leaf)/" -ForegroundColor Cyan
        if (-not $DryRun) {
            New-Item -ItemType Directory -Path $dir -Force | Out-Null
        }
    }
}
Write-Host "  -> All directories ready" -ForegroundColor Green
Write-Host ""

# -----------------------------------------------
# Step 3: Sync AG Kit Skills (prefix: agkit-)
# -----------------------------------------------
Write-Host "[3/11] Syncing AG Kit Skills -> agkit-*" -ForegroundColor White
$agkitSkillsSource = Join-Path (Join-Path $AgKitDir ".agent") "skills"

if (Test-Path $agkitSkillsSource) {
    Get-ChildItem $SkillsDir -Directory -Filter "agkit-*" -ErrorAction SilentlyContinue | ForEach-Object {
        if (-not $DryRun) { Remove-Item $_.FullName -Recurse -Force }
    }

    $agkitSkills = Get-ChildItem $agkitSkillsSource -Directory
    foreach ($skill in $agkitSkills) {
        $destName = "agkit-$($skill.Name)"
        $destPath = Join-Path $SkillsDir $destName
        Write-Host "  -> $($skill.Name) -> $destName" -ForegroundColor Cyan
        if (-not $DryRun) {
            Copy-Item $skill.FullName $destPath -Recurse -Force
        }
        $stats.AgKitSkills++
    }

    $docFile = Join-Path $agkitSkillsSource "doc.md"
    if (Test-Path $docFile) {
        if (-not $DryRun) { Copy-Item $docFile (Join-Path $SkillsDir "agkit-doc.md") -Force }
    }
    Write-Host "  -> $($stats.AgKitSkills) AG Kit skills synced" -ForegroundColor Green
}
else {
    Write-Host "  -> AG Kit skills source not found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 4: Sync AG Kit Agents
# -----------------------------------------------
Write-Host "[4/11] Syncing AG Kit Agents" -ForegroundColor White
$agkitAgentsSource = Join-Path (Join-Path $AgKitDir ".agent") "agents"

if (Test-Path $agkitAgentsSource) {
    $agentFiles = Get-ChildItem $agkitAgentsSource -File -Filter "*.md"
    foreach ($agent in $agentFiles) {
        Write-Host "  -> $($agent.Name)" -ForegroundColor Cyan
        if (-not $DryRun) {
            Copy-Item $agent.FullName (Join-Path $AgentsDir $agent.Name) -Force
        }
        $stats.AgKitAgents++
    }
    Write-Host "  -> $($stats.AgKitAgents) agents synced" -ForegroundColor Green
}
else {
    Write-Host "  -> AG Kit agents source not found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 5: Sync AG Kit Workflows
# -----------------------------------------------
Write-Host "[5/11] Syncing AG Kit Workflows" -ForegroundColor White
$agkitWorkflowsSource = Join-Path (Join-Path $AgKitDir ".agent") "workflows"

if (Test-Path $agkitWorkflowsSource) {
    $workflowFiles = Get-ChildItem $agkitWorkflowsSource -File -Filter "*.md"
    foreach ($wf in $workflowFiles) {
        Write-Host "  -> $($wf.Name)" -ForegroundColor Cyan
        if (-not $DryRun) {
            Copy-Item $wf.FullName (Join-Path $WorkflowsDir $wf.Name) -Force
        }
        $stats.AgKitWorkflows++
    }
    Write-Host "  -> $($stats.AgKitWorkflows) workflows synced" -ForegroundColor Green
}
else {
    Write-Host "  -> AG Kit workflows source not found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 6: Sync GEMINI.md from evo/
# -----------------------------------------------
Write-Host "[6/11] Syncing GEMINI.md from evo/" -ForegroundColor White
$evoGemini = Join-Path $EvoDir "GEMINI.md"

if (Test-Path $evoGemini) {
    Write-Host "  -> evo/GEMINI.md -> .agent/rules/GEMINI.md" -ForegroundColor Cyan
    if (-not $DryRun) {
        Copy-Item $evoGemini (Join-Path $RulesDir "GEMINI.md") -Force
    }
    Write-Host "  -> GEMINI.md v6 synced (Constitutional + Toolbox Mastery)" -ForegroundColor Green
}
else {
    # Fallback: try AG Kit base
    $agkitGemini = Join-Path (Join-Path (Join-Path $AgKitDir ".agent") "rules") "GEMINI.md"
    if (Test-Path $agkitGemini) {
        Write-Host "  -> evo/GEMINI.md not found, using AG Kit base" -ForegroundColor Yellow
        if (-not $DryRun) {
            Copy-Item $agkitGemini (Join-Path $RulesDir "GEMINI.md") -Force
        }
    }
    else {
        Write-Host "  -> No GEMINI.md source found" -ForegroundColor Red
    }
}
Write-Host ""

# -----------------------------------------------
# Step 7: Sync project-context.md from evo/
# -----------------------------------------------
Write-Host "[7/13] Syncing project-context.md from evo/" -ForegroundColor White
$evoProjectContext = Join-Path $EvoDir "project-context.md"

if (Test-Path $evoProjectContext) {
    $destProjectContext = Join-Path $AgentDir "project-context.md"
    Write-Host "  -> evo/project-context.md -> .agent/project-context.md" -ForegroundColor Cyan
    if (-not $DryRun) {
        Copy-Item $evoProjectContext $destProjectContext -Force
    }
    Write-Host "  -> project-context.md synced" -ForegroundColor Green
}
else {
    Write-Host "  -> evo/project-context.md not found (optional)" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 8: Sync Policies from evo/policies/
# -----------------------------------------------
Write-Host "[8/13] Syncing Policies from evo/policies/" -ForegroundColor White
$evoPolicies = Join-Path $EvoDir "policies"

if (Test-Path $evoPolicies) {
    $policyFiles = Get-ChildItem $evoPolicies -File -Filter "*.md"
    foreach ($policy in $policyFiles) {
        Write-Host "  -> $($policy.Name)" -ForegroundColor Cyan
        if (-not $DryRun) {
            Copy-Item $policy.FullName (Join-Path $PoliciesDir $policy.Name) -Force
        }
        $stats.EvoPolicies++
    }
    Write-Host "  -> $($stats.EvoPolicies) policies synced" -ForegroundColor Green
}
else {
    Write-Host "  -> evo/policies/ not found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 9: Sync custom skills from evo/skills/
# -----------------------------------------------
Write-Host "[9/13] Syncing custom skills from evo/skills/" -ForegroundColor White
$evoSkills = Join-Path $EvoDir "skills"
$evoSkillCount = 0

if (Test-Path $evoSkills) {
    $customSkills = Get-ChildItem $evoSkills -Directory
    foreach ($skill in $customSkills) {
        $destPath = Join-Path $SkillsDir $skill.Name
        Write-Host "  -> $($skill.Name)" -ForegroundColor Cyan
        if (-not $DryRun) {
            if (Test-Path $destPath) { Remove-Item $destPath -Recurse -Force }
            Copy-Item $skill.FullName $destPath -Recurse -Force
        }
        $evoSkillCount++
    }
    Write-Host "  -> $evoSkillCount custom skills synced" -ForegroundColor Green
}
else {
    Write-Host "  -> evo/skills/ not found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 10: Sync custom agents from evo/agents/
# -----------------------------------------------
Write-Host "[10/13] Syncing custom agents from evo/agents/" -ForegroundColor White
$evoAgents = Join-Path $EvoDir "agents"

if (Test-Path $evoAgents) {
    $customAgents = Get-ChildItem $evoAgents -File -Filter "*.md"
    foreach ($agent in $customAgents) {
        Write-Host "  -> $($agent.Name)" -ForegroundColor Cyan
        if (-not $DryRun) {
            Copy-Item $agent.FullName (Join-Path $AgentsDir $agent.Name) -Force
        }
        $stats.EvoAgents++
    }
    Write-Host "  -> $($stats.EvoAgents) custom agents synced" -ForegroundColor Green
}
else {
    Write-Host "  -> evo/agents/ not found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 11: Sync evo workflows (whitelist override + new additions)
# -----------------------------------------------
Write-Host "[11/13] Syncing evo workflows (smart override)" -ForegroundColor White
$evoWorkflows = Join-Path $EvoDir "workflows"

# Evo workflows OVERRIDE these AG Kit workflows (whitelist)
$overrideWhitelist = @("brainstorm", "create", "dev", "debug", "test", "review", "plan", "status", "orchestrate", "enhance", "architecture", "help", "deploy", "incident", "refactor")

if (Test-Path $evoWorkflows) {
    $customWorkflows = Get-ChildItem $evoWorkflows -File -Filter "*.md"
    foreach ($wf in $customWorkflows) {
        $baseName = $wf.BaseName
        $destPath = Join-Path $WorkflowsDir $wf.Name
        $existsInDest = Test-Path $destPath
        $isWhitelisted = $overrideWhitelist -contains $baseName

        if (-not $existsInDest) {
            # New evo-only workflow → always add
            Write-Host "  -> $($wf.Name) [NEW]" -ForegroundColor Green
        }
        elseif ($isWhitelisted) {
            # Whitelisted → override AG Kit version
            Write-Host "  -> $($wf.Name) [OVERRIDE]" -ForegroundColor Cyan
        }
        else {
            # Not whitelisted → skip (preserve AG Kit original)
            Write-Host "  -> $($wf.Name) [SKIP - not whitelisted]" -ForegroundColor Yellow
            continue
        }

        if (-not $DryRun) {
            Copy-Item $wf.FullName $destPath -Force
        }
        $stats.EvoWorkflows++
    }
    Write-Host "  -> $($stats.EvoWorkflows) evo workflows synced" -ForegroundColor Green
}
else {
    Write-Host "  -> evo/workflows/ not found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 12: Sync Superpowers Skills (prefix: sp-)
# -----------------------------------------------
Write-Host "[12/13] Syncing Superpowers Skills -> sp-*" -ForegroundColor White
$spSkillsSource = Join-Path $SuperpowersDir "skills"

if (Test-Path $spSkillsSource) {
    Get-ChildItem $SkillsDir -Directory -Filter "sp-*" -ErrorAction SilentlyContinue | ForEach-Object {
        if (-not $DryRun) { Remove-Item $_.FullName -Recurse -Force }
    }

    $spSkills = Get-ChildItem $spSkillsSource -Directory
    foreach ($skill in $spSkills) {
        $destName = "sp-$($skill.Name)"
        $destPath = Join-Path $SkillsDir $destName
        Write-Host "  -> $($skill.Name) -> $destName" -ForegroundColor Cyan
        if (-not $DryRun) {
            Copy-Item $skill.FullName $destPath -Recurse -Force
        }
        $stats.SuperpowersSkills++
    }
    Write-Host "  -> $($stats.SuperpowersSkills) Superpowers skills synced" -ForegroundColor Green
}
else {
    Write-Host "  -> Superpowers skills source not found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Step 13: Sync AG Kit shared resources
# -----------------------------------------------
Write-Host "[13/13] Syncing AG Kit Shared Resources" -ForegroundColor White
$agkitSharedSource = Join-Path (Join-Path $AgKitDir ".agent") ".shared"

if (Test-Path $agkitSharedSource) {
    $sharedDest = Join-Path $AgentDir ".shared"
    Write-Host "  -> .shared/ -> .agent/.shared/" -ForegroundColor Cyan
    if (-not $DryRun) {
        if (Test-Path $sharedDest) { Remove-Item $sharedDest -Recurse -Force }
        Copy-Item $agkitSharedSource $sharedDest -Recurse -Force
    }
    Write-Host "  -> Shared resources synced" -ForegroundColor Green
}
else {
    Write-Host "  -> No shared resources found" -ForegroundColor Yellow
}
Write-Host ""

# -----------------------------------------------
# Summary
# -----------------------------------------------
Write-Host "===============================" -ForegroundColor Green
Write-Host "  Sync Summary" -ForegroundColor Green
Write-Host "===============================" -ForegroundColor Green
Write-Host ""
Write-Host "  AG Kit Skills (agkit-*):      $($stats.AgKitSkills)" -ForegroundColor Cyan
Write-Host "  AG Kit Agents:                $($stats.AgKitAgents)" -ForegroundColor Cyan
Write-Host "  AG Kit Workflows:             $($stats.AgKitWorkflows)" -ForegroundColor Cyan
Write-Host "  Superpowers Skills (sp-*):    $($stats.SuperpowersSkills)" -ForegroundColor Cyan
Write-Host "  Evo Policies:                 $($stats.EvoPolicies)" -ForegroundColor Cyan
Write-Host "  Evo Agents:                   $($stats.EvoAgents)" -ForegroundColor Cyan
Write-Host "  Evo Workflows:                $($stats.EvoWorkflows)" -ForegroundColor Cyan
Write-Host "  GEMINI.md:                    v6 (from evo/)" -ForegroundColor Cyan
Write-Host ""

$bmadSkillCount = (Get-ChildItem $SkillsDir -Directory -Filter "bmad-*" -ErrorAction SilentlyContinue).Count
Write-Host "  BMAD Skills (bmad-*):         $bmadSkillCount (untouched)" -ForegroundColor Gray
Write-Host ""

$totalSkills = $stats.AgKitSkills + $stats.SuperpowersSkills + $bmadSkillCount + $evoSkillCount
Write-Host "  Total Skills Available:       $totalSkills" -ForegroundColor White
Write-Host ""

if ($DryRun) {
    Write-Host "  [DRY RUN] No changes were made" -ForegroundColor Yellow
}
else {
    Write-Host "  [OK] Sync complete! Your super-framework is ready." -ForegroundColor Green
}
Write-Host ""
