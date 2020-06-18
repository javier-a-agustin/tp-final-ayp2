package utiles is

   -- Que hace: Muestra un mensaje al usuario y devuelve verdadero o falso.
   -- Precondiciones: m=M
   -- Poscondiciones: confirma = V si el usuario confirma, falso sino.
   function confirma(mensaje: string) return boolean;

   -- Que hace: Muestra un mensaje al usuario y espera a que presione una tecla.
   -- Precondiciones: m = M
   -- Poscondiciones: no tiene.
   procedure continua(mensaje: string);

   -- Que hace: Muestra un mensaje al usuario y devuelve el entero ingresado.
   -- Precondiciones: m=M
   -- Poscondiciones: numeroEnt = N y N es entero.
   function numeroEnt(mensaje: string) return integer;

   -- Que hace: Muestra un mensaje al usuario y devuelve el real ingresado.
   -- Precondiciones: m=M
   -- Poscondiciones: numeroReal = R y R es un float.
   function numeroReal(mensaje: string) return float;

   -- Que hace: Muestra un mensaje al usuario y devuelve el entero ingresado.
   -- Precondiciones: m=M, rangoInf= RI, rangoSup= RS
   -- Poscondiciones: enteroEnRango = N y RI <= N <= RS.
   function enteroEnRango(mensaje:string; rangoInf, rangoSup: integer) return integer;

   -- Que hace: Muestra un mensaje al usuario y devuelve el real ingresado.
   -- Precondiciones: m=M, rangoInf= RI, rangoSup= RS
   -- Poscondiciones: realEnRango = R y RI <= R <= RS.
   function realEnRango(mensaje:string; rangoInf, rangoSup: float) return float;

   -- Que hace: Muestra un mensaje al usuario y devuelve una cadena ingresada.
   -- Precondiciones: m=M
   -- Poscondiciones: textoNoVacio = S y longitud(S) > 0.
   function textoNoVacio(mensaje:string) return string;

   -- Que hace: Limpia la pantalla.
   -- Precondiciones: no tiene.
   -- Poscondiciones: no tiene.
   procedure CLS;

end utiles;
