REM Variable Inventory
REM
REM A$ temp string variable
REM B3 number of starbases
REM B4 Starbase row???
REM B5 Starbase column???
REM B9 total number of starbases
REM C(9,2) row/column offsets for navigation directions
REM C$ condition string
REM      *RED*  = There is at least one Klingon in this quadrant
REM      YELLOW = Energy less than 10% of starting energy
REM      GREEN  = Otherwise
REM      DOCKED = If within 1 space of a starbase (including diagonals).
REM               This overrides all other conditions.
REM C1 User input: ship course
REM D(8) Damaged Systems; negative means rough time to repair, >=0 means
REM                       working.
REM      1 = Warp engines
REM      2 = Short Range Sensors
REM      4 = Phasers
REM      7 = Shields???
REM      8 = Computer
REM D0 1 if docked, 0 if not
REM D1 Flag to one-off damage report header
REM D4 ???
REM D6 ???
REM E energy
REM E0 starting energy
REM FND(D) distance to Klingon #D in sector
REM FNR(R) generate an integer random number between 1 and 8, inclusive.
REM        Argument is forwarded to RND().
REM G(8,8) galactic quadrant map, KBS values (Klingons Bases Stars)
REM G2$ General string return value from subroutine
REM G5 Flag for getting quadrant name. 1 means don't add Roman numerals.
REM H Energy hit from a Klingon attack
REM K(3,3) Klingon position and presense information
REM        There are up to three Klingons per quadrant
REM        K(x,1) = Klingon x sector row
REM        K(x,2) = Klingon x sector column
REM        K(x,3) = Klingon energy level??? Indicates Klingon not
REM                 present in sector if positive.
REM K3 the number of Klingons in this quadrant
REM K7 ??? Gets initted to K9 after galaxy setup
REM K9 total number of Klingons remaining in galaxy
REM N Energy needed for warp maneuver
REM N(3) Temporary holding in LRS for galactic scan data
REM O1$ Row of dashed lines above and below SRS, LRS
REM P photon torpedo count
REM P0 starting photon torpedo count???
REM Q$ 2D string representing the sector, 8x3 spaces wide per row, 8x8x3 spaces
REM Q1 Player current quadrant row [1,8]
REM Q2 Player current quadrant column [1,8]
REM R1 General random number holder
REM S Shield energy level
REM S1 Player current sector row [1,8]
REM S2 Player current sector column [1,8]
REM S3 number of stars
REM S8 Temporary variable in subroutine 8670 and 8830
REM S9 ??? set to 200?
REM T Current startdate
REM T0 Starting stardate
REM T8 Time we're going to advance the stardate
REM T9 How many days to complete mission
REM W1 User input: warp factor
REM X$ Used for plural "S"
REM X0$ Used for plural "IS"/"ARE"
REM Z(8,8) Discovered map. If 0, undiscovered. Else a copy of G(r,c).
REM Z$ 25 spaces, used to build Q$
REM Z1 Sector position row temp variable in subroutine 8670
REM Z2 Sector position column temp variable in subroutine 8670
REM Z4 row coordinate in the galactic map
REM Z5 column coordinate in the galactic map

REM Stardate Advance and Repair Time Rules:
REM 
REM    The most the stardate will advance per maneuver is 1.
REM
REM    If you maneuver at under Warp 1, the stardate will advance by the
REM    warp number truncated to a single decimal place. (e.g. 0.999 ->
REM    0.9).
REM
REM    The most repair that can be done to a critical system during a
REM    maneuver is 1.
REM
REM    If you maneuver at under Warp 1, the damage is repaired by a
REM    level equal to your warp number. (Not truncated.)

REM     1   2   3   4   5   6   7   8
REM
REM 1        ANTARES        SIRIUS
REM     I   II  III IV  I   II  III IV
REM
REM 2         RIGEL         DENEB
REM     I   II  III IV  I   II  III IV
REM
REM 3        PROCYON       CAPELLA
REM     I   II  III IV  I   II  III IV
REM
REM 4         VEGA        BETELGEUSE
REM     I   II  III IV  I   II  III IV
REM
REM 5        CANOPUS       ALDEBARAN
REM     I   II  III IV  I   II  III IV
REM
REM 6        ALTAIR         REGULUS
REM     I   II  III IV  I   II  III IV
REM
REM 7      SAGITTARIUS     ARCTURUS
REM     I   II  III IV  I   II  III IV
REM
REM 8        POLLUX         SPICA
REM     I   II  III IV  I   II  III IV

REM Display Symbols:
REM
REM   <*>   Enterprise
REM   +K+   Klingon
REM   >!<   Starbase
REM    *    Star

REM BASIC help
REM https://ia800708.us.archive.org/8/items/BASIC-80_MBASIC_Reference_Manual/BASIC-80_MBASIC_Reference_Manual_text.pdf

