def "nu-complete git branches" [] {
  ^git branch | lines | each { |line| $line | str replace '[\*\+] ' '' | str trim }
}

def "nu-complete git remotes" [] {
  ^git remote | lines | each { |line| $line | str trim }
}

def "nu-complete git log" [] {
  ^git log --pretty=%h | lines | each { |line| $line | str trim }
}

# Download objects and refs from another repository
export extern "git fetch" [
  repository?: string@"nu-complete git remotes" # name of the repository to fetch
  branch?: string@"nu-complete git branches"    # name of the branch to fetch
  --all                                         # Fetch all remotes
  --append(-a)                                  # Append ref names and object names to .git/FETCH_HEAD
  --atomic                                      # Use an atomic transaction to update local refs.
  --depth: int                                  # Limit fetching to n commits from the tip
  --deepen: int                                 # Limit fetching to n commits from the current shallow boundary
  --shallow-since: string                       # Deepen or shorten the history by date
  --shallow-exclude: string                     # Deepen or shorten the history by branch/tag
  --unshallow                                   # Fetch all available history
  --update-shallow                              # Update .git/shallow to accept new refs
  --negotiation-tip: string                     # Specify which commit/glob to report while fetching
  --negotiate-only                              # Do not fetch, only print common ancestors
  --dry-run                                     # Show what would be done
  --write-fetch-head                            # Write fetched refs in FETCH_HEAD (default)
  --no-write-fetch-head                         # Do not write FETCH_HEAD
  --force(-f)                                   # Always update the local branch
  --keep(-k)                                    # Keep dowloaded pack
  --multiple                                    # Allow several arguments to be specified
  --auto-maintenance                            # Run 'git maintenance run --auto' at the end (default)
  --no-auto-maintenance                         # Don't run 'git maintenance' at the end
  --auto-gc                                     # Run 'git maintenance run --auto' at the end (default)
  --no-auto-gc                                  # Don't run 'git maintenance' at the end
  --write-commit-graph                          # Write a commit-graph after fetching
  --no-write-commit-graph                       # Don't write a commit-graph after fetching
  --prefetch                                    # Place all refs into the refs/prefetch/ namespace
  --prune(-p)                                   # Remove obsolete remote-tracking references
  --prune-tags(-P)                              # Remove any local tags that do not exist on the remote
  --no-tags(-n)                                 # Disable automatic tag following
  --refmap: string                              # Use this refspec to map the refs to remote-tracking branches
  --tags(-t)                                    # Fetch all tags
  --recurse-submodules: string                  # Fetch new commits of populated submodules (yes/on-demand/no)
  --jobs(-j): int                               # Number of parallel children
  --no-recurse-submodules                       # Disable recursive fetching of submodules
  --set-upstream                                # Add upstream (tracking) reference
  --submodule-prefix: string                    # Prepend to paths printed in informative messages
  --upload-pack: string                         # Non-default path for remote command
  --quiet(-q)                                   # Silence internally used git commands
  --verbose(-v)                                 # Be verbose
  --progress                                    # Report progress on stderr
  --server-option(-o): string                   # Pass options for the server to handle
  --show-forced-updates                         # Check if a branch is force-updated
  --no-show-forced-updates                      # Don't check if a branch is force-updated
  -4                                            # Use IPv4 addresses, ignore IPv6 addresses
  -6                                            # Use IPv6 addresses, ignore IPv4 addresses
  --help                                        # Display the help message for this command
]

# Check out git branches and files
export extern "git checkout" [
  ...targets: string@"nu-complete git branches"   # name of the branch or files to checkout
  --conflict: string                              # conflict style (merge or diff3)
  --detach(-d)                                    # detach HEAD at named commit
  --force(-f)                                     # force checkout (throw away local modifications)
  --guess                                         # second guess 'git checkout <no-such-branch>' (default)
  --ignore-other-worktrees                        # do not check if another worktree is holding the given ref
  --ignore-skip-worktree-bits                     # do not limit pathspecs to sparse entries only
  --merge(-m)                                     # perform a 3-way merge with the new branch
  --orphan: string                                # new unparented branch
  --ours(-2)                                      # checkout our version for unmerged files
  --overlay                                       # use overlay mode (default)
  --overwrite-ignore                              # update ignored files (default)
  --patch(-p)                                     # select hunks interactively
  --pathspec-from-file: string                    # read pathspec from file
  --progress                                      # force progress reporting
  --quiet(-q)                                     # suppress progress reporting
  --recurse-submodules: string                    # control recursive updating of submodules
  --theirs(-3)                                    # checkout their version for unmerged files
  --track(-t)                                     # set upstream info for new branch
  -b: string                                      # create and checkout a new branch
  -B: string                                      # create/reset and checkout a branch
  -l                                              # create reflog for new branch
  --help                                          # Display the help message for this command
]

