%% Matlab Script example 

%% Common math function notations
% sqrt(x), x^(y),exp(x),sin(x),cos(x),tan(x),pi,asin,acos,atan,factorial(n),1e-n
% you can also use inline functions to creat your own  
y = @(x) exp(x)*sin(x);
sprintf('y(5) = %.2f',y(5))
% or you can also call other m file functions 
Matlabtest(20)
%% Vectors 
v = [1 2 3] %you can also do v = [1,2,3] 
w = [4;5;6] %using ; allows us to make column vectors
length(v) %gives the size of the vector 
%% use parenthesis in order to index entries 
v(2) % to grab second entry
v(end) % lets you grab the last entry
v(end-1) 
%% logical vectors 
idx = w > 4
nnz(idx) %tells you how many of the entries are true
w(idx) 
%% max function for vectors
max(v)
[largest, idx] = max(v)
%% Matrices
A = [1 2 3; 4 5 6;7 8 9]
%A = [7 2 1; 0 3 -1;-3 4 2]
%% indexing matrices
A(1,3) %acces with A(i,j)
A(:,3) %to grab every row of column 3 and vice versa for every column of a row
A(4) %if you put only one input it will treat it as a stacked column. A(4)
     %will give us 2 A(6) will give us 8
%% max function for matrices
%basically treats it as if u put in seperate column vectors 
max(A) %returns a row with the highest entries of each column 
max(A,[],2) % returns a column with the highest entries of each row 
max(A,2) %compares the number 2 with each entry and returns the max of that comparison
B = [1 2 4;4 1 1 ; 10 12 11]
max(A,B) %compares entrywise between two matrices

