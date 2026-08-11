set history save
set history filename ~/.gdb_history
set verbose off
set print pretty on
set print array off
set print array-indexes on
set print elements 5
set print max-depth 2
set python print-stack full

source ~/.gdb/colour_filter.py

python

import io

class PrintSourceContext(gdb.Command):
    def __init__(self):
        super(PrintSourceContext, self).__init__("print_source_context", gdb.COMMAND_USER)

    def invoke(self, arg, from_tty):
        if gdb.selected_thread() is None:
            return

        sal = gdb.selected_frame().find_sal()
        current_line = sal.line
        if current_line == 0:
            return

        file_name = sal.symtab.fullname()

        CONTEXT = 3

        counter = 1
        try:
            with io.open(file_name, errors='replace') as source_file:
                print("\033[32m{}\033[0m:{}".format(file_name, current_line))
                for line in source_file.readlines():
                    if (counter >= current_line - CONTEXT) and (counter <= current_line + CONTEXT):
                        line = line.rstrip()
                        if current_line == counter:
                            print("\033[1m\033[33m>>> " + line + "\033[0m")
                        else:
                            print("    " + line)
                    counter += 1
        except IOError as e:
            print('Cannot display "{}"'.format(file_name))

PrintSourceContext()

end

alias -a psc = print_source_context
define hook-stop
  print_source_context
end

# source ~/.gdb/dashboard
# dashboard -layout stack assembly source variables
# dashboard stack -style limit 5
# dashboard variables -style compact False