# Push changes
export extern "git push" [
  remote?: string@"nu-complete git remotes",      # the name of the remote
  ...refs: string@"nu-complete git branches"      # the branch / refspec
  --all                                           # push all refs
  --atomic                                        # request atomic transaction on remote side
  --delete(-d)                                    # delete refs
  --dry-run(-n)                                   # dry run
  --exec: string                                  # receive pack program
  --follow-tags                                   # push missing but relevant tags
  --force-with-lease                              # require old value of ref to be at this value
  --force(-f)                                     # force updates
  --ipv4(-4)                                      # use IPv4 addresses only
  --ipv6(-6)                                      # use IPv6 addresses only
  --mirror                                        # mirror all refs
  --no-verify                                     # bypass pre-push hook
  --porcelain                                     # machine-readable output
  --progress                                      # force progress reporting
  --prune                                         # prune locally removed refs
  --push-option(-o): string                       # option to transmit
  --quiet(-q)                                     # be more quiet
  --receive-pack: string                          # receive pack program
  --recurse-submodules: string                    # control recursive pushing of submodules
  --repo: string                                  # repository
  --set-upstream(-u)                              # set upstream for git pull/status
  --signed: string                                # GPG sign the push
  --tags                                          # push tags (can't be used with --all or --mirror)
  --thin                                          # use thin pack
  --verbose(-v)                                   # be more verbose
  --help                                          # Display the help message for this command
]

# Clone a repository into a new directory
export extern "git clone" [
  reponsitory: string                             # the repository to clone
  --local(-l)                                     # to clone from a local repository
  --no-hardlinks                                  # don't use local hardlinks, always copy
  --shared(-s)                                    # setup as shared repository
  --reference: string                             # reference repository
  --dissociate                                    # only borrow objects from reference repositories
  --quiet(-q)                                     # suppress summary after clone
  --verbose(-v)                                   # be more verbose
  --progress                                      # force progress reporting
  --server-option: string                         # options to transmit to server
  --no-checkout(-n)                               # no checkout of HEAD is performed after the clone
  --reject-shallow                                # deepening history of shallow clone is rejected
  --no-reject-shallow                             # deepening history of shallow clone is not rejected
  --bare                                          # create a bare repository
  --sparse                                        # initialize sparse-checkout file to include only files at root
  --filter: string                                # object filtering
  --also-filter-submodules                        # filter submodules according to the filter
  --mirror                                        # set up mirror of source repository
  --origin(-o): string                            # use <name> instead of 'origin' to track upstream
  --branch(-b): string                            # checkout <branch> instead of the remote's HEAD
  --upload-pack(-u): string                       # path to git-upload-pack on the remote
  --template: string                              # directory from which templates will be used
  --config(-c): string                            # set config inside the new repository
  --depth: int                                    # create a shallow clone of that depth
  --shallow-since: string                         # create a shallow clone since a specific time
  --shallow-exclude: string                       # create a shallow clone excluding commits reachable from a specific remote branch or tag
  --single-branch                                 # clone only one branch, HEAD or --branch
  --no-single-branch                              # clone all branches
  --no-tags                                       # don't clone any tags, and set remote.<remote>.tagOpt=--no-tags
  --recurse-submodules?: string                   # control recursive cloning of submodules
  --shallow-submodules                            # any cloned submodules will be shallow
  --no-shallow-submodules                         # any cloned submodules will not be shallow
  --remote-submodules                             # any cloned submodules will use the remote-tracking branch
  --no-remote-submodules                          # any cloned submodules will use the superproject recorded SHA-1
  --separate-git-dir: string                      # separate git dir from working tree
  --jobs(-j): int                                 # number of submodules pulled in parallel
  --bundle-uri: string                            # fetch a bundle from the specified URI before cloning
  --help                                          # Display the help message for this command
]

# Switch between branches and commits
export extern "git switch" [
  switch?: string@"nu-complete git branches"      # name of branch to switch to
  --create(-c): string                            # create a new branch
  --detach(-d): string@"nu-complete git log"      # switch to a commit in a detatched state
  --force-create(-C): string                      # forces creation of new branch, if it exists then the existing branch will be reset to starting point
  --force(-f)                                     # alias for --discard-changes
  --guess                                         # if there is no local branch which matches then name but there is a remote one then this is checked out
  --ignore-other-worktrees                        # switch even if the ref is held by another worktree
  --merge(-m)                                     # attempts to merge changes when switching branches if there are local changes
  --no-guess                                      # do not attempt to match remote branch names
  --no-progress                                   # do not report progress
  --no-recurse-submodules                         # do not update the contents of sub-modules
  --no-track                                      # do not set "upstream" configuration
  --orphan: string                                # create a new orphaned branch
  --progress                                      # report progress status
  --quiet(-q)                                     # suppress feedback messages
  --recurse-submodules                            # update the contents of sub-modules
  --track(-t)                                     # set "upstream" configuration
]