REM `CLEAR`: To set all numeric variables to zero, all string variables
REM to null, and to close all open files; and, optionally, to set the
REM end of memory and the amount of stack space.
REM
REM Remarks: <expression1> is a memory location which, if specified,
REM sets the highest location available for use by BASIC-80.

REM `RND`: Returns a random number between 0 and 1. The same sequence of
REM random numbers is generated each time the program is RUN unless the
REM random number generator is reseeded (see RANDOMIZE, Section 2.53).
REM However, X<0 always restarts the same sequence for any given X.
REM
REM X>0 or X omitted generates the next random number in the sequence.
REM X=0 repeats the last number generated.

REM `LEFT$(X$,I)`: Returns a string comprised of the leftmost I
REM characters of X$. I must be in the range 0 to 255. If I is greater
REM than LEN(X$), the entire string (X$) will be returned. If I=0, the
REM null string (length zero) is returned.

REM `STOP`: To terminate program execution and return to the command
REM level.
REM
REM STOP statements may be used anywhere in a program to terminate
REM execution. When a STOP is encountered, the following message is
REM printed:
REM
REM     Break in line nnnnn
REM
REM Unlike the END statement, the STOP statement does not close files.
REM
REM BASIC-80 always returns to the command level after a STOP is
REM executed. Execution is resumed by issuing a CONT command.

REM `INP(I)`: Returns the byte read from port I. I must be in the range
REM 0 to 255.

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
120 REM *** COMMENTS, EPITHETS, AND SUGGESTIONS SOLICITED --
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
226 PRINT"                    THE USS ENTERPRISE --- NCC-1701"
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

REM The following B9 is hard to read in the source. It could be E9, but
REM is very likely not.
REM
REM P=10 Photon torpedoes to 10
REM S=0 Shields to zero

440 P=10:P0=P:S9=200:S=0:B9=0:K9=0:X$="":X0$=" IS "
470 DEF FND(D)=SQR((K(I,1)-S1)^2+(K(I,2)-S2)^2)
475 DEF FNR(R)=INT(RND(R)*7.98+1.01)

REM Player quadrant random row, column 1..8
REM Player sector random row, column 1..8
REM "ENTERPRIZE'S" [sic]

480 REM INITIALIZE ENTERPRIZE'S POSITION
490 Q1=FNR(1):Q2=FNR(1):S1=FNR(1):S2=FNR(1)

REM Initialize C(9,2) array
REM
REM Row-column offsets for navigation directions.
REM
REM The left index is the user-inputted course. Right index is the row
REM (0) or column (1) offset for that course.
REM
REM     1   2
REM
REM 1   0   1
REM 2  -1   1
REM 3  -1   0
REM 4  -1  -1
REM 5   0  -1
REM 6   1  -1
REM 7   1   0
REM 8   1   1
REM 9   0   1
REM
REM     (-1,-1) (-1,0)  (-1,1)
REM
REM           4    3    2
REM            \   |   /
REM (0,-1) 5 ------+------ 1,9 (0,1)
REM            /   |   \
REM           6    7    8
REM
REM     (1,-1)   (1,0)   (1,1)
REM

530 FORI=1TO9:C(I,1)=0:C(I,2)=0:NEXTI
540 C(3,1)=-1:C(2,1)=-1:C(4,1)=-1:C(4,2)=-1:C(5,2)=-1:C(6,2)=-1
600 C(1,2)=1:C(2,2)=1:C(6,1)=1:C(7,1)=1:C(8,1)=1:C(8,2)=1:C(9,2)=1

REM Initialize D array--days left to repair damage to critical systems,
REM or >=0 if undamaged.

670 FORI=1TO8:D(I)=0:NEXTI

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

820 FORI=1TO8:FORJ=1TO8:K3=0:Z(I,J)=0:R1=RND(1)
850 IFR1>.98THENK3=3:K9=K9+3:GOTO980
860 IFR1>.95THENK3=2:K9=K9+2:GOTO980
870 IFR1>.80THENK3=1:K9=K9+1
980 B3=0:IFRND(1)>.96THENB3=1:B9=B9+1

REM Galactic map initialized to:
REM    K3 Klingons
REM    B3 Starbases
REM    Random number [11,18] stars
REM
REM If the total Klingons (K9) is greater than the number of days in
REM this game (T9), set the number of days to the number of Klingons
REM plus 1.

1040 G(I,J)=K3*100+B3*10+FNR(1):NEXTJ:NEXTI:IFK9>T9THENT9=K9+1

REM If there are any starbases in the galaxy, skip:
REM    Add a Klingon to Enterprise's quadrant if there are fewer than 2.
REM    Add a starbase to Enterprise's quadrant.
REM    Move Enterprise to another random quadrant.

1100 IFB9<>0THEN1200

REM If the quadrant has less than 2 klingons, add a klingon to the
REM quadrant. Increment the total number of klingons.

1150 IFG(Q1,Q2)<200THENG(Q1,Q2)=G(Q1,Q2)+100:K9=K9+1

