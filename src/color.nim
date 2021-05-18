import tables
import parseopt

const colors = to_ordered_table({"black": "\u001b[30m",
                                "red": "\u001b[31m",
                                "green": "\u001b[32m",
                                "yellow": "\u001b[33m",
                                "blue": "\u001b[34m",
                                "magenta": "\u001b[35m",
                                "cyan": "\u001b[36m",
                                "white": "\u001b[37m",
                                "reset": "\u001b[0m", })


proc options(msg: string) =
    var p = initOptParser()
    for kind, key, val in p.getopt():
        stdout.write(colors[val], msg, "\n")

proc get_stdin(): string =
    return stdin.readall

proc main() =
    #options(get_stdin())
    options(get_stdin())
    #for key, value in colors:
    #    echo value, key
    
when isMainModule:
  main()
