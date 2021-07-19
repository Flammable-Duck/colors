import tables
import system
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
    c: string = "" {.info("The color of the text"), alias("color").}
    m: string = "" {.info("The text (will use stdin if not supplied)"), alias("message").}
    b: bool = false {.info("bold"), alias("bold").}
    i: bool = false {.info("italic"), alias("italic").}
    u: bool = false {.info("underline"), alias("underline").}
    s: bool = false {.info("strikethrough"), alias("strikethrough").}
    rgb:seq[int] {. len(3), info("rgb color") .}

proc rgb(r:int,g:int,b:int):string =
    if r > 255 or r < 0 or g > 255 or g < 0 or b > 255 or b < 0:
        raise newException(ValueError, "Not a valid RGB value.")
    return "\u001b[38;2;" & $r & ";" & $g & ";" & $b & "m"

proc get_codes(): string =
    var codes:string
    case len(options.rgb):
        of 0:
            discard
        else:
            codes.add(rgb(options.rgb[0], options.rgb[1], options.rgb[2] ))
    case options.c in colors:
        of false:
            if options.c != "":
                raise newException(ValueError, "Not a valid color option.")
            else:
                discard
        of true:
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
    try:
        main()
    except:
        echo getCurrentExceptionMsg()
        quit(QuitFailure)
