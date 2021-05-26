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
                                "reset": "\u001b[0m",
                                "bold": "\u001b[1m",
                                "italic": "\u001b[3m",
                                "underline": "\u001b[4m",
                                "strikethrough": "\u001b[9m",
                                })

let options = get_options:
    c: string = "reset" {.info("The color of the text"), alias("color").}
    m: string = "" {.info("The text (will use stdin if not supplied)"), alias("message").}
    b: bool = false {.info("bold"), alias("bold").}
    i: bool = false {.info("italic"), alias("italic").}
    u: bool = false {.info("underline"), alias("underline").}
    s: bool = false {.info("strikethrough"), alias("strikethrough").}

proc get_codes(): string =
    var codes:string
    case options.c:
        of "":
            discard
        else:
            codes.add(colors[options.c])
    case options.b:
        of false:
            discard
        of true:
            codes.add(colors["bold"])
    case options.i:
        of false:
            discard
        of true:
            codes.add(colors["italic"])
    case options.u:
        of false:
            discard
        of true:
            codes.add(colors["underline"])
    case options.s:
        of false:
            discard
        of true:
            codes.add(colors["strikethrough"])
    return codes

proc color_stdin(codes:string) =
    if options.m != "":
        echo(codes, options.m, colors["reset"])
    else:
        var line: TaintedString
        while readLine(stdin, line):
            echo(codes, line, colors["reset"])


proc ctrlc() {.noconv.} =
    system.quit()
setControlCHook(ctrlc)

proc main() =
    color_stdin(get_codes())

when isMainModule:
    main()
