generic
   type tipoInfo is private;

package pila is

   -- Declaración de excepciones
   pilaLlena, pilaVacia,operacionNoImplementada: exception;

   type tipoPila is private;

   -- Que hace: crea una pila.
   -- Precondiciones:
   -- Postcondiciones: p=P y P esta creada
   procedure crear(p: out tipoPila);

   -- Que hace: agrega un elemento en el tope de la pila
   -- Precondiciones: p = P y i = I
   -- Postcondiciones: p=P1 y P1 es P con el elemento I agregado al tope
   -- Excepciones: pilaLlena
   procedure apilar (p: in out tipoPila; i: in tipoInfo);

   -- Que hace: elimina un elemento del tope de la pila
   -- Precondiciones: p = P
   -- Postcondiciones: p=P1 y P1 es P sin el elemento del tope
   -- Excepciones: pilaVacia
   procedure desapilar (p: in out tipoPila);

   -- Que hace: obtiene el elemento del tope de la pila
   -- Precondiciones: p = P
   -- Postcondiciones: i=I e I es elemento del tope de P
   -- Excepciones: pilaVacia
   procedure tope (p: in tipoPila; i: out tipoInfo);

   -- Que hace: vacia la pila
   -- Precondiciones: p = P
   -- Postcondiciones: p = P1 y P1 esta vacia
   procedure vaciar (p: in out tipoPila);

   -- Que hace: Determina si la pila esta vacia
   -- Precondiciones: p = P
   -- Postcondiciones: esVacia = Verdadero si la P esta vacia, sino Falso.
   function esVacia (p: in tipoPila) return boolean;

private
   type tipoNodo;
   type tipoPila is access tipoNodo;
   type tipoNodo is record
      info:tipoInfo;
      sig: tipoPila;
   end record;


end;
