function f_obj = f_obj(imagen_original, fudge, nu)
    bordes_imagen = bordes(imagen_original, fudge);
    f_obj = funcional(imagen_original, bordes_imagen, nu);
end

