#AMPL MODEL FILE CODE:

# Operational model used in Ch 2 for Florida tomato with NO uncertainty
# Crop is tomatoes only
###################################################################

set DAYH ordered;			# Days of the harvesting period
set DAYD ordered;			# Days of the demand period
set PLOT;				# Plot formed by an area of land planted with crop j
set CROP;				# Crops for planting
set CUST;				# Customers
set PROD; 				# Products produced and shipped
set FAC;				# Packing facilities
set WARE;				# Warehousing facilities
set DC;					# Distribution facilities
set TRANS; 				# Transportation modes available
set SCHE:=1..10;			# Type of harvesting schedule
set QUAL;				# Quality of the crop at harvest
set DAY:= DAYH union DAYD ordered;
set Tm;

param PN {DAYD,PROD} >=0;		# Price of open market for product k at period t
param PC {DAYD,PROD,CUST} >= 0;		# price of product k for customer i at day t 
param Cfix {CROP} >=0; 			# Fixed cost of production for crop j (except labor)
param Charv {CROP} >=0;			# Cost of harvesting a box of crop j
param Cpack {PROD} >=0;			# Cost of packing a box of product k (labor)
param Ccase {PROD} >=0;			# Cost of packaging a case of product k (Excluding labor)
param Cwater {PROD} >=0;		# Cost of water packing a box of product k (labor)
param Cenergy {PROD} >=0;		# Cost of energy packing a box of product k (labor)
param CI{PROD,WARE} >=0;		# Cost of inventory of product k in warehouse w
param CID{PROD,DC} >=0;			# Cost of inventory of product k in DC d
param Clabor >=0;			# Cost of an hour of labor at the field
param Pcrop {PROD} symbolic;		# Crop in the product k, tom or pepper 
param Ccrop {CROP} symbolic;
param Dcrop {PLOT} symbolic;

#####
param PKO {PROD,QUAL}; 			#PH packout
param WIR {PROD,QUAL}; 			#WH retention daily survival
param PWR {PROD,QUAL}; 			#travel survival
param DCIR {PROD,QUAL}; 		#DC retention daily survival
param WDCR {PROD,QUAL}; 		#travel survival
######

param AP {PLOT}>=0;			# Total area planted on plot p (Hectares)
param EH {DAYH,PLOT,SCHE};
param SH {DAYH,PLOT,SCHE};
param Freq {SCHE};			# Frequency of harvest selected
param VG {DAYH,PLOT,PROD}; 		# Percentage of crops transformed in different products
param VQ {SCHE,CROP,QUAL}; 		# Expected color distribution of crops harvested every n days
param COL {DAYD,CROP,QUAL}; 		# Expected color development of the crops after harvest, stored at 15C
param PROB {DAYD,CROP,QUAL}; 		# Expected color development of the crops after harvest, stored at 15C
param RW {PROD} >=0;			# Quantity in pounds required of crop j to form a case of product k
param RC {PROD} >=0;			# Number of cases of product k required to form a pallet
param Wcap {WARE};			# Capacity of the warehouse in pallets
param Dcap {DC};			# Capacity of the DC in pallets
param LAH {DAYH}>=0;			# Labor available for harvesting in day h (hours).
param LAP {DAYH}>=0;			# Labor available for packing in day h (hours).
param LRH {CROP} >=0;			# Boxes of crop j harvested per hour
param LBH {CROP} >=0;			# Labor required to cover a hectare of crop j (hours)	
param LRP {PROD} >=0;			# Boxes of product k packed per hour
param MOP;				# Maximum amount of field personal to hire
param SL {PROD,QUAL} >=0;		# Shelf life of product k
param KTC;				# Capacity of container in pallets
param KTW;				# Capacity of container in weight
param KPF {FAC} >=0;			# Capacity of packaging facility for a time period
param DW {DAYD,PROD,CUST} >= 0, default 0;	# Demand from customer i per day t from product k
param DM {DAYD,PROD} >= 0, default 0;		# Demand of product k from open market per day t
param LT {CUST} >=0;				# Lead time required by the customer
param LH {PLOT};				# Day of the last harvest at plot p

