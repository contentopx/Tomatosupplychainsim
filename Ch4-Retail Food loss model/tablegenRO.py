"""
Print outputs for retail model

"""
from __future__ import division
import openpyxl
#import pandas as pd
import numpy as np
#import matplotlib.pyplot as plt
import math
import scipy.stats as stats
import random
#import seaborn as sns
#import pdb; pdb. set_trace()

types=['T','TD','TQ','TDQ']
for type in types:
    name=type
    
###### Generate COL sheets with uncertainty in storage temp, days of transit, quality options
#name='T'
#name='TD'
#name='TQ'
#name='TDQ'
   
    tempdist=[]
    daysdist=[]
    qualdist=[]
    
    random.seed(0)
             
    def weight(var,x):
               
        if var<5.5:
             result = x
             #result = 0.5
        elif var<=6.5 and var>5.5:
             result = x*.7 #0.35 
             #result = 0.35
        else:
              result = (1-x-(x*.7)) #0.15
              if result <0:
                  result=.001
        return result       
            
            
    #number of xls files genrated
    for k in range(1,2):
        wb = openpyxl.Workbook()
        sheet = wb.active
        
        #named range for COL table so that AMPL can read it
        new_range = openpyxl.workbook.defined_name.DefinedName('vectors', attr_text='Sheet!$A$1:$E$29')
        wb.defined_names.append(new_range)
        
        #Storage temp into kelvin
        lowesttemp = 17
        highesttemp = 21
        avgtemp = 20
        stdvtemp = 0.6
        
        Hmin=142.1
        Hmax=37
        
        lowertempkelvin = (lowesttemp + 273.15)
        highesttempkelvin = (highesttemp + 273.15)
        avgtempkelvin = (avgtemp + 273.15)
        stdevtempkelvin = stdvtemp
          
        mu, sigma = avgtempkelvin, stdevtempkelvin
        lower, upper = lowertempkelvin, highesttempkelvin
        
