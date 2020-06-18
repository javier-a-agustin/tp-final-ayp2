with pila;
with Text_IO; use Text_IO;
procedure test_unidad_pila is
   package pila_enteros is new pila(integer);
   use pila_enteros;

   infos:  array (integer range <>) of integer := (25,15,100,9,20,3,18,23,75,120,90);

   procedure test_apilar(p: in out tipoPila;errores: in out integer) is
   begin
      for i in infos'range loop
         apilar(p, infos(i));
         put_line("TEST_APILAR: OK: Apilando.. " & Integer'Image(infos(i)));
      end loop;
   exception
      when operacionNoImplementada =>
        put_line("TEST_APILAR: Error. OPERACION APILAR no implementada.");
        errores:=errores+1;
   end test_apilar;


   procedure test_desapilar(p: in out tipoPila; errores: in out integer) is
   	j: integer;
   begin
      for i in reverse infos'range loop
         Begin
            tope(p,j);
            if (infos(i)/=j) then
               errores := errores +1;
               put_line("TEST_DESAPILAR: Error. Se esperaba" & integer'Image(j) & " Se encontro: " & integer'Image(i));
            else
               put_line("TEST_DESAPILAR: OK: Desapilando.. " & Integer'Image(infos(i)));
            end if;
            desapilar(p);
         exception
            when pilaVacia =>
               put_line("TEST_DESAPILAR: Error. PilaVacia inesperada");
               errores:=errores+1;
            when pilaLlena =>
               put_line("TEST_DESAPILAR: Error. PilaLlena inesperada");
               errores:=errores+1;
            when operacionNoImplementada =>
               put_line("TEST_DESAPILAR: Error. OPERACION TOPE O DESAPILAR no implementada");
               errores:=errores+1;

         end;
      end loop;
      if (not esVacia(p)) then
         put_line("TEST_DESAPILAR: Error. Pila con elementos, se esperaba vacia.");
         errores:= errores +1;
      end if;
   end test_desapilar;

   p: tipoPila;
   errores: integer:=0;
begin
   crear(p);
   test_apilar(p, errores);
   test_desapilar(p, errores);
   put_line("TOTAL DE ERRORES: " & Integer'Image(errores));
end test_unidad_pila;