var TC {DAYD,PROD,FAC,CUST,TRANS} binary;		# Transportation mode r selected for transporting product k from f 
var TD {DAYD,PROD,DC,CUST, TRANS} binary;		# Transportation mode r selected for transporting product k from d 
var TW {DAYD,PROD,WARE,CUST,TRANS} binary;		# Transportation mode r selected for transporting product k from w 
var TPD {DAYD,PROD,FAC,DC,TRANS} binary;		# Transportation mode r selected for transporting product k from f 
var TPW {DAYD,PROD,FAC,WARE,TRANS} binary;		# Transportation mode r selected for transporting product k from f 
var TWD {DAYD,PROD,WARE,DC,TRANS} binary;		# Transportation mode r selected for transporting product k from w 

param CT{FAC,CUST,TRANS} >=0;	# Cost of transportation from facility f customer c in mode r
param CTW{WARE,CUST,TRANS} >=0;	# Cost of transportation from warehouse w to customer c in mode r
param CTD{DC,CUST,TRANS} >=0;	# Cost of transportation from DC d to customer c in mode r
param CTPW{FAC,WARE,TRANS} >=0;	# Cost of transportation from facility f to warehouse w in mode r
param CTPD{FAC,DC,TRANS} >=0;	# Cost of transportation from facility f to DC d in mode r
param CTWD{WARE,DC,TRANS} >=0;	# Cost of transportation from warehouse w to DC d in mode r

param Ti {FAC,CUST,TRANS} >=0;		# Time of transportation from packing facility f to customer i by transportation mode r
param TiW {WARE,CUST,TRANS} >=0;	# Time of transportation from warehouse w to customer i by transportation mode r
param TiD {DC,CUST,TRANS} >=0;		# Time of transportation from DC d to customer i by transportation mode r
param TiPW {FAC,WARE,TRANS} >=0;	# Time from packing facility f to warehouse w by transportation mode r
param TiPD {FAC,DC,TRANS} >=0;		# Time of transportation from packing facility f to DC d by transportation mode r
param TiWD {WARE,DC,TRANS} >=0;		# Time of transportation from warehouse w to DC d by transportation mode r

param Chire >=0;	# Cost of hiring a full time employee
param Maxi =80;
param BM=1000000;	# Big value
param Psalv {CROP} >=0;	# Salvagae price of crop j in crop units
param LabH {CROP} >=0; 	# Men-hour required to harvest a hectare of crop j

param T1 {FAC,CUST,TRANS} >=0;	# Time in periods of transportation from packing facility f to customer i by transportation mode r
param T2 {WARE,CUST,TRANS} >=0;	# Time in periods of transportation from warehouse w to customer i by transportation mode r
param T3 {FAC,WARE,TRANS} >=0;	# Time in periods of transportation from warehouse w to DC d by transportation mode r
param T4 {FAC,DC,TRANS} >=0;	# Time in periods of transportation from packing facility f to DC d by transportation mode r
param T5 {WARE,DC,TRANS} >=0;	# Time in periods of transportation from warehouse w to DC d by transportation mode r
param Exp{Tm}>=0;
param Lin{Tm}>=0;
param Td{Tm}>=0;
param Tday{FAC,CUST,TRANS} symbolic;

var Y {DAYH,PLOT} >=0 binary;		# Harvest occurs on plot p at day h. 
var X {PLOT,SCHE} >=0;			# Amount of plot p to harvest according to schedule s.
var QH {DAYH,PLOT,QUAL} >=0;		# Pounds to harvest from plot p at day h.
var SP {DAYH,PLOT,QUAL,FAC} >=0;	# Quantity of crop j to ship from plot p to facility f in period h.
var QP {DAYH,PROD,QUAL,FAC} >=0;	# Quantity of product k packed at facility f in period h.
var OPL {DAYH} >=0;			# Operator hours hired in the field and time h.
var OPF {DAYH} >=0;			# Operators hours hired at packing facilities at time h.

var SD {DAYH,DAYD,PROD,QUAL,DC,CUST,TRANS} >=0 integer;		# Quantity of product k to ship to DC d from facility f in #################
var QC {DAYH,DAYD,PROD,QUAL,DC,CUST,TRANS} >=0;		

