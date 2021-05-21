import tables
import simple_parseopt

simple_parseopt.config: no_slash.dash_dash_parameters

const colors = to_ordered_table({"black": "\u001b[30m",
                                "red": "\u001b[31m",
                                "green": "\u001b[32m",
                                "yellow": "\u001b[33m",
                                "blue": "\u001b[34m",
                                "magenta": "\u001b[35m",
                                "cyan": "\u001b[36m",
                                "white": "\u001b[37m",
                                "reset": "\u001b[0m", })

let options = get_options:
    c: string = "reset" {. info("The color of the text"), alias("color") .}
    m: string = ""      {. info("The text (will use stdin if not supplied)"), alias("message") .}


proc color_stdin() =
    if options.m != "":
        echo(colors[options.c], options.m, colors["reset"])
    else:
        var line: TaintedString
        while readLine(stdin, line):
            echo(colors[options.c], line, colors["reset"])


proc ctrlc() {.noconv.} =
    system.quit()
setControlCHook(ctrlc)

proc main() =
    color_stdin()
    
when isMainModule:
    main()
