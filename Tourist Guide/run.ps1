$mavenVersion = "3.9.6"
$mavenZip = "apache-maven-$mavenVersion-bin.zip"
$mavenUrl = "https://archive.apache.org/dist/maven/maven-3/$mavenVersion/binaries/$mavenZip"
$mavenDir = "apache-maven-$mavenVersion"
$mvnCmd = "$mavenDir\bin\mvn.cmd"

if (-Not (Test-Path $mvnCmd)) {
    Write-Host "Downloading a local copy of Maven... (This will only happen once)"
    Invoke-WebRequest -Uri $mavenUrl -OutFile $mavenZip
    Write-Host "Extracting Maven..."
    Expand-Archive -Path $mavenZip -DestinationPath . -Force
    Remove-Item -Path $mavenZip
}

Write-Host "Starting Tourist Guide using Jetty Server..."
& $mvnCmd clean jetty:run
