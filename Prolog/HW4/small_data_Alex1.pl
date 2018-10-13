

afstand(S1,S2,Afstand):-
   stad(S1,C11,C12),
   stad(S2,C21,C22),
   S1 \= S2,
   Afstand is round( ( ((C21-C11)**2 + (C22-C12)**2)**0.5 ) / 1000000 ),
   Afstand =< 500.

%hotel(new_york).
hotel(los_angeles).
%hotel(chicago).
%hotel(san_francisco).
%hotel(el_paso).
%hotel(boston).

%stad(new_york,407127837,-740059413).
stad(los_angeles,340522342,-1182436849).
%stad(chicago,418781136,-876297982).
%stad(houston,297604267,-953698028).
%stad(philadelphia,399525839,-751652215).
%stad(phoenix,334483771,-1120740373).
%stad(san_antonio,294241219,-9849362819999990).
stad(san_diego,32715738,-1171610838).
%stad(dallas,327766642,-9679698789999990).
stad(san_jose,373382082,-1218863286).
%stad(austin,30267153,-977430608).
%stad(indianapolis,39768403,-86158068).
%stad(jacksonville,303321838,-8165565099999990).
%stad(san_francisco,377749295,-1224194155).
%stad(columbus,399611755,-8299879419999990).
%stad(charlotte,352270869,-808431267).
%stad(fort_worth,327554883,-973307658).
%stad(detroit,42331427,-830457538).
%stad(el_paso,317775757,-1064424559).
%stad(memphis,351495343,-900489801).
%stad(seattle,476062095,-1223320708).
%stad(denver,397392358,-104990251).
%stad(washington,389071923,-770368707).
%stad(boston,423600825,-710588801).
