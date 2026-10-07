% example from https://www.minizinc.org/doc-2.5.5/en/modelling.html 


%A banana cake which takes 250g of self-raising flour, 2 mashed bananas, 75g sugar and 100g of butter, and a 
%chocolate cake which takes 200g of self-raising flour, 75g of cocoa, 150g sugar and 150g of butter. 
 
%And we have 4kg self-raising flour, 6 bananas, 2kg of sugar, 500g of butter and 500g of cocoa.

%We can sell a chocolate cake for $4.50 and a banana cake for $4.00.

% Baking cakes for the school fete

var 0..100: b; % no. of banana cakes
var 0..100: c; % no. of chocolate cakes

% flour
constraint 250*b + 200*c <= 4000;
% bananas
constraint 2*b  <= 6;
% sugar
constraint 75*b + 150*c <= 2000;
% butter
constraint 100*b + 150*c <= 500;
% cocoa
constraint 75*c <= 500;

constraint 400*b + 450*c >= 1000;
%constraint b >= 2;
%constraint c >= 3;

% maximize our profit
%solve maximize 40*b + 450*c;
solve satisfy;

output ["no. of banana cakes = \(b)\n",
         "no. of chocolate cakes = \(c)\n"];