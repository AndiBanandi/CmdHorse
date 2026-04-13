@echo off
GOTO EOF_GOMAIN
:MAIN

::TODO:
::Keep records for each horse (wins, races)
::Horse stats: SPD, STM, MOT (speed, stamina, and motivation) - default to 100
::Horse abilities: FLY, APL, DRT, etc

CALL :RACE

EXIT /B 0



::vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
:RACE
color 07
CLS
ECHO Racers:

:SELECTHORSE1
CALL :SELECTHORSE HORSE1ARR HORSE1NAM HORSE1CHAR HORSE1FULLNAME
ECHO %HORSE1NAM% %HORSE1CHAR% %HORSE1FULLNAME%
:SELECTHORSE2
CALL :SELECTHORSE HORSE2ARR HORSE2NAM HORSE2CHAR HORSE2FULLNAME
IF %HORSE2NAM%==%HORSE1NAM% GOTO SELECTHORSE2
ECHO %HORSE2NAM% %HORSE2CHAR% %HORSE2FULLNAME%
:SELECTHORSE3
CALL :SELECTHORSE HORSE3ARR HORSE3NAM HORSE3CHAR HORSE3FULLNAME
IF %HORSE3NAM%==%HORSE1NAM% GOTO SELECTHORSE3
IF %HORSE3NAM%==%HORSE2NAM% GOTO SELECTHORSE3
ECHO %HORSE3NAM% %HORSE3CHAR% %HORSE3FULLNAME%
:SELECTHORSE4
CALL :SELECTHORSE HORSE4ARR HORSE4NAM HORSE4CHAR HORSE4FULLNAME
IF %HORSE4NAM%==%HORSE1NAM% GOTO SELECTHORSE4
IF %HORSE4NAM%==%HORSE2NAM% GOTO SELECTHORSE4
IF %HORSE4NAM%==%HORSE3NAM% GOTO SELECTHORSE4
ECHO %HORSE4NAM% %HORSE4CHAR% %HORSE4FULLNAME%


SET FIELDS=GGGGGGGGGGGGGGGDDDDDDDDCCCCCCWWWWVH
CALL :RANDOMFROMSTRING %FIELDS% FIELDCHAR

ECHO:
IF %FIELDCHAR% EQU G ECHO Field: grass
IF %FIELDCHAR% EQU D ECHO Field: dirt
IF %FIELDCHAR% EQU C ECHO Field: hard
IF %FIELDCHAR% EQU W ECHO Field: water
IF %FIELDCHAR% EQU V ECHO Field: void
IF %FIELDCHAR% EQU H ECHO Field: hell

SET PRIZES=CCCCCCAAAAABBPRFFF$$$MMMSSSiccghXmya
CALL :RANDOMFROMSTRING %PRIZES% PRIZECHAR
SET PRIZENAME=carrot
IF %PRIZECHAR% EQU C SET PRIZENAME=carrot
IF %PRIZECHAR% EQU A SET PRIZENAME=apple
IF %PRIZECHAR% EQU B SET PRIZENAME=burger
IF %PRIZECHAR% EQU P SET PRIZENAME=peanuts
IF %PRIZECHAR% EQU M SET PRIZENAME=mango
IF %PRIZECHAR% EQU R SET PRIZENAME=ryegrass
IF %PRIZECHAR% EQU F SET PRIZENAME=flowers
IF %PRIZECHAR% EQU S SET PRIZENAME=sugar cube
IF %PRIZECHAR% EQU $ SET PRIZENAME=horse money
IF %PRIZECHAR% EQU i SET PRIZENAME=ice cream
IF %PRIZECHAR% EQU m SET PRIZENAME=milkshake
IF %PRIZECHAR% EQU c SET PRIZENAME=cupcake
IF %PRIZECHAR% EQU g SET PRIZENAME=gummy worm
IF %PRIZECHAR% EQU h SET PRIZENAME=hat
IF %PRIZECHAR% EQU X SET PRIZENAME=XXX
IF %PRIZECHAR% EQU y SET PRIZENAME=celery
IF %PRIZECHAR% EQU a SET PRIZENAME=pony pony pony award
ECHO Prize: %PRIZENAME%

timeout /T 5

::Terminal colors change to reflect the field
::These are optimized for the display on the
::ancient laptop at work where I dick around with this,
::so they may not look ideal on other displays
IF %FIELDCHAR% EQU G COLOR 2A
IF %FIELDCHAR% EQU D COLOR 2E
IF %FIELDCHAR% EQU C COLOR 27
IF %FIELDCHAR% EQU W COLOR 9B
IF %FIELDCHAR% EQU V COLOR 0D
IF %FIELDCHAR% EQU H COLOR C4

