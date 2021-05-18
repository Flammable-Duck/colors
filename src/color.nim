import tables

const colors = to_ordered_table({"black": "\u001b[30m", "red": "\u001b[31m", "green": "\u001b[32m", "yellow": "\u001b[33m", "blue": "\u001b[34m", "magenta": "\u001b[35m", "cyan": "\u001b[36m", "white": "\u001b[37m", "reset": "\u001b[0m", })

proc main() =
    for value, key in colors:
        echo value, key
    
when isMainModule:
  main()
