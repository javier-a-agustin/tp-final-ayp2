generic
   -- Tipo de dato a utilizar.
   type tipoInfo is private;


package cola is

   -- Declaraci�n de las excepciones que lanza ADT COLA
   colaLlena, colaVacia, operacionNoImplementada: exception;

   -- La implementaci�n del tipo tipoCola queda oculta para el usuario.
   type tipoCola is private;

--------------------------------------------------------------------------------

   -- Qu� hace: crea una cola
   -- Precondiciones: -
   -- Postcondiciones: q = Q y Q est� vac�a
   procedure crear (q : out tipoCola);

   -- Qu� hace: agrega un elemento en el final de la cola
   -- Precondiciones: q = Q y i = I
   -- Postcondiciones: q = Q1 y Q1 es Q con el elemento I agregado en el final
   -- Excepciones: colaLlena
   procedure encolar (q: in out tipoCola; i : in tipoInfo);

   -- Qu� hace: elimina el elemento del frente de la cola
   -- Precondiciones: q = Q
   -- Postcondiciones: q = Q1 y Q1 es Q sin el elemento del frente
   -- Excepciones: colaVacia
   procedure desencolar (q: in out tipoCola);

   -- Qu� hace: obtiene el elemento del frente de la cola
   -- Precondiciones: q = Q
   -- Postcondiciones: i = I y I es el elemento del frente de Q
   -- Excepciones: colaVacia
   procedure frente (q: in tipoCola; i : out tipoInfo);

   -- Qu� hace: vac�a la cola
   -- Precondiciones: q = Q
   -- Postcondiciones: q = Q1 y Q1 est� vac�a
   procedure vaciar (q: in out tipoCola);

   -- Qu� hace: determina si la cola est� vac�a
   -- Precondiciones: q = Q
   -- Postcondiciones: esVacia = Verdadero si Q est� vac�a, sino esVaciaQ =  Falso
   function esVacia (q: in tipoCola) return boolean;

private				-- estructura de datos de la cola

   type tipoNodo;
   type tipoPunt is access tipoNodo;
   type tipoNodo is record
	info : tipoInfo;
	sig : tipoPunt;
   end record;
   type tipoCola is record
	frente : tipoPunt;
	final : tipoPunt;
   end record;

end cola;
