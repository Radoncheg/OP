UNIT WordTree;
INTERFACE
USES
  WordUnit, ConstUnit;
   
PROCEDURE AddToTree(VAR Node: NodePtr; Value: STRING);
PROCEDURE PrintTree(VAR OutFile: TEXT; VAR Node: NodePtr);
PROCEDURE DumpTree(VAR Route: NodePtr);
PROCEDURE DisposeTree(VAR Node: NodePtr);
FUNCTION IsTreeOverflow(): BOOLEAN;
PROCEDURE ClearCounter();
PROCEDURE UploadData(VAR OutFile: TEXT);

IMPLEMENTATION
VAR
  TempF1, TempF2: TEXT;
  CountUniqueWords: 0 .. MaxUniqueWords + 1;
  FirstCleared: BOOLEAN;

PROCEDURE Init();
BEGIN {Init}
  ASSIGN(TempF1, 'tempF1.txt');
  ASSIGN(TempF2, 'tempF2.txt');
  REWRITE(TempF1);
  REWRITE(TempF2);
  FirstCleared := TRUE;
  ClearCounter()
END;  {Init}

PROCEDURE AddToTree(VAR Node: NodePtr; Value: STRING);
BEGIN {AddToTree}
  IF (Node = NIL) AND (CountUniqueWords <= MaxUniqueWords)
  THEN
    BEGIN 
      NEW(Node);
      Node^.Word := Value;
      Node^.Count := 1;
      Node^.Left := NIL;
      Node^.Right := NIL;
      CountUniqueWords := CountUniqueWords + 1
    END
  ELSE
    IF CompareWords(Node^.Word, Value)
    THEN
      AddToTree(Node^.Left, Value)
    ELSE
      IF Node^.Word = Value
      THEN
        Node^.Count := Node^.Count + 1
      ELSE
        AddToTree(Node^.Right, Value)
END;  {AddToTree}

PROCEDURE PrintTree(VAR OutFile: TEXT; VAR Node: NodePtr);
BEGIN {PrintTree}
  IF Node <> NIL
  THEN
    BEGIN
      PrintTree(OutFile, Node^.Left);
      WRITELN(OutFile, Node^.Word, ' ', Node^.Count);
      PrintTree(OutFile, Node^.Right)
    END    
END;  {PrintTree}

PROCEDURE DisposeTree(VAR Node: NodePtr);
BEGIN {DisposeTree}
  IF Node <> NIL
  THEN
    BEGIN
      DisposeTree(Node^.Left);
      DisposeTree(Node^.Right);
      DISPOSE(Node);
      Node := NIL
    END
END;  {DisposeTree}

PROCEDURE ClearCounter();
BEGIN {ClearCounter}
  CountUniqueWords := 0
END;  {ClearCounter}

FUNCTION IsTreeOverflow(): BOOLEAN;
BEGIN {IsTreeOverflow}
  IsTreeOverflow := CountUniqueWords > MaxUniqueWords
END;  {IsTreeOverflow}

PROCEDURE ReadElm(VAR InFile: TEXT; VAR Elm: FileElm);
BEGIN {ReadElm}
  Elm.Word := ReadWord(InFile);
  IF NOT EOLN(InFile)
  THEN
    BEGIN
      READ(InFile, Elm.Count);
      READLN(InFile)
    END
END;  {ReadElm}

PROCEDURE MergeTree(VAR InFile, OutFile: TEXT; VAR Node: NodePtr; VAR Elm: FileElm);
BEGIN {MergeTree}
  IF Node <> NIL
  THEN
    BEGIN
      MergeTree(InFile, OutFile, Node^.Left, Elm);
      WHILE (Elm.Word <> '') AND CompareWords(Node^.Word, Elm.Word)
      DO
        BEGIN
          WRITELN(OutFile, Elm.Word, ' ', Elm.Count);
          ReadElm(InFile, Elm)
        END;
      IF Node^.Word = Elm.Word
      THEN
        BEGIN
          Node^.Count := Node^.Count + Elm.Count;
          ReadElm(InFile, Elm)
        END;
      WRITELN(OutFile, Node^.Word, ' ', Node^.Count);        
      MergeTree(InFile, OutFile, Node^.Right, Elm)
    END   
END;  {MergeTree}

PROCEDURE Merge(VAR InFile, OutFile: TEXT; VAR Route: NodePtr);
VAR
  Elm: FileElm;
BEGIN {Merge}
  RESET(InFile);
  REWRITE(OutFile);
  ReadElm(InFile, Elm);
  MergeTree(InFile, OutFile, Route, Elm);
  IF Elm.Word <> ''
  THEN
    BEGIN
      WRITELN(OutFile, Elm.Word, ' ', Elm.Count);
      WHILE NOT EOF(InFile)
      DO
        BEGIN
          ReadElm(InFile, Elm);
          WRITELN(OutFile, Elm.Word, ' ', Elm.Count)
        END
    END
END;  {Merge}

PROCEDURE DumpTree(VAR Route: NodePtr);
BEGIN {DumpTree}
  IF FirstCleared
  THEN
    Merge(TempF2, TempF1, Route)
  ELSE
    Merge(TempF1, TempF2, Route);
  DisposeTree(Route);
  ClearCounter();
  FirstCleared := NOT FirstCleared
END;  {DumpTree}

PROCEDURE PrintData(VAR InFile, OutFile: TEXT);
VAR
  Elm: FileElm;
BEGIN {PrintData}
  RESET(InFile);
  WHILE NOT EOF(InFile)
  DO
    BEGIN
      ReadElm(InFile, Elm);
      WRITELN(OutFile, Elm.Word, ' ', Elm.Count)
    END
END;  {PrintData}

PROCEDURE UploadData(VAR OutFile: TEXT);
BEGIN {UploadData}
  IF FirstCleared
  THEN
    PrintData(TempF2, OutFile)
  ELSE
    PrintData(TempF1, OutFile);
  ERASE(TempF1);
  ERASE(TempF2)
END;  {UploadData}

BEGIN {Tree}
  Init()
END.  {Tree}