%% functions for matrices
det(A)
inv(A) %will not work for A = [1:3;4:6;7:9] since condition number is large
A*inv(A)
cond(A)
%% solving Ax = b
b = [1 2 3]'
x1 = inv(A)*b
x2 = A\b
%% (Hermitian/Conjugate) Transpose
A' %Changes columns to rows but conjugates entries 
A(1) = 1 + i;
A' %use format short to avoid cluster of 0s
A.' % will not conjugate entries
%% Simbolic math 
syms a b c
v = [a b c]
v*v'
v' %gives column vector of cojugates
v*v.'
%alternate
syms a b c real
w = [a b c]
w'
%% shortcuts
v = [1:3]
A = [1:3;4:6;7:9]
v = [1:2:10] %odd numbers from 1 to 10
v = [10:-2:1] %deceding even numbers from 10 to 1
%Problem: build a vector of 10 entries evenly spaced from 0 to 1
v = linspace(0,1,10)
%% concatenate matrices and vectors
v = [1:3]
w = [4:6]
y = [v;w] %stacks vectors on top 
z = [v w] %concatenates from the right 
%% useful functions for building specific matrices
%	zeros(n,m)  #NxM matrix of zeroes
%	ones(n,m)   #NxM matrix of ones
%	eye(n)      #NxN identity matrix 
%	diag(X)     #makes a diagonal matrix with vector as the diagonal
%	tril(A)     #takes lower triangle of A
%	triu(A)     #takes upper triangle of A
%% Importing data
data = readtable('WalMart~MATLAB.csv');
%% summary function 
summary(data)
data.Properties %to see what properties your data has 
data.Properties.VariableNames{3} = 'Temp' %If you want to change varable names
%% Indexing
column1 = data(:,1) %will return a table 
column1 = data{:,1} %will return a vector of the entries in that table column 
%sometimes you might be to lazy to find the column number for something so
%you can just type the varable name to pull it
Temp = data{:,'Temp'};
%you can also pull multiple columns with either numbers or via variable id
%We shall grab everything with numbers  
storestuff = data(:,[1 3 4 10 11]);
%you can also pull the values of a variable with dot notation
data.Temp
%% cell Array
% basically vectors but for strings
a = {'Male' 'Female' 'Male' 'Female' 'Female'}
%can use cell arrays to pull the columns via varaible id
storestuff2 = data(:,{'Store','Temp','Fuel_Price','CPI','Unemployment'});
%% categorical vectors
%The values for Store are saved as doubles when they are actually just
%labels. In our case since they are numbers we can still index into them
%using data(data.Store == 1,:) to grab all the rows with store 1. However,
%if the labels were strings instead we would not be able to index with 
%a == 'Male
%Thus we change it into a categorical array/vector instead
b = categorical(a)
b == 'Male'
%Another benefit of using categorical arrays is the amount of space used
%since we are now just treating 1 or 'Male' as a label instead of a double
%or a string
whos a b
c = categorical(data.Store);
whos c column1
%% aggregating functions
% We need to change the str variables into doubles first
storestuff.CPI = str2double(storestuff.CPI);
storestuff.Unemployment = str2double(storestuff.Unemployment);
mean_storestuff = grpstats(storestuff,'Store',@mean); %applies the mean fucntion to everything in the data frame grouped by 'Store'
mean_storestuff.GroupCount = []; % to remove a column we dont want
%% How to handle 'N/A'
mean(storestuff.CPI) %will return NaN since there are NaN values in CPI data
mean(storestuff.CPI,'omitnan') %will omit all the N/A entries when using the mean functions
%% change str to logical
holidays = data(:,{'Store','IsHoliday'});
holidays.IsHoliday = categorical(holidays.IsHoliday); %change to categorical
holidays.IsHoliday = holidays.IsHoliday == 'TRUE'; %change to 0/1
sum_holidays = grpstats(holidays,'Store',@sum);
sum_holidays.GroupCount = [];
% Pretty useless info since it just tells us that all the stores had 13
% holidays each i.e. the data is spread among the same days. We can use
% this to filter out the holidays from the original data but we will just
% use it to play around with the join function 
%% Joining tables
mean_both = join(mean_storestuff,sum_holidays);
%if you want to join tables of different length, the second table has to be
%smaller row wise
%test = join(mean_storeNtemp,storeNtemp) %will fail
test = join(storestuff,mean_storestuff);
%% inner join 
%if you want the left hand table to be smaller you can use an inner which
%will keep those with match values
testi = innerjoin(mean_storestuff,storestuff); %in this case every row has a matching key
%% outer join 
%whereas inner join removes rows without matching keys, oter join will keep
%everything and just put NA for columns that do not have matching keys
testO = outerjoin(mean_storestuff,storestuff);
%outer join, however, will create seperate columns for each key of the
%respective tables
%% MerkeKey
%We use 'mergekey' to avoid this
testO = outerjoin(mean_storestuff,storestuff,'Mergekey',true);
%% discretizing groups
%we can use the discretize function to seperate our temperatures into bins
%in order to help find patterns 
x = mean_storestuff.mean_Temp; %dummy var for convenience
y = discretize(x,linspace(min(x),max(x),4),'Categorical',{'Low','Middle','High'}); %4 number vector to have 3 bins
mean_both.Tgroups = y; %add in a new column called Tgroups with our categories
%% graphing
f = gscatter(mean_both.mean_Unemployment,mean_both.mean_CPI,mean_both.Tgroups) 
%graphs unemployment vs CPI color coded by our temp groups
%use interactive graph tool to adjust whatever you'd like
%% adding stuff manually
xlabel('Unemployment')
ylabel('CPI')
title('Unemployment vs CPI')
grid('on')
%% finding outliers/finding data from specific points
gname(mean_both.Store) %12 28 38 have same means weird
%% etc/indexing
data.Store = categorical(data.Store);
idx = any(data.Store == {'12' '28' '38'},2);
test = data(idx,{'Store','Unemployment','CPI'});
test.Unemployment = str2double(test.Unemployment);
test.CPI = str2double(test.CPI);
test.Store = categorical(test.Store);
test{test.Store == '12',2} == test{test.Store =='28',2} % weird 
%all data matches, only reason there is 0 at the end is because NaN == NaN
%returns false 
% double check in excel and all 3 are the same 

