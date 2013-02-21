<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="ExtNet_ParteCinco.Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Control Grid con paginación</title>
</head>
<body>
    <ext:ResourceManager ID="rm" runat="server">
    </ext:ResourceManager>
    <ext:Viewport runat="server" Layout="BorderLayout">
        <Items>
            <ext:FormPanel runat="server" Layout="Column" AutoHeight="true" ButtonAlign="Center" Region="North" BodyPadding="5">
                <Items>
                    <ext:Panel runat="server" Border="false" Layout="Form" ColumnWidth="0.5" Height="100"
                        LabelWidth="300" BodyPadding="5">
                        <Items>
                            <ext:TextField ID="nombreBusqueda" runat="server" FieldLabel="Nombres" Width="400">
                            </ext:TextField>
                            <ext:TextField ID="apellidoBusqueda" runat="server" FieldLabel="Apellidos" Width="400">
                            </ext:TextField>
                            <ext:TextField ID="emailBusqueda" runat="server" FieldLabel="Correo Electronico" Width="400">
                            </ext:TextField>
                        </Items>
                    </ext:Panel>
                    <ext:Panel runat="server" Border="false" Layout="Form" ColumnWidth="0.5" Height="100" LabelWidth="125"
                        BodyPadding="5">
                        <Items>
                            <ext:TextField ID="direccionBusqueda" runat="server" FieldLabel="Dirección" Width="400">
                            </ext:TextField>
                            <ext:TextField ID="paisBusqueda" runat="server" FieldLabel="País" Width="400">
                            </ext:TextField>
                        </Items>
                    </ext:Panel>
                </Items>
                <Buttons>
                    <ext:Button ID="botonBuscar" runat="server" Text="Buscar">
                        <Listeners>
                            <Click Fn="buscar" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
            </ext:FormPanel>
            <ext:GridPanel ID="gridPersonas" runat="server" Height="400" LabelAlign="Right" Region="Center">
                <Store>
                    <ext:Store ID="storePersonas" runat="server" OnReadData="storePersonas_ReadData"
                        AutoLoad="false">                        
                        <Model>
                            <ext:Model runat="server">
                                <Fields>
                                    <ext:ModelField Name="Nombre">
                                    </ext:ModelField>
                                    <ext:ModelField Name="Apellido">
                                    </ext:ModelField>
                                    <ext:ModelField Name="CorreoElectronico">
                                    </ext:ModelField>
                                    <ext:ModelField Name="Direccion">
                                    </ext:ModelField>
                                    <ext:ModelField Name="Pais">
                                    </ext:ModelField>
                                </Fields>
                            </ext:Model>
                        </Model>
                        <Proxy>
                            <ext:PageProxy>
                                <Reader>
                                    <ext:JsonReader IDProperty="ID" />                                    
                                </Reader>                                
                            </ext:PageProxy>
                        </Proxy>
                        <Listeners>
                            <DataChanged Fn="onStoreClientLoaded">
                            </DataChanged>
                        </Listeners>
                    </ext:Store>                    
                </Store>                
                <ColumnModel>
                    <Columns>
                        <ext:RowNumbererColumn />
                        <ext:Column DataIndex="Nombre" Header="Nombres">
                        </ext:Column>
                        <ext:Column DataIndex="Apellido" Header="Apellidos">
                        </ext:Column>
                        <ext:Column DataIndex="CorreoElectronico" Flex="2" Header="Correo Electrónico">
                        </ext:Column>
                        <ext:Column Flex="1" DataIndex="Direccion" Header="Dirección">
                        </ext:Column>
                        <ext:Column DataIndex="Pais" Header="País">
                        </ext:Column>
                    </Columns>
                </ColumnModel>
                <SelectionModel>
                    <ext:RowSelectionModel SingleSelect="true" />
                </SelectionModel>
                <BottomBar>
                    <ext:PagingToolbar ID="barraPaginacion" runat="server" StoreID="storePersonas">
                    </ext:PagingToolbar>
                </BottomBar>
                <Listeners>
                    <ItemClick Fn="onGridItemClick"></ItemClick>
                </Listeners>
            </ext:GridPanel>
        </Items>
    </ext:Viewport>
    
    <ext:XScript runat="server">
        <script>
            var buscar = function () {
                var grid = #{gridPersonas};
                var store = grid.store;

                store.proxy.extraParams = {
                    "nombre": #{nombreBusqueda}.getValue(),
                    "apellido": #{apellidoBusqueda}.getValue(),
                    "email": #{emailBusqueda}.getValue(),
                    "direccion": #{direccionBusqueda}.getValue(),
                    "pais": #{paisBusqueda}.getValue()
                };

                store.load();
            };

            var onStoreClientLoaded = function(store, options){
                var msg = "";
                msg += "Total de Registros Encontrados " +  store.totalCount + "</br>";
                msg += "Total de Registros Presentados " +  store.data.items.length;
                console.log(store);
                Ext.Msg.alert("Store Cargado", msg);
            }

            var onGridItemClick = function(grid, record, item, index, e, eOpts){
                var msg = "";

                //el parametro aqui es nombre de la columna en el 'Model' del Store
                msg += record.get('Apellido') + "</br>";               
                msg += "Indice (basado en 0) " + index + "</br>";
                Ext.Msg.alert("Item Click", msg);
                console.log(record);
            }

        </script>        
    </ext:XScript>

</body>
</html>
