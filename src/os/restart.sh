#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

main() {

    print_in_purple "\n • Restart\n\n"

    ask_for_confirmation "Do you want to restart? (probably not)"
    printf "\n"
    if ! answer_is_yes; then
        return 0
    fi

    ask_for_confirmation "Are you sure you want to restart?"
    printf "\n"
    if ! answer_is_yes; then
        return 0
    fi

    print_warning "Well do it yourself then!\n"


    # ask_for_confirmation "Are you sure you want to restart?"
    # printf "\n"
    # if answer_is_yes; then
    #     sudo shutdown -r now &> /dev/null
    # fi

 }

 main
