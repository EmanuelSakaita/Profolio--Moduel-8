/* this code is for summary statistics*/
proc sql;
create table death_summary as
select age_Range,state, sum(Observed_Deaths) as tt_death, sum (Expected_Deaths) as tt_Exp_death
from import
group by 1,2;
quit;

/* this code creates a table with three columns and 8 rows */
proc sql;
create table death_avg as
select age_Range, avg(Observed_Deaths) as avg_death, avg (Expected_Deaths) as avg_Exp_death
from import
group by 1;
quit;

/* The code displays total deaths observed */
data death_avg_obs(rename=(Observed_Deaths=death));
set import (keep=Observed_Deaths age_Range) ;
cat = 'obs';
if age_Range = '0-49';
run;
/* The code displays total deaths expect*/
data death_avg_Exp(rename=(Expected_Deaths=death));
set import (keep=Expected_Deaths age_Range) ;
cat = 'Exp';
if age_Range = '0-49';
run;

/* this code shows the average death observed and expected*/
data death_final;
set death_avg_obs death_avg_Exp;
run;

/* this code generates the Ttest*/
proc ttest;
class cat; 
var death;
run;
