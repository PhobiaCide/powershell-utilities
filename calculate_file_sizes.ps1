$Files = Get-ChildItem -File
$Count = $Files.Count

if ($Count -gt 0) {
    $Sum = $Files | Measure-Object -Sum Length | Select-Object -ExpandProperty Sum
    $Average = $Sum / $Count

    $SortedSizes = $Files | Select-Object -ExpandProperty Length | Sort-Object
    $Median = if ($Count % 2 -eq 0) { ($SortedSizes[$Count / 2 - 1] + $SortedSizes[$Count / 2]) / 2 } else { $SortedSizes[($Count - 1) / 2] }

    $StandardDeviation = if ($Count -gt 1) {
        $SquaredDifferences = $Files | ForEach-Object { ($_.Length - $Average) * ($_.Length - $Average) }
        $SumSquaredDifferences = $SquaredDifferences | Measure-Object -Sum | Select-Object -ExpandProperty Sum
        [Math]::Sqrt($SumSquaredDifferences / ($Count - 1))
    } else {
        0
    }

    $MinSize = $SortedSizes[0]
    $MaxSize = $SortedSizes[-1]
} else {
    $Average = 0
    $Median = 0
    $StandardDeviation = 0
    $MinSize = 0
    $MaxSize = 0
}

$AverageFormatted = "{0:N2}" -f $Average
$MedianFormatted = "{0:N2}" -f $Median
$StandardDeviationFormatted = "{0:N2}" -f $StandardDeviation
$MinSizeFormatted = "{0:N0}" -f $MinSize
$MaxSizeFormatted = "{0:N0}" -f $MaxSize

Write-Host "Total Files: $Count"
Write-Host "Average Size: $AverageFormatted"
Write-Host "Median Size: $MedianFormatted"
Write-Host "Standard Deviation: $StandardDeviationFormatted"
Write-Host "Minimum Size: $MinSizeFormatted"
Write-Host "Maximum Size: $MaxSizeFormatted"

Read-Host "Press Enter to exit"
