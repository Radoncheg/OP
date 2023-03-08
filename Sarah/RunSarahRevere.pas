PROGRAM RunSarahRevere(INPUT, OUTPUT);
USES
  SarahRevere;
CONST
  Max = 256;
VAR
  Str: ARRAY [1 .. Max] OF CHAR;
  Ch: CHAR;
  LenStr: INTEGER;
BEGIN{SarahRevere}
  LenStr := 0;
  Init(Str);
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      LenStr := LenStr + 1;
      Str[LenStr] := Ch
    END;
  IF LenStr >= 3
  THEN
    PrintWay(Str, LenStr)
  ELSE
    WRITELN('Sarah didn''t'' say!')                        
END.{SarahRevere}




