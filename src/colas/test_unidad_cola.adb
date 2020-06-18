with cola;
with Text_IO; use Text_IO;
procedure test_unidad_cola is
   package cola_enteros is new cola(integer);
   use cola_enteros;

   infos:  array (integer range <>) of integer := (25,15,100,9,20,3,18,23,75,120,90);

   procedure test_encolar(q: in out tipoCola;errores: in out integer) is
   begin
      for i in infos'range loop
         encolar(q, infos(i));
         put_line("TEST_ENCOLAR: OK: Encolando.. " & Integer'Image(infos(i)));
      end loop;
   exception
      when operacionNoImplementada =>
        put_line("TEST_ENCOLAR: Error. OPERACION Encolar no implementada.");
        errores:=errores+1;
   end test_encolar;


   procedure test_desencolar(q: in out tipoCola; errores: in out integer) is
   	j: integer;
   begin
      for i in infos'range loop
         Begin
            frente(q,j);
            if (infos(i)/=j) then
               errores := errores +1;
               put_line("TEST_DESENCOLAR: Error. Se esperaba" & integer'Image(j) & " Se encontro: " & integer'Image(i));
            else
               put_line("TEST_DESENCOLAR: Frente OK: " & Integer'Image(infos(i)));
            end if;
            desencolar(q);
            put_line("TEST_DESENCOLAR: DESENCOLAR OK: " & Integer'Image(infos(i)));
         exception
            when colaVacia =>
               put_line("TEST_DESENCOLAR: Error. ColaVacia inesperada");
               errores:=errores+1;
            when colaLlena =>
               put_line("TEST_DESAPILAR: Error. ColaLlena inesperada");
               errores:=errores+1;
            when operacionNoImplementada =>
               put_line("TEST_DESENCOLAR: Error. OPERACION FRENTE O DESENCOLAR no implementada");
               errores:=errores+1;

         end;
      end loop;
      if (not esVacia(q)) then
         put_line("TEST_DESENCOLAR: Error. COLA con elementos, se esperaba vacia.");
         errores:= errores +1;
      end if;
   end test_desencolar;

   q: tipoCola;
   errores: integer:=0;
begin
   crear(q);
   test_encolar(q, errores);
   test_desencolar(q, errores);
   put_line("TOTAL DE ERRORES: " & Integer'Image(errores));
end test_unidad_cola;
