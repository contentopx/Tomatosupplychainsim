#Retail Model used in Chapter 4
#Uncertainty in retail temp, demand and maturity

#set TIME ordered;
set QUAL;	

set TIME := 1..10;
#set QUAL := 5..6;	

#param freshthresh = 7.1;	

param freshthresh = 7.1835;	

param pcost						>= 0;						# Purchase cost
param tcost						>= 0;						# Transportation cost
param hcost						>= 0;						# Holding cost per box
param e							>= 0;						# Environmental/social welfare cost per box

param price		{TIME, QUAL}	>= 0;						# Daily Price of total sold goods shoud depend on quality
param qsold		{TIME, QUAL}	>= 0;						# Daily Quantity of total sold goods
var shrink	{TIME, QUAL}	>= 0;


param fresh		{TIME, QUAL}	>= 0;						# end quality after x days

var SD			{QUAL}			>= 0;						# Total Quantity of boxes ordered by store (sum of all time intervals)
var notSold		{TIME, QUAL}	>= 0;						# Quantity of boxes not sold by store (IN EACH time intervals)		
var qdon		{TIME, QUAL}	>= 0;						# Daily Quantity of goods donated 
var inv			{TIME, QUAL}	>= 0;						# Daily Quantity of goods donated 
var sold	{TIME, QUAL}		>= 0;						# forecasted 


# Revenue

### objective function

var retailer_profit =			sum{t in TIME, q in QUAL} price[t,q] * (sold[t,q]) #Revenue
							  - hcost * sum{t in TIME, q in QUAL} notSold[t,q]
							  + e * sum{t in TIME, q in QUAL} qdon[t,q]
							  - pcost * sum {q in QUAL} SD[q]
							  - tcost;


maximize obj1: retailer_profit;

#We order whatever we project will be sold and leftover on the last day
subject to selling: 									
	sum {q in QUAL} SD[q] >= (sum{t in TIME, q in QUAL} sold[t,q]) 
	+ sum{q in QUAL} notSold[10,q];   #last(TIME)

# inventory
# if it is day 1 then stock is full, otherwise remaining from t-1 day
subject to notsold {t in TIME, q in QUAL}: 			 
 	notSold[t,q] <= (if t=1 then SD[q] - sold[t,q] - qdon[t,q] 
 	else notSold[t-1,q] - sold[t,q] - qdon[t,q]);
 	
# if quality is above threshold then you get zero profit
subject to waste{t in TIME, q in QUAL: fresh[t,q] > freshthresh}:	
	qdon[t,q] = qsold[t,q];
	
subject to demand{t in TIME, q in QUAL}: 									
	sold[t,q] <= qsold [t,q] - qdon[t,q]; 




