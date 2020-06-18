with Unchecked_Deallocation;

package body lista is

   -- Que hace: Crea una lista
   -- Precondiciones:
   -- Poscondiciones: l=L y L esta creada.
   procedure crear(l: out tipoLista) is
   begin
      l.lista:=null;
      l.long:=0;
   end crear;

   -- Que hace: Agrega un elemento a la lista dada su clave e informacion.
   -- Precondiciones: l = L, k=K, i=I
   -- Poscondiciones: l=L1 y L1 es L con nuevo elemento clave=K y info=I
   -- Excepciones: listaLLena - claveExiste
   procedure insertar(l: in out tipoLista; k: in tipoClave; i: in tipoInfo) is
      p,ant,nuevo: tipoPunt;
   begin
      p:=l.lista;
      while (p /= null) and then (p.clave<k) loop
         ant:=p;
         p:=p.sig;
      end loop;
      if (p=null) or else (p.clave /= k) then
         nuevo:= new tipoNodo;
         nuevo.clave:=k;
         nuevo.info:=i;
         nuevo.sig:=p;
         l.long:=l.long+1;
         if (p = l.lista) then
            l.lista:=nuevo;
         else
            ant.sig:=nuevo;
         end if;
      else
         raise claveExiste;
      end if;
   exception
         when Storage_Error => raise listaLlena;
   end insertar;



   -- Que hace: Modifica un elemento de la lista dada su clave.
   -- Precondiciones: l = L, k=K, i=I
   -- Poscondiciones: l=L1 y L1 es L con info(K)=I
   -- Excepciones: claveNoExiste
   procedure modificar(l: in out tipoLista; k: in tipoClave; i: in tipoInfo) is
   p: tipoPunt;
   begin
      p := l.lista;
      while (p/=null) and then (p.clave<k) loop
         p := p.sig;
      end loop;

      if (p /= null) and then (k = p.clave) then
         p.info := i;
      else
         raise claveNoExiste;
      end if;
   end modificar;



   -- Que hace: Quita un elemento de la lista dada su clave.
   -- Precondiciones: l = L, k=K
   -- Poscondiciones: l=L1 y L1 es L sin el elemento de clave clave=K
   -- Excepciones: claveNoExiste
   procedure suprimir(l: in out tipoLista; k: in tipoClave) is
      procedure free is new unchecked_deallocation (tipoNodo, tipoPunt);
   p, ant: tipoPunt;
   begin
      p := l.lista;
      while (p /= null) and then (p.clave<k) loop
         ant := p;
         p := p.sig;
      end loop;

      if (p /= null) and then (k = p.clave) then
         if (p = l.lista) then
            l.lista := p.sig;
         else
            ant.sig := p.sig;
         end if;
         l.long := l.long - 1;
         free(p);
      else
         raise claveNoExiste;
      end if;
   end suprimir;



   -- Que hace: Obtiene la longitud de la lista
   -- Precondiciones: l = L
   -- Poscondiciones: longitud = N y N >=0
   function longitud(l: in tipoLista) return natural is
   begin
      return l.long;
   end longitud;



   -- Que hace: Obtiene un elemento de la lista dada su clave.
   -- Precondiciones: l = L, k=K
   -- Poscondiciones: i=I y clave(I) = k
   -- Excepciones: claveNoExiste
   procedure recuClave(l: in tipoLista; k: in tipoClave; i: out tipoInfo) is
   p: tipoPunt := l.lista;
   begin
      while (p /= null) and then (p.clave<k) loop
         p := p.sig;
      end loop;
      if (p /= null) and then (k = p.clave) then
         i := p.info;
      else
         raise claveNoExiste;
      end if;
   end recuClave;



   -- Que hace: Obtiene la clave del elemento anterior a la clave dada.
   -- Precondiciones: l = L, k=K
   -- Poscondiciones: ant=K1 y K1 es la clave anterior a K
   -- Excepciones: claveNoExiste, claveEsPrimera
   procedure recuAnt(l: in tipoLista; k: in tipoClave; ant: out tipoClave) is
      p, aux: tipoPunt;
   begin
      p := l.lista;
      while (p /= null) and then (p.clave<k) loop
         aux := p;
         p := p.sig;
      end loop;
      if (p /= null) and then (k = p.clave) then
         if (p /= l.lista) then
            ant := aux.clave;
         else
            raise claveEsPrimera;
         end if;
      else
         raise claveNoExiste;
      end if;
   end recuAnt;



   -- Que hace: Obtiene la clave del elemento siguiente a la clave dada.
   -- Precondiciones: l = L, k=K
   -- Poscondiciones: sig=K1 y K1 es la clave siguiente a K
   -- Excepciones: claveNoExiste, claveEsUltima
   procedure recuSig(l: in tipoLista; k: in tipoClave; sig: out tipoClave) is
      p:tipoPunt:=l.lista;
   begin
      while(p /= null)and then(p.clave <k) loop
         p := p.sig;
      end loop;
      if(p /= null)and then(p.clave = k) then
         if(p.sig /= null) then
            sig := p.sig.clave;
         else
            raise claveEsUltima;
         end if;
      else
         raise claveNoExiste;
      end if;
   end recuSig;


   -- Que hace: Obtiene la clave del primer elemento de la lista
   -- Precondiciones: l = L
   -- Poscondiciones: prim=K1 y K1 es la clave del primer elemento de L
   -- Excepciones: listaVacia
   procedure recuPrim(l: in tipoLista; prim: out tipoClave) is
   begin
      if(l.lista /= null) then
         prim:=l.lista.clave;
      else
         raise listaVacia;
      end if;
   end recuPrim;




   -- Que hace: Obtiene la clave del ultimo elemento de la lista.
   -- Precondiciones: l = L
   -- Poscondiciones: ult=K1 y K1 es la clave del ultimo elemento de L
   -- Excepciones: listaVacia
   procedure recuUlt(l: in tipoLista; ult: out tipoClave) is
      p: tipoPunt;
   begin
      if (l.lista = null) then
         raise listaVacia;
      else
         p := l.lista;

         while (p.sig /= null) loop
            p := p.sig;
         end loop;

         ult := p.clave;

      end if;
   end recuUlt;



   -- Que hace: Vacia la lista.
   -- Precondiciones: l = L
   -- Poscondiciones: l=L1 y L1 esta vacia
   procedure vaciar(l: in out tipoLista) is
      procedure free is new unchecked_deallocation(tipoNodo, tipoPunt);
      p:tipoPunt;
   begin
      while (p/= null) loop
         p := l.lista;
         l.lista:=l.lista.sig;
         free(p);

      end loop;
      l.long:=0;
   end vaciar;



   -- Que hace: Determina si la lista esta vacia.
   -- Precondiciones: l = L
   -- Poscondiciones: esVacia = Verdadero si L esta vacia, falso sino.
   function esVacia(l: in tipoLista)return boolean is
   begin
      return l.long=0;
   end esVacia;


end lista;
