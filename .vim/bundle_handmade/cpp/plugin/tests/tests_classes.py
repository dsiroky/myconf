import unittest
import classes as sut

#==========================================================================

class TestPrototypesWithoutNamespace(unittest.TestCase):
    def setUp(self):
        self.code = [
            "",
            "x",
            "class Abc: public Other",
            "{",
            "\t\tpublic:",
            "        void method(content);",
            "        void method(content) const;",
            "        virtual void method(content) const;",
            "        static void method(content);",
            "        virtual void multiline(content1,\t ",
            "\t\t                              content2) const;",
            "\t\tvirtual void multiline(content1,",
            "\t\t\t\tcontent2) const;",
            "};"
        ]

    #-------------------------------------------------------

    def test_character_position(self):
        result = sut.character_position(self.code, (0, 0))
        self.assertEqual(0, result)
        result = sut.character_position(self.code, (0, 10))
        self.assertEqual(10, result)

        result = sut.character_position(self.code, (1, 0))
        self.assertEqual(1, result)
        result = sut.character_position(self.code, (1, 10))
        self.assertEqual(11, result)

        result = sut.character_position(self.code, (2, 0))
        self.assertEqual(3, result)

    #-------------------------------------------------------

    def test_raw_method(self):
        result = sut.raw_method(self.code, 0)
        self.assertIsNone(result)

        result = sut.raw_method(self.code, 2)
        self.assertIsNone(result)

        result = sut.raw_method(self.code, 5)
        self.assertEqual("void method(content);", result)

        result = sut.raw_method(self.code, 9)
        self.assertEqual("virtual void multiline(content1, content2) const;", result)

    #-------------------------------------------------------

    def test_get_class(self):
        result = sut.get_class(self.code, (1, 0))
        self.assertIsNone(result)

        result = sut.get_class(self.code, (5, 0))
        self.assertEqual("Abc", result)

#==========================================================================

class TestPrototypesWithNamespace(unittest.TestCase):
    def setUp(self):
        self.code = [
            "",
            "",
            "namespace N1 {",
            "",
            "class Cl1: public Other",
            "{",
            "",
            "namespace N2 {",
            "",
            "class Cl2: public Other",
            "{",
            "",
        ]

    #-------------------------------------------------------

    def test_get_class(self):
        result = sut.get_class(self.code, (1, 0))
        self.assertIsNone(result)

        result = sut.get_class(self.code, (3, 0))
        self.assertIsNone(result)

        result = sut.get_class(self.code, (6, 0))
        self.assertEqual("Cl1", result)

        result = sut.get_class(self.code, (11, 0))
        self.assertEqual("Cl2", result)

#==========================================================================

