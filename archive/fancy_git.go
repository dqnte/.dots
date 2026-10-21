package main

import (
    "fmt"
    "strings"
    "os/exec"
    "os"
    "strconv"
)

var RED string = "\033[31m"
var GREEN string = "\033[32m"
var YELLOW string = "\033[33m"
var BOLD string = "\033[1m"
var ITALIC string = "\033[3m"
var RESET string = "\033[0m"

func removeEmpties(lines []string) []string {
    cleared := []string{}
    for _, line := range lines {
        if line != "" {
            cleared = append(cleared, line)
        }
    }
    return cleared
}

func includes(list []string, a string) bool {
    for _, b := range list {
        if b == a {
            return true
        }
    }
    return false
}

func indexOf(list []string, a string) int {
    for i, b := range list {
        if b == a {
            return i
        }
    }
    return -1
}

func termWidth() int {
    cmd := exec.Command("stty", "size")
    cmd.Stdin = os.Stdin
    out, _ := cmd.Output()
    size := strings.Split(string(out)[:len(out)-1], " ")
    width, _ := strconv.Atoi(size[1])
    return width
}

func printer(lines []string) {
    width := termWidth()
    if len(lines) == 0 {
        return
    }

    fmt.Println("")
    for _ ,line := range lines {
        if len(line) > width {
            fmt.Println("  " + line[:width])
            fmt.Println("  " + line[width:])
        } else {
            fmt.Println("  " + line)
        }
    }
    fmt.Println("")
}

func git_(args ...string) []string {
    cmd := exec.Command("git", args...)
    stdout, _ := cmd.Output()
    return strings.Split(string(stdout), "\n")
}

func status() {
    output := git_("status")
    lines := []string{}
    if len(output) == 1 {
        lines = append(lines, ITALIC + "not a git repository" + RESET)
    } else {
        for _, line := range output {
            if line != "" && ! strings.Contains(line, " (use") {
                if strings.Contains(line, "On branch") {
                    branch := BOLD + strings.Split(line, " ")[2] + RESET
                    lines = append(lines, "On branch " + branch)
                } else if line == "Changes to be committed:" {
                    lines = append(lines, "\n  Staged:" + GREEN)
                } else if line == "Changes not staged for commit:" {
                    lines = append(lines, RESET + "\n  Unstaged:" + RED)
                } else if line == "Untracked files:" {
                    lines = append(lines, RESET + "\n  Untracked:" + RED)
                } else {
                    lines = append(lines, line)
                }
            }
        }
    }
    printer(lines)
}

func reset(args []string) {
    git_(args...)
    status()
}

func branch(args []string) {
    if len(args) == 1 {
        output := git_("branch")
        lines := []string{}

        for _, line := range output {
            if line != "" {
                if strings.Contains(line, "*") {
                    lines = append(lines, BOLD + line + RESET)
                } else {
                    lines = append(lines, line)
                }
            }
        }
        printer(lines)
    } else {
        git_(args...)
    }
}

func remote(args []string) {
    output := git_(args...)
    printer(removeEmpties(output))
}

func checkout(args []string) {
    output := git_(args...)

    if len(output) == 1 && includes(args, "-b") {
        idx := indexOf(args, "-b") + 1
        if idx >= len(args) {
            output = append(output, "No branch supplied")
        } else {
            output = append(output, "Could not find branch " + ITALIC + args[idx])
        }
    }
    printer(removeEmpties(output))
}

func log(args []string) {
    output := removeEmpties(git_("log", "--oneline", "-n", "8", "--decorate"))
    formatted := []string{}
    for _, line := range output {
        words := strings.Split(line ," ")
        words[0] = YELLOW + words[0] + RESET
        formatted = append(formatted, strings.Join(words," "))
    }
    printer(formatted)
}

func main() {
    if len(os.Args) == 1 {
        return
    }
    command := os.Args[1]

    switch command {
        case "status":
            status()
        case "reset":
            reset(os.Args[1:])
        case "branch":
            branch(os.Args[1:])
        case "remote":
            remote(os.Args[1:])
        case "checkout":
            checkout(os.Args[1:])
        case "log":
            log(os.Args[1:])
        default:
            printer(removeEmpties(git_(os.Args[1:]...)))
    }
}
