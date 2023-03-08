UNIT SarahRevere;
INTERFACE
CONST
  Max = 256;
TYPE
  StrArr = ARRAY [1..Max] OF CHAR;
  Lanterns =  0 .. 2;
  
PROCEDURE Init(Str: StrArr);
PROCEDURE PrintWay(Str: StrArr; LenStr: INTEGER);

IMPLEMENTATION                
PROCEDURE Init(Str: StrArr);
VAR
  I: INTEGER;
BEGIN
  FOR I := 1 TO Max
  DO
    Str[I] := ''; 
END;
                
FUNCTION GetLantern(Str: StrArr; LenStr: INTEGER): Lanterns;
VAR
  Ch: CHAR;
  I: INTEGER;
  L: Lanterns;
  Way: TEXT;
BEGIN {GetLantern}
  ASSIGN(Way, 'Way.txt');
  RESET(Way);
  L := 0;
  FOR I := 1 TO LenStr-2 
  DO
    BEGIN
      WHILE NOT EOF(Way) AND (L = 0)   
      DO
        BEGIN
          READ(Way, Ch);
          IF Ch = Str[I]
          THEN
            BEGIN
              READ(Way, Ch);
              IF Ch = Str[I + 1]
              THEN
                BEGIN
                  READ(Way, Ch);
                  IF Ch = Str[I + 2]
                  THEN
                    IF EOLN(Way)
                      THEN
                        L := 2
                      ELSE
                        IF (I + 2) < LenStr
                        THEN
                          BEGIN                         
                            READ(Way, Ch);
                            IF Ch = Str[I + 3]
                            THEN
                              L := 1
                          END                                                   
                END
            END;
          READLN(Way)          
        END;  
    RESET(Way)          
  END;
  CLOSE(Way);
  GetLantern := L
END; {GetLantern}

PROCEDURE PrintWay(Str: StrArr; LenStr: INTEGER);
VAR
  L: Lanterns;
BEGIN
  L := GetLantern(Str, LenStr);
  IF L > 0
  THEN
    WRITE(OUTPUT, 'Sarah says, British are coming by ')
  ELSE
    WRITELN(OUTPUT, 'Sarah didn''t'' say!');    
  CASE L OF
     1 : WRITELN(OUTPUT, 'land'); 
     2 : WRITELN(OUTPUT, 'sea')
  END
END;

BEGIN {Unit SarahRevere}
END.{Unit SarahRevere}