class TestMisc(unittest.TestCase):
    def test_strip_parameter_defaults(self):
        result = sut.strip_parameter_defaults("(a)")
        self.assertEqual("(a)", result)

        result = sut.strip_parameter_defaults(" (a)  ")
        self.assertEqual(" (a)  ", result)

        result = sut.strip_parameter_defaults("(a )")
        self.assertEqual("(a )", result)

        result = sut.strip_parameter_defaults("( =  somedefault)")
        self.assertEqual("()", result)

        result = sut.strip_parameter_defaults(" ( =  somedefault)  ")
        self.assertEqual(" ()  ", result)

        result = sut.strip_parameter_defaults("(a = somedefault )")
        self.assertEqual("(a )", result)

        result = sut.strip_parameter_defaults("( =  somedefault )")
        self.assertEqual("( )", result)

        result = sut.strip_parameter_defaults("(b =  somedefault({({ x, y})}) )")
        self.assertEqual("(b )", result)

        result = sut.strip_parameter_defaults("(b =  somedefault({[({ x, y})]}) , c = sd({}))")
        self.assertEqual("(b , c)", result)

    #-------------------------------------------------------

    def test_strip_method(self):
        result = sut.strip_method("  void   x ( ")
        self.assertIsNone(result)

        result = sut.strip_method("  void   x ( content, content2 )  ;")
        self.assertEqual("void   x ( content, content2 )", result)

        result = sut.strip_method("  void   *x ( content, content2 )  ;")
        self.assertEqual("void   *x ( content, content2 )", result)

        result = sut.strip_method("  void   * x ( content, content2 )  ;")
        self.assertEqual("void   * x ( content, content2 )", result)

        result = sut.strip_method("  void   &x ( content, content2 )  ;")
        self.assertEqual("void   &x ( content, content2 )", result)

        result = sut.strip_method("  static void   x ( content, content2 )   ;")
        self.assertEqual("void   x ( content, content2 )", result)

        result = sut.strip_method("  void   x ( content, content2 ) unknown  ;")
        self.assertEqual("void   x ( content, content2 )", result)

        result = sut.strip_method("  void   x ( content, content2 ) unknown  ;")
        self.assertEqual("void   x ( content, content2 )", result)

        result = sut.strip_method("  aa::bb   x ( content, content2);")
        self.assertEqual("aa::bb   x ( content, content2)", result)

        result = sut.strip_method("  aa::bb   x ( content, content2 ) ;")
        self.assertEqual("aa::bb   x ( content, content2 )", result)

        result = sut.strip_method("  aa::bb   x ( content, content2 ) unknown  ;")
        self.assertEqual("aa::bb   x ( content, content2 )", result)

        result = sut.strip_method("  virtual aa::bb   x ( content, content2 ) unknown  ;")
        self.assertEqual("aa::bb   x ( content, content2 )", result)

        result = sut.strip_method("  aa::bb   operator=( content, content2 ) unknown  ;")
        self.assertEqual("aa::bb   operator=( content, content2 )", result)

        result = sut.strip_method("  aa::bb   operator= ( content, content2 ) unknown  ;")
        self.assertEqual("aa::bb   operator= ( content, content2 )", result)

    #-------------------------------------------------------

    def test_split_method(self):
        result = sut.split_method("void   x ( content, content2 )")
        self.assertEqual(("void", "x ( content, content2 )"), result);

        result = sut.split_method("void   x ( content, content2 )  const")
        self.assertEqual(("void", "x ( content, content2 )  const"), result);

        result = sut.split_method("void   *x ( content, content2 )  const")
        self.assertEqual(("void   *", "x ( content, content2 )  const"), result);

        result = sut.split_method("void   * x ( content, content2 )  const")
        self.assertEqual(("void   *", "x ( content, content2 )  const"), result);

        result = sut.split_method("aa::bb   x ( content, content2 )  const")
        self.assertEqual(("aa::bb", "x ( content, content2 )  const"), result);

        result = sut.split_method("aa::bb   &x ( content, content2 )  const")
        self.assertEqual(("aa::bb   &", "x ( content, content2 )  const"), result);

        result = sut.split_method("aa::bb   & x ( content, content2 )  const")
        self.assertEqual(("aa::bb   &", "x ( content, content2 )  const"), result);

        result = sut.split_method("aa::bb   x( content, content2 )  const")
        self.assertEqual(("aa::bb", "x( content, content2 )  const"), result);

        result = sut.split_method("aa::bb   operator=( content, content2 )  const")
        self.assertEqual(("aa::bb", "operator=( content, content2 )  const"), result);

        result = sut.split_method("aa::bb   operator= ( content, content2 )  const")
        self.assertEqual(("aa::bb", "operator= ( content, content2 )  const"), result);

#==========================================================================

class TestPrototypesFull(unittest.TestCase):
    def setUp(self):
        self.code = [
            "",
            "namespace Ns {",
            "class Abc: public Other",
            "{",
            "\t\tpublic:",
            "        xx::yy operator=(content);",
            "        xx::yy method(content);",
            "        xx::yy * method(content);",
            "        void method(content) const;",
            "        virtual void method(content) const;",
            "        static void method(content);",
            "        virtual void multiline(content1 =  somedefault({({ x, y})}),",
            "                                content2 =  somedefault({({ x, y})})) const;",
            "\t\tvirtual void multiline(content1,",
            "\t\t\t\tcontent2) const;",
            "        const char *methodcc(content);",
            "};"
        ]

    #-------------------------------------------------------

    def test_full_prototype(self):
        result = sut.full_prototype(self.code, (5, 0))
        self.assertEqual("xx::yy Abc::operator=(content)", result)

        result = sut.full_prototype(self.code, (6, 0))
        self.assertEqual("xx::yy Abc::method(content)", result)

        result = sut.full_prototype(self.code, (7, 0))
        self.assertEqual("xx::yy * Abc::method(content)", result)

        result = sut.full_prototype(self.code, (8, 0))
        self.assertEqual("void Abc::method(content) const", result)

        result = sut.full_prototype(self.code, (9, 0))
        self.assertEqual("void Abc::method(content) const", result)

        result = sut.full_prototype(self.code, (11, 0))
        self.assertEqual("void Abc::multiline(content1, content2) const", result)

        result = sut.full_prototype(self.code, (13, 0))
        self.assertEqual("void Abc::multiline(content1, content2) const", result)

        result = sut.full_prototype(self.code, (15, 0))
        self.assertEqual("const char * methodcc(content)", result)

    #-------------------------------------------------------

    def test_full_prototype_no_prototype___returns_none(self):
        """
        Cursor is on a line without a method.
        """
        result = sut.full_prototype(self.code, (0, 0))
        self.assertIsNone(result)
        result = sut.full_prototype(self.code, (1, 0))
        self.assertIsNone(result)
        result = sut.full_prototype(self.code, (2, 0))
        self.assertIsNone(result)
        result = sut.full_prototype(self.code, (4, 0))
        self.assertIsNone(result)

        # multiline - cursor is on the second row

        # this is hard without syntax parser
        #result = sut.full_prototype(self.code, (11, 0))
        #self.assertIsNone(result)

        result = sut.full_prototype(self.code,  (14, 0))
        self.assertIsNone(result)
