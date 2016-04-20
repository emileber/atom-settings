# atom-settings

Use this when installing Atom on a new machine.

## Install a new Atom instance

1. Delete the following files (all root files of the `.atom` dir):   

    * `.gitignore`
    * `init.coffee`
    * `keymap.cson`
    * `snippets.cson`
    * `styles.less`

1. Clone the repo inside an existing and non-empty directory:  
    ```
    git init
    git remote add origin REPO_URL
    git fetch
    git checkout -t origin/master
    ```
1. Install the packages  
    ```
    apm install --packages-file packages.txt
    ```


## Update the package list

1. Install/update the new package as usual
1. Then update the `packages.txt` file:  
    ```
    apm list --installed --bare > package-list.txt
    ```
1. Add to git and commit, then push to upstream.
