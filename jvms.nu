# set $env.config.jvms.base_dir to the directory where you have installed your JDK/JREs
# 
# Directory structure should be like this:
# $env.config.jvms.base_dir
#   ├── zulu8.40.0.25-ca-jdk8.0.212
#   |   ├── bin
#   |   ├── ...   
#   ├── bellsoft-jdk11.0.2+9
#   |   ├── bin
#   |   ├── ...
#   ├── ...

export def-env use [
    name: string@'nu-complete jvms use', # name of the JDK/JRE
] {
    let-env JAVA_HOME = ($env.config.jvms.base_dir | path join $name)
}

def 'nu-complete jvms use' [] {
    ls $env.config.jvms.base_dir
    | where type == 'dir'
    | get name
    | path basename
}