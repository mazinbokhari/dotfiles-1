#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

create_symlinks() {

    declare -a FILES_TO_SYMLINK=(
        "bash/bashrc"
        "bash/bash_profile"
        "bash/bash_prompt"

        "zsh/zshrc"
        "zsh/zshenv"
        "zsh/zgen"

        "vim/vim"
        "vim/vimrc"

        "emacs/spacemacs.d"
        "emacs/emacs.d"

        "tmux/tmux"
        "tmux/tmux.conf"

        "shared/checks"
        "shared/aliases"
        "shared/exports"
        "shared/functions"
        "shared/path"
        "shared/extra"

        "tools/fzf"
        "shared/gitconfig"
        "shared/dircolors"
        "shared/jupyter"
        "shared/ptpython"

        # "shared/htop" -> ${XDG_CONFIG_HOME}/htop
        # "shared/bpython" -> ${XDG_CONFIG_HOME}/bpython
    )

    local i=""
    local sourceFile=""
    local targetFile=""
    local skipQuestions=false

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    skip_questions "$@" \
        && skipQuestions=true

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    for i in "${FILES_TO_SYMLINK[@]}"; do

        sourceFile="$(cd .. && pwd)/$i"
        targetFile="$HOME/.$(printf "%s" "$i" | sed "s/.*\/\(.*\)/\1/g")"

        if [ ! -e "$targetFile" ] || $skipQuestions; then

            execute \
                "ln -fs $sourceFile $targetFile" \
                "$targetFile → $sourceFile"

        elif [ "$(readlink "$targetFile")" == "$sourceFile" ]; then
            print_success "$targetFile → $sourceFile"
        else

            if ! $skipQuestions; then

                ask_for_confirmation "'$targetFile' already exists, do you want to overwrite it?"
                if answer_is_yes; then

                    rm -rf "$targetFile"

                    execute \
                        "ln -fs $sourceFile $targetFile" \
                        "$targetFile → $sourceFile"

                else
                    print_error "$targetFile → $sourceFile"
                fi

            fi

        fi

    done

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {
    print_in_purple "\n • Create symbolic links\n\n"
    create_symlinks "$@"
}

main "$@"