REM Set total starbases to 1. (We only run this if there were no
REM starbases added to the galaxy earlier.) Add a starbase to this
REM quadrant.
REM
REM Then move Enterprise to a new random quadrant.

1160 B9=1:G(Q1,Q2)=G(Q1,Q2)+10:Q1=FNR(1):Q2=FNR(1)

REM Set K7??? to number of klingons. If the number of bases isn't 1, set
REM up the pluralization variables X$ and X0$.

1200 K7=K9:IFB9<>1THENX$="S":X0$=" ARE "
1230 PRINT"YOUR ORDERS ARE AS FOLLOWS:"
1240 PRINT"     DESTROY THE";K9;"KLINGON WARSHIPS WHICH HAVE INVADED"
1250 PRINT"   THE GALAXY BEFORE THEY CAN ATTACK FEDERATION HEADQUARTERS"
1260 PRINT"   ON STARDATE";T0+T9;"  THIS GIVES YOU";T9;"DAYS.  THERE";X0$
1270 PRINT"  ";B9;"STARBASE";X$;" IN THE GALAXY FOR RESUPPLYING YOUR SHIP"
1280 PRINT:PRINT"HIT ANY KEY EXCEPT RETURN WHEN READY TO ACCEPT COMMAND"

REM INP(1) returns the byte from port 1, presumably stdin.

1300 I=RND(1):IF INP(1)=13 THEN 1300

1310 REM HERE ANY TIME NEW QUADRANT ENTERED

REM Set Z4 (row) and Z5 (column) to random coordinates Q1,Q2
REM Set K3 (number of Klingons) to 0
REM Set B3 (number of starbases) to 0
REM Set S3 (number of stars) to 0
REM Set G5 (flag for Roman numerals in quadrant names) to "Do add Roman numerals"
REM Set D4 (???) to a random number between 0 and .5
REM Set Z to G at this quadrant to mark it "discovered"

1320 Z4=Q1:Z5=Q2:K3=0:B3=0:S3=0:G5=0:D4=.5*RND(1):Z(Q1,Q2)=G(Q1,Q2)

REM BUG? I can't figure out when this would ever be true:

1390 IFQ1<1ORQ1>8ORQ2<1ORQ2>8THEN1600

REM Subroutine 9030 gets quadrant name into G2$.
REM If G5 == 1, adds the Roman numeral.
REM
REM If this is not the first round, skip the first round output.

1430 GOSUB 9030:PRINT:IF T0<>T THEN 1490
1460 PRINT"YOUR MISSION BEGINS WITH YOUR STARSHIP LOCATED"
1470 PRINT"IN THE GALACTIC QUADRANT, '";G2$;"'.":GOTO 1500
1490 PRINT"NOW ENTERING ";G2$;" QUADRANT . . ."

REM Extract number of Klingons in this quardrant to K3
REM Extract number of starbases in this quardrant to B3

1500 PRINT:K3=INT(G(Q1,Q2)*.01):B3=INT(G(Q1,Q2)*.1)-10*K3

REM Extract number of stars in this quadrant to S3. If no Klingons, skip
REM combat message.

1540 S3=G(Q1,Q2)-100*K3-10*B3:IFK3=0THEN1590

1560 PRINT"COMBAT AREA      CONDITION RED":IFS>200THEN1590
1580 PRINT"   SHIELDS DANGEROUSLY LOW"

REM Initialize Quadrant Klingon position array K() to all zero
REM Initialize Quadrant display string Q$ to 192 spaces (8x8x3)

1590 FORI=1TO3:K(I,1)=0:K(I,2)=0:NEXTI
1600 FORI=1TO3:K(I,3)=0:NEXTI:Q$=Z$+Z$+Z$+Z$+Z$+Z$+Z$+LEFT$(Z$,17)

1660 REM POSITION ENTERPRISE IN QUADRANT, THEN PLACE "K3" KLINGONS, &
1670 REM "B3" STARBASES, & "S3" STARS ELSEWHERE.

1680 A$="<*>":Z1=S1:Z2=S2:GOSUB8670:IFK3<1THEN1820

REM Set Klingon position and energy level ???
REM
REM   S9 = 200
REM   r = random in range [0.5,1.5)
REM
REM   K(I,3) = S9 * r ==> [100-300)

1720 FORI=1TOK3:GOSUB8590:A$="+K+":Z1=R1:Z2=R2
1780 GOSUB8670:K(I,1)=R1:K(I,2)=R2:K(I,3)=S9*(0.5+RND(1)):NEXTI

1820 IFB3<1THEN1910
1880 GOSUB8590:A$=">!<":Z1=R1:B4=R1:Z2=R2:B5=R2:GOSUB8670

1910 FORI=1TOS3:GOSUB8590:A$=" * ":Z1=R1:Z2=R2:GOSUB8670:NEXTI

