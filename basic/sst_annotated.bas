REM Variable Inventory
REM
REM B3 number of starbases
REM B9 total number of starbases???
REM C(x,y) ???
REM D0 damage...???
REM D(x) ???
REM E0 starting energy???
REM E9 ???
REM E energy???
REM FND(D) distance... to Klingons...???
REM FNR(R) generate an integer random number between 1 and 8, inclusive
REM G(x,y) galactic quadrant map, KBS values (Klingons Bases Stars)
REM K3 the number of Klingons
REM K7 ??? Gets initted to K9 after galaxy setup
REM K9 total number of Klingons in galaxy???
REM K(x,y) ??? klingon???
REM N(x) ???
REM P0 ???
REM P ???
REM Q1 ??? initialized to rand [1,8], coordinates?
REM Q2 ??? initialized to rand [1,8]
REM S3 number of stars
REM S9 ???
REM S ???
REM T0 Starting stardate
REM T9 How many days to complete mission
REM T ???
REM X$ ??? Used for plural "S"?
REM X0$ ??? Used for plural "IS"/"ARE"?
REM Z$ ????
REM Z(x,y) ??? Gets initted to 0

REM BASIC help
REM
REM CLEAR: "Purpose: To set all numeric variables to zero, all string
REM variables to null, and to close all open files; and, optionally, to
REM set the end of memory and the amount of stack space"
REM
REM "Remarks: <expression1> is a memory location which, if specified,
REM sets the highest location available for use by BASIC-80."
REM
REM https://ia800708.us.archive.org/8/items/BASIC-80_MBASIC_Reference_Manual/BASIC-80_MBASIC_Reference_Manual_text.pdf
REM
REM "RND Action: Returns a random number between 0 and 1. The same
REM sequence of random numbers is generated each time the program is RUN
REM unless the random number generator is reseeded (see RANDOMIZE,
REM Section 2.53). However, X<0 always restarts the same sequence for
REM any given X.
REM
REM "X>0 or X omitted generates the next random number in the sequence.
REM X=0 repeats the last number generated."
REM
REM https://ia800708.us.archive.org/8/items/BASIC-80_MBASIC_Reference_Manual/BASIC-80_MBASIC_Reference_Manual_text.pdf
REM

10 REM SUPER STARTREK - MAY 16,1978 - REQUIRES 24K MEMORY
30 REM
40 REM ****        **** STAR TREK ****        ****
50 REM **** SIMULATION OF A MISSION OF THE STARSHIP ENTERPRISE,
60 REM **** AS SEEN ON THE STAR TREK TV SHOW.

REM "ORIGIONAL" [sic]

70 REM **** ORIGIONAL PROGRAM BY MIKE MAYFIELD, MODIFIED VERSION
80 REM **** PUBLISHED IN DEC'S "101 BASIC GAMES", BY DAVE AHL.
90 REM **** MODIFICATIONS TO THE LATTER (PLUS DEBUGGING) BY BOB
100 REM *** LEEDOM - APRIL & DECEMBER 1974,
110 REM *** WITH A LITTLE HELP FROM HIS FRIENDS . . .
120 REM *** COMMENDS, EPITHETS, AND SUGGESTIONS SOLICITED --
130 REM *** SEND TO:  R. C. LEEDOM
140 REM ***           WESTINGHOUSE DEFENSE & ELECTRONICS SYSTEMS CNTR.
150 REM ***           BOX 746, M.S. 338
160 REM ***           BALTIMORE, MD  21203
170 REM ***
180 REM *** CONVERTED TO MICROSOFT 8 K BASIC 3/16/78 BY JOHN BORDERS
190 REM *** LINE NUMBERS FROM VERSION STREK7 OF 1/12/75 PRESERVED AS
200 REM *** MUCH AS POSSIBLE WHILE USING MULTIPLE STATEMENTS PER LINE
205 REM *** SOME LINES ARE LONGER THAN 72 CHARACTERS; THIS WAS DONE
210 REM *** BY USING "?" INSTEAD OF "PRINT" WHEN ENTERING LINES
215 REM ***
220 PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT:PRINT
221 PRINT"                                    ,------*------,"
222 PRINT"                    ,-------------   '---  ------'"
223 PRINT"                     '-------- --'      / /"
224 PRINT"                         ,---' '-------/ /--,"
225 PRINT"                          '----------------'":PRINT
225 PRINT"                    THE USS ENTERPRISE --- NCC-1701"
227 PRINT:PRINT:PRINT:PRINT:PRINT

