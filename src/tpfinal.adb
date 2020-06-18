with Ada.Text_IO,
     Ada.Strings.Unbounded,
     Ada.Text_IO.Unbounded_IO,
     Ada.Integer_Text_IO,
     Ada.Float_Text_IO,utiles,fechas,lista,pila,cola,arbol;
use Ada.Text_IO,
     Ada.Strings.Unbounded,
     Ada.Text_IO.Unbounded_IO,
     Ada.Integer_Text_IO,
    Ada.Float_Text_IO,utiles,fechas;

--Viandas, Pedidos, Clientes, Platos



procedure Tpfinal is


   --Viandas
   subtype tipoClaveVianda is Unbounded_String; -- Nombre
   type tipoInfoVianda is record
      cantidad: integer;
      precioIndividual: float;
   end record;

   package p_viandas is new lista(tipoClaveVianda, tipoInfoVianda, "<", "=");
   use p_viandas;

   --Clientes
   subtype tipoClaveCliente is integer; -- DNI
   type tipoInfoCliente is record
      nombre: Unbounded_String;
      apellido: Unbounded_String;
      direccion: Unbounded_String;
      telefono: Unbounded_String;
   end record;

   package p_clientes is new arbol(tipoClaveCliente, tipoInfoCliente, ">", "<", "=");
   use p_clientes;

   --Platos
   subtype tipoClavePlato is Unbounded_String; -- Nombre
   type tipoInfoPlato is record
      cantidad: integer;
      precioIndividual: float;
   end record;

   package p_platos is new lista(tipoClavePlato, tipoInfoPlato, "<", "=");
   use p_platos;

   --Pedidos
   subtype tipoClavePedido is integer; -- Numero de pedido
   type tipoInfoPedido is record
      dniCliente: tipoClaveCliente;
      fechaPedido: tFecha;
      platos: p_platos.tipoLista;
      montoTotal: float;
   end record;

   package p_pedidos is new arbol(tipoClavePedido, tipoInfoPedido, ">", "<", "=");
   use p_pedidos;


   procedure crearEstructuras(clientes: out p_clientes.tipoArbol; viandas: out p_viandas.tipoLista; pedidos: out p_pedidos.tipoArbol) is
   begin
      p_clientes.crear(clientes);
      p_viandas.crear(viandas);
      p_pedidos.crear(pedidos);
   end crearEstructuras;

   function menuPrincipal return integer is
   begin
      Put_Line("Menu Principal");
      Put_Line("1: Modulo Viandas");
      Put_Line("2: Modulo Clientes");
      Put_Line("3: Modulo Pedidos");
      Put_Line("4: Listados");
      Put_Line("0: Salir");

      return enteroEnRango("Ingrese una opcion", 0, 4); -- Utiles
   end menuPrincipal;

   procedure administrarViandas(viandas: in out p_viandas.tipoLista) is
   begin
      null;
   end administrarViandas;

   procedure abmCliente(clientes: in out p_clientes.tipoArbol; pedidos: in p_pedidos.tipoArbol) is
   begin
      null;
   end abmCliente;

   procedure abmPedido(pedidos: in out p_pedidos.tipoArbol; identificador: in out tipoClaveCliente; clientes: in p_clientes.tipoArbol; viandas: in p_viandas.tipoLista) is
   begin
      null;
   end abmPedido;

   procedure listados(pedidos: in p_pedidos.tipoArbol; clientes: in p_clientes.tipoArbol) is
   begin
      null;
   end listados;

   viandas: p_viandas.tipoLista;
   clientes: p_clientes.tipoArbol;
   pedidos: p_pedidos.tipoArbol;
   platos: p_platos.tipoLista;
   identificador: tipoClavePedido;
   resp: Integer;
begin

   identificador := 0;
   crearEstructuras(clientes, viandas, pedidos);        -- N1

   loop
      resp := menuPrincipal;

      case resp is
         when 1 => administrarViandas(viandas);
         when 2 => abmCliente(clientes, pedidos);
         when 3 => abmPedido(pedidos, identificador, clientes, viandas);
         when 4 => listados(pedidos, clientes);
         when others => null;
      end case;

     exit when resp = 0;
   end loop;


end Tpfinal;
