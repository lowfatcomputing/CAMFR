*DECK D9B0MP
      SUBROUTINE D9B0MP (X, AMPL, THETA)
C***BEGIN PROLOGUE  D9B0MP
C***SUBSIDIARY
C***PURPOSE  Evaluate the modulus and phase for the J0 and Y0 Bessel
C            functions.
C***LIBRARY   SLATEC (FNLIB)
C***CATEGORY  C10A1
C***TYPE      DOUBLE PRECISION (D9B0MP-D)
C***KEYWORDS  BESSEL FUNCTION, FNLIB, MODULUS, PHASE, SPECIAL FUNCTIONS
C***AUTHOR  Fullerton, W., (LANL)
C***DESCRIPTION
C
C Evaluate the modulus and phase for the Bessel J0 and Y0 functions.
C
C Series for BM0        on the interval  1.56250E-02 to  6.25000E-02
C                                        with weighted error   4.40E-32
C                                         log weighted error  31.36
C                               significant figures required  30.02
C                                    decimal places required  32.14
C
C Series for BTH0       on the interval  0.          to  1.56250E-02
C                                        with weighted error   2.66E-32
C                                         log weighted error  31.57
C                               significant figures required  30.67
C                                    decimal places required  32.40
C
C Series for BM02       on the interval  0.          to  1.56250E-02
C                                        with weighted error   4.72E-32
C                                         log weighted error  31.33
C                               significant figures required  30.00
C                                    decimal places required  32.13
C
C Series for BT02       on the interval  1.56250E-02 to  6.25000E-02
C                                        with weighted error   2.99E-32
C                                         log weighted error  31.52
C                               significant figures required  30.61
C                                    decimal places required  32.32
C
C***REFERENCES  (NONE)
C***ROUTINES CALLED  D1MACH, DCSEVL, INITDS, XERMSG
C***REVISION HISTORY  (YYMMDD)
C   770701  DATE WRITTEN
C   890531  Changed all specific intrinsics to generic.  (WRB)
C   890531  REVISION DATE from Version 3.2
C   891214  Prologue converted to Version 4.0 format.  (BAB)
C   900315  CALLs to XERROR changed to CALLs to XERMSG.  (THJ)
C   900720  Routine changed from user-callable to subsidiary.  (WRB)
C   920618  Removed space from variable names.  (RWC, WRB)
C***END PROLOGUE  D9B0MP
      DOUBLE PRECISION X, AMPL, THETA, BM0CS(37), BT02CS(39),
     1  BM02CS(40), BTH0CS(44), XMAX, PI4, Z, D1MACH, DCSEVL
      LOGICAL FIRST
      SAVE BM0CS, BTH0CS, BM02CS, BT02CS, PI4, NBM0, NBT02,
     1 NBM02, NBTH0, XMAX, FIRST
      DATA BM0CS(  1) / +.9211656246 8277427125 7376773018 2 D-1      /
      DATA BM0CS(  2) / -.1050590997 2719051024 8071637175 5 D-2      /
      DATA BM0CS(  3) / +.1470159840 7687597540 5639285095 2 D-4      /
      DATA BM0CS(  4) / -.5058557606 0385542233 4792932770 2 D-6      /
      DATA BM0CS(  5) / +.2787254538 6324441766 3035613788 1 D-7      /
      DATA BM0CS(  6) / -.2062363611 7809148026 1884101897 3 D-8      /
      DATA BM0CS(  7) / +.1870214313 1388796751 3817259626 1 D-9      /
      DATA BM0CS(  8) / -.1969330971 1356362002 4173077782 5 D-10     /
      DATA BM0CS(  9) / +.2325973793 9992754440 1250881805 2 D-11     /
      DATA BM0CS( 10) / -.3009520344 9382502728 5122473448 2 D-12     /
      DATA BM0CS( 11) / +.4194521333 8506691814 7120676864 6 D-13     /
      DATA BM0CS( 12) / -.6219449312 1884458259 7326742956 4 D-14     /
      DATA BM0CS( 13) / +.9718260411 3360684696 0176588526 9 D-15     /
      DATA BM0CS( 14) / -.1588478585 7010752073 6663596693 7 D-15     /
      DATA BM0CS( 15) / +.2700072193 6713088900 8621732445 8 D-16     /
      DATA BM0CS( 16) / -.4750092365 2340089924 7750478677 3 D-17     /
      DATA BM0CS( 17) / +.8615128162 6043708731 9170374656 0 D-18     /
      DATA BM0CS( 18) / -.1605608686 9561448157 4560270335 9 D-18     /
      DATA BM0CS( 19) / +.3066513987 3144829751 8853980159 9 D-19     /
      DATA BM0CS( 20) / -.5987764223 1939564306 9650561706 6 D-20     /
      DATA BM0CS( 21) / +.1192971253 7482483064 8906984106 6 D-20     /
      DATA BM0CS( 22) / -.2420969142 0448054894 8468258133 3 D-21     /
      DATA BM0CS( 23) / +.4996751760 5106164533 7100287999 9 D-22     /
      DATA BM0CS( 24) / -.1047493639 3511585100 9504051199 9 D-22     /
      DATA BM0CS( 25) / +.2227786843 7974681010 4818346666 6 D-23     /
      DATA BM0CS( 26) / -.4801813239 3981628623 7054293333 3 D-24     /
      DATA BM0CS( 27) / +.1047962723 4709599564 7699626666 6 D-24     /
      DATA BM0CS( 28) / -.2313858165 6786153251 0126080000 0 D-25     /
      DATA BM0CS( 29) / +.5164823088 4626742116 3519999999 9 D-26     /
      DATA BM0CS( 30) / -.1164691191 8500653895 2540159999 9 D-26     /
      DATA BM0CS( 31) / +.2651788486 0433192829 5833600000 0 D-27     /
      DATA BM0CS( 32) / -.6092559503 8257284976 9130666666 6 D-28     /
      DATA BM0CS( 33) / +.1411804686 1442593080 3882666666 6 D-28     /
      DATA BM0CS( 34) / -.3298094961 2317372457 5061333333 3 D-29     /
      DATA BM0CS( 35) / +.7763931143 0740650317 1413333333 3 D-30     /
      DATA BM0CS( 36) / -.1841031343 6614584784 2133333333 3 D-30     /
      DATA BM0CS( 37) / +.4395880138 5943107371 0079999999 9 D-31     /
      DATA BTH0CS(  1) / -.2490178086 2128936717 7097937899 67 D+0     /
      DATA BTH0CS(  2) / +.4855029960 9623749241 0486155354 85 D-3     /
      DATA BTH0CS(  3) / -.5451183734 5017204950 6562735635 05 D-5     /
      DATA BTH0CS(  4) / +.1355867305 9405964054 3774459299 03 D-6     /
      DATA BTH0CS(  5) / -.5569139890 2227626227 5832184149 20 D-8     /
      DATA BTH0CS(  6) / +.3260903182 4994335304 0042057194 68 D-9     /
      DATA BTH0CS(  7) / -.2491880786 2461341125 2379038779 93 D-10    /
      DATA BTH0CS(  8) / +.2344937742 0882520554 3524135648 91 D-11    /
      DATA BTH0CS(  9) / -.2609653444 4310387762 1775747661 36 D-12    /
      DATA BTH0CS( 10) / +.3335314042 0097395105 8699550149 23 D-13    /
      DATA BTH0CS( 11) / -.4789000044 0572684646 7507705574 09 D-14    /
      DATA BTH0CS( 12) / +.7595617843 6192215972 6425685452 48 D-15    /
      DATA BTH0CS( 13) / -.1313155601 6891440382 7733974876 33 D-15    /
      DATA BTH0CS( 14) / +.2448361834 5240857495 4268207383 55 D-16    /
      DATA BTH0CS( 15) / -.4880572981 0618777683 2567619183 31 D-17    /
      DATA BTH0CS( 16) / +.1032728502 9786316149 2237563612 04 D-17    /
      DATA BTH0CS( 17) / -.2305763381 5057217157 0047445270 25 D-18    /
      DATA BTH0CS( 18) / +.5404444300 1892693993 0171084837 65 D-19    /
      DATA BTH0CS( 19) / -.1324069519 4366572724 1550328823 85 D-19    /
      DATA BTH0CS( 20) / +.3378079562 1371970203 4247921247 22 D-20    /
      DATA BTH0CS( 21) / -.8945762915 7111779003 0269262922 99 D-21    /
      DATA BTH0CS( 22) / +.2451990688 9219317090 8999086514 05 D-21    /
      DATA BTH0CS( 23) / -.6938842287 6866318680 1399331576 57 D-22    /
      DATA BTH0CS( 24) / +.2022827871 4890138392 9463033377 91 D-22    /
      DATA BTH0CS( 25) / -.6062850000 2335483105 7941953717 64 D-23    /
      DATA BTH0CS( 26) / +.1864974896 4037635381 8237883962 70 D-23    /
      DATA BTH0CS( 27) / -.5878373238 4849894560 2450365308 67 D-24    /
      DATA BTH0CS( 28) / +.1895859144 7999563485 5311795035 13 D-24    /
      DATA BTH0CS( 29) / -.6248197937 2258858959 2916207285 65 D-25    /
      DATA BTH0CS( 30) / +.2101790168 4551024686 6386335290 74 D-25    /
      DATA BTH0CS( 31) / -.7208430093 5209253690 8139339924 46 D-26    /
      DATA BTH0CS( 32) / +.2518136389 2474240867 1564059767 46 D-26    /
      DATA BTH0CS( 33) / -.8951804225 8785778806 1439459536 43 D-27    /
      DATA BTH0CS( 34) / +.3235723747 9762298533 2562358685 87 D-27    /
      DATA BTH0CS( 35) / -.1188301051 9855353657 0471441137 96 D-27    /
      DATA BTH0CS( 36) / +.4430628690 7358104820 5792319417 31 D-28    /
      DATA BTH0CS( 37) / -.1676100964 8834829495 7920101356 81 D-28    /
      DATA BTH0CS( 38) / +.6429294692 1207466972 5323939660 88 D-29    /
      DATA BTH0CS( 39) / -.2499226116 6978652421 2072136827 63 D-29    /
      DATA BTH0CS( 40) / +.9839979429 9521955672 8282603553 18 D-30    /
      DATA BTH0CS( 41) / -.3922037524 2408016397 9891316261 58 D-30    /
      DATA BTH0CS( 42) / +.1581810703 0056522138 5906188456 92 D-30    /
      DATA BTH0CS( 43) / -.6452550614 4890715944 3440983654 26 D-31    /
      DATA BTH0CS( 44) / +.2661111136 9199356137 1770183463 67 D-31    /
      DATA BM02CS(  1) / +.9500415145 2283813693 3086133556 0 D-1      /
      DATA BM02CS(  2) / -.3801864682 3656709917 4808156685 1 D-3      /
      DATA BM02CS(  3) / +.2258339301 0314811929 5182992722 4 D-5      /
      DATA BM02CS(  4) / -.3895725802 3722287647 3062141260 5 D-7      /
      DATA BM02CS(  5) / +.1246886416 5120816979 3099052972 5 D-8      /
      DATA BM02CS(  6) / -.6065949022 1025037798 0383505838 7 D-10     /
      DATA BM02CS(  7) / +.4008461651 4217469910 1527597104 5 D-11     /
      DATA BM02CS(  8) / -.3350998183 3980942184 6729879457 4 D-12     /
      DATA BM02CS(  9) / +.3377119716 5174173670 6326434199 6 D-13     /
      DATA BM02CS( 10) / -.3964585901 6350127005 6935629582 3 D-14     /
      DATA BM02CS( 11) / +.5286111503 8838572173 8793974473 5 D-15     /
      DATA BM02CS( 12) / -.7852519083 4508523136 5464024349 3 D-16     /
      DATA BM02CS( 13) / +.1280300573 3866822010 1163407344 9 D-16     /
      DATA BM02CS( 14) / -.2263996296 3914297762 8709924488 4 D-17     /
      DATA BM02CS( 15) / +.4300496929 6567903886 4641029047 7 D-18     /
      DATA BM02CS( 16) / -.8705749805 1325870797 4753545145 5 D-19     /
      DATA BM02CS( 17) / +.1865862713 9620951411 8144277205 0 D-19     /
      DATA BM02CS( 18) / -.4210482486 0930654573 4508697230 1 D-20     /
      DATA BM02CS( 19) / +.9956676964 2284009915 8162741784 2 D-21     /
      DATA BM02CS( 20) / -.2457357442 8053133596 0592147854 7 D-21     /
      DATA BM02CS( 21) / +.6307692160 7620315680 8735370705 9 D-22     /
      DATA BM02CS( 22) / -.1678773691 4407401426 9333117238 8 D-22     /
      DATA BM02CS( 23) / +.4620259064 6739044337 7087813608 7 D-23     /
      DATA BM02CS( 24) / -.1311782266 8603087322 3769340249 6 D-23     /
      DATA BM02CS( 25) / +.3834087564 1163028277 4792244027 6 D-24     /
      DATA BM02CS( 26) / -.1151459324 0777412710 7261329357 6 D-24     /
      DATA BM02CS( 27) / +.3547210007 5233385230 7697134521 3 D-25     /
      DATA BM02CS( 28) / -.1119218385 8150046462 6435594217 6 D-25     /
      DATA BM02CS( 29) / +.3611879427 6298378316 9840499425 7 D-26     /
      DATA BM02CS( 30) / -.1190687765 9133331500 9264176246 3 D-26     /
      DATA BM02CS( 31) / +.4005094059 4039681318 0247644953 6 D-27     /
      DATA BM02CS( 32) / -.1373169422 4522123905 9519391601 7 D-27     /
      DATA BM02CS( 33) / +.4794199088 7425315859 9649152643 7 D-28     /
      DATA BM02CS( 34) / -.1702965627 6241095840 0699447645 2 D-28     /
      DATA BM02CS( 35) / +.6149512428 9363300715 0357516132 4 D-29     /
      DATA BM02CS( 36) / -.2255766896 5818283499 4430023724 2 D-29     /
      DATA BM02CS( 37) / +.8399707509 2942994860 6165835320 0 D-30     /
      DATA BM02CS( 38) / -.3172997595 5626023555 6742393615 2 D-30     /
      DATA BM02CS( 39) / +.1215205298 8812985545 8333302651 4 D-30     /
      DATA BM02CS( 40) / -.4715852749 7544386930 1321056804 5 D-31     /
      DATA BT02CS(  1) / -.2454829521 3424597462 0504672493 24 D+0     /
      DATA BT02CS(  2) / +.1254412103 9084615780 7853317782 99 D-2     /
      DATA BT02CS(  3) / -.3125395041 4871522854 9734467095 71 D-4     /
      DATA BT02CS(  4) / +.1470977824 9940831164 4534269693 14 D-5     /
      DATA BT02CS(  5) / -.9954348893 7950033643 4688503511 58 D-7     /
      DATA BT02CS(  6) / +.8549316673 3203041247 5787113977 51 D-8     /
      DATA BT02CS(  7) / -.8698975952 6554334557 9855121791 92 D-9     /
      DATA BT02CS(  8) / +.1005209953 3559791084 5401010821 53 D-9     /
      DATA BT02CS(  9) / -.1282823060 1708892903 4836236855 44 D-10    /
      DATA BT02CS( 10) / +.1773170078 1805131705 6557504510 23 D-11    /
      DATA BT02CS( 11) / -.2617457456 9485577488 6362841809 25 D-12    /
      DATA BT02CS( 12) / +.4082835138 9972059621 9664812211 03 D-13    /
      DATA BT02CS( 13) / -.6675166823 9742720054 6067495542 61 D-14    /
      DATA BT02CS( 14) / +.1136576139 3071629448 3924695499 51 D-14    /
      DATA BT02CS( 15) / -.2005118962 0647160250 5592664121 17 D-15    /
      DATA BT02CS( 16) / +.3649797879 4766269635 7205914641 06 D-16    /
      DATA BT02CS( 17) / -.6830963756 4582303169 3558437888 00 D-17    /
      DATA BT02CS( 18) / +.1310758314 5670756620 0571042679 46 D-17    /
      DATA BT02CS( 19) / -.2572336310 1850607778 7571306495 99 D-18    /
      DATA BT02CS( 20) / +.5152165744 1863959925 2677809493 33 D-19    /
      DATA BT02CS( 21) / -.1051301756 3758802637 9407414613 33 D-19    /
      DATA BT02CS( 22) / +.2182038199 1194813847 3010845013 33 D-20    /
      DATA BT02CS( 23) / -.4600470121 0362160577 2259054933 33 D-21    /
      DATA BT02CS( 24) / +.9840700692 5466818520 9536511999 99 D-22    /
      DATA BT02CS( 25) / -.2133403803 5728375844 7359863466 66 D-22    /
      DATA BT02CS( 26) / +.4683103642 3973365296 0662869333 33 D-23    /
      DATA BT02CS( 27) / -.1040021369 1985747236 5133823999 99 D-23    /
      DATA BT02CS( 28) / +.2334910567 7301510051 7777408000 00 D-24    /
      DATA BT02CS( 29) / -.5295682532 3318615788 0497493333 33 D-25    /
      DATA BT02CS( 30) / +.1212634195 2959756829 1962879999 99 D-25    /
      DATA BT02CS( 31) / -.2801889708 2289428760 2756266666 66 D-26    /
      DATA BT02CS( 32) / +.6529267898 7012873342 5937066666 66 D-27    /
      DATA BT02CS( 33) / -.1533798006 1873346427 8357333333 33 D-27    /
      DATA BT02CS( 34) / +.3630588430 6364536682 3594666666 66 D-28    /
      DATA BT02CS( 35) / -.8656075571 3629122479 1722666666 66 D-29    /
      DATA BT02CS( 36) / +.2077990997 2536284571 2383999999 99 D-29    /
      DATA BT02CS( 37) / -.5021117022 1417221674 3253333333 33 D-30    /
      DATA BT02CS( 38) / +.1220836027 9441714184 1919999999 99 D-30    /
      DATA BT02CS( 39) / -.2986005626 7039913454 2506666666 66 D-31    /
      DATA PI4 / 0.7853981633 9744830961 5660845819 876 D0 /
      DATA FIRST /.TRUE./
