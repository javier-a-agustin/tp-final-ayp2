with unchecked_Deallocation;
with Text_IO, Ada.Strings.Unbounded, Text_IO.Unbounded_IO, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Calendar;
use Text_IO, Ada.Strings.Unbounded, Text_IO.Unbounded_IO, Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO, Ada.Calendar;

--- los parametros entrantes deberian ser controlados antes de ser usados aqui, se espera que los datos entrantes
--- respeten su tipo determinado

package body fechas is

   procedure CLS is
   begin
      Ada.Text_IO.Put(ASCII.ESC & "[2J");
   end CLS;

   -- Que hace: Valida la consistencia de una fecha dada.
   -- Precondicion: f=F
   -- Poscondicion: fechaCorrecta = True y la fecha es consistente, falso sino.
   function esFechaCorrecta(fecha: in tfecha) return boolean is
   begin
      return fecha.dia in 1.. diasMes(fecha.mes, fecha.anio);
   end esFechaCorrecta;

   -- Que hace: Devuelve la cantidad de dia par aun mes y una año dado.
   -- Precondicion: m=M y anio = A y 1<=M<=12
   -- Poscondicion: diasMes = N y N dias del mes M en el año A.
   function diasMes(mes,anio: in integer) return integer is
      diasMeses: array (integer range 1..12)of integer := (31,28,31,30,31, 30,31,31,30,31,30,31);
   begin
      if (mes = 2) and (esBisiesto(anio)) then
         return 29;
      end if;
      return diasMeses(mes);
   end diasMes;

   -- Que hace: Determina si un año es bisiesto o no.
   -- Precondicion: anio = A
   -- Poscondicion: esBisiesto = True y A es bisiesto, Falso sino.
   function esBisiesto(anio: in integer) return boolean is
   begin
      return
        ((anio mod 4 = 0)and(anio mod 100 /= 0))
        or else
        ((anio mod 400 = 0)and(anio /= 3600));
   end esBisiesto;

   -- Que hace: Devuelve el nombre de un mes.
   -- Precondicion: mes=M, 1 <=M<=12
   -- Poscondicion: nombreMes=S y S es el nombre del mes M.
   function nombreMes (mes: in integer) return string is
      nombreMeses: array (integer range 1..12)of Unbounded_String
        := (To_Unbounded_String("enero"),
            To_Unbounded_String("febrero"),
            To_Unbounded_String("marzo"),
            To_Unbounded_String("abril"),
            To_Unbounded_String("mayo"),
            To_Unbounded_String("junio"),
            To_Unbounded_String("julio"),
            To_Unbounded_String("agosto"),
            To_Unbounded_String("septiembre"),
            To_Unbounded_String("octubre"),
            To_Unbounded_String("noviembre"),
            To_Unbounded_String("diciembre"));
   begin
      return to_string(nombreMeses(mes));
   end nombreMes;

   -- Que hace: Devuelve el texto correspondiente a una fecha.
   -- Precondicion: fecha=F
   -- Poscondicion: fechaTexto=Str y Str es F en formato texto.
   function fechatexto(fecha: in tfecha) return string is
   begin
      if esFechaCorrecta(fecha) then
         return Integer'Image(fecha.dia) & " de " & nombremes(fecha.mes) &
           " de" &Integer'Image(fecha.anio);
      else
         return "fecha no valida";
      end if;

   end fechatexto;

   -- Que hace: Devuelve una fecha convertida a dias
   -- Precondicion: fecha = F
   -- Poscondicion: fechaEnDias = N y N es la fecha convertida a dias
   function fechaEnDias(fecha: in tFecha) return Integer is
      dias, m: integer;
   begin
      dias := fecha.anio * 365;
      dias := dias + fecha.anio / 4 - fecha.anio / 100 + fecha.anio / 400;
        
      m := 1;
      while (m < fecha.mes) loop
         dias := dias + diasMes(m, fecha.anio);
         
         m := m + 1;
      end loop;
      
      dias := dias + fecha.dia;
      
      return dias;
   end fechaEnDias;
   
   -- Que hace: Devuelve la cantidad de dias transcurridos entre f1 y f2
   -- Precondicion: f1 = F1 y f2 = F2
   -- Poscondicion: diasEntreFechas = N y N es la cantidad de dias transcurridos desde f1 hasta llegar a f2
   function diasEntreFechas(f1, f2: in tfecha) return integer is
      dias: integer;
   begin
      dias := fechaEnDias(f2) - fechaEnDias(f1) + 1;         

      return dias;
   end diasEntreFechas;

   -- Que hace: Devuelve la fecha de hoy
   -- Precondicion: --
   -- Poscondicion: fechaHoy es la fecha del dia de hoy
   function fechaHoy return tfecha is
      f: tFecha;
      c: Time;
   begin
      c := Clock;
      f.dia := Day(c);
      f.mes := Month(c);
      f.anio := Year(c);

      return f;
   end fechaHoy;

end fechas;
