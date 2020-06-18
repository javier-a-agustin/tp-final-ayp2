package fechas is
   subtype tDia is integer range 1..31;
   subtype tMes is integer range 1..12;
   subtype tAnio is integer range 1..9999;
   type tFecha is record
      dia: tDia;
      mes: tMes;
      anio: tAnio;
   end record;

   -- Que hace: Valida la consistencia de una fecha dada.
   -- Precondicion: f=F
   -- Poscondicion: esFechaCorrecta = True y la fecha es consistente, falso sino.
   function esFechaCorrecta(fecha: in tfecha) return boolean;


   -- Que hace: Devuelve la cantidad de dia par aun mes y una año dado.
   -- Precondicion: m=M y anio = A
   -- Poscondicion: diasMes = N y N dias del mes M en el año A.
   function diasMes(mes, anio: in integer) return integer;

   -- Que hace: Devuelve el nombre de un mes.
   -- Precondicion: mes=M
   -- Poscondicion: nombreMes=S y S es el nombre del mes M.
   function nombreMes (mes: in integer) return string;

   -- Que hace: Determina si un año es bisiesto o no.
   -- Precondicion: anio = A
   -- Poscondicion: esBisiesto = True y A es bisiesto, Falso sino.
   function esBisiesto(anio: in integer) return boolean;

   -- Que hace: Devuelve el texto correspondiente a una fecha.
   -- Precondicion: fecha=F
   -- Poscondicion: fechaTexto=Str y Str es F en formato texto.
   function fechaTexto(fecha: in tfecha) return string;

   -- Que hace: Devuelve una fecha convertida a dias
   -- Precondicion: fecha = F
   -- Poscondicion: fechaEnDias = N y N es la fecha convertida a dias
   function fechaEnDias(fecha: in tFecha) return Integer;
   
   -- Que hace: Devuelve la cantidad de dias transcurridos entre f1 y f2
   -- Precondicion: f1 = F1 y f2 = F2
   -- Poscondicion: diasEntreFechas = N y N es la cantidad de dias transcurridos desde f1 hasta llegar a f2
   function diasEntreFechas(f1, f2: in tfecha) return integer;

   -- Que hace: Devuelve la fecha de hoy
   -- Precondicion: --
   -- Poscondicion: fechaHoy es la fecha del dia de hoy
   function fechaHoy return tfecha;

   procedure CLS; -- para limpiar pantalla
end fechas;
