10 'SUPER STARTREK
15 '
20 'From BASIC COMPUTER GAMES, Creative Computing
30 'Press, Edited by David H.Ahl, pp 157-163.
35 '
40 'Entered by hand, modified for the OSBORNE 1,
50 'and significantly enhanced by J.A.Woolley,
60 'member of the First Osborne Group (FOG),
70 'Santa Clara Valley, California.
190 CLEAR
200 DIM G(8,8),C(9,2),K(3,3),Z(8,8),D(8),SLOG$(19),TLOG(19)
210 REM
220 PRINT CHR$(26)
221 PRINT"                         ,------*------,"
222 PRINT"       ,-------------     '---  ------'"
223 PRINT"        '-------- --'        / /"
224 PRINT"            ,---' '---------/ /--,"
225 PRINT"             '------------------'"
226 PRINT:PRINT"        THE USS ENTERPRISE --- NCC-1701"
227 PRINT:PRINT:PRINT:PRINT:PRINT
270 Z$="                         "
340 'R=PEEK(&HEF67)+PEEK(&HEF68)+PEEK(&HEF69)  <- THIS LINE FOR GETTING SEED
350 RANDOMIZE:'<- ADD AN 'R' IF ABOVE LINE IS CORRECT
370 T=INT(RND*20+20)*100:T0=T:T9=25+INT(RND*10)
380 D0=0:E=3000:E0=E
440 P=10:P0=P:S9=200:S=0:B9=0:K9=0:X$="":X0$=" is"
470 DEF FND(D)=SQR((K(I,1)-S1)^2+(K(I,2)-S2)^2)
475 DEF FNR=INT(RND*7.98+1.01)
480 REM initialize enterprise position
490 Q1=FNR:Q2=FNR:S1=FNR:S2=FNR
530 FOR I=1 TO 9:C(I,1)=0:C(I,2)=0:NEXT
540 C(3,1)=-1:C(2,1)=-1:C(4,1)=-1:C(4,2)=-1
550 C(5,2)=-1:C(6,2)=-1
600 C(1,2)=1:C(2,2)=1:C(6,1)=1:C(7,1)=1:C(8,1)=1
610 C(8,2)=1:C(9,2)=1
670 FOR I=1 TO 8:D(I)=0:NEXT
710 A1$="NAVSRSLRSPHATORSHEDAMCOMXXX"
810 REM setup what exists in galaxy
815 REM k3=# klingons  b3=# starbases  s3=# stars
820 FOR I=1 TO 8:FOR J=1 TO 8:K3=0:Z(I,J)=0:R1=RND
850 IF R1>.98 THEN K3=3:K9=K9+3:GOTO 980
860 IF R1>.95 THEN K3=2:K9=K9+2:GOTO 980
870 IF R1>.8 THEN K3=1:K9=K9+1
980 B3=0:IF RND>.96 THEN B3=1:B9=B9+1
1040 G(I,J)=K3*100+B3*10+FNR:NEXT J,I
1050 IF K9>T9 THEN T9=K9+1
1100 IF B9<>0 THEN 1200
1150 IF G(Q1,Q2)<200 THEN G(Q1,Q2)=G(Q1,Q2)+100:K9=K9+1
1160 B9=1:G(Q1,Q2)=G(Q1,Q2)+10:Q1=FNR:Q2=FNR
1200 K7=K9:IF B9<>1 THEN X$="s":X0$=" are"
1230 PRINT"Your orders are as follows:"
1240 PRINT"   Destroy the";K9;"Klingon warships which have"
1245 PRINT"   invaded the galaxy before they can attack"
1250 PRINT"   Federation Headquarters on Stardate";T0+T9;CHR$(8)+"."
1255 PRINT"   This gives you";T9;"days.  There";X0$;B9
1260 PRINT"   Starbase";X$;" in the galaxy for resupplying"
1270 PRINT"   your ship.  Hit any key except RETURN when"
1275 PRINT"   you are ready to accept command."
1300 I=RND:IF INPUT$(1)=CHR$(13) THEN 1300
1301 PRINT CHR$(26)+"Starfleet Command wishes you to accept special"
1302 PRINT"energy conservation measures.  Will you accept ..."
1303 INPUT"... (YES/NO/MAYBE)";X0$
1304 X$=" cowardice ":IF X0$="NO" THEN 1309
1306 P0=8:E0=2500:X$=" "
1307 IF X0$="YES" THEN P0=6:E0=2000:X$=" severly "
1308 PRINT"Sorry, but your resources will be";X$;"limited.":X$=" bravery "
1309 E=E0:P=P0:PRINT"Your";X$;"will be noted in the ship's log.":LOGS=0:LOGF=0:TLOG(0)=T0:SLOG$(0)="Noted Captain's"+X$+"in face of enemy."
1310 REM here any time new quadrant entered
1320 Z4=Q1:Z5=Q2:K3=0:B3=0:S3=0:G5=0:D4=.5*RND
1330 Z(Q1,Q2)=G(Q1,Q2)
1390 IF Q1<1 OR Q1>8 OR Q2<1 OR Q2>8 THEN 1600
1430 GOSUB 9030:PRINT:IF T0<>T THEN 1490
1460 PRINT"Your mission begins with your Starship located"
1470 PRINT"in the galactic quadrant, '";G2$;"'."
1480 GOTO 1500
1490 PRINT"Now entering ";G2$;" quadrant . . ."
1500 PRINT:K3=INT(G(Q1,Q2)*.01):B3=INT(G(Q1,Q2)*.1)-10*K3
1540 S3=G(Q1,Q2)-100*K3-10*B3:IF K3=0 THEN 1590
1560 PRINT"Combat Area       Condition *RED*"+CHR$(7)
1570 IF S>200 THEN 1590
1580 PRINT"     Shields dangerously low"
1590 FOR I=1 TO 3:K(I,1)=0:K(I,2)=0:NEXT
1600 FOR I=1 TO 3:K(I,3)=0:NEXT
1610 Q$=Z$+Z$+Z$+Z$+Z$+Z$+Z$+LEFT$(Z$,17)
1660 REM position enterprise in quadrant, then place
1665 REM K3 klingons, B3 starbases, and S3 stars elsewhere
1680 A$="<*>":Z1=S1:Z2=S2:GOSUB 8670:IF K3<1 THEN 1820
1720 FOR I=1 TO K3:GOSUB 8590:A$="+K+":Z1=R1:Z2=R2
1780 GOSUB 8670:K(I,1)=R1:K(I,2)=R2:K(I,3)=S9*(.5+RND)
1790 NEXT
1820 IF B3<1 THEN 1910
1880 GOSUB 8590:A$=">!<":Z1=R1:B4=R1:Z2=R2:B5=R2
1890 GOSUB 8670
1910 FOR I=1 TO S3:GOSUB 8590
1912 A$=" * "
1914 Z1=R1:Z2=R2
1920 GOSUB 8670:NEXT
1980 GOSUB 6430
1990 IF S+E>10 THEN IF E>10 OR D(7)=0 THEN 2060
2020 PRINT:PRINT"** FATAL ERROR **   You've just stranded your"
2025 PRINT"ship in space.  You have insufficient maneuvering"
2030 PRINT"energy, and shield control is presently incapable"
2040 PRINT"of cross-circuiting to engine room!!":GOTO 6220
2060 INPUT"COMMAND";A$
2061 IF A$="E" THEN 5530
2062 J=3:IF LEN(A$)<=1 THEN J=1:GOTO 2080
2063 IF MID$(A$,2,1)<>" " THEN 2080
2064 IF LEN(A$)>2 THEN X=VAL(MID$(A$,3))
2065 FOR I=1 TO 9:IF LEFT$(A$,1)<>MID$(A1$,3*I-2,1) THEN 2068
2066 IF I=2 OR I=7 THEN PRINT CHR$(26)
2067 ON I GOTO 2069,1980,4000,4260,2070,2068,5690,2074,6270
2068 NEXT I:IF LEFT$(A$,1)="E" THEN 2072 ELSE 2170
2069 C1=X:GOTO 2305
2070 IF P<=0 OR D(5)<0 THEN 4700
2071 C1=X:GOTO 4770
2072 IF D(7)<0 THEN 5530
2073 GOTO 5580
2074 IF D(8)<0 THEN 7290
2075 IF X<0 THEN 1990
2076 A=X:GOTO 7350
2080 FOR I=1 TO 9:IF LEFT$(A$,J)<>MID$(A1$,3*I-2,J) THEN 2160
2100 IF I=2 OR I=7 THEN PRINT CHR$(26)
2140 ON I GOTO 2300,1980,4000,4260,4700,5530,5690,7290,6270
2160 NEXT I
2170 PRINT"Enter one of the following:"
2180 PRINT"  NAV or N n  to set course"
2190 PRINT"  SRS or S    for short range sensor scan"
2200 PRINT"  LRS or L    for long range sensor scan"
2210 PRINT"  PHA or P    to fire phasers"
2220 PRINT"  TOR or T n  to fire photon torpedoes"
2230 PRINT"  SHE or E n  to raise or lower shields"
2240 PRINT"  DAM or D    for damage control reports"
2250 PRINT"  COM or C n  to call on library-computer"
2260 PRINT"  XXX or X    to resign your command"
2270 PRINT"           where n is a number (optional)"
2280 PRINT:GOTO 1990
2290 REM course control begins here
2300 INPUT"COURSE (1-9)";C1
2305 IF C1=9 THEN C1=1
2310 IF C1>=1 AND C1<9 THEN 2350
2330 PRINT"Lt. Sulu reports, 'Incorrect course data, Sir!'"
2340 GOTO 1990
2350 X$="8":IF D(1)<0 THEN X$="0.2"
2360 PRINT"WARP FACTOR (0-";X$;")";:INPUT W1
2370 IF D(1)<0 AND W1>.2 THEN 2470
2380 IF W1>0 AND W1<=8 THEN 2490
2390 IF W1=0 THEN 1990
2420 PRINT"Chief Engineer Scott reports, 'The engines"
2430 PRINT"won't take WARP";W1;"!'":GOTO 1990
2470 PRINT"WARP engines damaged.  Max. speed = WARP 0.2"
2480 GOTO 1990
2490 N=INT(W1*8+.5):IF E-N>=0 THEN 2590
2500 PRINT"Engineering reports, 'Insufficient energy available"
2510 PRINT"for maneuvering at WARP";W1;"!'"
2530 IF S<N-E OR D(7)<0 THEN 1990
2550 PRINT"Deflector control room acknowledges";S;"units"
2560 PRINT"of energy presently deployed to shields."
2570 GOTO 1990
2580 REM klingons move/fire on moving starship
2590 PRINT CHR$(26):FOR I=1 TO K3:IF K(I,3)=0 THEN 2700
2610 A$="   ":Z1=K(I,1):Z2=K(I,2):GOSUB 8670
2620 GOSUB 8590
2660 K(I,1)=Z1:K(I,2)=Z2:A$="+K+":GOSUB 8670
2700 NEXT:GOSUB 6000:D6=W1:IF W1>=1 THEN D6=1
2770 FOR I=1 TO 8:IF D(I)>=0 THEN 2880
2790 D(I)=D(I)+D6:IF D(I)>-.1 AND D(I)<0 THEN D(I)=-.1:GOTO 2880
2800 IF D(I)<0 THEN 2880
2810 PRINT"Damage Control Report:"
2840 R1=I:GOSUB 8790:PRINT G2$;" repair completed."
2850 GOSUB 9400:SLOG$(LOGF)=G2$+" repaired."
2880 NEXT:IF RND>.2 THEN 3040
2910 R1=FNR:IF RND>=.6 THEN 2990
2930 D(R1)=D(R1)-(RND*5+1):PRINT"Damage Control Report:"
2960 GOSUB 8790:PRINT G2$;" damaged.":PRINT
2970 GOSUB 9400:SLOG$(LOGF)=G2$+" damaged.":GOTO 3040
2990 IF D(R1)>=0 THEN 3040
3000 D(R1)=D(R1)+RND*3+1:PRINT"Damage Control Report:"
3030 GOSUB 8790:PRINT G2$;" state of repair improved.":PRINT
3040 FOR I=1 TO 8:IF D(I)>0 THEN D(I)=0
3050 NEXT I
3060 REM begin moving starship
3070 A$="   ":Z1=INT(S1):Z2=INT(S2):GOSUB 8670
3110 X1=C1:X2=C1:C1=INT(C1)
3115 X1=C(C1,1)+(C(C1+1,1)-C(C1,1))*(X1-C1)
3120 X=S1:Y=S2
3140 X2=C(C1,2)+(C(C1+1,2)-C(C1,2))*(X2-C1)
3150 Q4=Q1:Q5=Q2
3170 FOR I=1 TO N:S1=S1+X1:S2=S2+X2
3180 IF S1<1 OR S1>=9 OR S2<1 OR S2>=9 THEN 3500
3240 S8=INT(S1)*24+INT(S2)*3-26
3250 IF MID$(Q$,S8,3)="   " THEN 3360
3320 S1=INT(S1-X1):S2=INT(S2-X2)
3330 PRINT"WARP engines shut down at sector";S1;",";S2
3340 IF MID$(Q$,S8,3)=">!<" THEN PRINT"for docking.":GOTO 3370
3350 PRINT"due to bad navigation.":GOTO 3370
3360 NEXT:S1=INT(S1):S2=INT(S2)
3370 A$="<*>":Z1=INT(S1):Z2=INT(S2):GOSUB 8670
3380 GOSUB 3910:T8=1
3430 IF W1<1 THEN T8=.1*INT(10*W1)
3450 T=T+T8:IF T>T0+T9 THEN 6220
3470 REM see if docked, then get command
3480 GOTO 1980
3490 REM exceeded quadrant limits
3500 X=8*Q1+X+N*X1:Y=8*Q2+Y+N*X2
3510 Q1=INT(X/8):Q2=INT(Y/8):S1=INT(X-Q1*8)
3550 S2=INT(Y-Q2*8):IF S1=0 THEN Q1=Q1-1:S1=8
3590 IF S2=0 THEN Q2=Q2-1:S2=8
3620 X5=0:IF Q1<1 THEN X5=1:Q1=1:S1=1
3670 IF Q1>8 THEN X5=1:Q1=8:S1=8
3710 IF Q2<1 THEN X5=1:Q2=1:S2=1
3750 IF Q2>8 THEN X5=1:Q2=8:S2=8
3790 IF X5=0 THEN 3860
3800 PRINT"Lt. Uhura reports message from Starfleet Command:"
3810 PRINT"'Permission to attempt crossing of galactic peri-"
3820 PRINT"meter is hereby *DENIED*.  Shut down engines.'"
3830 PRINT"Chief Engineer Scott reports, 'WARP engines"
3840 PRINT"shut down at sector";S1;",";S2;"of quadrant";Q1;",";Q2;".'"
3860 IF 8*Q1+Q2=8*Q4+Q5 THEN 3370
3870 T=T+1:IF T>T0+T9 THEN 6220
3880 GOSUB 3910:GOTO 1320
3900 REM maneuver energy s/r
3910 E=E-N-10:IF E>=0 THEN RETURN
3930 PRINT"Shield Control supplies energy to comlete maneuver."
3940 S=S+E:E=0:IF S<=0 THEN S=0
3980 RETURN
3990 REM long range sensor scan code
4000 IF D(3)<0 THEN PRINT"Long range sensors inoperable.":GOTO 1990
4030 PRINT"Long range scan for quadrant";Q1;",";Q2
4040 O1$="-------------------":PRINT O1$
4060 FOR I=Q1-1 TO Q1+1:N(1)=-1:N(2)=-2:N(3)=-3
4070 FOR J=Q2-1 TO Q2+1
4120 IF I>0 AND I<9 AND J>0 AND J<9 THEN
 N(J-Q2+2)=G(I,J):Z(I,J)=G(I,J)
