# set $env.custom_config.jvms.base_dir to the directory where you have installed your JDK/JREs
# 
# Directory structure should be like this:
# $env.custom_config.jvms.base_dir
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
    $env.JAVA_HOME = ($env.custom_config.jvms.base_dir | path join $name)
}

export extern-wrapped run [
    ...args: string
] {
    run-external ($env.JAVA_HOME | path join 'bin' 'java') $args
}

export extern-wrapped compile [
    ...args: string
] {
    run-external ($env.JAVA_HOME | path join 'bin' 'javac') $args
}

def 'nu-complete jvms use' [] {
    ls $env.custom_config.jvms.base_dir
    | where type == 'dir'
    | get name
    | path basename
}