260 CLEAR 600
270 Z$="                         "
330 DIM G(8,8),C(9,2),K(3,3),N(3),Z(8,8),D(8)

REM Choose starting stardate (T) as a random integer between 120-140
REM (inclusive??).
REM Initialize starting stardate (T0) starting startdate in T.
REM Initialize days to complete mission (T9) to an integer between 25
REM and 35 (inclusive??).

370 T=INT(RND(1)*20+20)*100:T0=T:T9=25+INT(RND(1)*10):D0=0:E=3000:E0=E
440 P=10:P0=P:S9=200:S=0:E9=0:K9=0:X$="":X0$=" IS "
470 DEF FND(D)=SQR((K(I,1)-S1)^2+(K(I,2)-S2)^2)
475 DEF FNR(R)=INT(RND(R)*7.98+1.01)

REM "ENTERPRIZE'S" [sic]

480 REM INITIALIZE ENTERPRIZE'S POSITION
490 Q1=FNR(1):Q2=FNR(1):S1=FNR(1):S2=FNR(1)

REM Initialize C array
REM ???

530 FORI=1TO9:C(I,1)=0:C(I,2)=0:NEXTI
540 C(3,1)=-1:C(2,1)=-1:C(4,1)=-1:C(4,2)=-1:C(5,2)=-1:C(6,2)=-1
600 C(1,2)=1:C(2,2)=1:C(6,1)=1:C(7,1)=1:C(8,1)=1:C(8,2)=1:C(9,2)=1

REM Initialize D array
REM ???

670 FORI=0TO8:D(I)=0:NEXTI

710 A1$="NAVSRSLRSPHATORSHEDAMCOMXXX"

REM "EXHISTS" [sic]

810 REM SETUP WHAT EXHISTS IN GALAXY . . .
815 REM K3= # KLINGONS  B3= # STARBASES  S3= # STARS

REM Quadrant Initialization
REM
REM 2% chance of 3 Klingons
REM 3% chance of 2 Klingons
REM 15% chance of 1 Klingon
REM
REM 4% chance of 1 starbase
REM
REM Between 1.01 and 8.99 stars? Is this an integer array?

820 FORI=1TO8:FORJ=1TO8:K3=0:Z(I,J)=0:R1=RND(1)
850 IFR1>.98THENK3=3:K9=K9+3:GOTO980
860 IFR1>.95THENK3=2:K9=K9+2:GOTO980
870 IFR1>.80THENK3=1:K9=K9+1
980 B3=0:IFRND(1)>0.96THENB3=1:B9=B9+1

REM If total klingons > T9, then T9 = total klingons + 1

1040 G(I,J)=K3*100+B3*10+FNR(1):NEXTJ:NEXTI:IFK9>T9THENT9=K9+1
1100 IFB9<>0THEN1200

REM This happens if the total number of bases is 0.
REM Q1 and Q2 are inited to random [1,8], quadrant coords.

REM If the quadrant has less than 2 klingons, add a klingon to the
REM quadrant. Increment the total number of klingons.

1150 IFG(Q1,Q2)<200THENG(Q1,Q2)=G(Q1,Q2)+100:K9=K9+1

REM Set total starbases to 1. Add a starbase to this quadrant. Set Q1
REM and Q2 to a new random quadrant.

1160 B9=1:G(Q1,Q2)=G(Q1,Q2)+10:Q1=FNR(1):Q2=FNR(1)

REM Set K7??? to number of klingons. If the number of bases isn't 1, set
REM up the pluralization variables X$ and X0$.

1200 K7=K9:IFB9<>1THENX$="S":X0$=" ARE "
1230 PRINT"YOUR ORDERS ARE AS FOLLOWS:"
1240 PRINT"     DESTROY THE";K9;"KLINGON WARSHIPS WHICH HAVE INVADED"
1250 PRINT"   THE GALAXY BEFORE THEY CAN ATTACK FEDERATION HEADQUARTERS"
1260 PRINT"   ON STARDATE";T0+T9;"  THIS GIVES YOU";T9;"DAYS.  THERE";X0$