var SPW {DAYH,DAYD,PROD,QUAL,FAC,WARE,TRANS} >=0;	# Quantity of product k to ship to warehouse w from 
var SWD {DAYH,DAYD,PROD,QUAL,WARE,DC,TRANS} >=0;	# Quantity of crop k shipped from warehouse w to DC d in 
var Invw {DAYH,DAYD,PROD,QUAL,WARE} >=0;		# Inventory in warehouse w (storage) of product k in period t
var Invd {DAYH,DAYD,PROD,QUAL,DC} >=0;			# Inventory in DC d (storage) of product k in period t


var NTP{DAYD,FAC,WARE,TRANS} integer;
var NTI {DAYD,FAC,CUST,TRANS} integer;
var NTD{DAYD,DC,CUST,TRANS} integer;
var NTW{DAYD,WARE,CUST,TRANS} integer;
var NTK{DAYD,FAC,DC,TRANS} integer;
var NTC{DAYD,WARE,DC,TRANS} integer;
var Totlabor {DAYH};
var SumPerishable>=0;
var K {DAYH,CROP} >=0;						# Surplus of crop j
var Z {DAY,PROD,WARE} >=0;					# Quantity to purchase of product k, in period t for warehouse w
var CostH;
var CostP;
var CostL;	


#OBJECTIVE FXN
maximize total_revenue: 
sum{k in PROD,q in QUAL,i in CUST,t in DAYD,d in DC,r in TRANS,h in DAYH:t>= h >= t-SL[k,q] and r='TM1'} SD[h,t,k,q,d,i,r]*PC[t,k,i]
-sum {h in DAYH,p in PLOT,q in QUAL} QH[h,p,q]*(Cfix[Dcrop[p]]+Charv[Dcrop[p]])
-sum {f in FAC,h in DAYH,k in PROD,q in QUAL} QP[h,k,q,f]*(Cpack[k]+Ccase[k]+Cenergy[k]+Cwater[k])
-sum {p in PLOT,s in SCHE} X[p,s]*LBH[Dcrop[p]]*Freq[s]*Clabor
-sum {h in DAYH,t in DAYD,k in PROD,q in QUAL,w in WARE} Invw[h,t,k,q,w]*CI[k,w]
-sum {h in DAYH,t in DAYD,k in PROD,q in QUAL,d in DC} Invd[h,t,k,q,d]*CID[k,d]
-sum {h in DAYH} OPL[h]*Clabor
-sum{k in PROD,q in QUAL,i in CUST,t in DAYD,d in DC,r in TRANS,h in DAYH:t> h >= t-SL[k,q] 
and r='TM1'} SD[h,t,k,q,d,i,r]*PC[t,k,i]*PROB[t-h,Pcrop[k],q]
-sum{k in PROD,q in QUAL,i in CUST,t in DAYD,d in DC,r in TRANS,h in DAYH:t> h >= t-SL[k,q] 
and r='TM1'} SD[h,t,k,q,d,i,r]*PC[t,k,i]*(COL[t-h,Pcrop[k],q]-2)/8;


# Cost of harvest #
subject to Cost_Harv: CostH= sum {h in DAYH,p in PLOT,q in QUAL} QH[h,p,q]*(Cfix[Dcrop[p]]+Charv[Dcrop[p]]);
subject to Cost_Pack: CostP= sum {f in FAC,h in DAYH,k in PROD,q in QUAL} QP[h,k,q,f]*(Cpack[k]+Ccase[k]);

subject to Cost_Labor: 
CostL=sum {p in PLOT,s in SCHE} X[p,s]*LBH[Dcrop[p]]*Freq[s]*Clabor
+ sum {h in DAYH} OPL[h]*Clabor;

# The amount to harvest cannot be more than the land you planted #CHANGED!!!!!!!!
subject to Tot_harv {h in DAYH,p in PLOT,q in QUAL}: 
QH[h,p,q] <= sum{s in SCHE}X[p,s]*(1)*EH[h,p,s]*VQ[s,Dcrop[p],q];

# The amount of to harvest is restricted to labor availability
subject to Tot_field {h in DAYH}: 
sum {p in PLOT,q in QUAL} (QH[h,p,q]/LRH[Dcrop[p]])
+ sum{p in PLOT,s in SCHE} SH[h,p,s]*X[p,s]*LBH[Dcrop[p]]<=LAH[h]+OPL[h];