::Stats are a WIP - they can be initialized but they don't do anything
::CALL :INITIALIZEHORSESTATS %HORSE1NAM% H1ABL1 H1ABL2 H1SPD H1STM H1MOT %FIELDCHAR%
::CALL :INITIALIZEHORSESTATS %HORSE2NAM% H2ABL1 H2ABL2 H2SPD H2STM H2MOT %FIELDCHAR%
::CALL :INITIALIZEHORSESTATS %HORSE3NAM% H3ABL1 H3ABL2 H3SPD H3STM H3MOT %FIELDCHAR%
::CALL :INITIALIZEHORSESTATS %HORSE4NAM% H4ABL1 H4ABL2 H4SPD H4STM H4MOT %FIELDCHAR%

set FINISH=30

SET HORSE1POS=0
SET HORSE2POS=0
SET HORSE3POS=0
SET HORSE4POS=0

:LOOP_RACE
CALL :TICKLANE HORSE1POS
CALL :TICKLANE HORSE2POS
CALL :TICKLANE HORSE3POS
CALL :TICKLANE HORSE4POS

::For unknown reasons, the parameters don't get properly passed into this function
::CALL :TICKLANE_WITHSTATS %HORSE1NAM% HORSE1POS %H1ABL1% %H1ABL2% H1SPD H1STM H1MOT
::CALL :TICKLANE_WITHSTATS %HORSE1NAM% HORSE2POS %H2ABL1% %H2ABL2% H2SPD H2STM H2MOT
::CALL :TICKLANE_WITHSTATS %HORSE1NAM% HORSE3POS %H3ABL1% %H3ABL2% H3SPD H3STM H3MOT
::CALL :TICKLANE_WITHSTATS %HORSE1NAM% HORSE4POS %H4ABL1% %H4ABL2% H4SPD H4STM H4MOT
::Usage: CALL :TICKLANE_WITHSTATS HORSENAM *POS ABL1 ABL2 *SPD *STM *MOT


::We render each lane to a string, then print them all at once to minimize flickering
CALL :RENDERLANE %HORSE1POS% %HORSE1CHAR% %HORSE1NAM% %FINISH% LANE1
CALL :RENDERLANE %HORSE2POS% %HORSE2CHAR% %HORSE2NAM% %FINISH% LANE2
CALL :RENDERLANE %HORSE3POS% %HORSE3CHAR% %HORSE3NAM% %FINISH% LANE3
CALL :RENDERLANE %HORSE4POS% %HORSE4CHAR% %HORSE4NAM% %FINISH% LANE4

cls
echo %LANE1%
echo %LANE2%
echo %LANE3%
echo %LANE4%

IF %HORSE1POS% LEQ %FINISH% IF %HORSE2POS% LEQ %FINISH% IF %HORSE3POS% LEQ %FINISH% IF %HORSE4POS% LEQ %FINISH% GOTO LOOP_RACE

ECHO:
IF %HORSE1POS% GTR %FINISH% echo Winner: %HORSE1FULLNAME%
IF %HORSE2POS% GTR %FINISH% echo Winner: %HORSE2FULLNAME%
IF %HORSE3POS% GTR %FINISH% echo Winner: %HORSE3FULLNAME%
IF %HORSE4POS% GTR %FINISH% echo Winner: %HORSE4FULLNAME%
ECHO Got: %PRIZENAME%

ECHO:
SET /P INPUT=Race again? (y/n) 
IF %INPUT%==y CLS & GOTO RACE

EXIT /B 0
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



::vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
:SELECTHORSE
::Usage: CALL :SELECTHORSE *HORSEARRAY *HORSESHORTNAME *HORSECHAR *HORSEFULLNAME
SETLOCAL
SET HORSEPOOL=AMR,SUN,DRM,STP,PEP,NUG,LAK,TRX,URA,GOL,OOB,SUP,COM,FUZ,OLV,APH,IVW,PPB,MWT,CHK,MBL,JAD,DAZ,CXA,MST,CHY,PnW,WOU,DIF
CALL :STRLEN HORSEPOOL LEN
SET /A POOLSIZE=(LEN+1)/4
SET /A X=%RANDOM%%%%POOLSIZE%*4
CALL SET "HORSENAM=%%HORSEPOOL:~%X%,3%%"