REM --- Main loop ---
REM
REM Print Short Range Sensor Scan

1980 GOSUB6430

REM Check for out of gas

1990 IFS+E>10THENIFE>10ORD(7)=0THEN2060
2020 PRINT:PRINT"** FATAL ERROR **   YOU'VE JUST STRANDED YOUR SHIP IN "
2030 PRINT"SPACE":PRINT"YOU HAVE INSUFFICIENT MANEUVERING ENERGY,";
2040 PRINT" AND SHIELD CONTROL":PRINT"IS PRESENTLY INCAPABLE OF CROSS";
2050 PRINT"-CIRCUITING TO ENGINE ROOM!!":GOTO6220

REM Main command input

2060 INPUT"COMMAND";A$
2080 FORI=1TO9:IFLEFT$(A$,3)<>MID$(A1$,3*I-2,3)THEN2160
2140 ONIGOTO2300,1980,4000,4260,4700,5530,5690,7290,6270
2160 NEXTI:PRINT"ENTER ONE OF THE FOLLOWING:"
2180 PRINT"  NAV  (TO SET COURSE)"
2190 PRINT"  SRS  (FOR SHORT RANGE SENSOR SCAN)"
2200 PRINT"  LRS  (FOR LONG RANGE SENSOR SCAN)"
2210 PRINT"  PHA  (TO FIRE PHASERS)"
2220 PRINT"  TOR  (TO FIRE PHOTON TORPEDOES)"
2230 PRINT"  SHE  (TO RAISE OR LOWER SHIELDS)"
2240 PRINT"  DAM  (FOR DAMAGE CONTROL REPORTS)"
2250 PRINT"  COM  (TO CALL ON LIBRARY-COMPUTER)"
2260 PRINT"  XXX  (TO RESIGN YOUR COMMAND)":PRINT:GOTO1990

2290 REM COURSE CONTROL BEGINS HERE

REM Warp factors: (0-8] (or (0-0.2] if warp engines damaged)
REM
REM Warp factor of exactly 0 bails out.
REM
REM Other warp factors Scott complains the engines won't take it.
REM
REM Total energy needed to move:
REM
REM   N = W1 * 8 rounded to nearest integer
REM   
REM   Energy level in E must be at least this high or the action is
REM   aborted.
REM
REM If there's enough energy in shields to make up the difference (and
REM the shields aren't damaged), this information is shown to the user,
REM but no further action is taken.
REM
REM This portion of code only gets the course in C1 and warp factor in
REM W1; it doesn't actually move the ship.

2300 INPUT"COURSE (0-9)";C1:IFC1=9THENC1=1
2310 IFC1>=1ANDC1<9THEN2350
2330 PRINT"   LT. SULU REPORTS, 'INCORRECT COURSE DATA, SIR!'":GOTO1990
2350 X$="8":IFD(1)<0THENX$="0.2"
2360 PRINT"WARP FACTOR (0-";X$;")";:INPUTW1:IFD(1)<0ANDW1>.2THEN2470
2380 IFW1>0ANDW1<=8THEN2490
2390 IFW1=0THEN1990
2420 PRINT"   CHIEF ENGINEER SCOTT REPORTS 'THE ENGINES WON'T TAKE";
2430 PRINT" WARP ";W1;"!'":GOTO1990

REM "MAXIUM" [sic]

2470 PRINT"WARP ENGINES ARE DAMAGED.  MAXIUM SPEED = WARP 0.2":GOTO1990

REM Compute energy needed for maneuver (N)

2490 N=INT(W1*8+.5):IFE-N>=0THEN2590
2500 PRINT"ENGINEERING REPORTS   'INSUFFICIENT ENERGY AVAILABLE"
2510 PRINT"                       FOR MANEUVERING AT WARP";W1;"!'"
2530 IFS<N-EORD(7)<0THEN1990

REM "ACKNOWLEGES" [sic]

2550 PRINT"DEFLECTOR CONTROL ROOM ACKNOWLEGES";S;"UNITS OF ENERGY"
2560 PRINT"                         PRESENTLY DEPLOYED TO SHIELDS."
2570 GOTO1990

2580 REM KLINGONS MOVE/FIRE ON MOVING STARSHIP . . .

2590 FORI=1TOK3:IFK(I,3)=0THEN2700

REM Replace old Klingon position with empty

2610 A$="   ":Z1=K(I,1):Z2=K(I,2):GOSUB8670:GOSUB8590

REM Place Klingon in new empty slot

2660 K(I,1)=Z1:K(I,2)=Z2:A$="+K+":GOSUB8670

REM D1 = flag to one-print header
REM D6 = Amount of repair, set to the input warp value, clamped at 1

2700 NEXTI:GOSUB6000:D1=0:D6=W1:IFW1>=1THEND6=1

REM This block of code prepares of report of systems that came back
REM online this turn.
REM
REM For all crit systems, if the damage level >= 0, no report of repair