#TABLE OF CONSTANTS
        tablescalars = openpyxl.workbook.defined_name.DefinedName('scalars', attr_text='Sheet!$G$1:$J$2')
        wb.defined_names.append(tablescalars)
        sheet['G1'] = 'pcost'
        sheet['G2'] = 9
        
        sheet['H1'] = 'tcost'
        sheet['H2'] = 30
        
        sheet['I1'] = 'hcost'
        sheet['I2'] = 0.8
        
        sheet['J1'] = 'e'
        sheet['J2'] = 7
        
        #tables for indices
        qual = openpyxl.workbook.defined_name.DefinedName('qual', attr_text='Sheet!$G$5:$G$7')
        wb.defined_names.append(qual)
        sheet['G5'] = 'QUAL'
        sheet['G6'] = 5
        sheet['G7'] = 6
        
        
        time = openpyxl.workbook.defined_name.DefinedName('time', attr_text='Sheet!$I$5:$I$19')
        wb.defined_names.append(time)
    
        sheet['I5'] = 'TIME'
        days=np.array(range(15))
        
        sheet['I6'] = days[1]
        sheet['I7'] = days[2]
        sheet['I8'] = days[3]
        sheet['I9'] = days[4]
        sheet['I10'] = days[5]
        sheet['I11'] = days[6]
        sheet['I12'] = days[7]
        sheet['I13'] = days[8]
        sheet['I14'] = days[9]
        sheet['I15'] = days[10]
        sheet['I16'] = days[11]
        sheet['I17'] = days[12]
        sheet['I18'] = days[13]
        sheet['I19'] = days[14]
    
    
    #First column
    #DAYS
        sheet['A1'] = 'TIME'
        number_of_repeats = 2
        days=range(1,15)
        current_cell_num = 2
        
        for repeat in range(number_of_repeats):
            for day in days:
                cell_string = 'A%d' % current_cell_num
                sheet[cell_string] = day
                current_cell_num = current_cell_num + 1
    
                
    #Second Column
    #QUAL
        sheet['B1'] = 'QUAL'     
        for i, rowOfCellObjects in enumerate(sheet['B2':'B15']):
            for n, cellObj in enumerate(rowOfCellObjects):
                cellObj.value = 5
        
        sheet['B1'] = 'QUAL'     
        for i, rowOfCellObjects in enumerate(sheet['B16':'B29']):
            for n, cellObj in enumerate(rowOfCellObjects):
                cellObj.value = 6
                               
       
    #third Column 
    #PRICE    
    
        #price is dependent on qual
        
        sheet['C1'] = 'price'     
        for i, rowOfCellObjects in enumerate(sheet['C2':'C15']):
            for n, cellObj in enumerate(rowOfCellObjects):
                cellObj.value = 45
        
        sheet['C1'] = 'price'     
        for i, rowOfCellObjects in enumerate(sheet['C16':'C29']):
            for n, cellObj in enumerate(rowOfCellObjects):
                cellObj.value = 45
                
    #fourth and fifth column
    #FRESH
    #QSOLD
        sheet['E1'] = 'qsold'       
        sheet['D1'] = 'fresh'     
        for i in range(1,29):
                        
            #uncertainties in days
            days=sheet['A'][i].value
            #daysuncertain=stats.uniform.rvs(loc=days-.25,scale=.5)
            
            #uncertainty in qual     
            qual=sheet['B'][i].value
            
            #read in price        
            price=sheet['C'][i].value
                         
            #set demand parameters
            #a=200
            a=110
            #b=3.4
            b=5.3 
            
            #how quality evolves through time given certainty or uncertainty
            if days==1 and qual==5: 
                qual=4.92
                qualuncertain=stats.uniform.rvs(loc=4.92-.4,scale=.8)
            elif days==1 and qual==6:
                qual=5.92
                qualuncertain=stats.uniform.rvs(loc=5.92-.4,scale=.8)
            elif days > 1:
                qual=sheet['D'][i-1].value
                qualuncertain = sheet['D'][i-1].value
            
            
            
            #print(qualuncertain)
    
            #temp=15*[avgtempkelvin]
            temp = stats.truncnorm.rvs((lower - mu) / sigma, (upper - mu) / sigma, loc=mu, scale=sigma, size=15)
            #plt.hist(temp)
            #plt.show()
            
            temp=temp[days-1]          
            temp=np.round(temp,3)
            
            #uncertainty outputs
            if name=="None":
                qual=qual 
            if name=="T":
                qual=qual            
            if name=="TQ":
                qual=qualuncertain
            if name=="TD":
                qual=qual
            if name=="TDQ":
                qual=qualuncertain
                
            
            #calculate hterm freshness
            kterm=0.0021*math.exp((138443/8.314)*((1/288.15)-(1/temp)))     
            ktermconstant=0.0021*math.exp((138443/8.314)*((1/288.15)-(1/avgtempkelvin)))
            
            # Hterm calc for uncertinaty in temp only
            Hterm_t = (-6.197)*\
                np.log((Hmax+((Hmin-Hmax)/\
                (1+((math.exp(kterm*((1))*(Hmin-Hmax)))*\
                (Hmin-(117.26*math.exp(-0.161*qual))))/\
                ((117.26*math.exp(-0.161*qual))-Hmax)))))+29.56
            Hterm_0 = (-6.197)*\
                np.log((Hmax+((Hmin-Hmax)/\
                (1+((math.exp(ktermconstant*((days))*(Hmin-Hmax)))*\
                (Hmin-(117.26*math.exp(-0.161*qual))))/\
                ((117.26*math.exp(-0.161*qual))-Hmax)))))+29.56
    
            #uncertainty in preference
            pref=.5
            prefuncertain=float(np.random.triangular(.4, .5, .6, 1))
            
            #uncertainty outputs
            if name=="None":
                Hterm=Hterm_0
                x=pref
            if name=="T":
                Hterm=Hterm_t
                x=pref
            if name=="TQ":
                Hterm=Hterm_t
                x=pref
            if name=="TD":
                Hterm=Hterm_t
                x=prefuncertain
            if name=="TDQ":
                Hterm=Hterm_t
                x=prefuncertain
                
            #outputs freshnesss
            sheet['D'][i].value = Hterm       
            
            
            #calculate freshness dependent demand
            qsold=a-(b*price)*(abs(Hterm-6))*weight(Hterm,x)
            if qsold <0:
                qsold=0
            #qsold=(a-(b*price))+(freshness/7)
            
            #print amount sold
            sheet['E'][i].value = qsold
            
            #print (temp)
            #tempdist.append(temp)
            #daysdist.append(daysuncertain)
            #qualdist.append(qualuncertain)    
    
    

    
        #save the file everytime
        
        wb.save(filename='Stochastic'+ str(name) +'/stoc' + str(name)+ str(k+1) + 'low.xlsx') #, keep_vba=True)
        print(k)
        print(name)
    tempdist=np.array(tempdist)
    daysdist = np.array(daysdist)

#plt.hist(tempdist, bins=15)
#plt.show()


    
    


"""



"""