# Create an empty Git repository or reinitialize an existing one
export extern "git init" [
  directory?: string                              # the directory to initialize
  --bare                                          # create a bare repository
  --object-format: string                         # specify the object format to use
  --separate-git-dir: string                      # separate git dir from working tree
  --template: string                              # directory from which templates will be used
  --shared(-s): string                            # set sharing for repository
  --quiet(-q)                                     # suppress feedback messages
  --verbose(-v)                                   # be more verbose
  --initial-branch(-b): string                    # name of the initial branch
  --help                                          # Display the help message for this command
]

# Add file contents to the index
export extern "git add" [
  path: string                                    # the path to add
  --interactive(-i)                               # interactively choose hunks of patch between index and work tree and add them to the index
  --patch(-p)                                     # interactively choose hunks of patch between index and work tree and add them to the index
  --edit(-e)                                      # edit current diff and apply
  --all(-A)                                       # add changes from all tracked and untracked files
  --update(-u)                                    # update tracked files
  --no-all                                        # add new changes in tracked files
  --intent-to-add(-N)                             # record only the fact that the path will be added later
  --refresh                                       # don't add, only refresh the index
  --ignore-errors                                 # just skip files which cannot be added because of errors
  --ignore-missing                                # check if - even missing - files are ignored in dry run
  --dry-run(-n)                                   # dry run
  --verbose(-v)                                   # be more verbose
  --force(-f)                                     # allow adding otherwise ignored files
  --sparse                                        # allow updating index entries with sparse paths
  --ignore-removal(-E)                            # ignore paths removed in the working tree (same as --no-all)
  --ignore-removal(-e)                            # ignore paths removed in the working tree (same as --no-all)
  --renormalize                                   # renormalize EOL of tracked files (implies -u)
  --chmod: string                                 # override the executable bit of the added files
  --pathspec-file-nul: string                     # pathspec file passed in <nul> terminated format
  --pathspec-file: string                         # pathspec file passed in <lines> terminated format
  --pathspec-from-file(-z): string                # read pathspec from file
  --pathspec-from-file(-z): string                # read pathspec from file
  --pathspec-file-nul                             # pathspec file passed in <nul> terminated format
  --pathspec-file                                 # pathspec file passed in <lines> terminated format
  --pathspec-from-file(-z)                        # read pathspec from file
  --pathspec-from-file(-z)                        # read pathspec from file
  --pathspec-from-file-literal(-z): string        # read pathspec from file, treating it as literal value
  --pathspec-from-file-literal(-z): string        # read
]

# Record changes to the repository
export extern "git commit" [
  pathspec?: string                               # the pathspec to commit
  --all(-a)                                       # commit all changed files
  --patch(-p)                                     # interactively choose hunks of patch between index and work tree and add them to the index
  --reuse-message(-C): string                     # reuse message from specified commit
  --reedit-message(-c): string                    # reuse and edit message from specified commit
  --fixup: string                                 # use autosquash formatted message to fixup specified commit
  --amend                                         # amend previous commit
  --squash: string                                # use autosquash formatted message to squash specified commit
  --reset-author                                  # use the commit author as the author for the commit
  --short                                         # show status concisely
  --branch(-b): string                            # show status on branch
  --porcelain                                     # machine-readable output
  --long                                          # give the output in the long-format when doing a dry-run
  --null(-z)                                      # terminate entries with NUL
  --file(-F): string                              # read message from file
  --author: string                                # override the commit author
  --date: string                                  # override the author date used in the commit
  --message(-m): string                           # commit message
  --template(-t): string                          # use specified template file
  --signoff(-s)                                   # add Signed-off-by
  --no-signoff                                    # do not add Signed-off-by
  --trailer: string                               # add/override specified trailer
  --no-verify(-n)                                 # bypass pre-commit and commit-msg hooks
  --allow-empty                                   # allow recording a commit that has the exact same tree as its sole parent
  --allow-empty-message                           # allow recording a commit with an empty message
  --cleanup: string@git-commit-cleanup            # how to strip spaces and #comments from message
  --edit(-e)                                      # force edit of commit
  --no-edit                                       # use the selected commit message without launching an editor
  --no-post-rewrite                               # bypass post-rewrite hook
  --only(-o)                                      # commit only specified files
  --pathspec-from-file: string                    # read pathspec from file
  --pathspec-file-nul                             # pathspec file passed in <nul> terminated format
  --untracked-files: string@git-commit-untracked  # show untracked files
  --verbose(-v)                                   # show unified diff between the HEAD commit and what would be committed at the bottom of the commit message template to help the user describe the commit by reminding what changes the commit has
  --quiet(-q)                                     # suppress summary after successful commit
  --dry-run                                       # show what would be committed
  --status                                        # include the output of git-status(1) in the commit message template
  --no-status                                     # do not include the output of git-status(1) in the commit message template
  --gpg-sign(-S): string                          # GPG sign commit
  --no-gpg-sign                                   # do not GPG sign commit
  --help                                          # Display the help message for this command
]

def git-commit-cleanup [] {
  ["strip" "verbatim" "whitespace" "scissors" "default"]
}

def git-commit-untracked [] {
  ["no" "normal" "all"]
}