2770 FORI=1TO8:IFD(I)>=0THEN2880

REM Repair D6 [0,1] units of damage
REM
REM If damage between (-0.1, 0), clamp to -0.1 and don't report ???

2790 D(I)=D(I)+D6:IFD(I)>-.1ANDD(I)<0THEND(I)=-.1:GOTO2880

REM If still damaged, no report

2800 IFD(I)<0THEN2880

REM If we haven't printed the report header, print it

2810 IFD1<>1THEND1=1:PRINT"DAMAGE CONTROL REPORT:  ";

REM If we got to this point, the damage must have been repaired

2840 PRINTTAB(8);:R1=I:GOSUB8790:PRINTG2$;" REPAIR COMPLETED."

REM This next block of code is about things getting damaged or repaired
REM early.
REM
REM There's a 20% chance this inner block will occur:
REM
REM    There's a 60% chance this will occur:
REM
REM       Damage system by random [1,6)
REM
REM    Else this will occur:
REM
REM       Repair system by additional [1,4)
REM
REM Else nothing occurs

2880 NEXTI:IFRND(1)>.2THEN3070
2910 R1=FNR(1):IFRND(1)>=.6THEN3000
2930 D(R1)=D(R1)-(RND(1)*5+1):PRINT"DAMAGE CONTROL REPORT:  ";
2960 GOSUB8790:PRINTG2$;" DAMAGED":PRINT:GOTO3070
3000 D(R1)=D(R1)+RND(1)*3+1:PRINT"DAMAGE CONTROL REPORT:  ";
3030 GOSUB8790:PRINTG2$;" STATE OF REPAIR IMPROVED":PRINT

3060 REM BEGIN MOVING STARSHIP

REM Remove old Enterprise from map

3070 A$="   ":Z1=INT(S1):Z2=INT(S2):GOSUB8670

REM C1 is the course
REM
REM X1 and X2 are the row and column step offsets
REM
REM Computed by looking up the offset for the integer course and lerping
REM the fractional part to the next course.
REM
REM row_offset = C(input_course,1)
REM next_row_offset = C(input_course + 1, 1)
REM
REM fractional_course = frac(input_course)  // Just fractional part
REM row_offset_diff = next_row_offset - row_offset
REM
REM interpolated_fractional_offset = row_offset_diff * fractional_course
REM
REM row_step = row_offset + interpolated_fractional_offset

3110 X1=C(C1,1)+(C(C1+1,1)-C(C1,1))*(C1-INT(C1)):X=S1:Y=S2
3140 X2=C(C1,2)+(C(C1+1,2)-C(C1,2))*(C1-INT(C1)):Q4=Q1:Q5=Q2

REM Start moving, but if we go out of quadrant, handle it at 3500
REM N is the amount of energy used for the maneuver

3170 FORI=1TON:S1=S1+X1:S2=S2+X2:IFS1<1ORS1>=9ORS2<1ORS2>=9THEN3500

REM Make sure we're about to move into empty space

3240 S8=INT(S1)*24+INT(S2)*3-26:IFMID$(Q$,S8,2)="  "THEN3360

REM If we didn't, move back and tell user

3320 S1=INT(S1-X1):S2=INT(S2-X2):PRINT"WARP ENGINES SHUT DOWN AT ";

REM "NAVAGATION" [sic]

3350 PRINT"SECTOR";S1;",";S2;"DUE TO BAD NAVAGATION":GOTO3370

3360 NEXTI:S1=INT(S1):S2=INT(S2)

REM Place Enterprise a new position
REM T8 is time we're going to advance the clock, default to 1

3370 A$="<*>":Z1=INT(S1):Z2=INT(S2):GOSUB8670:GOSUB3910:T8=1

REM If the warp factor is less than one, truncate T8 to a single decimal
REM place.

3430 IFW1<1THENT8=.1*INT(10*W1)

REM Add to stardate. If time exceeded, jump to game over.

3450 T=T+T8:IFT>T0+T9THEN6220

3470 REM SEE IF DOCKED, THEN GET COMMAND
3480 GOTO1980

REM Routine 3500 Handle maneuvering off the edge of the quadrant
REM 
REM Called repeatedly during ship motion.
REM
REM Inputs:
REM 
REM S1 = Sector row
REM S2 = Sector column
REM Q1 = Quadrant row
REM Q2 = Quadrant column
REM X = Previous S1
REM Y = Previous S2
REM Q4 = Previous Q1
REM Q5 = Previous Q2
REM N = Energy used for this maneuver
REM
REM Outputs:
REM 
REM X5 = 1 if we tried to go off the map, 0 otherwise

3490 REM EXCEEDED QUADRANT LIMITS

3500 X=8*Q1+X+N*X1:Y=8*Q2+Y+N*X2:Q1=INT(X/8):Q2=INT(Y/8):S1=INT(X-Q1*8)
3550 S2=INT(Y-Q2*8):IFS1=0THENQ1=Q1-1:S1=8
3590 IFS2=0THENQ2=Q2-1:S2=8

