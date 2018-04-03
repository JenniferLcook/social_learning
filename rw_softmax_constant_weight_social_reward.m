function logp = rw_softmax_constant_weight_social_reward(r, infStates, ptrans)
% Calculates the log-probability of response y=1 under the IOIO response model with constant
% weight zeta_1
%
% --------------------------------------------------------------------------------------------------
% Copyright (C) 2012-2015 Christoph Mathys, Andreea Diaconescu TNU, UZH & ETHZ
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.
%
% Edited 14/01/2018 by JCook to use learned value of utility of advice to weight the advice that was provided on each trial

% Transform zetas to their native space
ze1 = sgm(ptrans(1),1);
ze2 = exp(ptrans(2));

% Initialize returned log-probabilities as NaNs so that NaN is
% returned for all irregualar trials
logp = NaN(length(infStates),1);

% Weed irregular trials out from inferred states, cue inputs, and responses
x = infStates(:,1,1);
x(r.irr) = [];

% Weed irregular trials out from inferred states, cue inputs, and responses
x_r = infStates(:,1,1);
x_r(r.irr) = [];

x_a = infStates(:,1,2);
x_a(r.irr) = [];

y = r.y(:,1);
y(r.irr) = [];

y = r.y(:,1);
y(r.irr) = [];

% Belief vector
j = find(r.advice==0);
x_a(j,1) = 1-x_a(j,1); % JC. Use learned value of utility of advice to weight the advice that was provided on each trial
b = ze1.*x_a + (1-ze1).*x_r;

% Calculate log-probabilities for non-irregular trials
logp(not(ismember(1:length(logp),r.irr))) = y.*ze2.*log(b./(1-b)) +log((1-b).^ze2 ./((1-b).^ze2 +b.^ze2));

return;
