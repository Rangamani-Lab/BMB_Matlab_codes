
function da=fun_s_red(t,C,k_gef,k_gap,k_tilde,k_on)

da=[-k_gef*C(1)+k_gap*C(2)
    k_gef*C(1) - k_gap*C(2) - k_tilde*(1-C(4))*C(2)
    k_tilde*C(4)*(1-C(3)) - k_gap*C(3)
    k_on*(1-C(4))*C(2)
    ];
end
 