subject to Tot_lab_sum {h in DAYH}: 
Totlabor[h]=sum {p in PLOT,q in QUAL} (QH[h,p,q]/LRH[Dcrop[p]])
+ sum{p in PLOT,s in SCHE} SH[h,p,s]*X[p,s]*LBH[Dcrop[p]]; 

# The Packing of products is dependent on the frequency of harvest and the characteristics of crops 
subject to Tot_pack {h in DAYH,k in PROD,q in QUAL,f in FAC}:
QP[h,k,q,f]
=sum{p in PLOT:Dcrop[p]=Pcrop[k]}VG[h,p,k]*(PKO[k,q])*(SP[h,p,q,f]);

# Transportation from fields to packing facilities
subject to Trans_SP {h in DAYH,p in PLOT,q in QUAL}: 
sum{f in FAC}SP[h,p,q,f] <= QH[h,p,q]; 

# Capacity to pack at plant 
subject to Lap_pack {h in DAYH,f in FAC}: 
sum{k in PROD,q in QUAL}QP[h,k,q,f]<= KPF[f];

# Harvest restrictions in the daily operation
subject to Harvest {p in PLOT}: 
sum{s in SCHE}X[p,s]=AP[p];

# Labor availability for field production
subject to Lab_pack {h in DAYH}: OPL[h]<=MOP;

# Production of cases at the packing plants go to the warehouse, DC or customer
subject to Production {h in DAYH,f in FAC,k in PROD,q in QUAL}: 
sum{w in WARE,r in TRANS} SPW[h,h+T3[f,w,r],k,q,f,w,r]
=QP[h,k,q,f];

subject to SPW_Prod: 
sum {h in DAYH,k in PROD,q in QUAL,f in FAC,w in WARE,r in TRANS,t in DAYD:t<(h+T3[f,w,r])} 
SPW[h,t,k,q,f,w,r]=0;

subject to SPW_Prod2: 
sum {h in DAYH,k in PROD,q in QUAL,f in FAC,w in WARE,r in TRANS,t in DAYD:t>(h+T3[f,w,r])} 
SPW[h,t,k,q,f,w,r]=0;


# Capacity at the warehouse
subject to Cap_warehouse {w in WARE, t in DAYD}: 
sum{k in PROD,h in DAYH,q in QUAL} Invw[h,t,k,q,w]/RC[k]<= Wcap[w];

# Labor availability for packing #####WAS commented out
#subject to Lab_Packing {h in DAYH,f in FAC}: OPF[h,f]>=sum{k in PROD} PACK[h,k,f]*LabF[k]; 

#Initial shipment
subject to Initial_hold {h in DAYH,k in PROD,q in QUAL,w in WARE}: 
Invw[h,h,k,q,w] = sum{f in FAC,r in TRANS} SPW[h,h,k,q,f,w,r]
-sum{d in DC,r in TRANS} SWD[h,h+T5[w,d,r],k,q,w,d,r]; 

# Inventory at the warehouses WIR[k,q]*
subject to Inventw {h in DAYH,k in PROD,q in QUAL,w in WARE,t in DAYD: last(DAYD)>= t >h}: 
Invw[h,t,k,q,w]=Invw[h,t-1,k,q,w]+PWR[k,q]*sum{f in FAC,r in TRANS} SPW[h,t,k,q,f,w,r]
-sum{d in DC,r in TRANS} (if t<(last(DAYD)-T5[w,d,r]+1) then SWD[h,t+T5[w,d,r],k,q,w,d,r]); 

# initial inv
subject to Initial_DC {h in DAYH,k in PROD,q in QUAL,d in DC}: 
Invd[h,h,k,q,d]=
-sum{i in CUST,r in TRANS} SD[h,h,k,q,d,i,r]
+sum{w in WARE,r in TRANS}SWD[h,h,k,q,w,d,r];

# Inventory at the DC's #############DCIR[k,q]*
subject to Inv_DC {h in DAYH, k in PROD,q in QUAL,d in DC,t in DAYD: last(DAYD)>= t >h}: 
Invd[h,t,k,q,d]=Invd[h,t-1,k,q,d]
-sum{i in CUST,r in TRANS}SD[h,t,k,q,d,i,r]+WDCR[k,q]*sum{w in WARE,r in TRANS}SWD[h,t,k,q,w,d,r];


