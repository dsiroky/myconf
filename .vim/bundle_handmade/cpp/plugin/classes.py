import re

#==========================================================================

def character_position(buf, cursor):
    """
    Newlines are counted in as well.
    @return character position from the buffer start
    """
    cur_row, cur_column = cursor
    counter = 0
    for i in range(cur_row):
        counter += len(buf[i]) + 1 # \n
    return counter + cur_column

#--------------------------------------------------------------------------

def raw_method(buf, row):
    # there must be an opening parenthesis
    if "(" not in buf[row]:
        return None

    lines = [buf[row].strip()]
    while (row < len(buf) - 1) and (";" not in buf[row]):
        row += 1
        lines.append(buf[row].strip())

    return " ".join(lines)

#--------------------------------------------------------------------------

def strip_parameter_defaults(method):
    stop_chars = " \t\n,)"
    open_brackets = "[({"
    close_brackets = "])}"

    # extract parameters
    m = re.match(r"(.*?\()(.*)(\).*)$", method, re.DOTALL)
    if m is None:
        return None

    pre = m.group(1)
    params = m.group(2)
    post = m.group(3)

    while True:
        m = re.search(r"\s*=\s*", params)
        if m is None:
            break
        start = m.start()

        nesting = 0
        for i in range(m.end(), len(params)):
            c = params[i]
            if (c in stop_chars) and (nesting == 0):
                break
            if c in open_brackets:
                nesting += 1
            elif c in close_brackets:
                nesting -= 1
        else:
            i += 1 # skip to next character

        end = i

        params = params[:start] + params[end:]

    return pre + params + post

#--------------------------------------------------------------------------

def strip_method(method):
    """
    Strip "virtual", "static", "override", ..., semicollon.
    """
    allowed_afterwords = ("const", "noexcept",)
    m = re.match(r"^.*?((\S+\s+|\S+\s*[*&]\s*)\S+\s*\(.*\))(.*);", method)
    if m is None:
        return None

    afterwords = []
    for aw in m.group(3).split(" "):
        aw = aw.strip()
        if aw in allowed_afterwords:
            afterwords.append(aw);

    stripped = (m.group(1) + " " + " ".join(afterwords)).strip()

    return stripped

#--------------------------------------------------------------------------

def split_method(method):
    """
    @return (prototype, rest)
    """
    re_type = r"(\S+(\s*?[*&]\s*|\s+))"
    re_body = r"(.*\(.*\).*)"
    m = re.match(re_type + re_body + "$", method)
    if m is None:
        return None
    return (m.group(1).strip(), m.group(3).strip())

#--------------------------------------------------------------------------

def narrow_text(buf):
    """
    @return list converted to continuous text
    """
    return "\n".join(buf)

#--------------------------------------------------------------------------

def get_class(buf, cursor):
    """
    @return classname
    """
    pos = character_position(buf, cursor)
    text = narrow_text(buf)[:pos]

    m = re.match("(.*)class\s+(\w+)[^;]*?{", text, re.DOTALL)
    if m is None:
        # error - class is requested
        return None

    return m.group(2)

#--------------------------------------------------------------------------

def full_prototype(buf, cursor):
    """
    @return prototype parts [datatype, class_name, prototype] or None
    """
    cl = get_class(buf, cursor)
    raw = raw_method(buf, cursor[0])
    if raw is None:
        return None
    stripped = strip_method(raw)
    if stripped is None:
        return None
    stripped = strip_parameter_defaults(stripped)
    _split = split_method(stripped)
    if _split is None:
        return None
    tp, rest = _split
    return "%s %s::%s\n{\n}" % (tp, cl, rest)
