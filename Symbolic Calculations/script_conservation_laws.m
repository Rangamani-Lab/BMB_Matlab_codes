clear all; close all; clc % fresh start


% load stoichometric matrices for Arrows 1, 1+2 and 1+2+3
A1  = sym([-1 1 0 0 0 0 0;1 -1 -1 0 0 0 0;0 0 0 -1 1 0 0;0 0 0 1 -1 0 0;0 0 -1 0 0 0 0;0 0 1 0 0 0 0;0 0 0 0 0 0 0;0 0 0 0 0 0 0])
A12 = sym([-1 1 0 0 0 0 0; 1 -1 -1 0 0 0 0;0 0 0 -1 1 0 0; 0 0 0 1 -1 0 0; 0 0 -1 0 0 0 0; 0 0 1 0 0 0 -1; 0 0 0 0 0 0 -1;0 0 0 0 0  0 1]);
A123 = sym([-1 1 0 0 0 0 0;1 -1 -1 0 0 0 0;0 0 0 -1 1 0 0; 0 0 0 1 -1 -1 0;0 0 -1 0 0 0 0;0 0 1 0 0 0 -1;0 0 0 0 0 -1 -1;0 0 0 0 0 1 1]);


% Compute left null space (right null space of transpose matrices). The
% number of columns gives number of conservation laws in the system
N_1     = null(A1.');
N_12    = null(A12.');
N_123   = null(A123.');

