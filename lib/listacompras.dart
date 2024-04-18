import 'package:flutter/material.dart';

class ListaCompras {
  String nome;
  List<ItemListaCompras> itens;

  ListaCompras(this.nome, this.itens);
}

class ItemListaCompras {
  String nome;
  String quantidade;
  bool comprado;

  ItemListaCompras({required this.nome, required this.quantidade, this.comprado = false});
}

class PaginaListaCompras extends StatefulWidget {
  @override
  _PaginaListaComprasState createState() => _PaginaListaComprasState();
}

class _PaginaListaComprasState extends State<PaginaListaCompras> {
  List<ListaCompras> _listasCompras = [];

  TextEditingController _controladorNovoNomeLista = TextEditingController();

  void _mostrarDetalhesLista(BuildContext context, ListaCompras lista) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PaginaDetalhesLista(lista: lista)),
    );
  }

  void _mostrarDialogoNovaLista(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nova Lista de Compras'),
          content: TextField(
            controller: _controladorNovoNomeLista,
            decoration: InputDecoration(
              hintText: 'Nome da lista',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _listasCompras.add(
                    ListaCompras(
                      _controladorNovoNomeLista.text,
                      [],
                    ),
                  );
                  _controladorNovoNomeLista.clear();
                  Navigator.pop(context);
                });
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _removerItemLista(ListaCompras lista, ItemListaCompras item) {
    setState(() {
      lista.itens.remove(item);
    });
  }

  void _marcarItemComprado(ItemListaCompras item) {
    setState(() {
      item.comprado = !item.comprado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Minhas Listas de Compras',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _listasCompras.length,
              itemBuilder: (context, indiceLista) {
                return ListTile(
                  title: Text(_listasCompras[indiceLista].nome),
                  onTap: () {
                    _mostrarDetalhesLista(context, _listasCompras[indiceLista]);
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Implementar a edição da lista
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _listasCompras.removeAt(indiceLista);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _mostrarDialogoNovaLista(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PaginaDetalhesLista extends StatefulWidget {
  final ListaCompras lista;

  PaginaDetalhesLista({required this.lista});

  @override
  _PaginaDetalhesListaState createState() => _PaginaDetalhesListaState();
}

class _PaginaDetalhesListaState extends State<PaginaDetalhesLista> {
  TextEditingController _controladorPesquisaItem = TextEditingController();
  String _termoPesquisa = '';

  List<ItemListaCompras> _filtrarItens(String termo, List<ItemListaCompras> itens) {
    return itens.where((item) => item.nome.toLowerCase().contains(termo.toLowerCase())).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<ItemListaCompras> itensFiltrados = _filtrarItens(_termoPesquisa, widget.lista.itens);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lista.nome,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controladorPesquisaItem,
              onChanged: (texto) {
                setState(() {
                  _termoPesquisa = texto;
                });
              },
              decoration: InputDecoration(
                labelText: 'Pesquisar Item',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itensFiltrados.length,
              itemBuilder: (context, indice) {
                final item = itensFiltrados[indice];
                return ListTile(
                  title: Row(
                    children: [
                      IconButton(
                        icon: Icon(item.comprado ? Icons.check_circle : Icons.radio_button_unchecked),
                        onPressed: () {
                          // Marcar item como comprado
                          setState(() {
                            item.comprado = !item.comprado;
                          });
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.nome),
                          SizedBox(height: 4),
                          Text(
                            'Quantidade: ${item.quantidade}',
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Editar item da lista
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Remover item da lista
                          setState(() {
                            widget.lista.itens.remove(item);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              // Adicionar novo item à lista
              showDialog(
                context: context,
                builder: (context) {
                  ItemListaCompras novoItem = ItemListaCompras(nome: '', quantidade: '');

                  return AlertDialog(
                    title: Text('Novo Item'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Nome do Item',
                          ),
                          onChanged: (value) {
                            setState(() {
                              novoItem.nome = value;
                            });
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Quantidade',
                          ),
                          onChanged: (value) {
                            setState(() {
                              novoItem.quantidade = value;
                            });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            widget.lista.itens.add(novoItem);
                          });
                          Navigator.pop(context);
                        },
                        child: Text('Adicionar'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
