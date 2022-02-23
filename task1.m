% read csv file and consider closing price for 7MA and 14MA
A = readtable('JET.L.csv');
data = A.Close;

% step 1 finds 7MA and length of 7MA
type = 'simple';
sevenm = movavg(data ,type,7);
sevenma_length = length(sevenm);

% step 2 finds 14MA and length of 7MA
fourteenm = movavg(data ,type,14);

% plot figure for 7MA and 14MA
% plot(data)
% hold on
% plot(fourteenm)
% plot(sevenm)
% hold off
% legend('Actual','fourteenm','sevenm')


budget = 1000000;
share = 0;
final_result = string([]);
header = {'Day', 'Buy/Sell', 'Date', 'Budget', 'Share'};

% start selling and buying using condition
for i=15: sevenma_length
    if(sevenm(i) > fourteenm(i))
        buyshare = floor(budget/data(i));  
        if(buyshare > 0)
            budget = budget - (buyshare * data(i));
            share = share + buyshare;
            date = string(A.Date(i), "yyyy-MM-dd");
            final_result(end+1, :) = [i "th row buy on " date budget share];
        end
    elseif (sevenm(i) < fourteenm(i) && share > 0)
        amount = (share * data(i));
        budget = budget + amount;
        share = share - share;
        date = string(A.Date(i), "yyyy-MM-dd");
        final_result(end+1, :) = [i "th row sell on" date budget share];
    end
end
% step 3 gets when buy and sell and how much buy and what's the budget when buy and sell
data_matrix = [header; final_result];

% step 4 Profit at the end of process
profit = budget - 1000000;
