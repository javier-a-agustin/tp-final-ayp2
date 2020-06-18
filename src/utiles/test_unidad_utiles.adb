with utiles; use utiles;
with Text_IO; use Text_IO;

procedure test_unidad_utiles is

   n: integer;
   f:float;
begin
   continua("Presione una tecla siguiente TEST");
   CLS;
   put_line("TEST Confirma");
   if (confirma("Desea continuar, pone que si")) then
      Put_Line("Confirma OK");
   end if;

   if (not confirma("Deseacontinuar, pone que no")) then
      Put_Line("NOT Confirma OK");
   end if;

   continua("Presione una tecla siguiente TEST");
   CLS;
   put_line("TEST continua ");

   continua("Presione una tecla para continuar");
   Put_Line("Continua OK");

   continua("Presione una tecla siguiente TEST");
   CLS;
   put_line("TEST numeroEnt ");


   n:= numeroEnt("Ingrese un entero cualquiera");
   Put_Line("numeroEntero: OK");

   continua("Presione una tecla siguiente TEST");
   CLS;
   put_line("TEST numeroReal: ");


   f:= numeroReal("Ingrese un real cualquiera");
   Put_Line("numeroReal: OK");

   continua("Presione una tecla siguiente TEST");
   CLS;
   put_line("TEST enteroEnRango: ");


   n:= enteroEnRango("Ingrese un entero " , -9,-9);
   if (n=-9) then
      Put_Line("EnteroEnRango (cerrado): OK");
   end if;


   n:= enteroEnRango("Ingrese un entero " , 10,100);
   if (n in 10..100) then
      Put_Line("EnteroEnRango: OK");
   end if;

   continua("Presione una tecla siguiente TEST");
   CLS;
   put_line("TEST realEnRango: ");

   f:= realEnRango("Ingrese un real" , -9.9,-9.9);
   if (f=-9.9) then
      Put_Line("realEnRango (cerrado): OK");
   end if;

   f:= realEnRango("Ingrese un real" , 10.1 ,99.9);
   if (f in 10.1..99.9) then
      Put_Line("realEnRango: OK");
   end if;


end test_unidad_utiles;
