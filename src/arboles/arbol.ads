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

   -- Declaración de las excepciones que lanza ADT ARBOL
   arbolLleno, claveExiste, claveNoExiste, errorEnCola, operacionNoImplementada: exception;

   -- La implementación del tipo tipoArbo queda oculta para el usuario
   type tipoArbol is private;

--------------------------------------------------------------------------------
   -- Qué hace: crea un ABB
   -- Precondiciones: -
   -- Postcondiciones: a = A y A está vacío
   procedure crear (a : out tipoArbol);

   -- Qué hace: agrega un elemento al ABB dada su clave e información
   -- Precondiciones: a = A y k = K y i = I
   -- Postcondiciones: a = A1 y A1 es A con el elemento con clave K e información I agregado y A1 está ordenado
   -- Excepciones: arbolLleno - claveExiste
   procedure insertar (a : in out tipoArbol; k : in tipoClave ; i : in tipoInfo);

   -- Qué hace: elimina un elemento del ABB dada su clave
   -- Precondiciones: a = A y k = K
   -- Postcondiciones: a = A1 y A1 es A sin el elemento con clave K y A1 está ordenado
   -- Excepciones: claveNoExiste
   procedure suprimir (a : in out tipoArbol; k : in tipoClave);

   -- Qué hace: obtiene un elemento del ABB dada su clave
   -- Precondiciones: a = A y k = K
   -- Postcondiciones: i = I y clave(I) = K
   -- Excepciones: claveNoExiste
   procedure buscar (a : in tipoArbol ; k : in tipoClave ; i : out tipoInfo);

   -- Qué hace: modifica la información de un elemento del ABB dada su clave y la nueva información
   -- Precondiciones: a = A y k = K y i = I
   -- Postcondiciones: a = A1 y A1 es A con el elemento con clave K con la información modificada con I y A1 está ordenado
   -- Excepciones: claveNoExiste
   procedure modificar (a : in out tipoArbol; k : in tipoClave ; i : in tipoInfo);

   -- Qué hace: vacía el ABB
   -- Precondiciones: a = A
   -- Postcondiciones: a = A1 y A1 está vacío
   procedure vaciar (a : in out tipoArbol);

   -- Qué hace: determina si el ABB está vacío
   -- Precondiciones: a = A
   -- Postcondiciones: esVacioA = Verdadero si A está vacío, sino esVacioA = Falso
   function esVacio (a : in tipoArbol) return boolean;

   -- Qué hace: obtiene las claves de los elementos del ABB en pre-order
   -- Precondiciones: a = A y q = Q y Q está vacía
   -- Postcondiciones: q = Q1 y Q1 es Q con las claves de los elementos del ABB en pre-order
   -- Excepciones: errorEnCola
   procedure preOrder (a : in tipoArbol ; q : in out tipoCola);

   -- Qué hace: obtiene las claves de los elementos del ABB en post-order
   -- Precondiciones: a = A y q = Q y Q está vacía
   -- Postcondiciones: q = Q1 y Q1 es Q con las claves de los elementos del ABB en post-order
   -- Excepciones: errorEnCola
   procedure postOrder (a : in tipoArbol ; q : in out tipoCola);

   -- Qué hace: obtiene las claves de los elementos del ABB en in-order
   -- Precondiciones: a = A y q = Q y Q está vacía
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
