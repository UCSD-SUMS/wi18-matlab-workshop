% Test function for MATLAB workshop

% wobble wobble
function y = Matlabtest(x)
%% for loop example1: indexing from a vector
x = 10;
sum1 = 0;
for i = 1:x %you can index from linspace since it is a vector but you generally don't
            %to index backward simply build the backward vector x:-1:1
    sum1 = sum1 + i;
end
sprintf('sum of first %.f integers is %.f',x,sum1)
%% for loop example3: indexing from a matrix 
sum3 = 0 ;
A = [1:3;4:6;7:9]; %never really do this but this is what happens if you do 
for i = A
    sum3 = sum3 + i;
end
sum3
%% While loops
% generally use while loops when you don't know when to stop 
% thus you need an exit criteria (an epislon or an upper bound) 
% and/or an index
%Exaple: from taylor approximation we know when x is close to 0, sin(x) is
%approximately x. 
    %Question: how close to 0 do we have to be for |sin(x) - x| < epsilon 
epsilon = 1e-5;
x = 0.5;
counter = 1;
while(abs(sin(x) - x) > epsilon)
    x = x - 1e-6; %Use ctrl + c to break out of loops in command window if you get stuck in infinite loop
    counter = counter + 1;
end
sprintf('after %.f iterations we get x = %f',counter,x)
%% If and if-else
%Requires logicals:
   % & (and)
   % == (check equivalence)
   % | (or = and/or since its a "math" or) 
   % ~ (negation)
a = 10;
b = 5;
if a == 10 & b ~= 5
    sprintf('a is 10 and b is not 5')
elseif a == 15 | b == 5
    sprintf('a is 15 or b is 5')
else 
    sprintf('Neither')
end

y = 10; % since we defined the function to spit out a y, 
        %this is what it will return if we try to assing the function to a variable
end

