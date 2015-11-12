$charset  = @()
$charset += ([char]'0'..[char]'9') |% {[char]$_}
$charset += ([char]'a'..[char]'z') |% {[char]$_}
$charset += ([char]'A'..[char]'Z') |% {[char]$_}
$charset  = $charset | Select-Object -uniq

function Get-NextPassword() {
    param(
        $Password
    )    
        
    if (($Password -eq $null) -or ($Password -eq '')) {
        #Started with nothing, return the first item of the character set.
        return [string]$charset[0]
    }
    else {
        for ($pass_pos = ($Password.Length - 1); $pass_pos -ge 0; $pass_pos--) {            
            $charset_pos = [array]::indexOf($charset, [char]$Password[$pass_pos])
            if ($charset_pos -eq $charset.Length - 1) {
                #Overflow of the current password position.
                $tempArray = $Password[0..$Password.Length]
                $tempArray[$pass_pos] = $charset[0]
                $Password = $tempArray -join ""
                #Add character. Extend by 1 position.
                if ($pass_pos -eq 0) {
                    $Password = $charset[0] + $Password
                }
            }
            else {
                #No overflow, update the current position +1 of the current character.
                $tempArray = $Password[0..$Password.Length]
                $tempArray[$pass_pos] = $charset[$charset_pos+1]
                $Password = $tempArray -join ""
                break #No overflow, therefore break the loop.
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