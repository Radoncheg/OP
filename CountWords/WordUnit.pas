UNIT WordUnit; 
INTERFACE
USES
  ConstUnit;
  
FUNCTION ReadWord(VAR InputFile: TEXT): LimitedString;
FUNCTION CompareWords(FirstWord, SecondWord: STRING): BOOLEAN;

IMPLEMENTATION
FUNCTION ToLowerCase(Ch: CHAR): CHAR;
VAR
  ChL: CHAR;
  I: INTEGER;
BEGIN {ToLowerCase}
  I := Pos(Ch, SH);
  IF I <> 0
  THEN
     ToLowerCase := SL[I]
  ELSE
     ToLowerCase := Ch
END; {ToLowerCase}

FUNCTION ReadWord(VAR InputFile: TEXT): LimitedString;
VAR
  Ch: CHAR;
  Found: BOOLEAN;
  OutputWord: LimitedString;
BEGIN {ReadWord}
  Found := FALSE;
  OutputWord := '';
  WHILE NOT EOLN(InputFile) AND NOT Found
  DO
    BEGIN
      READ(InputFile, Ch);
      IF Ch IN SetOfChars
      THEN
        BEGIN
          Ch := ToLowerCase(Ch);
          OutputWord := OutputWord + Ch;
          IF EOLN(InputFile) AND (OutputWord[1] = '-')
          THEN
            OutputWord := '';    
          IF (Ch = '-') AND (EOLN(InputFile))
          THEN
            READLN(InputFile)
        END    
      ELSE
        BEGIN          
          IF OutputWord[LENGTH(OutputWord)] = '-'
          THEN
            DELETE(OutputWord, LENGTH(OutputWord), 1);
          IF OutputWord[1] = '-'
          THEN
            OutputWord := '';
          Found := TRUE;  
        END  
    END;
  ReadWord := OutputWord    
END; {ReadWord}

FUNCTION CompareWords(FirstWord, SecondWord: STRING): BOOLEAN;
BEGIN
  CompareWords := FirstWord > SecondWord
END;

BEGIN {Word}
END.  {Word}
