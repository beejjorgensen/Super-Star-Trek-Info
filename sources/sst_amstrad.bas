REM From https://www.retromagazine.net/super-star-trek-amstrad-cpc-locomotive-basic/

10 rem super startrek - may 16,1978 - requires 24k memory (at least)
30 rem
40 rem ****        **** star trek ****      ****
50 rem **** simulation of a mission of the starship enterprise,
60 rem **** as seen on the star trek tv show.
70 rem **** original program by mike mayfield, modified version
80 rem **** published in dec's "101 basic games", by dave ahl.
90 rem **** modif ications to the latter (plus debugging) by bob
100 rem *** leedom - april & december 1974,
110 rem *** with a little help from his friends . . .
120 rem *** comments, ephitets, and suggestions solicited --
130 rem *** send to: r.c. leedom
140 rem ***          westinghose defense & electronics systems cnir
150 rem ***          box 746, m.s. 338
160 rem ***          baltimore, md 21203
170 rem ***
180 rem *** converted to microsoft 8 k basic 3/16/78 by john borders
190 rem *** line numbers from version trek7 of 1/12/75 preserved as
191 rem *** much as possible while using multiple statements per line
195 rem *** converted to Amstrad CPC (40 columns)  
200 rem *** by Francesco Fiorentini on July 2022
201 gosub 10000
205 cls:border 0: ink 0,0: ink 1,26
215 print  ">>> the uss enterprise --- ncc-1701 <<<"
218 print
221 print  "                    ,------*------,"
222 print  "    ,-------------   '---  ------'"
223 print  "     '-------- --'      / /"
224 print  "         ,---' '-------/ /--,"
225 print  "          '----------------'"
235 print
270 z$="                          "
280 if fl=1 then goto  370
330 dim g(8,8),c(9,2),k(3,3),n(3),z(8,8),d(8):fl=1
370 t=int(rnd(1)*20+20)*100:t0=t:t9=25+int(rnd(1)*10):d0=0:e=3000:e0=e
440 p=10:p0=p:s9=200:s=0:b9=2:k9=0:x$="":x0$=" is "
470 def fnd(d)=sqr((k(i,1)-s1)^2+(k(i,2)-s2)^2)
475 def fnr(r)=int(rnd(r)*7.98+1.01)
480 rem initialize enterprize's position
490 q1=fnr(1):q2=fnr(1):s1=fnr(1):s2=fnr(1)
530 for i=1 to 9:c(i,1)=0:c(i,2)=0:next i
540 c(3,1)=-1:c(2,1)=-1:c(4,1)=-1:c(4,2)=-1:c(5,2)=-1:c(6,2)=-1
600 c(1,2)=1:c(2,2)=1:c(6,1)=1:c(7,1)=1:c(8,1)=1:c(8,2)=1:c(9,2)=1
670 for i=1 to 8:d(i)=0:next i
710 a1$="navsrslrsphatorshedamcomxxx"
810 rem setup what exhists in galaxy . . .
815 rem k3= # klingons  b3= # starbases  s3 = # stars
820 for i=1 to 8:for j=1 to 8:k3=0:z(i,j)=0:r1=rnd(1)
850 if r1>.98 then k3=3:k9=k9+3:goto 980
860 if r1>.95 then k3=2:k9=k9+2:goto 980
870 if r1>.80 then k3=1:k9=k9+1
980 b3=0:if rnd(1)>.96 then b3=1:b9=b9+1
1040 g(i,j)=k3*100+b3*10+fnr(1):next j:next i:if k9>t9 then t9=k9+1
1100 if b9<>0 then 1200
1150 if g(q1,q2)<200 then g(q1,q2)=g(q1,q2)+120:k9=k9+1
1160 b9=1:g(q1,q2)=g(q1,q2)+10:q1=fnr(1):q2=fnr(1)
1200 k7=k9:if b9<>1 then x$="s":x0$=" are "
1230 print "your orders are as follows:"
1235 print "--------------------------"
1240 print "destroy the";k9;"klingon warships which"
1250 print "invaded the galaxy before they attack"
1260 print "federation headquarters"
1261 print "on stardate";t0+t9;"."
1262 print "this gives you";t9;"days."
1270 print "there";x0$;b9;"starbase";x$;" in the galaxy"
1275 print "for resupplying your ship."
1280 print :input "are you ready to accept command";gg$
1300 i=rnd(1): if  inp(1)=13  then  1300
1310 rem here any time new quadrant entered
1320 z4=q1:z5=q2:k3=0:b3=0:s3=0:g5=0:d4=.5*rnd(1):z(q1,q2)=g(q1,q2)
1390 if q1<1 or q1>8 or q2<1 or q2>8 then 1600
1430 gosub  9030:print :if t0<>t then 1490
1460 print "your mission begins with starship"
1470 print "in galactic quadrant,'";g2$;"'.":goto  1500
1490 print "now entering ";g2$;" quadrant . . ."
1500 print :k3=int(g(q1,q2)*.01):b3=int(g(q1,q2)*.1)-10*k3
1540 s3=g(q1,q2)-100*k3-10*b3:if k3=0 then 1590
1560 print "combat area      condition red":if s>200 then 1590
1580 print "   shields dangerously low"
1590 for i=1 to 3:k(i,1)=0:k(i,2)=0:next i
1600 for i=1 to 3:k(i,3)=0:next i:q$=z$+z$+z$+z$+z$+z$+z$+left$(z$,17)
1660 rem position enterprise in quadrant,  then  place "k3" klingons, &
1670 rem "b3" starbases, & "s3" stars elsewhere.
1680 a$="<*>":z1=s1:z2=s2:gosub 8670:if k3<1 then 1820
1720 for i=1 to k3:gosub 8590:a$="+k+":z1=r1:z2=r2
1780 gosub 8670:k(i,1)=r1:k(i,2)=r2:k(i,3)=s9*(0.5+rnd(1)):next i
1820 if b3<1 then 1910
1880 gosub 8590:a$=">!<":z1=r1:b4=r1:z2=r2:b5=r2:gosub 8670
1910 for i=1 to s3:gosub 8590:a$=" * ":z1=r1:z2=r2:gosub 8670:next i
1980 gosub 6430
1990 if s+e>10 then if e>10 or d(7)=0 then 2060
2020 print :print "** fatal error ** you've just stranded"
2030 print "your ship in space and you have"
2035 print "insufficient maneuvering energy,"
2040 print "and shield control":print "is presently incapable of cross"
2050 print "-circuiting to engine room!!":goto 6220
2060 input "->command";a$
2080 for i=1 to 9:if left$(a$,3)<>mid$(a1$,3*i-2,3) then 2160
2140 on i goto 2300,1980,4000,4260,4700,5530,5690,7290,6270
2160 next i:print "enter one of the following:"
2180 print "  nav  (to set course)"
2190 print "  srs  (for short range sensor scan)"
2200 print "  lrs  (for long range sensor scan)"
2210 print "  pha  (to fire phasers)"
2220 print "  tor  (to fire photon torpedoes)"
2230 print "  she  (to raise or lower shields)"
2240 print "  dam  (for damage control reports)"
2250 print "  com  (to call on library-computer)"
2260 print "  xxx  (to resign your command)":print :goto  1990
2290 rem course control begins here
2300 input "course (0-9)";c1:if c1=9 then c1=1
2310 if c1>=1 and c1<9 then 2350
2330 print "lt. sulu reports,"
2340 print "'incorrect course data, sir!'":goto 1990
2350 x$="8":if d(1)<0 then x$="0.2"
2360 print "warp factor (0-";x$;")";:input w1:if d(1)<0 and w1>.2 then 2470
2380 if w1>0 and w1<=8 then 2490
2390 if w1=0 then 1990
2420 print "chief engineer scott reports 'the";
2430 print "engines won't take warp ";w1;"!'":goto 1990
2470 print "warp engines are damaged."
2480 print "maxium speed = warp 0.2":goto 1990
2490 n=int(w1*8+.5):if e-n>=0 then 2590
2500 print "engineering reports:"
2510 print "'insufficient energy available for"
2520 print "maneuvering at warp";w1;"!'"
2530 if s<n-e or d(7)<0 then 1990
2550 print "deflector control room acknowledges"
2560 print  s;"units of energy presently "
2565 print "deployed to shields."
2570 goto 1990
2580 rem klingons move/fire on moving starship . . .
2590 for i=1 to k3:if k(i,3)=0 then 2700
2610 a$="   ":z1=k(i,1):z2=k(i,2):gosub 8670:gosub 8590
2660 k(i,1)=z1:k(i,2)=z2:a$="+k+":gosub 8670
2700 next i:gosub 6000:d1=0:d6=w1:if w1>=1 then d6=1
2770 for i=1 to 8:if d(i)>=0 then 2880
2790 d(i)=d(i)+d6:if d(i)>-.1 and d(i)<0 then d(i)=-.1:goto 2880
2800 if d(i)<0 then 2880
2810 if d1<>1 then d1=1:print "damage control report:";print
2840 print tab(8);:r1=i:gosub 8790:print g2$;" repair completed."
2880 next i:if rnd(1)>.2 then 3070
2910 r1=fnr(1):if rnd(1)>=.6 then 3000
2930 d(r1)=d(r1)-(rnd(1)*5+1):print "damage control report:"
2960 gosub 8790:print g2$;" damaged":print :goto 3070
3000 d(r1)=d(r1)+rnd(1)*3+1:print "damage control report: "
3030 gosub 8790:print g2$;" state of repair improved":print
3060 rem begin moving starship
3070 a$="   ":z1=int(s1):z2=int(s2):gosub 8670
3110 x1=c(c1,1)+(c(c1+1,1)-c(c1,1))*(c1-int(c1)):x=s1:y=s2
3140 x2=c(c1,2)+(c(c1+1,2)-c(c1,2))*(c1-int(c1)):q4=q1:q5=q2
3170 for i=1 to n:s1=s1+x1:s2=s2+x2:if s1<1 or s1>=9 or s2<1 or s2>=9 then 3500
3240 s8=int(s1)*24+int(s2)*3-26:if mid$(q$,s8,2)="  " then 3360
3320 s1=int(s1-x1):s2=int(s2-x2):print "warp engines shut down at "
3350 print "sector";s1;",";s2;"due to bad navagation":goto 3370
3360 next i:s1=int(s1):s2=int(s2)
3370 a$="<*>":z1=int(s1):z2=int(s2):gosub 8670:gosub 3910:t8=1
3430 if w1<1 then t8=.1*int(10*w1)
3450 t=t+t8:if t>t0+t9 then 6220
3470 rem see if  docked,  then  get command
3480 goto 1980
3490 rem exceeded quadrant limits
3500 x=8*q1+x+n*x1:y=8*q2+y+n*x2:q1=int(x/8):q2=int(y/8):s1=int(x-q1*8)
3550 s2=int(y-q2*8):if s1=0 then q1=q1-1:s1=8
3590 if s2=0 then q2=q2-1:s2=8
3620 x5=0:if q1<1 then x5=1:q1=1:s1=1
3670 if q1>8 then x5=1:q1=8:s1=8
3710 if q2<1 then x5=1:q2=1:s2=1
3750 if q2>8 then x5=1:q2=8:s2=8
3790 if x5=0 then 3860
3800 print "lt. uhura reports message from"
3810 print "starfleet command: 'permission to"
3820 print "attempt crossing of galactic perimeter"
3825 print "is hereby *denied*. shut down your"
3828 print "engines.'"
3830 print "chief engineer scott reports 'warp"
3835 print "engines shut down at sector";s1;",";s2
3840 print "of quadrant";q1;",";q2;".'"
3850 if t>t0+t9 then 6220
3860 if 8*q1+q2=8*q4+q5 then 3370
3870 t=t+1:gosub 3910:goto 1320
3900 rem maneuver energy s/r **
3910 e=e-n-10:if e>=0 then return
3930 print "shield control supplies energy to"
3935 print "complete the maneuver."
3940 s=s+e:e=0:if s<=0 then s=0
3980 return
3990 rem long range sensor scan code
4000 if d(3)<0 then print "long range sensors are inoperable":goto 1990
4030 print "long range scan for quadrant";q1;",";q2
4040 o1$="-------------------":print  o1$
4060 for i=q1-1 to q1+1:n(1)=-1:n(2)=-2:n(3)=-3:for j=q2-1 to q2+1
4120 if i>0 and i<9 and j>0 and j<9 then n(j-q2+2)=g(i,j):z(i,j)=g(i,j)
4180 next j:for l=1 to 3:print ": ";:if n(l)<0 then print "*** ";:goto 4230
4210 print right$(str$(n(l)+1000),3);" ";
4230 next l:print ":":print  o1$:next i:goto 1990
4250 rem phaser control code begins here
4260 if d(4)<0 then print "phasers inoperative":goto 1990
4265 if k3>0 then 4330
4270 print "science officer spock reports 'sensors"
4280 print "show no enemy ships in this quadrant'":goto 1990
4330 if d(8)<0 then print "computer failure hampers accuracy"
4350 print "phasers locked on target;  ";
4360 print "energy available =";e;"units"
4370 input "number of units to fire";x:if x<=0 then 1990
4400 if e-x<0 then 4360
4410 e=e-x:if d(7)<0 then x=x*rnd(1)
4450 h1=int(x/k3):for i=1 to 3:if k(i,3)<=0 then 4670
4480 h=int((h1/fnd(0))*(rnd(1)+2)):if h>.15*k(i,3) then 4530
4500 print "no damage to enemy at ";k(i,1);",";k(i,2):goto 4670
4530 k(i,3)=k(i,3)-h:print h;"unit hit on klingon at sector";k(i,1);",";
4550 print k(i,2):if k(i,3)<=0 then print "*** klingon destroyed ***":goto 4580
4560 print "   (sensors show";k(i,3);"units remaining)":goto 4670
4580 k3=k3-1:k9=k9-1:z1=k(i,1):z2=k(i,2):a$="   ":gosub 8670
4650 k(i,3)=0:g(q1,q2)=g(q1,q2)-100:z(q1,q2)=g(q1,q2):if k9<=0 then 6370
4670 next i:gosub 6000:goto 1990
4690 rem photon torpedo code begins here
4700 if p<=0 then print "all photon torpedoes expended":goto  1990
4730 if d(5)<0 then print "photon tubes are not operational":goto 1990
4760 input "photon torpedo course (1-9)";c1:if c1=9 then c1=1
4780 if c1>=1 and c1<9 then 4850
4790 print "ensign chekov reports, 'incorrect course data, sir!'"
4800 goto 1990
4850 x1=c(c1,1)+(c(c1+1,1)-c(c1,1))*(c1-int(c1)):e=e-2:p=p-1
4860 x2=c(c1,2)+(c(c1+1,2)-c(c1,2))*(c1-int(c1)):x=s1:y=s2
4910 print "torpedo track:"
4920 x=x+x1:y=y+x2:x3=int(x+.5):y3=int(y+.5)
4960 if x3<1 or x3>8 or y3<1 or y3>8 then 5490
5000 print "               ";x3;",";y3:a$="   ":z1=x:z2=y:gosub 8830
5050 if z3<>0 then 4920
5060 a$="+k+":z1=x:z2=y:gosub 8830:if z3=0 then 5210
5110 print "*** klingon destroyed ***":k3=k3-1:k9=k9-1:if k9<=0 then 6370
5150 for i=1 to 3:if x3=k(i,1) and y3=k(i,2) then 5190
5180 next i:i=3
5190 k(i,3)=0:goto 5430
5210 a$=" * ":z1=x:z2=y:gosub 8830:if z3=0 then 5280
5260 print "star at";x3;",";y3;"absorbed torpedo energy.":gosub 6000:goto 1990
5280 a$=">!<":z1=x:z2=y:gosub 8830:if z3=0 then 4760
5330 print "*** starbase destroyed ***":b3=b3-1:b9=b9-1
5360 if b9>0 or k9>t-t0-t9 then 5400
5370 print "that does it, captain!! you are hereby"
5380 print "relieved of command and sentenced to 99"
5385 print "stardates at hard labor on cygnus 12!!"
5390 goto  6270
5400 print "starfleet command reviewing your record"
5410 print "to consider court martial!":d0=0
5430 z1=x:z2=y:a$="   ":gosub 8670
5470 g(q1,q2)=k3*100+b3*10+s3:z(q1,q2)=g(q1,q2):gosub 6000:goto 1990
5490 print "torpedo missed":gosub 6000:goto 1990
5520 rem shield control
5530 if d(7)<0 then print "shield control inoperable":goto 1990
5560 print "energy available =";e+s;:input "number of units to shields";x
5580 if x<0 or s=x then print "<shields unchanged>":goto 1990
5590 if x<=e+s then 5630
5600 print "shield control reports 'this is not the"
5610 print "federation treasury'-shields unchanged":goto 1990
5630 e=e+s-x:s=x:print "deflector control room report:"
5660 print "'shields now at";int(s);"units"
5670 print "per your command.'":goto 1990
5680 rem damage control
5690 if d(6)>=0 then 5910
5700 print "damage control report not available":if d0=0 then 1990
5720 d3=0:for i=1 to 8:if d(i)<0 then d3=d3+.1
5760 next i:if d3=0 then 1990
5780 print :d3=d3+d4:if d3>=1 then d3=.9
5810 print "technicians standing by to effect"
5815 print "repairs to your ship; estimated"
5820 print "time to repair:";.01*int(100*d3);"stardates"
5840 input  "will you authorize the repair (y/n)";a$
5860 if a$<>"y" then  1990
5870 for i=1 to 8:if d(i)<0 then d(i)=0
5890 next i:t=t+d3+.1
5910 print :print "device             state of repair":for r1=1 to 8
5920 gosub 8790:print g2$;left$(z$,25-len(g2$));int(d(r1)*100)*.01
5950 next r1:print :if d0<>0 then 5720
5980 goto  1990
5990 rem klingons shooting
6000 if k3<=0 then return
6010 if d0<>0 then print "starbase shields protect the enterprise":return
6040 for i=1 to 3:if k(i,3)<=0 then 6200
6060 h=int((k(i,3)/fnd(1))*(2+rnd(1))):s=s-h:k(i,3)=k(i,3)/(3+rnd(0))
6080 print h;"unit hit on enterprise"
6085 print "from sector";k(i,1);",";k(i,2)
6090 if s<=0 then 6240
6100 print "<shields down to";s;"units>":if h<20 then 6200
6120 if rnd(1)>.6 or h/s<=.02 then 6200
6140 r1=fnr(1):d(r1)=d(r1)-h/s-.5*rnd(1):gosub 8790
6170 print "damage control reports ";g2$;" damaged"
6180 print "by the hit'"
6200 next i:return
6210 rem end of game
6220 print "it is stardate";t:goto  6270
6240 print :print "the enterprise has been destroyed."
6250 print "then federation will be conquered.":goto  6220
6270 print "there were";k9;"klingon battle cruisers"
6280 print "left at the end of your mission."
6290 print :print :if b9=0 then 6360
6310 print "the federation is in need of a new"
6320 print "starship commander for a similar"
6321 print "mission -- if  there is a volunteer,"
6330 input "let him step for ward and enter 'aye'";a$:if a$="aye" then 10
6360 end
6370 print "congratulation, captain! the last"
6380 print "klingon battle cruiser menacing the"
6390 print "federation has been destroyed.":print
6400 print "your efficiency rating is";1000*(k7/(t-t0))^2:goto 6290
6420 rem short range sensor scan & startup subroutine
6430 for i=s1-1 to s1+1:for j=s2-1 to s2+1
6450 if int(i+.5)<1 or int(i+.5)>8 or int(j+.5)<1 or int(j+.5)>8 then 6540
6490 a$=">!<":z1=i:z2=j:gosub 8830:if z3=1 then 6580
6540 next j:next i:d0=0:goto 6650
6580 d0=1:c$="docked":e=e0:p=p0
6620 print "shields dropped for  docking purposes":s=0:goto 6720
6650 if k3>0 then c$="*red*":goto 6720
6660 c$="green":if e<e0*.1 then c$="yellow"
6720 if d(2)>=0 then 6770
6730 print :print "*** short range sensors are out ***":print :return
6770 o1$="---------------------------------------":print  o1$:for i=1 to 8
6820 for j=(i-1)*24+1 to (i-1)*24+22 step 3:print " ";mid$(q$,j,3);:next j
6825 next i:print :print  o1$
6830 rem onigoto 6850,6900,6960,7020,7070,7120,7180,7240
6850 print "  stardate           ";int(t*10)*.1:rem goto 7260
6900 print "  condition           ";c$:rem goto 7260
6960 print "  quadrant           ";q1;",";q2:rem goto 7260
7020 print "  sector             ";s1;",";s2:rem goto 7260
7070 print "  photon torpedoes   ";int(p):rem goto 7260
7120 print "  total energy       ";int(e+s):rem goto 7260
7180 print "  shields            ";int(s):rem goto 7260
7240 print "  klingons remaining ";int(k9):print
7260 return: rem next i:print o1$:return
7280 rem library computer code
7290 if d(8)<0 then print "computer disabled":goto 1990
7320 input "computer active, awaiting command";a:if a<0 then 1990
7350 print :h8=1:on a+1 goto 7540,7900,8070,8500,8150,7400
7360 print "functions available on library-computer:"
7370 print "   0 = cumulative galactic record"
7372 print "   1 = status report"
7374 print "   2 = photon torpedo data"
7376 print "   3 = starbase nav data"
7378 print "   4 = direction/distance calculator"
7380 print "   5 = galaxy 'region name' map":print :goto 7320
7390 rem setup  to  change cum gal record  to  galaxy map
7400 h8=0:g5=1:print "          the galaxy":goto 7550
7530 rem cum galactic record
7540 rem input "do you want a hardcopy? is the tty on (y/n)";a$
7542 rem if a$="y" then poke1229,2:poke1237,3:null1
7543 print
7544 print " computer record of galaxy"
7546 print " quadrant:";q1;",";q2
7548 print
7550 print "     1   2   3   4   5   6   7   8"
7560 o1$="   ---------------------------------"
7570 print  o1$:for i=1 to 8:print i;:if h8=0 then 7740
7630 for j=1 to 8:print " ";:if z(i,j)=0 then print "***";:goto 7720
7700 print right$(str$(z(i,j)+1000),3);
7720 next j:goto 7850
7740 z4=i:z5=1:gosub 9030:j0=int(10-.5*len(g2$)):print tab(j0);g2$;
7800 z5=5:gosub  9030:j0=int(30-.5*len(g2$)):print tab(j0);g2$;
7850 print :print  o1$:next i:print :goto 1990
7890 rem status report
7900 print  ">>> status report <<<":x$="":if k9>1 then x$="s"
7940 print "klingon";x$;" left: ";k9
7960 print "mission to be completed in";.1*int((t0+t9-t)*10);"stardates"
7970 x$="s":if b9<2 then x$="":if b9<1 then 8010
7980 print "the federation is maintaining"
7981 print " ";b9;"starbase";x$;" in the galaxy"
7990 goto 5690
8010 print "your stupidity has left you alone on in"
8020 print "the galaxy. you have no starbases left!":goto 5690
8060 rem torpedo, base nav, d/d calculator
8070 if k3<=0 then 4270
8080 x$="":if k3>1 then x$="s"
8090 print "enterprise to klingon battle cruser";x$
8100 h8=0:for i=1 to 3:if k(i,3)<=0 then 8480
8110 w1=k(i,1):x=k(i,2)
8120 c1=s1:a=s2:goto 8220
8150 print "direction/distance calculator:"
8160 print "you are at quadrant ";q1;",";q2
8161 print "           sector   ";s1;",";s2
8170 print "please enter":input "  initial coordinates (x,y)";c1,a
8200 input "  final coordinates (x,y)";w1,x
8220 x=x-a:a=c1-w1:if x<0 then 8350
8250 if a<0 then 8410
8260 if x>0 then 8280
8270 if a=0 then c1=5:goto 8290
8280 c1=1
8290 if abs(a)<=abs(x) then 8330
8310 print "direction =";c1+(((abs(a)-abs(x))+abs(a))/abs(a)):goto 8460
8330 print "direction =";c1+(abs(a)/abs(x)):goto 8460
8350 if a>0 then c1=3:goto 8420
8360 if x<>0 then c1=5:goto 8290
8410 c1=7
8420 if abs(a)>=abs(x) then 8450
8430 print "direction =";c1+(((abs(x)-abs(a))+abs(x))/abs(x)):goto 8460
8450 print "direction =";c1+(abs(x)/abs(a))
8460 print "distance =";sqr(x^2+a^2):if h8=1 then 1990
8480 next i:goto 1990
8500 if b3<>0 then print "from enterprise to starbase:":w1=b4:x=b5:goto 8120
8510 print "mr. spock reports, 'sensors show no";
8520 print "starbases in this quadrant.'":goto 1990
8580 rem find empty place in quadrant (for  things)
8590 r1=fnr(1):r2=fnr(1):a$="   ":z1=r1:z2=r2:gosub 8830:if z3=0 then 8590
8600 return
8660 rem insert in string array for  quadrant
8670 s8=int(z2-.5)*3+int(z1-.5)*24+1
8675 if len(a$)<>3 then  print "error":stop
8680 if s8=1 then q$=a$+right$(q$,189):return
8690 if s8=190 then q$=left$(q$,189)+a$:return
8700 q$=left$(q$,s8-1)+a$+right$(q$,190-s8):return
8780 rem print s device name
8790 on r1 goto 8792,8794,8796,8798,8800,8802,8804,8806
8792 g2$="warp engines":return
8794 g2$="short range sensors":return
8796 g2$="long range sensors":return
8798 g2$="phaser control":return
8800 g2$="photon tubes":return
8802 g2$="damage control":return
8804 g2$="shield control":return
8806 g2$="library-computer":return
8820 rem string comparison in quadrant array
8830 z1=int(z1+.5):z2=int(z2+.5):s8=(z2-1)*3+(z1-1)*24+1:z3=0
8890 if mid$(q$,s8,3)<>a$ then return
8900 z3=1:return
9010 rem quadrant name in g2$ from z4,z5 (=q1,q2)
9020 rem call with g5=1 to get region name only
9030 if z5<=4 then  on z4 goto 9040,9050,9060,9070,9080,9090,9100,9110
9035 goto 9120
9040 g2$="antares":goto 9210
9050 g2$="rigel":goto 9210
9060 g2$="procyon":goto 9210
9070 g2$="vega":goto 9210
9080 g2$="canopus":goto 9210
9090 g2$="altair":goto 9210
9100 g2$="sagittarius":goto 9210
9110 g2$="pollux":goto 9210
9120 on z4 goto 9130,9140,9150,9160,9170,9180,9190,9200
9130 g2$="sirius":goto 9210
9140 g2$="deneb":goto 9210
9150 g2$="capella":goto 9210
9160 g2$="betelgeuse":goto 9210
9170 g2$="aldebaran":goto 9210
9180 g2$="regulus":goto 9210
9190 g2$="arcturus":goto 9210
9200 g2$="spica"
9210 if g5<>1  then  on z5 goto 9230,9240,9250,9260,9230,9240,9250,9260
9220 return
9230 g2$=g2$+" i":return
9240 g2$=g2$+" ii":return
9250 g2$=g2$+" iii":return
9260 g2$=g2$+" iv":return
10000 REM ****************************************************
10010 REM ****************************************************
10011 REM * Future Set on Amstrad CPC
10012 REM * original code by Pete White
10013 REM * for Popular Computing Weekly 7-13 August 1983
10014 REM *
10015 REM * Typed and corrected by
10016 REM * Francesco Fiorentini on June 2020
10017 REM * for RetroMagazine World July 2020
10018 REM *
10019 REM ****************************************************
10020 SYMBOL AFTER 32
10030 REM Upper case chars
10040 SYMBOL 65,126,66,66,126,98,98,98,0
10050 SYMBOL 66,126,66,66,126,98,98,126,0
10060 SYMBOL 67,126,64,64,96,96,96,126,0
10070 SYMBOL 68,254,66,66,98,98,98,254,0
10080 SYMBOL 69,126,64,64, 120,96,96,126,0
10090 SYMBOL 70,126,64,64,120,96,96,96,0
10100 SYMBOL 71,126,64,64,102,98,98,126,0
10110 SYMBOL 72,66,66,66,126,98,98,98,0
10120 SYMBOL 73,60,16,16,24,24,24,60,0
10130 SYMBOL 74,126,8,8,24,24,24,120,0
10140 SYMBOL 75,68,68,68, 120,100,100,100,0
10150 SYMBOL 76,64,64,64,96,96,96, 126,0
10160 SYMBOL 77,126,74,74,98,98,98,98,0
10170 SYMBOL 78,98,82,74,102,98,98,98,0
10180 SYMBOL 79,126,66,66,98,98,98,126,0
10190 SYMBOL 80,126,66,66,126,96,96,96,0
10200 SYMBOL 81,126,66,66,98,98,106,126,4
10210 SYMBOL 82,126,66,66,126,106,100,98,0
10220 SYMBOL 83,126,64,64,126,6,6,126,0
10230 SYMBOL 84,126,16,16,24,24,24,24,0
10240 SYMBOL 85,66,66,66,98,98,98,126,0
10250 SYMBOL 86,66,66,66,66,66,36,24,0
10260 SYMBOL 87,66,66,66,98,106,106,126,0
10270 SYMBOL 88,102,102,36,24,36,102,102,0
10280 SYMBOL 89,66,66,126,16,24,24,24,0
10290 SYMBOL 90,126,4,8,16,32,64,126,0
10295 REM Lower case chars
10300 SYMBOL 97,0,0,126,6,126,70,126,0
10310 SYMBOL 98,96,96,96,126,98,98,126,0
10320 SYMBOL 99,0,0,126,96,96,96,126,0
10330 SYMBOL 100,6,6,6,126,70,70,126,0
10340 SYMBOL 101,0,0,126,98,126,96,126,0
10350 SYMBOL 102,60,48,48,120,48,48,48,0
10360 SYMBOL 103,0,0,126,70,70,126,6,126
10370 SYMBOL 104,96,96,96,126,98,98,98,0
10380 SYMBOL 105,24,0,24,24,24,24,24,0
10390 SYMBOL 106,6,0,6,6,6,6,6,126
10400 SYMBOL 107,96,96,102,108,120,108, 102,0
10410 SYMBOL 108,24,24,24,24,24,24,24,0
10420 SYMBOL 109,0,0,126,90,90,66,66,0
10430 SYMBOL 110,0,0,108,114,98,98,98,0
10440 SYMBOL 111,0,0,126,102,102,102,126,0
10450 SYMBOL 112,0,0,126,98,98,126,96,96
10460 SYMBOL 113,8,0,126,70,70,126,6,6
10470 SYMBOL 114,0,0,108,114,96,96,96,0
10480 SYMBOL 115,0,0,126,96,126,6,126,0
10490 SYMBOL 116,24,62,24,24,24,24,30,0
10500 SYMBOL 117,0,0,102,102,102,102,126,0
10510 SYMBOL 118,0,0,102,102,102,60,24,0
10520 SYMBOL 119,0,0,66,66,90,90,126,0
10530 SYMBOL 120,0,0,198,104,16,104,198,0
10540 SYMBOL 121,0,0,102,102,102,126,6,126
10550 SYMBOL 122,0,0,126,12,24,48,126,0
10555 REM Numbers
10560 SYMBOL 48,126,102,110,118,102,102,126,0
10570 SYMBOL 49,24,56,24,24,24,24,126,0
10580 SYMBOL 50,126,2,2,126,96,96,126,0
10590 SYMBOL 51,126,2,2,30,6,6,126,0
10600 SYMBOL 52,96,96,96,96,104,126,8,8
10610 SYMBOL 53,126,64,126,6,6,6,126,0
10620 SYMBOL 54,126,64,64,126,98,98,126,0
10630 SYMBOL 55,126,2,4,62,16,32,64,0
10640 SYMBOL 56,126,66,66,126,66,66,126,0
10650 SYMBOL 57,126,66,66,126,6,6,6,0
10680 SYMBOL 95,0,255,0,0,0,0,0,0
10700 RETURN

REM Loader code

10 INK 0,0
11 INK 1,13
12 INK 2,12
13 INK 3,26
14 PEN 3: BORDER 0
15 CLS
20 LOAD "SST.SCR",&C000
22 LOCATE 1,2:PRINT" >>>        SUPER STAR TREK         <<<"
23 LOCATE 1,4:PRINT" >>> the USS ENTERPRISE -- NCC-1701 <<<"
24 LOCATE 10,21:PRINT"an AMSTRAD CPC port"
25 LOCATE 6,23:PRINT"by F.Fiorentini - July 2022"
50 FOR I=1 TO 5000
60 NEXT I
70 RUN "SST.BAS"