subject to SD_Inv {h in DAYH,t in DAYD, k in PROD,q in QUAL}:
sum{i in CUST,r in TRANS,d in DC:t<=h}SD[h,t,k,q,d,i,r]
+sum{w in WARE,r in TRANS,d in DC:t<h+T5[w,d,r]}SWD[h,t,k,q,w,d,r]
+sum{f in FAC,r in TRANS,w in WARE:t<h+T3[f,w,r]}SPW[h,t,k,q,f,w,r]
=0;

subject to Losstravel {h in DAYH,t in DAYD, k in PROD, q in QUAL, d in DC, i in CUST,r in TRANS}:
QC[h,t,k,q,d,i,r]=(0.95)*SD[h,t,k,q,d,i,r];

#Capacity at the DC
subject to Cap_DC {d in DC, t in DAYD}: 
sum{h in DAYH, k in PROD,q in QUAL} Invd[h,t,k,q,d]/RC[k]<= Dcap[d];

# Customer demand is met either through shipping from field to customer or from DC to customer
subject to Demand {k in PROD,i in CUST,t in DAYD}:
sum {d in DC,r in TRANS,q in QUAL,h in DAYH:t>= h >= t-SL[k,q] and r='TM1'} SD[h,t,k,q,d,i,r] <= DW[t,k,i];

# Shipment of products is subject to transportation selection
subject to SPW_TPW {h in DAYH,t in DAYD,k in PROD,q in QUAL,f in FAC,w in WARE,r in TRANS}: 
SPW[h,t,k,q,f,w,r]<=BM*TPW[t,k,f,w,r];

# Shipment of products is subject to transportation selection
subject to SWD_TWD {h in DAYH,t in DAYD,k in PROD,q in QUAL,w in WARE,d in DC,r in TRANS}: 
SWD[h,t,k,q,w,d,r]<=BM*TWD[t,k,w,d,r];

# Shipment of products is subject to transportation selection
subject to SD_TD {h in DAYH,t in DAYD,k in PROD,q in QUAL,d in DC,i in CUST,r in TRANS}: 
SD[h,t,k,q,d,i,r]<=BM*TD[t,k,d,i,r];

# Shipment of products is subject to transportation selection
subject to SPW_W {t in DAYD,f in FAC,w in WARE,r in TRANS,k in PROD}: 
sum{h in DAYH,q in QUAL} SPW[h,t,k,q,f,w,r]*RW[k]<= KTW*NTP[t,f,w,r];
subject to SPW_C {t in DAYD,f in FAC,w in WARE,r in TRANS,k in PROD}: 
sum{h in DAYH,q in QUAL} SPW[h,t,k,q,f,w,r]/RC[k]<= KTC*NTP[t,f,w,r];

subject to SWD_W {t in DAYD,w in WARE,d in DC,r in TRANS,k in PROD}:
sum{h in DAYH,q in QUAL} SWD[h,t,k,q,w,d,r]*RW[k]<= KTW*NTC[t,w,d,r];
subject to SWD_C {t in DAYD,w in WARE,d in DC,r in TRANS,k in PROD}: 
sum{h in DAYH,q in QUAL} SWD[h,t,k,q,w,d,r]/RC[k]<= KTC*NTC[t,w,d,r];

subject to SD_W {t in DAYD,d in DC,i in CUST,r in TRANS,k in PROD}: 
sum{h in DAYH,q in QUAL} SD[h,t,k,q,d,i,r]*RW[k]<= KTW*NTD[t,d,i,r];
subject to SD_C {t in DAYD,d in DC,i in CUST,r in TRANS,k in PROD}: 
sum{h in DAYH,q in QUAL} SD[h,t,k,q,d,i,r]/RC[k]<= KTC*NTD[t,d,i,r];


# Cycle time restriction
subject to TC_Time {t in DAYD,k in PROD,f in FAC,i in CUST,r in TRANS}: Ti[f,i,r]*TC[t,k,f,i,r]<= LT[i];

# Cycle time restriction
subject to TW_Time {t in DAYD,k in PROD,w in WARE,i in CUST,r in TRANS}: TiW[w,i,r]*TW[t,k,w,i,r]<= LT[i];

# Cycle time restriction
subject to TD_Time {t in DAYD,k in PROD,d in DC,i in CUST,r in TRANS:r='TM1'}: TiD[d,i,r]*TD[t,k,d,i,r]<= LT[i];



