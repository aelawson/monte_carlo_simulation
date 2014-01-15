% Monte Carlo Area Calculation
% February 19, 2012
% Andrew Lawson

% This is a Monte Carlo simulation of potatoes being fired upon a square
% island in a circular pond.

clc
clf
clear

disp('----------');
disp('Monte Carlo Area Calculation');
disp('----------');

% Initial variables. Allows user to assign different amounts to some variables.

potatoes = input('How many potatoes do you want to fire: ');
pondRadius = input('What radius should the pond have: ');
islandSide = input('What side length should the island have: ');
potatoIsland = 0;
potatoPond = 0;
potatoMiss = 0;

% Graphically plots the pond and island.

axis([-pondRadius, pondRadius, -pondRadius, pondRadius]);
axis equal;
hold on;
theta = 0 : 0.1 : 8 * pi;
x = pondRadius * cos(theta);
y = pondRadius * sin(theta);
plot(x, y, 'k')
half = islandSide / 2;
x1 = [-half, half, half, -half, -half];
y1 = [-half, -half, half, half, -half];
plot(x1, y1, 'r')

% While loop. Generates random cartesian coordinates for each potato
% launched, plots these coordinates (where the potato landed),
% and calculates the amount of potatoes in each zone (island,
% pond, or neither).

while (potatoes > 0)
    X = (rand() * (2 * pondRadius)) - pondRadius;
    Y = (rand() * (2 * pondRadius)) - pondRadius;
    if ((abs(X) <= (islandSide / 2)) && (abs(Y) <= (islandSide / 2)))
        plot(X, Y, 'ro');
        potatoIsland = potatoIsland + 1;
    elseif (sqrt(X^2 + Y^2) <= pondRadius)
        plot(X, Y, 'b*');
        potatoPond = potatoPond + 1;
    else
        plot(X, Y, 'g+');
        potatoMiss = potatoMiss + 1;
    end
    potatoes = potatoes - 1;
end

% Calculates the actual area value, observational area value (Monte Carlo),
% and the percent error between the two.

pondArea = (pondRadius^2 * pi);
islandAreaRatioObserv = (potatoIsland) / (potatoPond + potatoIsland);
islandAreaObserv = islandAreaRatioObserv * pondArea;
islandAreaTrue = islandSide^2;
islandAreaPE = ((abs(islandAreaObserv - islandAreaTrue)) / islandAreaTrue) * 100;


% Outputs the results; the number of potatoes that hit the island,
% pond, and the number that missed completely.

disp('----------');
disp('Results:');
disp('----------');
fprintf('Number of potatoes that hit the island: %d\n', potatoIsland);
fprintf('Number of potatoes that hit the pond: %d\n', potatoPond);
fprintf('Number of potatoes that missed completely: %d\n', potatoMiss);
fprintf('The observed area of the island is: %0.3f square units.\n', islandAreaObserv);
fprintf('The actual area of the island is: %0.3f square units.\n', islandAreaTrue);
fprintf('The actual area of the pond is: %0.3f square units.\n', pondArea);

% Outputs the percent error between the simulated results and actual data.

disp('----------');
disp('Error:');
disp('----------');
fprintf('The amount of error in the simulation is: %0.3f percent.\n', islandAreaPE);

hold off
