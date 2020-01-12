cmd.exe /c "call `"C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat`" && set > %temp%\vcvars.txt"
Get-Content "$env:temp\vcvars.txt" | Foreach-Object {
  if ($_ -match "^(.*?)=(.*)$") {
    Set-Content "env:\$($matches[1])" $matches[2]
  }
}

ruby "C:\Users\ruby-packer\ruby-packer-metanorma\bin\rubyc" "C:\Users\ruby-packer\ruby-packer-test\app.rb" -c -o "C:\Users\ruby-packer\ruby-packer-build\ruby-packer-test-app.exe" --
nmake-args=CC=clang-cl
ruby "C:\Users\ruby-packer\ruby-packer-metanorma\bin\rubyc" "C:\Users\ruby-packer\ruby-packer-test\app.rb" -o "C:\Users\ruby-packer\ruby-packer-build\ruby-packer-test-app.exe" --
nmake-args=CC=clang-cl