function f_obj = f_obj(imagen_original, sensibilidad, nu)
    bordes_imagen = bordes(imagen_original, sensibilidad);
    f_obj = funcional(imagen_original, bordes_imagen, nu);
end

