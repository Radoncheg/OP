PROGRAM CountWords(INPUT, OUTPUT);
USES
  WordTree, WordUnit, ConstUnit;

PROCEDURE CollectData(VAR InFile, OutFile: TEXT);
VAR
  Route: NodePtr;
  CurWord: STRING;
BEGIN {CollectData}
  Route := NIL;
  WHILE NOT EOF(InFile)
  DO
    IF IsTreeOverflow()
    THEN
      DumpTree(Route)
    ELSE
      IF NOT EOLN(InFile)
      THEN 
        BEGIN
          CurWord := ReadWord(InFile);
          IF CurWord <> ''
          THEN
            AddToTree(Route, CurWord)
        END
      ELSE
        READLN(InFile);
  DumpTree(Route);
  UploadData(OutFile)
END;  {CollectData}

BEGIN {CountWords}
  CollectData(INPUT, OUTPUT)
END.  {CountWords}
