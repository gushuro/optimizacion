function phi = phi(f,x,d,t)
    phi = @f(x+t*d,y+td);
end
