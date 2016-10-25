function [const_plus, const_minus] = data_load(filename)
% DATA_LOAD	Load constants to model.
%	[CONST_PLUS, CONST_MINUS] = DATA_LOAD(FILENAME)
%   Load constants from file to model.
%
%	Constants are:
%	N+, N- -- quantities of number sets. Must be positive integers.
%
%	Happa+, Happa- -- eigenvalues. Must be positive.
%
%	b+, b- -- factor before reversed exponent.
%	Elements with odd index must be positive, even -- negative.
%
%	See also DLMREAD, class CONST.
	N_temp = dlmread(filename,';',[0 0 0 1]);	% Load quantities
    % Check for positiveness of quantities
	assert((N_temp(1, 1) >= 1) && (N_temp(1, 2) >= 1), ...
        'N must be positive.')
    % Load other constants
	raw_plus = dlmread(filename,';',[1 0 2 (N_temp(1, 1) - 1)]);
	raw_minus = dlmread(filename,';',[3 0 4 (N_temp(1, 2) - 1)]);
    % Construct objects from loaded data
	const_plus = consts(N_temp(1, 1), raw_plus(1), raw_plus(2));
	const_minus = consts(N_temp(1, 2), raw_minus(1), raw_minus(2));
	