

$url = "https://91.186.93.70"

# Disable SSL hostname validation
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true } 

$req=[system.Net.HttpWebRequest]::Create($url);
$res = $req.getresponse();

# Output status code and headers

Write-Host Status Code: $res.StatusCode

Write-Host Headers:
Write-Host -----------------

$headers = $res.Headers

$keys = $res.Headers.AllKeys
foreach ($key in $keys) {
   Write-Host $key :  $headers.Get($key);
}

# Output body

Write-Host Body:

Write-Host -----------------

$buffer = new-object System.Byte[] 1024
$encoding = new-object System.Text.AsciiEncoding 

$stream = $res.GetResponseStream()


while($stream.CanRead) { 
   $read = $stream.Read($buffer, 0, 1024)   
   write-host -n ($encoding.GetString($buffer, 0, $read)) 
} 


$res.Close();

# Enable SSL hostname validation
[System.Net.ServicePointManager]::ServerCertificateValidationCallback = $null
