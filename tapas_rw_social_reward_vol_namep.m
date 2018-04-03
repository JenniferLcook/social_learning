function pstruct = tapas_rw_binary_namep(pvec)
% --------------------------------------------------------------------------------------------------
% Copyright (C) 2012-2013 Christoph Mathys, TNU, UZH & ETHZ
%
% This file is part of the HGF toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.
%
% Edited 14/01/2018 by JCook to estimate separate alpha values for volatile
% and stable blocks


pstruct = struct;

pstruct.vr_0  = pvec(1);
pstruct.al_s_r  = pvec(2);
pstruct.al_v_r  = pvec(3);

pstruct.va_0  = pvec(4);
pstruct.al_s_a  = pvec(5);
pstruct.al_v_a  = pvec(6);

return;