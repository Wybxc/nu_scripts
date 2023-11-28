# Activate conda environment
export def shell [
    env_name?: string@'nu-complete mamba envs' # name of the environment
] {
    if ($env_name != null) {
        micromamba run -n $env_name nu
    } else {
        micromamba run -n base nu
    }
}

def 'nu-complete mamba envs' [] {
    mamba-envs | get name
}

def mamba-envs [] {
    micromamba env list | parse --regex '\s*(?P<name>\w+)\s+(?P<location>.+)' | skip 1
}
