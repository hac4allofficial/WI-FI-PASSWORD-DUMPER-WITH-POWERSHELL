$charset  = @()
$charset += ([char]'0'..[char]'9') |% {[char]$_}
$charset += ([char]'a'..[char]'z') |% {[char]$_}
$charset += ([char]'A'..[char]'Z') |% {[char]$_}
$charset  = $charset | Select-Object -uniq

function Get-NextPassword() {
    param(
        $Password
    )
    
    #Start with nothing
    if (($Password -eq $null) -or ($Password -eq '')) {
        return [string]$charset[0]
    }
    else {
        for ($pass_pos = ($Password.Length - 1); $pass_pos -ge 0; $pass_pos--) {
            #Overflow
            $index = [array]::indexOf($charset, [char]$Password[$pass_pos])
            if ($index -eq $charset.Length - 1) {
                $tempArray = $Password[0..$Password.Length]
                $tempArray[$pass_pos] = $charset[0]
                $Password = $tempArray -join ""
                #Add character. Extend by 1 position.
                if ($pass_pos -eq 0) {
                    $Password = $charset[0] + $Password
                }
            }
            else {
                $tempArray = $Password[0..$Password.Length]
                $tempArray[$pass_pos] = $charset[$index+1]
                $Password = $tempArray -join ""
                break
            }
        }    
        return $Password
    }
    
}    

$Password = $null
While ($true) {
     $Password = Get-NextPassword $Password
     $Password
}