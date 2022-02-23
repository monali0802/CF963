% Step 1 decide random 20 buyer price
buyer = randi([1 200],1,20);
bid = [];
total_unit = 0;

% Step 2 set qunatity and seller unit 
for seller=1:length(buyer)
    unit_seller(seller) = 30;
end

% Simulator for 10 round
for i=1:10
    % set bid 
    for j=1:length(buyer)
       bid(j) = randi([1 buyer(j)]);
       quantity_buy(j) = randi([1 5]);
    end
    [maximum_bid,maximum_bid_index] = max(bid(:));
    quantity = quantity_buy(maximum_bid_index);
    
    % set ask
    intial = 10;
    for s=1:length(buyer)
        ask(s) = randi([intial 200]);
        intial = intial + 10;
    end
    [minimum_ask,minimum_ask_index] = min(ask(:));
    unit = unit_seller(minimum_ask_index);
    
    % check seller has unit > buyer quantity
    if(unit > quantity)
        remaining_unit = unit - quantity;
        unit_seller(minimum_ask_index) = remaining_unit;
    else 
        need_from_other_seller = quantity - unit;
        remaining_unit = 0;
        unit_seller(minimum_ask_index) = remaining_unit;
        [minimum_second_ask,minimum_second_ask_index] = min(setdiff(ask(:),min(ask(:))));
        unit_other = unit_seller(minimum_second_ask_index);
        if(unit_other > need_from_other_seller)
            remaining_unit_s = unit_other - need_from_other_seller;
            unit_seller(minimum_second_ask_index) = remaining_unit_s;
        end
    end
    % Step 3 Total unit 
    total_unit = total_unit + quantity;
    % Step 4 find difference between bid and ask   
    spread(i) = maximum_bid - minimum_ask;
end

total_unit;
spread;
array_unit_price = [];
for x=1:length(buyer)
    array_unit_price(end+1,:) = [unit_seller(x) ask(x)];
end    
% Step 5 remaining unit and price
array_unit_price;

% plot figure for spread
plot(10)
hold on
plot(spread)
hold off
legend('Simulation','spread')