%{
## Copyright (C) 2007 Muthiah Annamalai <muthiah.annamalai@uta.edu>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {Function File} {} reedmullerenc (@var{MSG}, @var{R}, @var{M})
##
## Definition type construction of Reed-Muller code,
## of order @var{R}, length @math{2^M}. This function
## returns the generator matrix for the said order RM code.
##
## Encodes the given message word/block, of column size k,
## corresponding to the RM(@var{R},@var{M}), and outputs a
## code matrix @var{C}, on each row with corresponding codeword.
## The second return value is the @var{G}, which is generator matrix
## used for this code.
##
## @example
## @group
## msg = rand (10, 11) > 0.5;
## [c, g] = reedmullerenc (msg, 2, 4);
## @end group
## @end example
## @seealso{reedmullerdec, reedmullergen}
## @end deftypefn
%}

function [C, G] = reedmullerenc (MSG, R, M)

  if (nargin ~= 3)
    print_usage ();
  end
  
  G = reedmullergen (R, M);
  
  if (size(MSG, 2) ~= size(G, 1))
    error ("reedmullerenc: MSG must be a matrix with K columns");
  end
  
  C = zeros (size(MSG, 1), 2.^M);
  
  for idx = 1:size(MSG, 1)
    C(idx,:) = mod (MSG(idx,:)*G, 2);
  end

end

%% Test input validation
%!error reedmullerenc ()
%!error reedmullerenc (1)
%!error reedmullerenc (1, 2)
%!error reedmullerenc (1, 2, 3, 4)