::Short name shown left of their lane; Character to use for the horse; Full name for win screen
IF %HORSENAM%==AMR SET HORSEARR=AMR A Amrita
IF %HORSENAM%==SUN SET HORSEARR=SUN S Sunny Field
IF %HORSENAM%==DRM SET HORSEARR=DRM d Orange Dream
IF %HORSENAM%==STP SET HORSEARR=STP w Striped Sweater
IF %HORSENAM%==PEP SET HORSEARR=PEP P Pepperoney Pizza
IF %HORSENAM%==NUG SET HORSEARR=NUG N Nugget
IF %HORSENAM%==LAK SET HORSEARR=LAK K Last Argument of Kings
IF %HORSENAM%==TRX SET HORSEARR=TRX T Trixie
IF %HORSENAM%==URA SET HORSEARR=URA U Haru Urara
IF %HORSENAM%==GOL SET HORSEARR=GOL G Gold Ship
IF %HORSENAM%==OOB SET HORSEARR=OBL 0 Out Of Bounds
IF %HORSENAM%==SUP SET HORSEARR=GOL s Superstitional Realism
IF %HORSENAM%==COM SET HORSEARR=COM c Comely Material Morning
IF %HORSENAM%==FUZ SET HORSEARR=FUZ F Fuzao
IF %HORSENAM%==OLV SET HORSEARR=OLV O Olive Branch
IF %HORSENAM%==RIV SET HORSEARR=RIV R River Smiles
IF %HORSENAM%==APH SET HORSEARR=APH f Behold A Pale Horse
IF %HORSENAM%==IVW SET HORSEARR=IVW i Ivory Wind
IF %HORSENAM%==PPB SET HORSEARR=PPB p Painted Pebble
IF %HORSENAM%==MWT SET HORSEARR=MWT m Merriweather
IF %HORSENAM%==CHK SET HORSEARR=CHK h Checkers
IF %HORSENAM%==MBL SET HORSEARR=MBL M Moonbelle
IF %HORSENAM%==JAD SET HORSEARR=JAD J Jadehoof
IF %HORSENAM%==DAZ SET HORSEARR=DAZ Z Dazzleflash
IF %HORSENAM%==CXA SET HORSEARR=CXA X Coxa
IF %HORSENAM%==MST SET HORSEARR=MST $ Morning Star
IF %HORSENAM%==HOP SET HORSEARR=HOP h Hopscotch
IF %HORSENAM%==CHY SET HORSEARR=CHY y Cherry Berry
IF %HORSENAM%==PnW SET HORSEARR=PnW B Pip and Whistle
IF %HORSENAM%==WOU SET HORSEARR=WOU W The Weight of Understanding that Burdens Life
IF %HORSENAM%==DIF SET HORSEARR=DIF D Desire In Flesh
IF %HORSENAM%==??? SET HORSEARR=??? ? ???

CALL SET "HORSECHAR=%%HORSEARR:~4,1%%"
CALL :STRLEN HORSEARR LEN
SET /A LEN-=6
CALL SET "HORSEFULLNAME=%%HORSEARR:~6,%LEN%%%"

(ENDLOCAL & SET %~1=%HORSEARR%&SET %~2=%HORSENAM%&SET %~3=%HORSECHAR%&SET %~4=%HORSEFULLNAME%&EXIT /B 0)
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
:INITIALIZEHORSESTATS
::Usage: CALL :INITIALIZEHORSESTATS HORSENAM *ABL1 *ABL2 *SPD *STM *MOT FIELD
::Horses have 100 in all stats by default, but may be assigned individual stats here
::Each horse can have up to two abilities
SETLOCAL
SET HORSENAM=%~1
SET SPD=100
SET STM=100
SET MOT=100
SET ABL1=NUL
SET ABL2=NUL
SET FIELD=%~6

IF %HORSENAM%==URA SET MOT=150 & SET SPD=80 & SET ABL1=DRT
IF %HORSENAM%==AMR SET SPD=130 & SET STM=80 & SET MOT=90 & SET ABL1=FLY
IF %HORSENAM%==SUN SET SPD=90 & SET STM=120 & SET MOT=120 & SET ABL1=GRS&SET ABL2=DRT
IF %HORSENAM%==COM SET ABL1=APL&SET ABL2=TPT
IF %HORSENAM%==OOB SET SPD=80 & SET MOT=120 & SET ABL1=TAZ&SET ABL2=SUP
IF %HORSENAM%==SUP SET SPD=85 & SET MOT=110 & SET ABL2=OOB

SET ABILDRT=1 & IF NOT "%ABL1%"=="DRT" IF NOT "%ABL2%"=="DRT" SET ABILDRT=0
SET ABILGRS=1 & IF NOT "%ABL1%"=="GRS" IF NOT "%ABL2%"=="GRS" SET ABILGRS=0
SET ABILFLY=1 & IF NOT "%ABL1%"=="FLY" IF NOT "%ABL2%"=="FLY" SET ABILFLY=0

