UNIT ConstUnit;
INTERFACE
CONST
  MaxWordLength = 50;
  MaxUniqueWords = 10000;
  SH: STRING[60] = 'ABCDEFGHIJKLMNOPQRSTUVWXYZÀÁÂÃÄÅ¨ÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞß¸';
  SL: STRING[60] = 'abcdefghijklmnopqrstuvwxyzàáâãäååæçèéêëìíîïğñòóôõö÷øùúûüışÿå';
  SetOfChars = ['A' .. 'Z', 'a' .. 'z', 'À' .. 'ß', '¨', 'à' .. 'ÿ', '¸', '-'];  
TYPE
  LimitedString = STRING[MaxWordLength];
  NodePtr = ^Node;
  Node = RECORD
           Word: LimitedString;
           Count: INTEGER;
           Left: NodePtr;
           Right: NodePtr
         END;
  FileElm = RECORD
              Word: LimitedString;
              Count: INTEGER
            END;       
IMPLEMENTATION
BEGIN {ConstUnit}
END. {ConstUnit}

