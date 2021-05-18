type termColors = object
    black: string
    red: string
    green: string
    yellow: string
    blue: string
    magenta: string
    cyan: string
    white: string
    reset: string

func Colors(): termColors =
    result.black = "\u001b[30m"
    result.red = "\u001b[31m"
    result.green = "\u001b[32m"
    result.yellow = "\u001b[33m"
    result.blue = "\u001b[34m"
    result.magenta = "\u001b[35m"
    result.cyan = "\u001b[36m"
    result.white = "\u001b[37m"
    result.reset = "\u001b[0m"

proc main() =
    echo(Colors().black, "test")
    echo(Colors().red, "test")
    echo(Colors().green, "test")
    echo(Colors().yellow, "test")
    echo(Colors().blue, "test")
    echo(Colors().magenta, "test")
    echo(Colors().cyan, "test")
    echo(Colors().white, "test")
    echo(Colors().reset, "test")
    
    
when isMainModule:
  main()
