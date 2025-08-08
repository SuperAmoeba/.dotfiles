function set_custom_color
    set -l bold $argv[1]
    set -l r $argv[2]
    set -l g $argv[3]
    set -l b $argv[4]

    if test "$bold" = "true"
        printf "\033[1;38;2;%s;%s;%sm" $r $g $b
    else
        printf "\033[38;2;%s;%s;%sm" $r $g $b
    end
end

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status

    set -l git_info
    if git rev-parse 2>/dev/null
        set -l git_branch (
            command git symbolic-ref HEAD 2>/dev/null | string replace 'refs/heads/' ''
            or command git describe HEAD 2>/dev/null
            or echo unknown
        )
        set git_branch (set_custom_color true 91 206 250)"$git_branch"
        set -l git_status
        if git rev-parse --quiet --verify HEAD >/dev/null
            and not command git diff-index --quiet HEAD --
            for i in (git status --porcelain | string sub -l 2 | sort | uniq)
                switch $i
                    case "."
                        set git_status "$git_status"(set_color green)✚
                    case " D"
                        set git_status "$git_status"(set_color red)✖
                    case "*M*"
                        set git_status "$git_status"(set_color green)✱
                    case "*R*"
                        set git_status "$git_status"(set_color purple)➜
                    case "*U*"
                        set git_status "$git_status"(set_color brown)═
                    case "??"
                        set git_status "$git_status"(set_color red)≠
                end
            end
        else
            set git_status (set_color green):
        end
        set git_info "(git$git_status$git_branch"(set_color white)")"
    end

    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # First line (no leading space, proper color resets)
    printf '%s❰%s%s%s%s%s%s❱\n' \
        (set_color -o white) \
        (set_custom_color false 91 206 250) $USER \
        (set_color white)'❙' \
        (set_custom_color false 245 169 184)(prompt_pwd)(set_color white) \
        $git_info \
        (set_color white)


    # Second line: prompt symbol
    if test $last_status -eq 0
        printf '%s✔%s≻%s ' (set_color -o green) (set_color white) (set_color normal)
    else
        printf '%s✘%s≻%s ' (set_color -o red) (set_color white) (set_color normal)
    end
end