4180 NEXT J
4190 FOR L=1 TO 3:PRINT": ";:IF N(L)<0 THEN PRINT"*** ";:
GOTO 4230
4210 PRINT RIGHT$(STR$(N(L)+1000),3);" ";
4230 NEXT L:PRINT":":PRINT O1$:NEXT I:GOTO 1990
4250 REM phaser control code begins here
4260 IF D(4)<0 THEN PRINT"Phasers inoperative.":GOTO 1990
4265 IF K3>0 THEN 4330
4270 PRINT"Science Officer Spock reports, 'Sensors show no"
4280 PRINT"enemy ships in this quadrant.'":GOTO 1990
4330 IF D(8)<0 THEN PRINT"Computer failure hampers accuracy."
4350 PRINT"Phasers locked on target."
4360 PRINT"Energy available =";E;"units."
4370 INPUT"NUMBER OF UNITS TO FIRE";X:IF X<=0 THEN 1990
4400 IF E-X<0 THEN 4360
4410 E=E-X:IF D(8)<0 THEN X=X*RND
4450 H1=X/K3:FOR I=1 TO 3:IF K(I,3)<=0 THEN 4670
4480 H=INT((H1/FND(0))*(RND+2)):IF H>H1 THEN H=INT(H1)
4490 IF H>.15*K(I,3) THEN 4530
4500 PRINT"Sensors show no damage to enemy at ";K(I,1);",";K(I,2)
4510 GOTO 4670
4530 K(I,3)=K(I,3)-H
4540 PRINT H;"unit hit on Klingon at sector";K(I,1);",";
4550 PRINT K(I,2):IF K(I,3)>0 THEN 4560
4555 PRINT"*** KLINGON DESTROYED ***"
4556 GOSUB 9400:SLOG$(LOGF)="Klingon destroyed.":GOTO 4580
4560 PRINT"   (Sensors show";K(I,3);"units remaining)"
4570 GOTO 4670
4580 K3=K3-1:K9=K9-1:Z1=K(I,1):Z2=K(I,2):A$="   "
4590 GOSUB 8670
4650 K(I,3)=0:G(Q1,Q2)=G(Q1,Q2)-100:Z(Q1,Q2)=G(Q1,Q2)
4660 IF K9<=0 THEN 6370
4670 NEXT I:GOSUB 6000:GOTO 1990
4690 REM photon torpedo code begins here
4700 IF P<=0 THEN PRINT"All photon torpedoes expended.":GOTO 1990
4730 IF D(5)<0 THEN PRINT"Photon tubes are not operational.":GOTO 1990
4760 INPUT"PHOTON TORPEDO COURSE (1-9)";C1
4770 IF C1=9 THEN C1=1
4775 X1=C1:X2=C1:C1=INT(C1)
4780 IF C1>=1 AND C1<9 THEN 4850
4790 PRINT"Ensign Chekov reports, 'Incorrect course data, Sir!'"
4800 GOTO 1990
4850 X1=C(C1,1)+(C(C1+1,1)-C(C1,1))*(X1-C1)
4855 E=E-2:P=P-1
4860 X2=C(C1,2)+(C(C1+1,2)-C(C1,2))*(X2-C1)
4870 X=S1:Y=S2
4875 IF D(2)<0 THEN 4910
4880 PRINT CHR$(26):GOSUB 6650:GOTO 4920
4910 PRINT"Short range sensors inoperable.  Torpedo track:"
4920 X=X+X1:Y=Y+X2:X3=INT(X+.5):Y3=INT(Y+.5)
4960 IF X3<1 OR X3>8 OR Y3<1 OR Y3>8 THEN 5485
4970 IF D(2)<0 THEN 5000
4974 J0=-1:X=X-X1/2:Y=Y-X2/2
4976 X3=INT(2*X+.5)/2:Y3=INT(4*Y+.5)/4
4980 A$=" o "
4990 IF X3<>S1 OR ABS(Y-S2)>.5 THEN GOSUB 9300
4992 J0=J0+1:IF J0>0 THEN 5010
4995 X=X+X1/2:Y=Y+X2/2:GOTO 4976
5000 PRINT"          ";X3;",";Y3
5010 A$="   ":Z1=X:Z2=Y:GOSUB 8830
5020 X3=INT(X+.5):Y3=INT(Y+.5)
5050 IF Z3<>0 THEN 4920
5060 A$="+K+":Z1=X:Z2=Y:GOSUB 8830
5070 IF Z3=0 THEN 5210
5080 IF D(2)<0 THEN 5110
5090 GOSUB 9280
5110 PRINT"*** KLINGON DESTROYED ***"
5115 GOSUB 9400:SLOG$(LOGF)="Klingon destroyed."
5120 K3=K3-1:K9=K9-1
5130 IF K9<=0 THEN 6370
5150 FOR I=1 TO 3:IF X3=K(I,1) AND Y3=K(I,2) THEN 5190
5180 NEXT I:I=3
5190 K(I,3)=0:GOTO 5430
5210 A$=" * ":Z1=X:Z2=Y:GOSUB 8830:IF Z3=0 THEN 5280
5220 IF D(2)<0 THEN 5260
5230 GOSUB 9280
5240 A$=" * ":KEEP=1:GOSUB 9300:KEEP=0
5250 GOSUB 9290
5260 PRINT"Star at";X3;",";Y3;"absorbed torpedo energy."
5270 GOSUB 6000:GOTO 1990
5280 A$=">!<":Z1=X:Z2=Y:GOSUB 8830:IF Z3=0 THEN 4920
5290 IF D(2)<0 THEN 5330
5300 GOSUB 9280
5330 PRINT"*** STARBASE DESTROYED ***":B3=B3-1:B9=B9-1
5340 GOSUB 9400:SLOG$(LOGF)="Starbase destroyed."
5360 IF B9>0 OR K9<T0+T9-T THEN 5400
5370 PRINT"That does it, Captain!  You are hereby relieved"
5375 PRINT"of command and sentenced to 99 stardates at hard"
5380 PRINT"labor on Cygnus 12!"
5390 GOTO 6270
5400 PRINT"Starfleet command reviewing your record to consider"
5410 PRINT"court martial!":D0=0
5420 SLOG$(LOGF)=SLOG$(LOGF)+" Captain under review."
5430 Z1=X:Z2=Y:A$="   ":GOSUB 8670
5470 G(Q1,Q2)=K3*100+B3*10+S3:Z(Q1,Q2)=G(Q1,Q2)
5480 GOSUB 6000:GOTO 1990
5485 IF D(2)>=0 THEN GOSUB 9290
5490 PRINT"Torpedo missed.":GOSUB 6000:GOTO 1990
5520 REM shield control
5530 IF D(7)<0 THEN PRINT"Shield control inoperable.":GOTO 1990
5560 PRINT"Energy available =";E+S;"units."
5570 INPUT"NUMBER OF UNITS TO SHIELDS";X
5580 IF X<0 OR S=X THEN PRINT"Shields unchanged.":GOTO 1990
5590 IF X<=E+S THEN 5630
5600 PRINT"Shield control reports, 'This is not the Federation"
5605 PRINT"Treasury.'"
5610 PRINT"Shields unchanged.":GOTO 1990
5630 E=E+S-X:S=X:PRINT"Deflector control room report:"
5660 PRINT"'Shields now at";INT(S);"units per your command.'"
5670 GOTO 1990
5680 REM damage control
5690 IF D(6)>=0 THEN 5910
5700 PRINT"Damage control report not available."
5710 IF D0=0 THEN 1990
5720 D3=0:FOR I=1 TO 8:IF D(I)<0 THEN D3=D3+.1
5760 NEXT I:IF D3=0 THEN 1990
5780 PRINT:D3=D3+D4:IF D3>=1 THEN D3=.9
5810 PRINT"Technicians standing by to repair your ship."
5820 PRINT"Estimated time to repair:";.01*INT(100*D3);"stardates."
5840 INPUT"Will you authorize the repair order (Y/N)";A$
5860 IF A$<>"Y" THEN 1990
5870 FOR I=1 TO 8:IF D(I)<0 THEN D(I)=0
5890 NEXT I:T=T+D3+.1
5900 GOSUB 9400:SLOG$(LOGF)="Technicians repaired ship."
5910 PRINT:PRINT"DEVICE             STATE OF REPAIR"
5915 FOR R1=1 TO 8
5920 GOSUB 8790
5930 PRINT G2$;LEFT$(Z$,25-LEN(G2$));INT(D(R1)*100)*.01
5950 NEXT R1:PRINT:IF D0<>0 THEN 5720
5980 GOTO 1990
5990 REM klingons shooting
6000 IF K3<=0 THEN RETURN
6010 IF D0<>0 THEN PRINT"Starbase shields protect the Enterprise.":
RETURN
6040 FOR I=1 TO 3:IF K(I,3)<=0 THEN 6200
6060 H=INT((K(I,3)/FND(1))*(2+RND)):S=S-H
6070 K(I,3)=K(I,3)/(3+RND(0))
6080 PRINT H;"unit hit on Enterprise from sector";K(I,1);",";K(I,2)
6090 IF S<=0 THEN 6240
6100 PRINT"Shields down to";S;"units.":IF H<20 THEN 6200
6120 IF RND>.6 OR H/S<=.02 THEN 6200
6140 R1=FNR:D(R1)=D(R1)-H/S-.5*RND:GOSUB 8790
6170 PRINT"Damage control reports, '";G2$
6180 PRINT "damaged by the hit.'"
6190 GOSUB 9400:SLOG$(LOGF)=G2$+" damaged."
6200 NEXT I:RETURN
6210 REM end of game
6220 PRINT"It is stardate";T;CHR$(8)+".":GOTO 6270
6240 PRINT:PRINT"The Enterprise has been destroyed.  The Federation"
6250 PRINT"will be conquered.  ";:GOTO 6220
6270 PRINT"There were";K9;"Klingon battle cruisers left at"
6280 PRINT"the end of your mission."
6300 PRINT:PRINT
6310 PRINT"The Federation is in need of a starship commander"
6320 PRINT"for a similar mission.  If there is a volunteer,"
6330 INPUT"let him step forward and enter AYE";A$
6335 FINI=1:GOSUB 9440:FINI=0
6340 IF A$<>"AYE" THEN END
6350 INPUT"Ready";A$:GOTO 220
6360 END
6370 PRINT"Congratulations, Captain!  The last Klingon battle"
6380 PRINT"cruiser menacing the Federation has been destroyed."
6400 PRINT:PRINT"Your efficiency rating is";1000*(K7/(T-T0))^2
6410 GOTO 6300
6420 REM short range sensor scan and startup s/r
6430 FOR I=S1-1 TO S1+1:FOR J=S2-1 TO S2+1
6450 IF INT(I+.5)<1 OR INT(I+.5)>8 OR INT(J+.5)<1 OR INT(J+.5)>8 THEN 6540
6490 A$=">!<":Z1=I:Z2=J:GOSUB 8830:IF Z3=1 THEN 6580
6540 NEXT J:NEXT I:D0=0:GOTO 6650
6580 D0=1:C$="DOCKED":E=E0:P=P0
6620 PRINT"Shields dropped for docking purposes.":S=0:GOTO 6720
6650 IF K3>0 THEN C$="*RED*"+CHR$(7):GOTO 6720
6660 C$="GREEN":IF E<E0*.1 THEN C$="YELLOW"+CHR$(7)
6720 IF D(2)>=0 THEN 6770
6730 PRINT:PRINT"*** SHORT RANGE SENSORS ARE OUT ***":PRINT:RETURN
6770 O1$="---------------------------------"
6780 PRINT O1$:FOR I=1 TO 8:IF I>1 THEN PRINT
6820 FOR J=(I-1)*24+1 TO (I-1)*24+22 STEP 3
6825 PRINT" ";MID$(Q$,J,3);:NEXT J
6830 ON I GOTO 6850,6900,6960,7020,7070,7120,7180,7240
6850 PRINT"  Stardate  ";INT(T*10)*.1:GOTO 7260
6900 PRINT"  Condition  ";C$:GOTO 7260
6960 PRINT"  Quadrant  ";Q1;",";Q2:GOTO 7260
7020 PRINT"  Sector    ";S1;",";S2:GOTO 7260
7070 PRINT"  Torpedoes ";INT(P):GOTO 7260
7120 PRINT"  Tot.Energy";INT(E+S):GOTO 7260
7180 PRINT"  Shields   ";INT(S):GOTO 7260
7240 PRINT"  Klingons  ";INT(K9)
7260 NEXT I:PRINT O1$:RETURN
7280 REM library-computer code
7290 IF D(8)<0 THEN PRINT"Computer disabled.":GOTO 1990
7310 PRINT"Computer active and awaiting your command."
7320 INPUT"FUNCTION (0-5)";A:IF A<0 THEN 1990
7350 PRINT:H8=1:ON A+1 GOTO 7540,7900,8070,8500,8150,7400,9440
7360 PRINT"Functions available from library-computer:"
7370 PRINT"  0 = Cumulative galactic record"
7372 PRINT"  1 = Status report"
7374 PRINT"  2 = Photon torpedo data"
7376 PRINT"  3 = Starbase NAV data"
7378 PRINT"  4 = Direction/distance calculator"
7380 PRINT"  5 = Galaxy 'Region Name' map"
7385 PRINT"  6 = Ship's log":PRINT:GOTO 7320
7390 REM setup to change cum gal record to galaxy map
7400 H8=0:G5=1:PRINT CHR$(26)+"                        THE GALAXY"
7410 GOTO 7550
7530 REM cum galactic record
7540 REM deleted TTY logic
7543 PRINT CHR$(26):PRINT"     ";
7544 PRINT"Computer record of galaxy for quadrant";Q1;",";Q2
7546 PRINT
7550 PRINT"       1     2     3     4     5     6     7     8"
7560 O1$="     ----- ----- ----- ----- ----- ----- ----- -----"
7570 PRINT O1$:FOR I=1 TO 8:PRINT I;:IF H8=0 THEN 7740
7630 FOR J=1 TO 8:PRINT"   ";:IF Z(I,J)=0 THEN PRINT"***";:GOTO 7720
7700 PRINT RIGHT$(STR$(Z(I,J)+1000),3);
7720 NEXT J:GOTO 7850
7740 Z4=I:Z5=1:GOSUB 9030:J0=INT(15-.5*LEN(G2$))
7750 PRINT TAB(J0);G2$;
7800 Z5=5:GOSUB 9030:J0=INT(39-.5*LEN(G2$))
7810 PRINT TAB(J0);G2$;
7850 PRINT:PRINT O1$:NEXT I:PRINT:GOTO 1990
7890 REM status report
7900 PRINT CHR$(26)+"   Status report:":X$="":XX$="is"
7910 IF K9>1 THEN X$="s":XX$="are"
7940 PRINT"There ";XX$;K9;" Klingon";X$;" remaining."
7960 PRINT"Mission must be completed in";.1*INT((T0+T9-T)*10);"stardates."
7970 X$="s":IF B9<2 THEN X$="":IF B9<1 THEN 8010
7980 PRINT"The Federation is maintaining";B9;"starbase";X$
7985 PRINT"in the galaxy."
7990 GOTO 5690
8010 PRINT"Your stupidity has left you on your own in"
8020 PRINT"the galaxy.  You have no starbases left!"
8030 GOTO 5690
8060 REM torpedo, base NAV, d/d calculator
8070 IF K3<=0 THEN 4270
8080 X$="":IF K3>1 THEN X$="s"
8090 PRINT"From Enterprise to Klingon battle cruiser";X$;":"
8100 H8=0:FOR I=1 TO 3:IF K(I,3)<=0 THEN 8480
8110 W1=K(I,1):X=K(I,2)
8120 C1=S1:A=S2:GOTO 8220
8150 PRINT"Direction/Distence Calculator:"
8160 PRINT"You are at quadrant ";Q1;",";Q2;" sector ";S1;",";S2
8170 PRINT"Please enter:"
8180 INPUT"  INITIAL COORDINATES (X,Y)";C1,A
8200 INPUT"    FINAL COORDINATES (X,Y)";W1,X
8220 X=X-A:A=C1-W1:IF X<0 THEN 8350
8250 IF A<0 THEN 8410
8260 IF X>0 THEN 8280
8270 IF A=0 THEN C1=5:GOTO 8290
8280 C1=1
8290 IF ABS(A)<=ABS(X) THEN 8330
8310 PRINT"Direction =";C1+(((ABS(A)-ABS(X))+ABS(A))/ABS(A))
8320 GOTO 8460
8330 PRINT"Direction =";C1+(ABS(A)/ABS(X)):GOTO 8460
8350 IF A>0 THEN C1=3:GOTO 8420
8360 IF X<>0 THEN C1=5:GOTO 8290
8410 C1=7
8420 IF ABS(A)>=ABS(X) THEN 8450
8430 PRINT"Direction =";C1+(((ABS(X)-ABS(A))+ABS(X))/ABS(X))
8440 GOTO 8460
8450 PRINT"Direction =";C1+(ABS(X)/ABS(A))
8460 X=SQR(X^2+A^2):PRINT"Distance  =";X
8470 IF H8=1 THEN PRINT"Use WARP  =";X/8;"if maneuver is within quadrant.":GOTO 1990
8480 NEXT I:GOTO 1990
8500 IF B3<>0 THEN PRINT"From Enterprise to Starbase:":W1=B4:X=B5:GOTO 8120
8510 PRINT"Mr. Spock reports, 'Sensors show no starbases"
8520 PRINT"in this quadrant.'":GOTO 1990
8580 REM find empty place in quadrant for things
8590 R1=FNR:R2=FNR:A$="   ":Z1=R1:Z2=R2:GOSUB 8830
8595 IF Z3=0 THEN 8590
8600 RETURN
8660 REM insert in string array for quadrant
8670 S8=INT(Z2-.5)*3+INT(Z1-.5)*24+1
8675 IF LEN(A$)<>3 THEN PRINT"error":STOP
8680 IF S8=1 THEN Q$=A$+RIGHT$(Q$,189):RETURN
8690 IF S8=190 THEN Q$=LEFT$(Q$,189)+A$:RETURN
8700 Q$=LEFT$(Q$,S8-1)+A$+RIGHT$(Q$,190-S8):RETURN
8780 REM prints device name
8790 ON R1 GOTO 8792,8794,8796,8798,8800,8802,8804,8806
8792 G2$="WARP engines":RETURN
8794 G2$="Short range sensors":RETURN
8796 G2$="Long range sensors":RETURN
8798 G2$="Phaser control":RETURN
8800 G2$="Photon tubes":RETURN
8802 G2$="Damage control":RETURN
8804 G2$="Shield control":RETURN
8806 G2$="Library-computer":RETURN
8820 REM string comparison in quadrant array
8830 Z1=INT(Z1+.5):Z2=INT(Z2+.5)
8840 S8=(Z2-1)*3+(Z1-1)*24+1:Z3=0
8890 IF MID$(Q$,S8,3)<>A$ THEN RETURN
8900 Z3=1:RETURN
9010 REM quadrant name in g2$ from z4,z5=q1,q2
9020 REM call with g5=1 to get region name only
9030 IF Z5<=4 THEN ON Z4 GOTO 9040,9050,9060,9070,9080,9090,9100,9110
9035 GOTO 9120
9040 G2$="Antares":GOTO 9210
9050 G2$="Rigel":GOTO 9210
9060 G2$="Procyon":GOTO 9210
9070 G2$="Vega":GOTO 9210
9080 G2$="Canopus":GOTO 9210
9090 G2$="Altair":GOTO 9210
9100 G2$="Sagittarius":GOTO 9210
9110 G2$="Polux":GOTO 9210
9120 ON Z4 GOTO 9130,9140,9150,9160,9170,9180,9190,9200
9130 G2$="Sirius":GOTO 9210
9140 G2$="Deneb":GOTO 9210
9150 G2$="Capella":GOTO 9210
9160 G2$="Betelgeuse":GOTO 9210
9170 G2$="Aldebaran":GOTO 9210
9180 G2$="Regulus":GOTO 9210
9190 G2$="Arcturus":GOTO 9210
9200 G2$="Spica"
9210 IF G5<>1 THEN ON Z5 GOTO 9230,9240,9250,9260,9230,9240,9250,9260
9220 RETURN
9230 G2$=G2$+" I":RETURN
9240 G2$=G2$+" II":RETURN
9250 G2$=G2$+" III":RETURN
9260 G2$=G2$+" IV":RETURN
9280 A$="[#]":GOSUB 9300
9290 PRINT CHR$(27)+"=1 ":RETURN
9300 PRINT CHR$(27)+"="+CHR$(32+2*X3)+CHR$(29+4*Y3)+A$
9305 IF KEEP THEN RETURN
9310 FOR I=1 TO 150:NEXT
9315 J=LEN(A$):A$="":FOR I=1 TO J:A$=A$+" ":NEXT
9320 PRINT CHR$(27)+"="+CHR$(32+2*X3)+CHR$(29+4*Y3)+A$
9340 RETURN
9400 LOGF=(LOGF+1) MOD 20
9410 IF LOGS=LOGF THEN LOGS=(LOGS+1) MOD 20
9420 TLOG(LOGF)=T:RETURN
9440 J=LOGF-LOGS+1:IF LOGS>LOGF THEN J=20
9450 PRINT CHR$(26)+"Most recent";J;"entries in ship's log:"
9460 'X$=CHR$(27)+"l":X0$=CHR$(27)+"m" <-UNDERLINE ON/OFF
9470 PRINT:PRINT "Stardate","Log Entry"
9475 PRINT"--------","---------"
9480 I=LOGS
9490 PRINT USING " ####.#  &";TLOG(I);SLOG$(I)
9500 I=(I+1) MOD 20
9510 IF LOGS<=LOGF AND I<=LOGF THEN 9490
9520 IF LOGS>LOGF AND I<>LOGS THEN 9490
9525 PRINT
9530 IF FINI THEN RETURN ELSE 1990