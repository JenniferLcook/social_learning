function c = tapas_rw_social_reward_vol_config
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Contains the configuration for the Rescorla-Wagner (RW) learning model for binary inputs.
%
% The RW model was introduced in :
%
% Rescorla, R. A., and Wagner, A. R. (1972). "A theory of Pavlovian conditioning:
% Variations in the effectiveness of reinforcement," in Classical Conditioning
% II: Current Research and Theory, eds. A. H. Black and W. F. Prokasy (New
% York: Appleton-Century-Crofts), 64-99.
%
% Edited 14/01/2018 by JCook to estimate separate alpha values for volatile
% and stable blocks
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% The RW configuration consists of the priors of the learning rate alpha and the initial value v_0
% of the value v. The priors are Gaussian in the space where the parameters they refer to are
% estimated. They are specified by their sufficient statistics: mean and variance (NOT standard
% deviation).
% 
% Both alpha and v_0 are estimated in 'logit-space' because they are bounded inside the unit
% interval.
%
% 'Logit-space' is a logistic sigmoid transformation of native space
% 
% tapas_logit(x) = ln(x/(1-x)); x = 1/(1+exp(-tapas_logit(x)))
%
% Any of the parameters can be fixed (i.e., set to a fixed value) by setting the variance of their
% prior to zero. To fix v_0 to 0.5 set the mean as well as the variance of the prior to zero.
%
% Fitted trajectories can be plotted by using the command
%
% >> tapas_rw_binary_plotTraj(est)
% 
% where est is the stucture returned by tapas_fitModel. This structure contains the estimated
% parameters alpha and v_0 in est.p_prc and the estimated trajectories of the agent's
% representations:
%              
%         est.p_prc.v_0      initial value of v
%         est.p_prc.alpha    alpha
%
%         est.traj.v         value: v
%         est.traj.da        prediction error: delta
%
% Tips:
% - Your guide to all these adjustments is the log-model evidence (LME). Whenever the LME increases
%   by at least 3 across datasets, the adjustment was a good idea and can be justified by just this:
%   the LME increased, so you had a better model.
%
% --------------------------------------------------------------------------------------------------
% Copyright (C) 2012-2013 Christoph Mathys, Andreea Diaconescu TNU, UZH & ETHZ
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.

% Config structure
c = struct;

% Model name
c.model = 'tapas_rw_social_reward_vol';

% Initial v
c.logitvr_0mu = tapas_logit(0.5, 1);
c.logitvr_0sa = 0;

c.logitva_0mu = tapas_logit(0.5, 1);
c.logitva_0sa = 0;

% Alpha
c.logit_als_rmu = tapas_logit(0.2, 1);
c.logit_als_rsa = 1;

c.logit_alv_rmu = tapas_logit(0.2, 1);
c.logit_alv_rsa = 1;

c.logit_als_amu = tapas_logit(0.2, 1);
c.logit_als_asa = 1;

c.logit_alv_amu = tapas_logit(0.2, 1);
c.logit_alv_asa = 1;

% Gather prior settings in vectors
c.priormus = [
    c.logitvr_0mu,...
    c.logit_als_rmu,...
    c.logit_alv_rmu,...
    c.logitva_0mu,...
    c.logit_als_amu,...
    c.logit_alv_amu,...
         ];

c.priorsas = [
    c.logitvr_0sa,...
    c.logit_als_rsa,...
    c.logit_alv_rsa,...
    c.logitva_0sa,...
    c.logit_als_asa,...
    c.logit_alv_asa,...
         ];

% Model function handle
c.prc_fun = @tapas_rw_social_reward_vol;

% Handle to function that transforms perceptual parameters to their native space
% from the space they are estimated in
c.transp_prc_fun = @tapas_rw_social_reward_vol_transp;

return;
