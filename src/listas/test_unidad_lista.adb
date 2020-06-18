with Text_IO, utiles;
use Text_IO, utiles;


with lista;

procedure test_unidad_lista is

   subtype TipoInfo is Integer;
   subtype TipoClave is Integer;

   package mi_lista is new lista(TipoClave, TipoInfo, "<", "=");
   use mi_lista;


   claves: array (integer range <>) of integer := (25,15,100,9,20,3,18,23,75,120,90);
   infos:  array (integer range <>) of integer := (25,15,100,9,20,3,18,23,75,120,90);

   procedure test_insertar (l: in out tipoLista; errores: in out integer) is
   begin
      for i in claves'Range loop
         insertar(l,claves(i),infos(i));
      end loop;
      begin
         insertar(l,claves(claves'First),infos(infos'First));
         put_line ("TEST_INSERTAR: no se lanzo excepcion esperada: ClaveExiste.");
         errores:=errores+1;
      exception
         when claveExiste => null;
         when others=>
            put_line ("TEST_INSERTAR: Error en insertar, excepcion inesperada.");
            errores:=errores+1;
      end;
      if (longitud(l)/=claves'Length) then
         put_line ("TEST_INSERTAR: Longitud incorrecta.");
         errores:=errores+1;
      end if;

   exception
      when others =>
         put_line ("TEST_INSERTAR: Error en insertar, excepcion inesperada.");
         errores:=errores+1;
   end test_insertar;

   procedure test_modificar (l: in out tipoLista; errores: in out integer) is
      info: integer;
   begin
      for i in claves'Range loop
         modificar(l,claves(i), -infos(i));
		 recuclave(l, claves(i), info);
		 If info /= -infos(i) then
			 put_line ("TEST_MODIFICAR: modificacion de info incorrecta.");
			 errores := errores + 1;
		 end if;
		 
         modificar(l,claves(i), infos(i));
		 recuclave(l, claves(i), info);
		 If info /= infos(i) then
			 put_line ("TEST_MODIFICAR: modificacion de info incorrecta.");
			 errores := errores + 1;
		 end if;
      end loop;
      begin
         modificar(l, -1, infos(infos'First));
         put_line ("TEST_MODIFICAR: no se lanzo excepcion esperada: ClaveNoExiste.");
         errores:=errores+1;
      exception
         when claveNoExiste => null;
         when others=>
            put_line ("TEST_MODIFICAR: Error en modificar, excepcion inesperada.");
            errores:=errores+1;
      end;

   exception
      when others =>
         put_line ("TEST_MODIFICAR: Error en modificar, excepcion inesperada.");
         errores:=errores+1;
   end test_modificar;

   procedure test_suprimir (l: in out tipoLista; errores: in out integer) is
      prim: tipoClave;
   begin
      begin
         suprimir(l,3); -- Eliminando al inicio.
      exception
         when others =>
            put_line ("TEST_SUPRIMIR: suprimir al inicio, excepcion inesperada");
            errores:=errores+1;
      end;
      begin
         suprimir(l,3); -- Clave inexistente.
         suprimir(l,1000); -- Clave inexistente, pero al final.
      exception
         when claveNoExiste => null;
         when others =>
            put_line ("TEST_SUPRIMIR: Error se esperaba ClaveNoExiste");
            errores:=errores+1;
      end;

      if (longitud(l)/=(claves'Length-1)) then
         put_line ("TEST_SUPRIMIR: Longitud incorrecta suprimiendo al inicio.");
         errores:=errores+1;
      end if;

      begin
         suprimir(l,120); -- Eliminando al final.
      exception
         when others =>
            put_line ("TEST_SUPRIMIR: suprimir al final, excepcion inesperada");
            errores:=errores+1;
      end;
      if (longitud(l)/=(claves'Length-2)) then
         put_line ("TEST_SUPRIMIR: Longitud incorrecta suprimiendo al final.");
         errores:=errores+1;
      end if;

      begin
         suprimir(l,75); -- Eliminando por ahi.
      exception
         when others =>
            put_line ("TEST_SUPRIMIR: suprimir al medio, excepcion inesperada");
            errores:=errores+1;
      end;
      if (longitud(l)/=(claves'Length-3)) then
         put_line ("TEST_SUPRIMIR: Longitud incorrecta suprimiendo al medio.");
         errores:=errores+1;
      end if;

      while (not esVacia(l)) loop
         recuPrim(l,prim);
         suprimir(l,prim);
      end loop;
      if (longitud(l)/=0) then
         put_line ("TEST_SUPRIMIR: Longitud incorrecta suprimiendo resto.");
         errores:=errores+1;
      end if;
      test_insertar(l, errores);

   exception
      when others =>
         put_line ("TEST_SUPRIMIR: Error en suprimir, excepcion inesperada.");
         errores:=errores+1;
   end test_suprimir;

   procedure test_recuClave (l: in out tipoLista; errores: in out integer) is
      info: integer;
   begin
      for i in claves'Range loop
		 recuclave(l, claves(i), info);
		 If info /= infos(i) then
			 put_line ("TEST_RECUCLAVE: info incorrecta.");
			 errores := errores + 1;
		 end if;
      end loop;
      begin
         modificar(l, -1, infos(infos'First));
         put_line ("TEST_RECUCLAVE: no se lanzo excepcion esperada: ClaveNoExiste.");
         errores:=errores+1;
      exception
         when claveNoExiste => null;
         when others=>
            put_line ("TEST_RECUCLAVE: Error en recuClave, excepcion inesperada.");
            errores:=errores+1;
      end;
   exception
      when others =>
         put_line ("TEST_RECUCLAVE: Error en recuClave, excepcion inesperada.");
         errores:=errores+1;
   end test_recuClave;


   procedure test_recuprim (l: in out tipoLista; errores: in out integer) is
      l2: tipoLista;
      prim:tipoClave;
   begin
      begin
         crear(l2);
         recuprim(l2,prim);
         put_line ("TEST_RECUPRIM: no se lanzo excepcion esperada: listaVacia.");
         errores:=errores+1;
      exception
         when listaVacia => null;
         when others=>
            put_line ("TEST_RECUPRIM: Error en recuprim, excepcion inesperada.");
            errores:=errores+1;
      end;
      recuprim(l,prim);
      if (prim/=3) then
         put_line ("TEST_RECUPRIM: Error en recuprim, primero encontrado incorrecto.");
         errores:=errores+1;
      end if;

   exception
      when others =>
         put_line ("TEST_RECUPRIM: Error en recuprim, excepcion inesperada.");
         errores:=errores+1;
   end test_recuprim;

   procedure test_recuUlt (l: in out tipoLista; errores: in out integer) is
      l2: tipoLista;
      ult:tipoClave;
   begin
      begin
         crear(l2);
         recuult(l2,ult);
         put_line ("TEST_RECUULT: no se lanzo excepcion esperada: listaVacia.");
         errores:=errores+1;
      exception
         when listaVacia => null;
         when others=>
            put_line ("TEST_RECUULT: Error en recuUlt, excepcion inesperada.");
            errores:=errores+1;
      end;
      recuUlt(l,ult);
      if (ult/=120) then
         put_line ("TEST_RECUULT: Error en recuUlt, ultimo encontrado incorrecto.");
         errores:=errores+1;
      end if;

   exception
      when others =>
         put_line ("TEST_RECUULT: Error en recuUlt, excepcion inesperada.");
         errores:=errores+1;
   end test_recuUlt;

   procedure test_recuSig (l: in out tipoLista; errores: in out integer) is
      aux:tipoClave;
   begin
      begin
         recuSig(l,12321,aux);
         put_line ("TEST_RECUSIG: no se lanzo excepcion esperada: claveNoExiste.");
         errores:=errores+1;
      exception
         when claveNoExiste => null;
         when others=>
            put_line ("TEST_RECUSIG: Error en recuSig, excepcion inesperada, se esperaba claveNoExiste.");
            errores:=errores+1;
      end;

      begin
         recuSig(l,120,aux);
         put_line ("TEST_RECUSIG: no se lanzo excepcion esperada: claveEsUltima.");
         errores:=errores+1;
      exception
         when claveEsUltima => null;
         when others=>
            put_line ("TEST_RECUSIG: Error en recuSig, excepcion inesperada.");
            errores:=errores+1;
      end;
      recuSig(l,100,aux);
      if (aux/=120) then
         put_line ("TEST_RECUSIG: Error en recuSig, siguiente encontrado incorrecto.");
         errores:=errores+1;
      end if;

   exception
      when others =>
         put_line ("TEST_RECUSIG: Error en recuSig, excepcion inesperada.");
         errores:=errores+1;
   end test_recuSig;

   procedure test_recuAnt (l: in out tipoLista; errores: in out integer) is
      aux:tipoClave;
   begin
       begin
         recuAnt(l,12321,aux);
         put_line ("TEST_RECUANT: no se lanzo excepcion esperada: claveNoExiste.");
         errores:=errores+1;
      exception
         when claveNoExiste => null;
         when others=>
            put_line ("TEST_RECUANT: Error en recuAnt, excepcion inesperada, se esperaba claveNoExiste.");
            errores:=errores+1;
      end;

      begin
         recuAnt(l,3,aux);
         put_line ("TEST_RECUANT: no se lanzo excepcion esperada: claveEsPrimera.");
         errores:=errores+1;
      exception
         when claveEsPrimera => null;
         when others=>
            put_line ("TEST_RECUANT: Error en recuAnt, excepcion inesperada.");
            errores:=errores+1;
      end;
      recuAnt(l,9,aux);
      if (aux/=3) then
         put_line ("TEST_RECUANT: Error en recuAnt, anterior encontrado incorrecto.");
         errores:=errores+1;
      end if;

   exception
      when others =>
         put_line ("TEST_RECUANT: Error en recuAnt, excepcion inesperada.");
         errores:=errores+1;
   end test_recuAnt;

   procedure test_Vaciar (l: in out tipoLista; errores: in out integer) is
   begin
      vaciar(l);
      if (longitud(l)/=0) then
         put_line ("TEST_VACIAR: Error en vaciar, longitud /=0.");
         errores:=errores+1;
      end if;

   exception
      when others =>
         put_line ("TEST_VACIAR: Error en vaciar, excepcion inesperada.");
         errores:=errores+1;
   end test_Vaciar;

   l: tipoLista;
   total,errores: integer:=0;

begin
   crear(l);
   continua("Test de unidad Lista. Presione enter para iniciar INSERTAR.");
   --cls;

   test_insertar(l,errores);
   put_line("INSERTAR errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;

   --continua("Presione enter para iniciar MODIFICAR.");
   --cls;
   test_modificar(l,errores);
   put_line("MODIFICAR errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;

   --continua("Presione enter para iniciar SUPRIMIR.");
   --cls;
   test_suprimir(l,errores);
   put_line("SUPRIMIR errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;

   --continua("Presione enter para iniciar RECUPRIM.");
   --cls;
   test_recuprim(l,errores);
   put_line("RECUPRIM errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;

   --continua("Presione enter para iniciar RECUULT.");
   --cls;
   test_recuUlt(l,errores);
   put_line("RECUULT errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;

   --continua("Presione enter para iniciar RECUSIG.");
   --cls;
   test_recuSig(l,errores);
   put_line("RECUSIG errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;

   --continua("Presione enter para iniciar RECUCLAVE.");
   --cls;
   test_recuClave(l,errores);
   put_line("RECUCLAVE errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;

   --continua("Presione enter para iniciar RECUANT.");
   --cls;
   test_recuAnt(l,errores);
   put_line("RECUANT errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;

   --continua("Presione enter para iniciar VACIAR.");
   --cls;
   test_vaciar(l,errores);
   put_line("VACIAR errores: " & Integer'Image(errores));
   total:=total +errores;
   errores:=0;


   put_line ("Test finalizado. Total de errores encontrados: " & integer'image(total));
end test_unidad_lista;