C***FIRST EXECUTABLE STATEMENT  D9B0MP
      IF (FIRST) THEN
         ETA = 0.1*REAL(D1MACH(3))
         NBM0 = INITDS (BM0CS, 37, ETA)
         NBT02 = INITDS (BT02CS, 39, ETA)
         NBM02 = INITDS (BM02CS, 40, ETA)
         NBTH0 = INITDS (BTH0CS, 44, ETA)
C
         XMAX = 1.0D0/D1MACH(4)
      ENDIF
      FIRST = .FALSE.
C
      IF (X .LT. 4.D0) CALL XERMSG ('SLATEC', 'D9B0MP',
     +   'X MUST BE GE 4', 1, 2)
C
      IF (X.GT.8.D0) GO TO 20
      Z = (128.D0/(X*X) - 5.D0)/3.D0
      AMPL = (.75D0 + DCSEVL (Z, BM0CS, NBM0))/SQRT(X)
      THETA = X - PI4 + DCSEVL (Z, BT02CS, NBT02)/X
      RETURN
C
 20   IF (X .GT. XMAX) CALL XERMSG ('SLATEC', 'D9B0MP',
     +   'NO PRECISION BECAUSE X IS BIG', 2, 2)
C
      Z = 128.D0/(X*X) - 1.D0
      AMPL = (.75D0 + DCSEVL (Z, BM02CS, NBM02))/SQRT(X)
      THETA = X - PI4 + DCSEVL (Z, BTH0CS, NBTH0)/X
      RETURN
C
      END
