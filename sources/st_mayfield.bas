1  REM ****  HP BASIC PROGRAM LIBRARY  ******************************
2  REM
3  REM       STTR1: STAR TREK
4  REM
5  REM       36243  REV B  --  10/73
6  REM
7  REM ****  CONTRIBUTED PROGRAM  ***********************************
100  REM *****************************************************************
110  REM ***                                                           ***
120  REM ***     STAR TREK: BY MIKE MAYFIELD, CENTERLINE ENGINEERING   ***
130  REM ***                                                           ***
140  REM ***        TOTAL INTERACTION GAME - ORIG. 20 OCT 1972
150  REM ***                                                           ***
160  REM *****************************************************************
170  GOSUB 5460
180  PRINT "                          STAR TREK "
190  PRINT "DO YOU WANT INSTRUCTIONS (THEY'RE LONG!)";
200  INPUT A$
210  IF A$ <> "YES" THEN 230
220  GOSUB 5820
230  REM *****  PROGRAM STARTS HERE *****
240  Z$="                                                                      "
250  GOSUB 5460
260  DIM G[8,8],C[9,2],K[3,3],N[3],Z[8,8]
270  DIM C$[6],D$[72],E$[24],A$[3],Q$[72],R$[72],S$[48]
280  DIM Z$[72]
290  T0=T=INT(RND(1)*20+20)*100
300  T9=30
310  D0=0
320  E0=E=3000
330  P0=P=10
340  S9=200
350  S=H8=0
360  DEF FND(D)=SQR((K[I,1]-S1)^2+(K[I,2]-S2)^2)
370  Q1=INT(RND(1)*8+1)
380  Q2=INT(RND(1)*8+1)
390  S1=INT(RND(1)*8+1)
400  S2=INT(RND(1)*8+1)
410  T7=TIM(0)+60*TIM(1)
420  C[2,1]=C[3,1]=C[4,1]=C[4,2]=C[5,2]=C[6,2]=-1
430  C[1,1]=C[3,2]=C[5,1]=C[7,2]=C[9,1]=0
440  C[1,2]=C[2,2]=C[6,1]=C[7,1]=C[8,1]=C[8,2]=C[9,2]=1
450  MAT D=ZER
460  D$="WARP ENGINESS.R. SENSORSL.R. SENSORSPHASER CNTRL"
470  D$[49]="PHOTON TUBESDAMAGE CNTRL"
480  E$="SHIELD CNTRLCOMPUTER"
490  B9=K9=0
500  FOR I=1 TO 8
510  FOR J=1 TO 8
520  R1=RND(1)
530  IF R1>.98 THEN 580
540  IF R1>.95 THEN 610
550  IF R1>.8 THEN 640
560  K3=0
570  GOTO 660
580  K3=3
590  K9=K9+3
600  GOTO 660
610  K3=2
620  K9=K9+2
630  GOTO 660
640  K3=1
650  K9=K9+1
660  R1=RND(1)
670  IF R1>.96 THEN 700
680  B3=0
690  GOTO 720
700  B3=1
710  B9=B9+1
720  S3=INT(RND(1)*8+1)
730  G[I,J]=K3*100+B3*10+S3
740  Z[I,J]=0
750  NEXT J
760  NEXT I
770  K7=K9
775  IF B9 <= 0 OR K9 <= 0 THEN 490
780  PRINT "YOU MUST DESTROY"K9;" KLINGONS IN"T9;" STARDATES WITH"B9;" STARBASES"
810  K3=B3=S3=0
820  IF Q1<1 OR Q1>8 OR Q2<1 OR Q2>8 THEN 920
830  X=G[Q1,Q2]*.01
840  K3=INT(X)
850  B3=INT((X-K3)*10)
860  S3=G[Q1,Q2]-INT(G[Q1,Q2]*.1)*10
870  IF K3=0 THEN 910
880  IF S>200 THEN 910
890  PRINT "COMBAT AREA      CONDITION RED"
900  PRINT "   SHIELDS DANGEROUSLY LOW"
910  MAT K=ZER
920  FOR I=1 TO 3
930  K[I,3]=0
940  NEXT I
950  Q$=Z$
960  R$=Z$
970  S$=Z$[1,48]
980  A$="<*>"
990  Z1=S1
1000  Z2=S2
1010  GOSUB 5510
1020  FOR I=1 TO K3
1030  GOSUB 5380
1040  A$="+++"
1050  Z1=R1
1060  Z2=R2
1070  GOSUB 5510
1080  K[I,1]=R1
1090  K[I,2]=R2
1100  K[I,3]=S9
1110  NEXT I
1120  FOR I=1 TO B3
1130  GOSUB 5380
1140  A$=">!<"
1150  Z1=R1
1160  Z2=R2
1170  GOSUB 5510
1180  NEXT I
1190  FOR I=1 TO S3
1200  GOSUB 5380
1210  A$=" * "
1220  Z1=R1
1230  Z2=R2
1240  GOSUB 5510
1250  NEXT I
1260  GOSUB 4120
1270  PRINT "COMMAND:";
1280  INPUT A
1290  GOTO A+1 OF 1410,1260,2330,2530,2800,3460,3560,4630
1300  PRINT
1310  PRINT "   0 = SET COURSE"
1320  PRINT "   1 = SHORT RANGE SENSOR SCAN"
1330  PRINT "   2 = LONG RANGE SENSOR SCAN"
1340  PRINT "   3 = FIRE PHASERS"
1350  PRINT "   4 = FIRE PHOTON TORPEDOES"
1360  PRINT "   5 = SHIELD CONTROL"
1370  PRINT "   6 = DAMAGE CONTROL REPORT"
1380  PRINT "   7 = CALL ON LIBRARY COMPUTER"
1390  PRINT
1400  GOTO 1270
1410  PRINT "COURSE (1-9):";
1420  INPUT C1
1430  IF C1=0 THEN 1270
1440  IF C1<1 OR C1 >= 9 THEN 1410
1450  PRINT "WARP FACTOR (0-8):";
1460  INPUT W1
1470  IF W1<0 OR W1>8 THEN 1410
1480  IF D[1] >= 0 OR W1 <= .2 THEN 1510
1490  PRINT "WARP ENGINES ARE DAMAGED, MAXIMUM SPEED = WARP .2"
1500  GOTO 1410
1510  IF K3 <= 0 THEN 1560
1520  GOSUB 3790
1530  IF K3 <= 0 THEN 1560
1540  IF S<0 THEN 4000
1550  GOTO 1610
1560  IF E>0 THEN 1610
1570  IF S<1 THEN 3920
1580  PRINT "YOU HAVE"E" UNITS OF ENERGY"
1590  PRINT "SUGGEST YOU GET SOME FROM YOUR SHIELDS WHICH HAVE"S" UNITS LEFT"
1600  GOTO 1270
1610  FOR I=1 TO 8
1620  IF D[I] >= 0 THEN 1640
1630  D[I]=D[I]+1
1640  NEXT I
1650  IF RND(1)>.2 THEN 1810
1660  R1=INT(RND(1)*8+1)
1670  IF RND(1) >= .5 THEN 1750
1680  D[R1]=D[R1]-(RND(1)*5+1)
1690  PRINT
1700  PRINT "DAMAGE CONTROL REPORT:";
1710  GOSUB 5610
1720  PRINT " DAMAGED"
1730  PRINT
1740  GOTO 1810
1750  D[R1]=D[R1]+(RND(1)*5+1)
1760  PRINT
1770  PRINT "DAMAGE CONTROL REPORT:";
1780  GOSUB 5610
1790  PRINT " STATE OF REPAIR IMPROVED"
1800  PRINT
1810  N=INT(W1*8)
1820  A$="   "
1830  Z1=S1
1840  Z2=S2
1850  GOSUB 5510
1870  X=S1
1880  Y=S2
1885  C2=INT(C1)
1890  X1=C[C2,1]+(C[C2+1,1]-C[C2,1])*(C1-C2)
1900  X2=C[C2,2]+(C[C2+1,2]-C[C2,2])*(C1-C2)
1910  FOR I=1 TO N
1920  S1=S1+X1
1930  S2=S2+X2
1940  IF S1<.5 OR S1 >= 8.5 OR S2<.5 OR S2 >= 8.5 THEN 2170
1950  A$="   "
1960  Z1=S1
1970  Z2=S2
1980  GOSUB 5680
1990  IF Z3 <> 0 THEN 2070
2030  PRINT  USING 5370;S1,S2
2040  S1=S1-X1
2050  S2=S2-X2
2060  GOTO 2080
2070  NEXT I
2080  A$="<*>"
2083  S1=INT(S1+.5)
2086  S2=INT(S2+.5)
2090  Z1=S1
2100  Z2=S2
2110  GOSUB 5510
2120  E=E-N+5
2130  IF W1<1 THEN 2150
2140  T=T+1
2150  IF T>T0+T9 THEN 3970
2160  GOTO 1260
2170  X=Q1*8+X+X1*N
2180  Y=Q2*8+Y+X2*N
2190  Q1=INT(X/8)
2200  Q2=INT(Y/8)
2210  S1=INT(X-Q1*8+.5)
2220  S2=INT(Y-Q2*8+.5)
2230  IF S1 <> 0 THEN 2260
2240  Q1=Q1-1
2250  S1=8
2260  IF S2 <> 0 THEN 2290
2270  Q2=Q2-1
2280  S2=8
2290  T=T+1
2300  E=E-N+5
2310  IF T>T0+T9 THEN 3970
2320  GOTO 810
2330  IF D[3] >= 0 THEN 2370
2340  PRINT "LONG RANGE SENSORS ARE INOPERABLE"
2350  IMAGE  "LONG RANGE SENSOR SCAN FOR QUADRANT",D,",",D
2360  GOTO 1270
2370  PRINT  USING 2350;Q1,Q2
2380  PRINT  USING 2520
2390  FOR I=Q1-1 TO Q1+1
2400  MAT N=ZER
2410  FOR J=Q2-1 TO Q2+1
2420  IF I<1 OR I>8 OR J<1 OR J>8 THEN 2460
2430  N[J-Q2+2]=G[I,J]
2440  IF D[7]<0 THEN 2460
2450  Z[I,J]=G[I,J]
2460  NEXT J
2470  PRINT  USING 2510;N[1],N[2],N[3]
2480  PRINT  USING 2520
2490  NEXT I
2500  GOTO 1270
2510  IMAGE  ": ",3(3D," :")
2520  IMAGE  "-----------------"
2530  IF K3 <= 0 THEN 3670
2540  IF D[4] >= 0 THEN 2570
2550  PRINT "PHASER CONTROL IS DISABLED"
2560  GOTO 1270
2570  IF D[7] >= 0 THEN 2590
2580  PRINT " COMPUTER FAILURE HAMPERS ACCURACY"
2590  PRINT "PHASERS LOCKED ON TARGET.  ENERGY AVAILABLE="E
2600  PRINT "NUMBER OF UNITS TO FIRE:";
2610  INPUT X
2620  IF X <= 0 THEN 1270
2630  IF E-X<0 THEN 2570
2640  E=E-X
2650  GOSUB 3790
2660  IF D[7] >= 0 THEN 2680
2670  X=X*RND(1)
2680  FOR I=1 TO 3
2690  IF K[I,3] <= 0 THEN 2770
2700  H=(X/K3/FND(0))*(2*RND(1))
2710  K[I,3]=K[I,3]-H
2720  PRINT  USING 2730;H,K[I,1],K[I,2],K[I,3]
2730  IMAGE  4D," UNIT HIT ON KLINGON AT SECTOR ",D,",",D,"   (",3D," LEFT)"
2740  IF K[I,3]>0 THEN 2770
2750  GOSUB 3690
2760  IF K9 <= 0 THEN 4040
2770  NEXT I
2780  IF E<0 THEN 4000
2790  GOTO 1270
2800  IF D[5] >= 0 THEN 2830
2810  PRINT "PHOTON TUBES ARE NOT OPERATIONAL"
2820  GOTO 1270
2830  IF P>0 THEN 2860
2840  PRINT "ALL PHOTON TORPEDOES EXPENDED"
2850  GOTO 1270
2860  PRINT "TORPEDO COURSE (1-9):";
2870  INPUT C1
2880  IF C1=0 THEN 1270
2890  IF C1<1 OR C1 >= 9 THEN 2860
2895  C2=INT(C1)
2900  X1=C[C2,1]+(C[C2+1,1]-C[C2,1])*(C1-C2)
2910  X2=C[C2,2]+(C[C2+1,2]-C[C2,2])*(C1-C2)
2920  X=S1
2930  Y=S2
2940  P=P-1
2950  PRINT "TORPEDO TRACK:"
2960  X=X+X1
2970  Y=Y+X2
2980  IF X<.5 OR X >= 8.5 OR Y<.5 OR Y >= 8.5 THEN 3420
2990  PRINT  USING 3000;X,Y
3000  IMAGE  15X,D,",",D
3010  A$="   "
3020  Z1=X
3030  Z2=Y
3040  GOSUB 5680
3050  IF Z3=0 THEN 3070
3060  GOTO 2960
3070  A$="+++"
3080  Z1=X
3090  Z2=Y
3100  GOSUB 5680
3110  IF Z3=0 THEN 3220
3120  PRINT "*** KLINGON DESTROYED ***"
3130  K3=K3-1
3140  K9=K9-1
3150  IF K9 <= 0 THEN 4040
3160  FOR I=1 TO 3
3170  IF INT(X+.5) <> K[I,1] THEN 3190
3180  IF INT(Y+.5)=K[I,2] THEN 3200
3190  NEXT I
3200  K[I,3]=0
3210  GOTO 3360
3220  A$=" * "
3230  Z1=X
3240  Z2=Y
3250  GOSUB 5680
3260  IF Z3=0 THEN 3290
3270  PRINT "YOU CAN'T DESTROY STARS SILLY"
3280  GOTO 3420
3290  A$=">!<"
3300  Z1=X
3310  Z2=Y
3320  GOSUB 5680
3330  IF Z3=0 THEN 2960
3340  PRINT "*** STAR BASE DESTROYED ***  .......CONGRATULATIONS"
3350  B3=B3-1
3360  A$="   "
3370  Z1=INT(X+.5)
3380  Z2=INT(Y+.5)
3390  GOSUB 5510
3400  G[Q1,Q2]=K3*100+B3*10+S3
3410  GOTO 3430
3420  PRINT "TORPEDO MISSED"
3430  GOSUB 3790
3440  IF E<0 THEN 4000
3450  GOTO 1270
3460  IF D[7] >= 0 THEN 3490
3470  PRINT "SHIELD CONTROL IS NON-OPERATIONAL"
3480  GOTO 1270
3490  PRINT "ENERGY AVAILABLE ="E+S"   NUMBER OF UNITS TO SHIELDS:";
3500  INPUT X
3510  IF X <= 0 THEN 1270
3520  IF E+S-X<0 THEN 3490
3530  E=E+S-X
3540  S=X
3550  GOTO 1270
3560  IF D[6] >= 0 THEN 3590
3570  PRINT "DAMAGE CONTROL REPORT IS NOT AVAILABLE"
3580  GOTO 1270
3590  PRINT
3600  PRINT "DEVICE        STATE OF REPAIR"
3610  FOR R1=1 TO 8
3620  GOSUB 5610
3630  PRINT "",D[R1]
3640  NEXT R1
3650  PRINT
3660  GOTO 1270
3670  PRINT "SHORT RANGE SENSORS REPORT NO KLINGONS IN THIS QUADRANT"
3680  GOTO 1270
3690  PRINT  USING 3700;K[I,1],K[I,2]
3700  IMAGE  "KLINGON AT SECTOR ",D,",",D," DESTROYED ****"
3710  K3=K3-1
3720  K9=K9-1
3730  A$="   "
3740  Z1=K[I,1]
3750  Z2=K[I,2]
3760  GOSUB 5510
3770  G[Q1,Q2]=K3*100+B3*10+S3
3780  RETURN
3790  IF C$ <> "DOCKED" THEN 3820
3800  PRINT "STAR BASE SHIELDS PROTECT THE ENTERPRISE"
3810  RETURN
3820  IF K3 <= 0 THEN 3910
3830  FOR I=1 TO 3
3840  IF K[I,3] <= 0 THEN 3900
3850  H=(K[I,3]/FND(0))*(2*RND(1))
3860  S=S-H
3870  PRINT  USING 3880;H,K[I,1],K[I,2],S
3880  IMAGE  4D," UNIT HIT ON ENTERPRISE AT SECTOR ",D,",",D,"   (",4D," LEFT)"
3890  IF S<0 THEN 4000
3900  NEXT I
3910  RETURN
3920  PRINT "THE ENTERPRISE IS DEAD IN SPACE.  IF YOU SURVIVE ALL IMPENDING"
3930  PRINT "ATTACK YOU WILL BE DEMOTED TO THE RANK OF PRIVATE"
3940  IF K3 <= 0 THEN 4020
3950  GOSUB 3790
3960  GOTO 3940
3970  PRINT
3980  PRINT "IT IS STARDATE"T
3990  GOTO 4020
4000  PRINT
4010  PRINT "THE ENTERPRISE HAS BEEN DESTROYED.  THE FEDERATION WILL BE CONQUERED"
4020  PRINT "THERE ARE STILL"K9" KLINGON BATTLE CRUISERS"
4030  GOTO 230
4040  PRINT
4050  PRINT "THE LAST KLINGON BATTLE CRUISER IN THE GALAXY HAS BEEN DESTROYED"
4060  PRINT "THE FEDERATION HAS BEEN SAVED !!!"
4070  PRINT
4080  PRINT "YOUR EFFICIENCY RATING ="((K7/(T-T0))*1000)
4090  T1=TIM(0)+TIM(1)*60
4100  PRINT "YOUR ACTUAL TIME OF MISSION ="INT((((T1-T7)*.4)-T7)*100)" MINUTES"
4110  GOTO 230
4120  FOR I=S1-1 TO S1+1
4130  FOR J=S2-1 TO S2+1
4140  IF I<1 OR I>8 OR J<1 OR J>8 THEN 4200
4150  A$=">!<"
4160  Z1=I
4170  Z2=J
4180  GOSUB 5680
4190  IF Z3=1 THEN 4240
4200  NEXT J
4210  NEXT I
4220  D0=0
4230  GOTO 4310
4240  D0=1
4250  C$="DOCKED"
4260  E=3000
4270  P=10
4280  PRINT "SHIELDS DROPPED FOR DOCKING PURPOSES"
4290  S=0
4300  GOTO 4380
4310  IF K3>0 THEN 4350
4320  IF E<E0*.1 THEN 4370
4330  C$="GREEN"
4340  GOTO 4380
4350  C$="RED"
4360  GOTO 4380
4370  C$="YELLOW"
4380  IF D[2] >= 0 THEN 4430
4390  PRINT
4400  PRINT "*** SHORT RANGE SENSORS ARE OUT ***"
4410  PRINT
4420  GOTO 4530
4430  PRINT  USING 4540
4440  PRINT  USING 4550;Q$[1,3],Q$[4,6],Q$[7,9],Q$[10,12],Q$[13,15],Q$[16,18],Q$[19,21],Q$[22,24]
4450  PRINT  USING 4560;Q$[25,27],Q$[28,30],Q$[31,33],Q$[34,36],Q$[37,39],Q$[40,42],Q$[43,45],Q$[46,48],T
4460  PRINT  USING 4570;Q$[49,51],Q$[52,54],Q$[55,57],Q$[58,60],Q$[61,63],Q$[64,66],Q$[67,69],Q$[70,72],C$
4470  PRINT  USING 4580;R$[1,3],R$[4,6],R$[7,9],R$[10,12],R$[13,15],R$[16,18],R$[19,21],R$[22,24],Q1,Q2
4480  PRINT  USING 4590;R$[25,27],R$[28,30],R$[31,33],R$[34,36],R$[37,39],R$[40,42],R$[43,45],R$[46,48],S1,S2
4490  PRINT  USING 4600;R$[49,51],R$[52,54],R$[55,57],R$[58,60],R$[61,63],R$[64,66],R$[67,69],R$[70,72],E
4500  PRINT  USING 4610;S$[1,3],S$[4,6],S$[7,9],S$[10,12],S$[13,15],S$[16,18],S$[19,21],S$[22,24],P
4510  PRINT  USING 4620;S$[25,27],S$[28,30],S$[31,33],S$[34,36],S$[37,39],S$[40,42],S$[43,45],S$[46,48],S
4520  PRINT  USING 4540
4530  RETURN 
4540  IMAGE  "---------------------------------"
4550  IMAGE  8(X,3A)
4560  IMAGE  8(X,3A),8X,"STARDATE",8X,5D
4570  IMAGE  8(X,3A),8X,"CONDITION",8X,6A
4580  IMAGE  8(X,3A),8X,"QUADRANT",9X,D,",",D
4590  IMAGE  8(X,3A),8X,"SECTOR",11X,D,",",D
4600  IMAGE  8(X,3A),8X,"ENERGY",9X,6D
4610  IMAGE  8(X,3A),8X,"PHOTON TORPEDOES",3D
4620  IMAGE  8(X,3A),8X,"SHIELDS",8X,6D
4630  IF D[8] >= 0 THEN 4660
4640  PRINT "COMPUTER DISABLED"
4650  GOTO 1270
4660  PRINT "COMPUTER ACTIVE AND AWAITING COMMAND";
4670  INPUT A
4680  GOTO A+1 OF 4740,4830,4880
4690  PRINT "FUNCTIONS AVAILABLE FROM COMPUTER"
4700  PRINT "   0 = CUMULATIVE GALACTIC RECORD"
4710  PRINT "   1 = STATUS REPORT"
4720  PRINT "   2 = PHOTON TORPEDO DATA"
4730  GOTO 4660
4740  PRINT  USING 4750;Q1,Q2
4750  IMAGE  "COMPUTER RECORD OF GALAXY FOR QUADRANT ",D,",",D
4760  PRINT  USING 5330
4770  PRINT  USING 5360
4780  FOR I=1 TO 8
4790  PRINT  USING 5350;I,Z[I,1],Z[I,2],Z[I,3],Z[I,4],Z[I,5],Z[I,6],Z[I,7],Z[I,8]
4800  PRINT  USING 5360
4810  NEXT I
4820  GOTO 1270
4830  PRINT "\012   STATUS REPORT\012"
4840  PRINT "NUMBER OF KLINGONS LEFT ="K9
4850  PRINT "NUMBER OF STARDATES LEFT ="(T0+T9)-T
4860  PRINT "NUMBER OF STARBASES LEFT ="B9
4870  GOTO 3560
4880  PRINT 
4890  H8=0
4900  FOR I=1 TO 3
4910  IF K[I,3] <= 0 THEN 5260
4920  C1=S1
4930  A=S2
4940  W1=K[I,1]
4950  X=K[I,2]
4960  GOTO 5010
4970  PRINT  USING 4980;Q1,Q2,S1,S2
4980  IMAGE  "YOU ARE AT QUADRANT ( ",D,",",D," )  SECTOR ( ",D,",",D," )"
4990  PRINT "SHIP'S & TARGET'S COORDINATES ARE";
5000  INPUT C1,A,W1,X
5010  X=X-A
5020  A=C1-W1
5030  IF X<0 THEN 5130
5040  IF A<0 THEN 5190
5050  IF X>0 THEN 5070
5060  IF A=0 THEN 5150
5070  C1=1
5080  IF ABS(A) <= ABS(X) THEN 5110
5090  PRINT "DIRECTION ="C1+(((ABS(A)-ABS(X))+ABS(A))/ABS(A))
5100  GOTO 5240
5110  PRINT "DIRECTION ="C1+(ABS(A)/ABS(X))
5120  GOTO 5240
5130  IF A>0 THEN 5170
5140  IF X=0 THEN 5190
5150  C1=5
5160  GOTO 5080
5170  C1=3
5180  GOTO 5200
5190  C1=7
5200  IF ABS(A) >= ABS(X) THEN 5230
5210  PRINT "DIRECTION ="C1+(((ABS(X)-ABS(A))+ABS(X))/ABS(X))
5220  GOTO 5240
5230  PRINT "DIRECTION ="C1+(ABS(X)/ABS(A))
5240  PRINT "DISTANCE ="(SQR(X^2+A^2))
5250  IF H8=1 THEN 5320
5260  NEXT I
5270  H8=0
5280  PRINT "DO YOU WANT TO USE THE CALCULATOR";
5290  INPUT A$
5300  IF A$="YES" THEN 4970
5310  IF A$ <> "NO" THEN 5280
5320  GOTO 1270
5330  IMAGE  "     1     2     3     4     5     6     7     8"
5340  IMAGE  "---------------------------------------------------"
5350  IMAGE  D,8(3X,3D)
5360  IMAGE  "   ----- ----- ----- ----- ----- ----- ----- -----"
5370  IMAGE  " WARP ENGINES SHUTDOWN AT SECTOR ",D,",",D," DUE TO BAD NAVIGATION"
5380  R1=INT(RND(1)*8+1)
5390  R2=INT(RND(1)*8+1)
5400  A$="   "
5410  Z1=R1
5420  Z2=R2
5430  GOSUB 5680
5440  IF Z3=0 THEN 5380
5450  RETURN
5460  FOR I=1 TO 11
5470  PRINT
5480  NEXT I
5490  PRINT
5500  RETURN
5510  REM ******  INSERTION IN STRING ARRAY FOR QUADRANT ******
5520  S8=Z1*24+Z2*3-26
5530  IF S8>72 THEN 5560
5540  Q$[S8,S8+2]=A$
5550  GOTO 5600
5560  IF S8>144 THEN 5590
5570  R$[S8-72,S8-70]=A$
5580  GOTO 5600
5590  S$[S8-144,S8-142]=A$
5600  RETURN
5610  REM ****  PRINTS DEVICE NAME FROM ARRAY *****
5620  S8=R1*12-11
5630  IF S8>72 THEN 5660
5640  PRINT D$[S8,S8+11];
5650  GOTO 5670
5660  PRINT E$[S8-72,S8-61];
5670  RETURN
5680  REM *******  STRING COMPARISON IN QUADRANT ARRAY **********
5683  Z1=INT(Z1+.5)
5686  Z2=INT(Z2+.5)
5690  S8=Z1*24+Z2*3-26
5700  Z3=0
5710  IF S8>72 THEN 5750
5720  IF Q$[S8,S8+2] <> A$ THEN 5810
5730  Z3=1
5740  GOTO 5810
5750  IF S8>144 THEN 5790
5760  IF R$[S8-72,S8-70] <> A$ THEN 5810
5770  Z3=1
5780  GOTO 5810
5790  IF S$[S8-144,S8-142] <> A$ THEN 5810
5800  Z3=1
5810  RETURN
5820  PRINT "     INSTRUCTIONS:"
5830  PRINT "<*> = ENTERPRISE"
5840  PRINT "+++ = KLINGON"
5850  PRINT ">!< = STARBASE"
5860  PRINT " *  = STAR"
5870  PRINT "COMMAND 0 = WARP ENGINE CONTROL"
5880  PRINT "  'COURSE' IS IN A CIRCULAR NUMERICAL          4  3  2"
5890  PRINT "  VECTOR ARRANGEMENT AS SHOWN.                  \ ^ /"
5900  PRINT "  INTERGER AND REAL VALUES MAY BE                \^/"
5910  PRINT "  USED.  THEREFORE COURSE 1.5 IS              5 ----- 1"
5920  PRINT "  HALF WAY BETWEEN 1 AND 2.                      /^\"
5930  PRINT "                                                / ^ \"
5940  PRINT "  A VECTOR OF 9 IS UNDEFINED, BUT              6  7  8"
5950  PRINT "  VALUES MAY APPROACH 9."
5960  PRINT "                                               COURSE"
5970  PRINT "  ONE 'WARP FACTOR' IS THE SIZE OF"
5980  PRINT "  ONE QUADRANT.  THEREFORE TO GET"
5990  PRINT "  FROM QUADRANT 6,5 TO 5,5 YOU WOULD"
6000  PRINT "  USE COURSE 3, WARP FACTOR 1"
6010  PRINT "COMMAND 1 = SHORT RANGE SENSOR SCAN"
6020  PRINT "  PRINTS THE QUADRANT YOU ARE CURRENTLY IN, INCLUDING"
6030  PRINT "  STARS, KLINGONS, STARBASES, AND THE ENTERPRISE; ALONG"
6040  PRINT "  WITH OTHER PERTINATE INFORMATION."
6050  PRINT "COMMAND 2 = LONG RANGE SENSOR SCAN"
6060  PRINT "  SHOWS CONDITIONS IN SPACE FOR ONE QUADRANT ON EACH SIDE"
6070  PRINT "  OF THE ENTERPRISE IN THE MIDDLE OF THE SCAN.  THE SCAN"
6080  PRINT "  IS CODED IN THE FORM XXX, WHERE THE UNITS DIGIT IS THE"
6090  PRINT "  NUMBER OF STARS, THE TENS DIGIT IS THE NUMBER OF STAR-"
6100  PRINT "  BASES, THE HUNDREDS DIGIT IS THE NUMBER OF KLINGONS."
6110  PRINT "COMMAND 3 = PHASER CONTROL"
6120  PRINT "  ALLOWS YOU TO DESTROY THE KLINGONS BY HITTING HIM WITH"
6130  PRINT "  SUITABLY LARGE NUMBERS OF ENERGY UNITS TO DEPLETE HIS "
6140  PRINT "  SHIELD POWER.  KEEP IN MIND THAT WHEN YOU SHOOT AT"
6150  PRINT "  HIM, HE GONNA DO IT TO YOU TOO."
6160  PRINT "COMMAND 4 = PHOTON TORPEDO CONTROL"
6170  PRINT "  COURSE IS THE SAME AS USED IN WARP ENGINE CONTROL"
6180  PRINT "  IF YOU HIT THE KLINGON, HE IS DESTROYED AND CANNOT FIRE"
6190  PRINT "  BACK AT YOU.  IF YOU MISS, HE WILL SHOOT HIS PHASERS AT"
6200  PRINT "  YOU."
6210  PRINT "   NOTE: THE LIBRARY COMPUTER (COMMAND 7) HAS AN OPTION"
6220  PRINT "   TO COMPUTE TORPEDO TRAJECTORY FOR YOU (OPTION 2)."
6230  PRINT "COMMAND 5 = SHIELD CONTROL"
6240  PRINT "  DEFINES NUMBER OF ENERGY UNITS TO BE ASSIGNED TO SHIELDS"
6250  PRINT "  ENERGY IS TAKEN FROM TOTAL SHIP'S ENERGY."
6260  PRINT "COMMAND 6 = DAMAGE CONTROL REPORT"
6270  PRINT "  GIVES STATE OF REPAIRS OF ALL DEVICES.  A STATE OF REPAIR"
6280  PRINT "  LESS THAN ZERO SHOWS THAT THAT DEVICE IS TEMPORARALY"
6290  PRINT "  DAMAGED."
6300  PRINT "COMMAND 7 = LIBRARY COMPUTER"
6310  PRINT "  THE LIBRARY COMPUTER CONTAINS THREE OPTIONS:"
6320  PRINT "    OPTION 0 = CUMULATIVE GALACTIC RECORD"
6330  PRINT "     SHOWS COMPUTER MEMORY OF THE RESULTS OF ALL PREVIOUS"
6340  PRINT "     LONG RANGE SENSOR SCANS"
6350  PRINT "    OPTION 1 = STATUS REPORT"
6360  PRINT "     SHOWS NUMBER OF KLINGONS, STARDATES AND STARBASES"
6370  PRINT "     LEFT."
6380  PRINT "    OPTION 2 = PHOTON TORPEDO DATA"
6390  PRINT "     GIVES TRAJECTORY AND DISTANCE BETWEEN THE ENTERPRISE"
6400  PRINT "     AND ALL KLINGONS IN YOUR QUADRANT"
6410  RETURN
6420  END
