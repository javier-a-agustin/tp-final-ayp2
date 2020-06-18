with cola;
generic
   -- Tipos de datos a utilizar
   type tipoClave is private; -- tipo de la clave a almacenar
   type tipoInfo is private;  -- tipo del dato a almacenar

   -- Operaciones que el usuario del ADT debe proveer al instanciarlo
   with function ">"(a,b:in tipoclave)return boolean is <>;
   with function "<"(a,b:in tipoclave)return boolean is <>;
   with function "="(a,b:in tipoclave)return boolean is <>;

package arbol is

   package ColaRecorridos is new Cola(tipoClave);
   use ColaRecorridos;

   -- Declaraci�n de las excepciones que lanza ADT ARBOL
   arbolLleno, claveExiste, claveNoExiste, errorEnCola, operacionNoImplementada: exception;

   -- La implementaci�n del tipo tipoArbo queda oculta para el usuario
   type tipoArbol is private;

--------------------------------------------------------------------------------
   -- Qu� hace: crea un ABB
   -- Precondiciones: -
   -- Postcondiciones: a = A y A est� vac�o
   procedure crear (a : out tipoArbol);

   -- Qu� hace: agrega un elemento al ABB dada su clave e informaci�n
   -- Precondiciones: a = A y k = K y i = I
   -- Postcondiciones: a = A1 y A1 es A con el elemento con clave K e informaci�n I agregado y A1 est� ordenado
   -- Excepciones: arbolLleno - claveExiste
   procedure insertar (a : in out tipoArbol; k : in tipoClave ; i : in tipoInfo);

   -- Qu� hace: elimina un elemento del ABB dada su clave
   -- Precondiciones: a = A y k = K
   -- Postcondiciones: a = A1 y A1 es A sin el elemento con clave K y A1 est� ordenado
   -- Excepciones: claveNoExiste
   procedure suprimir (a : in out tipoArbol; k : in tipoClave);

   -- Qu� hace: obtiene un elemento del ABB dada su clave
   -- Precondiciones: a = A y k = K
   -- Postcondiciones: i = I y clave(I) = K
   -- Excepciones: claveNoExiste
   procedure buscar (a : in tipoArbol ; k : in tipoClave ; i : out tipoInfo);

   -- Qu� hace: modifica la informaci�n de un elemento del ABB dada su clave y la nueva informaci�n
   -- Precondiciones: a = A y k = K y i = I
   -- Postcondiciones: a = A1 y A1 es A con el elemento con clave K con la informaci�n modificada con I y A1 est� ordenado
   -- Excepciones: claveNoExiste
   procedure modificar (a : in out tipoArbol; k : in tipoClave ; i : in tipoInfo);

   -- Qu� hace: vac�a el ABB
   -- Precondiciones: a = A
   -- Postcondiciones: a = A1 y A1 est� vac�o
   procedure vaciar (a : in out tipoArbol);

   -- Qu� hace: determina si el ABB est� vac�o
   -- Precondiciones: a = A
   -- Postcondiciones: esVacioA = Verdadero si A est� vac�o, sino esVacioA = Falso
   function esVacio (a : in tipoArbol) return boolean;

   -- Qu� hace: obtiene las claves de los elementos del ABB en pre-order
   -- Precondiciones: a = A y q = Q y Q est� vac�a
   -- Postcondiciones: q = Q1 y Q1 es Q con las claves de los elementos del ABB en pre-order
   -- Excepciones: errorEnCola
   procedure preOrder (a : in tipoArbol ; q : in out tipoCola);

   -- Qu� hace: obtiene las claves de los elementos del ABB en post-order
   -- Precondiciones: a = A y q = Q y Q est� vac�a
   -- Postcondiciones: q = Q1 y Q1 es Q con las claves de los elementos del ABB en post-order
   -- Excepciones: errorEnCola
   procedure postOrder (a : in tipoArbol ; q : in out tipoCola);

   -- Qu� hace: obtiene las claves de los elementos del ABB en in-order
   -- Precondiciones: a = A y q = Q y Q est� vac�a
   -- Postcondiciones: q = Q1 y Q1 es Q con las claves de los elementos del ABB en in-order
   -- Excepciones: errorEnCola
   procedure inOrder (a : in tipoArbol ; q : in out tipoCola);

private 				-- estructura de datos del ABB

   type tipoNodo;
   type tipoArbol is access tipoNodo;

   type tipoNodo is record
      clave : tipoClave;
      info : tipoInfo;
      hijoIzq : tipoArbol;
      hijoDer : tipoArbol;
   end record;

end arbol;