REM Check if new Q1,Q2 coordinates are out of bounds. If so, clamp
REM quadrant and sector coordinates at galactic edge and set X5=1 so
REM that Starfleet complains.

3620 X5=0:IFQ1<1THENX5=1:Q1=1:S1=1
3670 IFQ1>8THENX5=1:Q1=8:S1=8
3710 IFQ2<1THENX5=1:Q2=1:S2=1
3750 IFQ2>8THENX5=1:Q2=8:S2=8
3790 IFX5=0THEN3860
3800 PRINT"LT. UHURA REPORTS MESSAGE FROM STARFLEET COMMAND:"
3810 PRINT"  'PERMISSION TO ATTEMPT CROSSING OF GALACTIC PERIMETER"
3820 PRINT"  IS HEREBY *DENIED*.  SHUT DOWN YOUR ENGINES.'"
3830 PRINT"CHIEF ENGINEER SCOTT REPORTS  'WARP ENGINES SHUT DOWN"
3840 PRINT"  AT SECTOR";S1;",";S2;"OF QUADRANT";Q1;",";Q2;".'"

REM Check for game over (timeout)

3850 IFT>T0+T9THEN6220

REM If we didn't move, jump back to 3370 (place Enterprise, update
REM stardate, then back to main loop).

3860 IF8*Q1+Q2=8*Q4+Q5THEN3370

REM Add to stardate. Check for shield energy needed for maneuver. Goto
REM "Enter new quadrant" code.

3870 T=T+1:GOSUB3910:GOTO1320

REM Subroutine 3910: Use shield energy for maneuvering
REM
REM Inputs:
REM
REM E = Ship energy
REM N = Energy needed for maneuver
REM
REM Outputs:
REM
REM E = Modified ship energy
REM S = Modified ship shield energy

3900 REM MANEUVER ENERGY S/R **

3910 E=E-N-10:IFE>=0THENRETURN
3930 PRINT"SHIELD CONTROL SUPPLIES ENERGY TO COMPLETE THE MANEUVER."
3940 S=S+E:E=0:IFS<=0THENS=0
3980 RETURN


REM Routine 4000: LRS
REM
REM Inputs:
REM
REM Outputs:

3990 REM LONG RANGE SENSOR SCAN CODE

4000 IFD(3)<0THENPRINT"LONG RANGE SENSORS ARE INOPERABLE":GOTO1990

4030 PRINT"LONG RANGE SCAN FOR QUADRANT";Q1;",";Q2
4040 O1$="-------------------":PRINTO1$
4060 FORI=Q1-1TOQ1+1:N(1)=-1:N(2)=-2:N(3)=-3:FORJ=Q2-1TOQ2+1

REM If not out of bounds:
REM   Set N() array to the values of the quadrants in this row
REM   add Quadrant I,J to discovered map Z()

4120 IFI>0ANDI<9ANDJ>0ANDJ<9THENN(J-Q2+2)=G(I,J):Z(I,J)=G(I,J)

REM Print out the row, or "*** " if out of bounds

4180 NEXTJ:FORL=1TO3:PRINT": ";:IFN(L)<0THENPRINT"*** ";:GOTO4230

REM Effectively pads left zeros to three digits

4210 PRINTRIGHT$(STR$(N(L)+1000),3);" ";
4230 NEXTL:PRINT":":PRINTO1$:NEXTI:GOTO1990

REM Routine 4260: PHA control
REM
REM Inputs:
REM
REM Outputs:

4250 REM PHASER CONTROL CODE BEGINS HERE
4260 IFD(4)<0THENPRINT"PHASERS INOPERATIVE":GOTO1990

REM Make sure there are Klingons in this quadrant

4265 IFK3>0THEN4330

4270 PRINT"SCIENCE OFFICER SPOCK REPORTS  'SENSORS SHOW NO ENEMY SHIPS"
4280 PRINT"                                IN THIS QUADRANT'":GOTO1990

4330 IFD(8)<0THENPRINT"COMPUTER FAILURE HAMPERS ACCURACY"

REM Get number of units to fire--doesn't include shield energy.
REM Enter <=0 to cancel.

4350 PRINT"PHASERS LOCKED ON TARGET;  ";
4360 PRINT"ENERGY AVAILABLE =";E;"UNITS"
4370 INPUT"NUMBER OF UNITS TO FIRE";X:IFX<=0THEN1990

REM -- bookmark --

REM Subroutine 6000: Klingons shooting
REM
REM Inputs:
REM
REM K3 = Number of Klingons in this quadrant
REM D0 = Nonzero if docked
REM K(3,3) = Klingon position and energy ???
REM
REM Outputs:
REM
REM H = Energy of hit
REM S = Shield level
REM D(8) = Critical damage status

5990 REM KLINGONS SHOOTING

