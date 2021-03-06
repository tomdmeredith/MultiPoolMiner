﻿$Path = '.\Bin\AMD-NiceHash\sgminer.exe'
$Uri = 'https://github.com/nicehash/sgminer/releases/download/5.6.1/sgminer-5.6.1-nicehash-51-windows-amd64.zip'

$Name = (Get-Item $script:MyInvocation.MyCommand.Path).BaseName

$Algorithms = [PSCustomObject]@{
    #Lyra2z = 'lyra2z' #not supported
    #Equihash = 'equihash' #not supported
    #Cryptonight = 'cryptonight' #not supported
    #Ethash = 'ethash' #not supported
    Sia = 'sia'
    Yescrypt = 'yescrypt'
    BlakeVanilla = 'vanilla'
    Lyra2RE2 = 'lyra2rev2'
    Skein = 'skeincoin'
    Qubit = 'qubitcoin'
    NeoScrypt = 'neoscrypt'
    X11 = 'darkcoin-mod'
    MyriadGroestl = 'myriadcoin-groestl'
    Groestl = 'groestlcoin'
    Keccak = 'maxcoin'
    Scrypt = 'zuikkis'
}

$Optimizations = [PSCustomObject]@{
    Lyra2z = ' --worksize 32 --intensity 18'
    Equihash = ' --gpu-threads 2 --worksize 256'
    Cryptonight = ' --gpu-threads 1 --worksize 8 --rawintensity 896'
    Ethash = ' --gpu-threads 1 --worksize 192 --xintensity 1024'
    Sia = ''
    Yescrypt = ' --worksize 4 --rawintensity 256'
    BlakeVanilla = ' --intensity d'
    Lyra2RE2 = ' --gpu-threads 2 --worksize 128 --intensity d'
    Skein = ' --gpu-threads 2 --worksize 256 --intensity 23'
    Qubit = ' --gpu-threads 2 --worksize 128 --intensity d'
    NeoScrypt = ' --gpu-threads 1 --worksize 64 --intensity 13 --thread-concurrency 64'
    X11 = ' --gpu-threads 2 --worksize 128 --intensity d'
    MyriadGroestl = ' --gpu-threads 2 --worksize 64 --intensity d'
    Groestl = ' --gpu-threads 2 --worksize 128 --intensity d'
    Keccak = ''
    Scrypt = ''
}

$Algorithms | Get-Member -MemberType NoteProperty | Select -ExpandProperty Name | ForEach {
    [PSCustomObject]@{
        Type = 'AMD'
        Path = $Path
        Arguments = -Join ('--api-listen -k ', $Algorithms.$_, ' -o $($Pools.', $_, '.Protocol)://$($Pools.', $_, '.Host):$($Pools.', $_, '.Port) -u $($Pools.', $_, '.User) -p $($Pools.', $_, '.Pass)', $Optimizations.$_)
        HashRates = [PSCustomObject]@{$_ = -Join ('$($Stats.', $Name, '_', $_, '_HashRate.Week)')}
        API = 'Xgminer'
        Port = 4028
        Wrap = $false
        URI = $Uri
    }
}