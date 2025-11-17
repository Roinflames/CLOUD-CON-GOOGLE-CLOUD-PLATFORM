[](https://cloud.google.com/sdk/docs/install?hl=es-419)

# En 2 líneas no tiene error
(New-Object Net.WebClient).DownloadFile(
  "https://dl.google.com/dl/cloudsdk/channels/rapid/GoogleCloudSDKInstaller.exe",
  "$env:Temp\GoogleCloudSDKInstaller.exe"
)

& "$env:Temp\GoogleCloudSDKInstaller.exe"