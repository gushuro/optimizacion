function triseccion = triseccion(a0,b0,f, xk, dk)
    a = a0;
    b = b0;
    tol = 0.0001;
    
    while norm(b-a) > tol
        x1 = a + (b-a)/3;
        x2 = a + (b-a)*2/3;
        phix1 = f(xk(1) + x1*dk(1), xk(2) + x1*dk(2));
        phix2 = f(xk(1) + x2*dk(1), xk(2) + x2*dk(2));
        
        if phix1 < phix2 -tol
            b = x2;
        elseif phix1 > phix2 + tol
            a = x1;
        else
            a = x1;
            b = x2;
        end
    end
    triseccion = (a+b)/2; 
   
end
