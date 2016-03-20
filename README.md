# atom-settings

Use this when installing Atom on a new machine.

## Install a new Atom instance

1. Clone the repo inside the `.atom` directory.
1. Install the packages
        apm install --packages-file packages.txt

## Update the package list

1. Install/update the new package as usual
1. Then update the `packages.txt` file:  
        apm list --installed --bare > package-list.txt
1. Add to git and commit, then push to upstream.
