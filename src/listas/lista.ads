generic
   type tipoClave is private;
   type tipoInfo is private;

   with function "<"(a,b: in tipoClave)return boolean is <>;
   with function "="(a,b: in tipoClave)return boolean is <>;

package lista is

   listaLlena: exception;
   claveExiste: exception;
   claveNoExiste: exception;
   claveEsPrimera: exception;
   claveEsUltima: exception;
   listaVacia: exception;

   operacionNoImplementada:exception;

   type tipoLista is private;

   -- Que hace: Crea una lista
   -- Precondiciones:
   -- Poscondiciones: l=L y L esta creada.
   procedure crear(l: out tipoLista);

   -- Que hace: Agrega un elemento a la lista dada su clave e informacion.
   -- Precondiciones: l = L, k=K, i=I
   -- Poscondiciones: l=L1 y L1 es L con nuevo elemento clave=K y info=I
   -- Excepciones: listaLLena - claveExiste
   procedure insertar(l: in out tipoLista; k: in tipoClave; i: in tipoInfo);

   -- Que hace: Modifica un elemento de la lista dada su clave.
   -- Precondiciones: l = L, k=K, i=I
   -- Poscondiciones: l=L1 y L1 es L con info(K)=I
   -- Excepciones: claveNoExiste
   procedure modificar(l: in out tipoLista; k: in tipoClave; i: in tipoInfo);

   -- Que hace: Quita un elemento de la lista dada su clave.
   -- Precondiciones: l = L, k=K
   -- Poscondiciones: l=L1 y L1 es L sin el elemento de clave clave=K
   -- Excepciones: claveNoExiste
   procedure suprimir(l: in out tipoLista; k: in tipoClave);

   -- Que hace: Obtiene la longitud de la lista
   -- Precondiciones: l = L
   -- Poscondiciones: longitud = N y N >=0
   function longitud(l: in tipoLista) return natural;

   -- Que hace: Obtiene un elemento de la lista dada su clave.
   -- Precondiciones: l = L, k=K
   -- Poscondiciones: i=I y clave(I) = k
   -- Excepciones: claveNoExiste
   procedure recuClave(l: in tipoLista; k: in tipoClave; i: out tipoInfo);

   -- Que hace: Obtiene la clave del elemento anterior a la clave dada.
   -- Precondiciones: l = L, k=K
   -- Poscondiciones: ant=K1 y K1 es la clave anterior a K
   -- Excepciones: claveNoExiste, claveEsPrimera
   procedure recuAnt(l: in tipoLista; k: in tipoClave; ant: out tipoClave);

   -- Que hace: Obtiene la clave del elemento siguiente a la clave dada.
   -- Precondiciones: l = L, k=K
   -- Poscondiciones: sig=K1 y K1 es la clave siguiente a K
   -- Excepciones: claveNoExiste, claveEsUltima
   procedure recuSig(l: in tipoLista; k: in tipoClave; sig: out tipoClave);

   -- Que hace: Obtiene la clave del primer elemento de la lista
   -- Precondiciones: l = L
   -- Poscondiciones: prim=K1 y K1 es la clave del primer elemento de L
   -- Excepciones: listaVacia
   procedure recuPrim(l: in tipoLista; prim: out tipoClave);

   -- Que hace: Obtiene la clave del ultimo elemento de la lista.
   -- Precondiciones: l = L
   -- Poscondiciones: ult=K1 y K1 es la clave del ultimo elemento de L
   -- Excepciones: listaVacia
   procedure recuUlt(l: in tipoLista; ult: out tipoClave);

   -- Que hace: Vacia la lista.
   -- Precondiciones: l = L
   -- Poscondiciones: l=L1 y L1 esta vacia
   procedure vaciar(l: in out tipoLista);

   -- Que hace: Determina si la lista esta vacia.
   -- Precondiciones: l = L
   -- Poscondiciones: esVacia = Verdadero si L esta vacia, falso sino.
   function esVacia(l: in tipoLista)return boolean;

private

   type tipoNodo;
   type tipoPunt is access tipoNodo;
   type tipoNodo is record
      clave: tipoClave;
      info: tipoInfo;
      sig: tipoPunt;
   end record;
   type tipoLista is record
      long: natural;
      lista: tipoPunt;
   end record;

end lista;
