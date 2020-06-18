with text_IO, unchecked_Deallocation;
use text_IO;

package body cola is

   procedure free is new Unchecked_Deallocation (tipoNodo, tipoPunt);


   -- Qué hace: crea una cola
   -- Precondiciones: -
   -- Postcondiciones: q = Q y Q está vacía
   procedure crear (q:out tipoCola) is
   begin
      q.frente:=null;
      q.final:=null;
   end crear;


   -- Qué hace: agrega un elemento en el final de la cola
   -- Precondiciones: q = Q y i = I
   -- Postcondiciones: q = Q1 y Q1 es Q con el elemento I agregado en el final
   -- Excepciones: colaLlena
   procedure encolar (q: in out tipoCola; i: in tipoInfo) is
      aux: tipoPunt;
   begin
      aux := new tipoNodo;
      aux.info := i;
      aux.sig := null;
      if (q.final /= null) then
         q.final.sig := aux;
      else
         q.frente := aux;
      end if;
      q.final := aux;
   exception
      when STORAGE_ERROR => raise colaLlena;
   end encolar;


   -- Qué hace: elimina el elemento del frente de la cola
   -- Precondiciones: q = Q
   -- Postcondiciones: q = Q1 y Q1 es Q sin el elemento del frente
   -- Excepciones: colaVacia
   procedure desencolar (q: in out tipoCola) is
      aux: tipoPunt;
   begin
      if (q.frente = null) then
         raise colaVacia;
      else
         aux := q.frente;
         q.frente := q.frente.sig;
         if (q.frente = null) then
            q.final := null;
         end if;
         free(aux);
      end if;
   end desencolar;

   -- Qué hace: obtiene el elemento del frente de la cola
   -- Precondiciones: q = Q
   -- Postcondiciones: i = I y I es el elemento del frente de Q
   -- Excepciones: colaVacia
   procedure frente(q: in tipoCola; i: out tipoInfo) is
   begin
      if (q.frente = null) then
         raise colaVacia;
      else
         i := q.frente.info;
      end if;
   end frente;

   -- Qué hace: vacía la cola
   -- Precondiciones: q = Q
   -- Postcondiciones: q = Q1 y Q1 está vacía
   procedure vaciar(q:in out tipoCola) is
      aux: tipoPunt;
   begin
      while (q.frente /= null) loop
         aux := q.frente;
         q.frente := q.frente.sig;
         free(aux);
      end loop;
      q.final := null;
   end vaciar;


   -- Qué hace: determina si la cola está vacía
   -- Precondiciones: q = Q
   -- Postcondiciones: esVacia = Verdadero si Q está vacía, sino esVaciaQ =  Falso
   function esVacia(q:in tipoCola) return boolean is
   begin
      return (q.frente=null);
   end esVacia;

end cola;
