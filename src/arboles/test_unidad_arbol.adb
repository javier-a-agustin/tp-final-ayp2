with Text_IO; use Text_IO;

with arbol;

procedure test_unidad_arbol is

   subtype TipoInfo is Integer;
   subtype TipoClave is Integer;

   package arbol_b is new arbol(TipoInfo,TipoClave,">","<","=");
   use arbol_b; use arbol_b.ColaRecorridos;


   claves: array (integer range <>) of integer := (25,15,100,9,20,3,18,23,75,120,90);
   infos:  array (integer range <>) of integer := (25,15,100,9,20,3,18,23,75,120,90);

   procedure test_inOrder (A: in TipoArbol; errores: in out integer) is
      q:tipoCola;
      k: TipoClave := 0;
      infos_inOrder: array (Integer range <>) of integer:=(120,100,90,75,25,23,20,18,15,9,3);
   begin
      crear(q);
      inOrder(A,Q);
      for i  in reverse infos_inOrder'range loop
         frente(Q,k);
         if (infos_inOrder(i)/=k) then
            put_line("TEST_INORDER: Error. El orden de los elementos en la cola es incorrecto");
            errores:= errores+1;
         end if;
         desencolar(q);
      end loop;
      if (not esVacia(q)) then
         put_line("TEST_INORDER: Error. Hay más elementos en la cola que los que debiera tener");
         errores:=errores+1;
      end if;
   exception
      when others =>
         put_line ("TEST_INORDER: Error en inOrder");
         errores:=errores+1;
   end test_inOrder;

   procedure test_preOrder (A: in TipoArbol;errores: in out integer) is
      q:tipoCola;
      k: TipoClave := 0;
      infos_preOrder: array (Integer range <>) of integer:=(120,90, 75,100, 23, 18,20,3,9,15,25);
   begin
      crear(q);
      preOrder(A,Q);
      for i in reverse infos_preOrder'range loop
         frente(Q,k);
         if (infos_preOrder(i)/=k) then
            put_line("TEST_PREORDER: Error. El orden de los elementos en la cola es incorrecto");
            errores:=errores+1;
         end if;
         desencolar(q);
      end loop;
      if (not esVacia(q)) then
         put_line("TEST_PREORDER: Error. Hay más elementos en la cola que los que debiera tener");
         errores:=errores+1;
      end if;
   exception
      when others =>
         put_line ("TEST_PREORDER: Error en preOrder");
         errores:=errores+1;
   end test_preOrder;

   procedure test_postOrder (A: in TipoArbol;errores: in out integer) is
      q:tipoCola;
      k: TipoClave := 0;
      infos_postOrder: array (Integer range <>) of integer:=(25,100,120,75,90,15,20,23,18,9,3);
   begin
      crear(q);
      postOrder(A,q);
      for i in reverse infos_postOrder'range loop
         frente(q,k);
         if (infos_postOrder(i)/=k) then
            put_line("TEST_POSTORDER: Error. El orden de los elementos en la cola es incorrecto.");
            errores:=errores+1;
         end if;
         desencolar(q);
      end loop;
      if (not esVacia(q)) then
         put_line("TEST_POSTORDER: Error. Hay más elementos en la cola que los que debiera tener.");
         errores:=errores+1;
      end if;
   exception
      when others =>
         put_line ("TEST_POSTORDER: Error. No funciona postOrder.");
         errores:=errores+1;
   end test_postOrder;

   procedure test_modificar (A: in out tipoArbol; errores:in out integer) is
      info:TipoInfo;
   begin
      begin
         for i in claves'range loop
            buscar (A,claves(i),info) ;
         end loop;
      exception
         when others =>
            put_line ("TEST_MODIFICAR: Error. No encuentra las claves.");
            errores:=errores+1;
      end;
      begin
         for i in claves'range loop
            buscar (A,claves(i),info) ;
            modificar (A,claves(i),info*10);
            buscar (A,claves(i),info);
            if (info /= infos(i)*10) then
               put_line("TEST_MODIFICAR: Error. No persisten las modificaciones.");
               errores:=errores+1;
            end if;
            modificar (A,claves(i),infos(i));
         end loop;
      exception
         when others =>
            put_line ("TEST_MODIFICAR: Error. No modifica las claves.");
            errores:=errores+1;
      end;
   end test_modificar;

   procedure test_insertar (A: in out tipoArbol; errores: in out integer) is
   begin
      for i in claves'range loop
         insertar (A,claves(i),infos(i));
         begin
           insertar (A,claves(i),infos(i));
           put_line("TEST_INSERTAR: Error. Permite inserción de claves duplicadas.");
           errores:=errores+1;
         exception
            when others =>
               null;
         end;
      end loop;
   exception
        when others =>
           put_line("TEST_INSERTAR: Error. Excepcion inesperada");
           errores:=errores+1;
   end test_insertar;

   procedure test_vaciar (A: in out tipoArbol; errores: in out integer) is
   begin
      vaciar(A);
      if (not esVacio(A)) then
         put_line("TEST_VACIAR: Error. No vacía el arbol.");
         errores:=errores+1;
      end if;
   end test_vaciar;

   procedure test_suprimir (A: in out tipoArbol; errores: in out integer) is
   begin
      begin
         for i in claves'range loop
            suprimir (A,claves(i));
         end loop;
         if (not esVacio(A)) then
            put_line ("TEST_SUPRIMIR: Error. No suprime los elementos correctamente");
            errores:=errores+1;
         end if;
  	 test_insertar(A, errores);
      exception
         when others =>
            put_line ("TEST_SUPRIMIR: Error. Excepcion inesperada.");
            errores:=errores+1;
      end;
   end test_suprimir;

   A: TipoArbol;
   errores: integer:=0;

begin
   Put_line("Ejecutando Test de unidad Arbol..");

   test_insertar(A,errores);
   put_line("Total errores INSERTAR: " & Integer'Image(errores));

   test_modificar(A,errores);
   put_line("Total errores MODIFICAR: " & Integer'Image(errores));

   test_inOrder(A,errores);
   put_line("Total errores INORDER: " & Integer'Image(errores));

   test_preOrder(A, errores);
   put_line("Total errores PREORDER: " & Integer'Image(errores));

   test_postOrder(A, errores);
   put_line("Total errores POSORDER: " & Integer'Image(errores));

   test_suprimir(A, errores);
   put_line("Total errores SUPRIMIR: " & Integer'Image(errores));

   test_vaciar(A, errores);
   put_line("Total errores VACIAR: " & Integer'Image(errores));

   put_line ("Test finalizado. Total de errores encontrados: " & integer'image(errores));
end test_unidad_arbol;