REM Return if there are no Klingons here

6000 IFK3<=0THENRETURN

REM If docked, no damage.

6010 IFD0<>0THENPRINT"STARBASE SHIELDS PROTECT THE ENTERPRISE":RETURN

REM For all the currently-active Klingons in the quadrant:

6040 FORI=1TO3:IFK(I,3)<=0THEN6200

REM Compute the energy of the hit (H)
REM
REM   e = K(I,3)  Energy level
REM   f = random in range [2-3)
REM   d = Distance of Klingon I from the Enterprise
REM
REM   H = trunc(e / d) * f
REM
REM Reduce shields (S) by H:
REM
REM   S = S - H
REM
REM Reduce Klingon energy ??? by dividing it by [5-6)
REM
REM   K(I,3) = e / (3 + f)

REM BUG? It looks like it calls FND(1), but that would always divide
REM `this` Klingon's energy by the distance to Klingon #1. It makes more
REM sense to divide it by the distance to this Klingon, FND(I).
REM
REM The printout of the source is unclear in the book scan. Every BASIC
REM version I've found has FND(1).
REM
REM It looks like FND(1) in the SPACEWR source, too.

6060 H=INT((K(I,3)/FND(1))*(2+RND(1))):S=S-H:K(I,3)=K(I,3)/(3+RND(0))
6080 PRINTH;"UNIT HIT ON ENTERPRISE FROM SECTOR";K(I,1);",";K(I,2)

REM If shields fall to 0 or lower, game over, man.

6090 IFS<=0THEN6240

REM If the damage is 20 or more, a critical hit might occur.

6100 PRINT"      <SHIELDS DOWN TO";S;"UNITS>":IFH<20THEN6200

REM If the damage is 20 or more, then we're saved if either:
REM
REM   We roll > 60%, or...
REM   The ratio of hit energy to shield energy < 0.02

6120 IFRND(1)>.6ORH/S<=.02THEN6200

REM Otherwise if we get here, we're taking a crit.
REM
REM Damage calculation:
REM
REM    H = energy hit value
REM    S = shield level
REM    r = random [0,0.5)
REM
REM    additional_damage = -(H / S + r)

6140 R1=FNR(1):D(R1)=D(R1)-H/S-.5*RND(1):GOSUB8790
6170 PRINT"DAMAGE CONTROL REPORTS '";G2$;" DAMAGED BY THE HIT'"
6200 NEXTI:RETURN

REM Subroutine 6430: Short Range Sensor Scan
REM
REM Inputs:
REM 
REM S1 = Player sector row
REM S2 = Player sector column
REM
REM Outputs:
REM
REM D0 = 1 if docked, 0 if not docked
REM C$ = Condition string: "*RED*", "YELLOW", "GREEN", "DOCKED"
REM Prints SRS on console

6420 REM SHORT RANGE SENSOR SCAN & STARTUP SUBROUTINE

REM Test for being docked at a neighboring starbase

6430 FORI=S1-1TOS1+1:FORJ=S2-1TOS2+1
6450 IFINT(I+.5)<1ORINT(I+.5)>8ORINT(J+.5)<1ORINT(J+.5)>8THEN6540
6490 A$=">!<":Z1=I:Z2=J:GOSUB8830:IFZ3=1THEN6580
6540 NEXTJ:NEXTI:D0=0:GOTO6650

6580 D0=1:C$="DOCKED":E=E0:P=P0
6620 PRINT"SHIELDS DROPPED FOR DOCKING PURPOSES":S=0:GOTO6720

REM Condition status:
REM
REM If there are any Klingons in this quadrant: *RED*
REM Elif energy level is under 10% full: YELLOW
REM Else: GREEN

6650 IFK3>0THENC$="*RED*":GOTO6720
6660 C$="GREEN":IFE<E0*.1THENC$="YELLOW"

REM If short range sensors damanged, skip output

6720 IFD(2)>=0THEN6770
6730 PRINT:PRINT"*** SHORT RANGE SENSORS ARE OUT ***":PRINT:RETURN
6770 O1$="---------------------------------":PRINTO1$:FORI=1TO8
6820 FORJ=(I-1)*24+1TO(I-1)*24+22STEP3:PRINT" ";MID$(Q$,J,3);:NEXTJ
6830 ONIGOTO6850,6900,6960,7020,7070,7120,7180,7240
6850 PRINT"        STARDATE          ";INT(T*10)*.1:GOTO7260
6900 PRINT"        CONDITION          ";C$:GOTO7260
6960 PRINT"        QUADRANT          ";Q1;",";Q2:GOTO7260
7020 PRINT"        SECTOR            ";S1;",";S2:GOTO7260
7070 PRINT"        PHOTON TORPEDOES  ";INT(P):GOTO7260
7120 PRINT"        TOTAL ENERGY      ";INT(E+S):GOTO7260
7180 PRINT"        SHIELDS           ";INT(S):GOTO7260
7240 PRINT"        KLINGONS REMAINING";INT(K9)
7260 NEXTI:PRINTO1$:RETURN

