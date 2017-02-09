classdef consts
    % CONST Class for representing constants as one object
    %   Objects of this class represent constants for later calculations.
    
    properties (SetAccess = immutable)
        N uint8    % Quantity of numbers in set. Must be positive integer.
        happa      % Array of eigenvalues. Must be positive.
        
        % b - Array of factors before reversed exponent, where
        % elements with odd index must be positive, even -- negative.
        b
    end
    
    methods
        function obj = consts(n, Happa, B, varargin)
            % Constructor for CONST object. 
            % [CONST] = CONST(N, HAPPA, B) or [CONST] = CONST()
            % Before assignment tries run default constructor statements,
            % then checks for argument correctness.
            % All arguments must be numeric values.
    
            if nargin == 0
                obj.N = 1;
                obj.happa = 0.5;
                obj.b = 0.25;
                return
            end
            assert(isvector([Happa, B]), ...
                'Input values (exclude quantity) must be vectors.')
            assert(isnumeric([n, Happa, B]), ...
                'Input values must be numeric.')
            assert(n >= 1, 'N must be positive.')
            assert(all(Happa > 0.0), 'All Happa must be positive.')
            assert(all(B(1:2:n) > 0.0) && ...
                ((n < 2) || all(B(2:2:n) < 0.0)), ...
                'Incorrect b initialisation.')
            obj.N = uint8(n);
            obj.happa = Happa;
            obj.b = B;
            if(~iscolumn(obj.happa))
                obj.happa = obj.happa.';
            end
            if(~iscolumn(obj.b))
                obj.b = obj.b.';
            end
            for v_s = 1:length(varargin)
                switch varargin{v_s}
                    case 'InverseB'
                        obj.b = -obj.b;
                end
            end
        end
    end
    
end