IF %ABILDRT%==1 IF %FIELD%==D SET /A SPD*=1.25
IF %ABILGRS%==1 IF %FIELD%==G SET /A SPD*=1.25
IF %FIELD%==W IF NOT "%ABL1%"=="FLY" IF NOT "%ABL2%"=="FLY" IF NOT "ABL1"=="%SWM%" IF NOT "%ABL2%"=="SWM" SET /A SPD*=0.75
IF %FIELD%==V IF NOT "%ABL1%"=="FLY" IF NOT "%ABL2%"=="FLY" SET /A STM*=0.75
IF %FIELD%==H IF NOT "%ABL1%"=="FLY" IF NOT "%ABL2%"=="FLY" SET /A MOT*=0.75

(ENDLOCAL & SET %~2=%ABL1%&set %~3=%ABL2%& SET %~4=%SPD%& SET %~5=%STM%& SET %~6=%MOT%)
EXIT /B 0
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


::vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
:TICKLANE
::Usage: CALL :TICKLANE *POS
::This is where the running happens. This version is simplistic but reliable.
IF %RANDOM% LEQ 12000 set /A %~1+=1
IF %RANDOM% LEQ  6000 set /A %~1+=1
EXIT /B 0
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
:TICKLANE_WITHSTATS
::Usage: CALL :TICKLANE *HORSENAM *POS ABL1 ABL2 *SPD *STM *MOT
::Terrain modifiers are made during initialization, so aren't needed here
::Why are the arguments not getting passed in properly?
SETLOCAL
SET HORSENAM=%~1
SET POS=%~2
SET SPD=%~5
SET STM=%~6
SET MOT=%~7
echo %HORSENAM% ARG %~1 %~2 %~3 %~4 %~5 %~6 %~7

SET /A CHANCE1=1200 * %SPD%
SET /A CHANCE2=600 * %SPD%

IF %RANDOM% LEQ %CHANCE1% SET /A POS += 1
IF %RANDOM% LEQ %CHANCE2% SET /A POS += 1
echo %HORSENAM% NEWPOS %POS%

SET /A STM-=1
IF %STM% LEQ 0 SET /A SPD-=1

SET /A MOTCHANCESTM=12000 * %MOT%
SET /A MOTCHANCESPD=6000 * %MOT%
IF %RANDOM% LEQ %MOTCHANCESTM% SET /A STM+=3
IF %RANDOM% LEQ %MOTCHANCESPD% SET /A SPD+=2

(ENDLOCAL & SET %~2=%POS% & SET %~5=%SPD% & SET %~6=%STM% & SET %~7=%MOT%)
::SET %~2=%POS% & SET %~5=%SPD% & SET %~6=%STM% & SET %~7=%MOT%
EXIT /B 0
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
:RENDERLANE
::Usage: CALL :RENDERLANE POS HORSECHAR HORSENAM FINISH *LANESTR
SETLOCAL
SET X=0
SET CHAR=%~2
SET FINISH=%~4
SET STR=%~3 :
SET POS=%~1
:LOOP_RENDER
IF %X% LSS %POS% SET STR=%STR%.
IF %X% EQU %POS% SET STR=%STR%%CHAR%
IF %X% GTR %POS% SET STR=%STR%.
set /A X+=1
IF %X% LEQ %FINISH% GOTO LOOP_RENDER

set STR=%STR%#
IF %POS% GTR %FINISH% set STR=%STR%%CHAR%

(ENDLOCAL & SET %~5=%STR%)
EXIT /B 0
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^




::Helper functions

::vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
:STRLEN
::Usage: CALL:STRLEN *ARR *OUTPUTVAR
setlocal enabledelayedexpansion
set LEN=0
:LOOP_STRLEN
IF NOT "!%1:~%LEN%!"=="" set /A LEN+=1 & GOTO LOOP_STRLEN
(endlocal & set %2=%LEN%)
EXIT /B 0
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


::vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
:RANDOMFROMSTRING
::Usage: CALL :RANDOMFROMSTRING STR *OUTCHAR
SETLOCAL
SET CHARS=%~1
CALL:STRLEN CHARS LEN
SET /A X=%RANDOM%%%%LEN%
CALL SET "CHAR=%%CHARS:~%X%,1%%"
(ENDLOCAL & SET %~2=%CHAR%)
EXIT /B 0
::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


::#######################################################################
::By visiting the EOF, we make all the functions in between load. I think.
:EOF_GOMAIN
GOTO MAIN
::#######################################################################