REM Subroutine 8590: Find empty sector in quadrant
REM
REM Input:
REM
REM None
REM
REM Output:
REM
REM Z1 = Sector position row
REM Z2 = Sector position column

8580 REM FIND EMPTY PLACE IN QUADRANT (FOR THINGS)
8590 R1=FNR(1):R2=FNR(1):A$="   ":Z1=R1:Z2=R2:GOSUB8830:IFZ3=0THEN8590
8600 RETURN

REM Subtroutine 8670: Insert a string in the quadrant string
REM
REM Inputs:
REM
REM Z1 = Sector position row
REM Z2 = Sector position column
REM A$ = String to insert (must be 3 characters)
REM Q$ = The string we're building
REM
REM Outputs:
REM
REM Q$ = The string we're building, 192 characters, 8x8x3

8660 REM INSERT IN STRING ARRAY FOR QUADRANT

REM Compute the position to insert in the string

8670 S8=INT(Z2-.5)*3+INT(Z1-.5)*24+1

8675 IF LEN(A$)<>3THEN PRINT"ERROR":STOP

REM Insert at the left, right, or middle

8680 IFS8=1THENQ$=A$+RIGHT$(Q$,189):RETURN
8690 IFS8=190THENQ$=LEFT$(Q$,189)+A$:RETURN
8700 Q$=LEFT$(Q$,S8-1)+A$+RIGHT$(Q$,190-S8):RETURN

REM Subroutine 8790: Get Device Name
REM
REM Input:
REM
REM R1 = The device number 1-8
REM
REM Output:
REM
REM G2$ = The device name

8780 REM PRINTS DEVICE NAME

8790 ONR1GOTO8792,8794,8796,8798,8800,8802,8804,8806
8792 G2$="WARP ENGINES":RETURN
8794 G2$="SHORT RANGE SENSORS":RETURN
8796 G2$="LONG RANGE SENSORS":RETURN
8798 G2$="PHASER CONTROL":RETURN
8800 G2$="PHOTON TUBES":RETURN
8802 G2$="DAMAGE CONTROL":RETURN
8804 G2$="SHIELD CONTROL":RETURN
8806 G2$="LIBRARY-COMPUTER":RETURN

REM Subroutine 8830: Sector Comparison
REM
REM Input:
REM
REM Z1 = Sector row
REM Z2 = Sector column
REM A$ = String to compare
REM
REM Output:
REM
REM Z = 0 if the string doesn't match the sector contents, 1 if it does

8820 REM STRING COMPARISON IN QUADRANT ARRAY
8830 Z1=INT(Z1+.5):Z2=INT(Z2+.5):S8=(Z2-1)*3+(Z1-1)*24+1:Z3=0
8890 IFMID$(Q$,S8,3)<>A$THENRETURN
8900 Z3=1:RETURN

REM Subroutine 9030: Get Quadrant Name
REM
REM Inputs:
REM
REM Z4 = Galactic map row
REM Z5 = Galactic map column
REM G5 = Set to 1 to get the region name only (no Roman numerals)
REM
REM Outputs:
REM
REM G2$ = The name of the quadrant

9010 REM QUADRANT NAME IN G2$ FROM Z4,Z5 (=Q1,Q2)
9020 REM CALL WITH G5=1 TO GET REGION NAME ONLY
9030 IFZ5<=4THENONZ4GOTO9040,9050,9060,9070,9080,9090,9100,9110
9035 GOTO9120
9040 G2$="ANTARES":GOTO9210
9050 G2$="RIGEL":GOTO9210
9060 G2$="PROCYON":GOTO9210
9070 G2$="VEGA":GOTO9210
9080 G2$="CANOPUS":GOTO9210
9090 G2$="ALTAIR":GOTO9210
9100 G2$="SAGITTARIUS":GOTO9210
9110 G2$="POLLUX":GOTO9210

REM The middle of the following line is missing from the source code.
REM Interpolated.

9120 ONZ4GOTO9130,9140,9150,9160,9170,9180,9190,9200
9130 G2$="SIRIUS":GOTO9210
9140 G2$="DENEB":GOTO9210
9150 G2$="CAPELLA":GOTO9210
9160 G2$="BETELGEUSE":GOTO9210
9170 G2$="ALDEBARAN":GOTO9210
9180 G2$="REGULUS":GOTO9210
9190 G2$="ARCTURUS":GOTO9210
9200 G2$="SPICA"

9210 IFG5<>1THENONZ5GOTO9230,9240,9250,9260,9230,9240,9250,9260
9220 RETURN

9230 G2$=G2$+" I":RETURN
9240 G2$=G2$+" II":RETURN
9250 G2$=G2$+" III":RETURN
9260 G2$=G2$+" IV":RETURN

