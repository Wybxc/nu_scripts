# Run an executable in a conda environment.

def 'nu-complete conda envs' [] {
  ^conda info --envs
  | lines
  | where not ($it | str starts-with '#')
  | where not ($it | is-empty)
  | each {|entry| $entry | split row ' ' | get 0 }
}

export extern "conda run" [
  executable_call: string                      # Executable name, with additional arguments to be passed to the executable on invocation.
  --name(-n): string@'nu-complete conda envs'  # Name of the environment to run the command in.
  --path(-p): string                           # Full path to environment location (i.e. prefix).
  --verbose(-v)                                # Print verbose output.
  --dev                                        # Sets `CONDA_EXE` to `python -m conda`
  --debug-wrapper-scripts                      # Print debug output for wrapper scripts.
  --cwd: string                                # Change the working directory to the specified path.
  --no-capture-output                          # Do not capture output from the executable.
  --live-stream                                # Display the output for the subprocess stdout and stderr on real time.
]
