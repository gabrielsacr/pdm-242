DROP DATABASE IF EXISTS loja;
CREATE DATABASE loja;
USE loja;
CREATE TABLE Produtos
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    valor_brl DECIMAL(10,2) NOT NULL,
    unidade ENUM('kg','und.','L','mL','cx.')
);
CREATE TABLE Clientes
(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(100)
);
CREATE TABLE Pedidos
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    data DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT NOT NULL
);
CREATE TABLE ItensPedido
(
	id_pedido INT NOT NULL,
    id_produto INT NOT NULL,
    qtde_produto FLOAT NOT NULL
);

ALTER TABLE Pedidos
ADD CONSTRAINT fk_ClientePedido
FOREIGN KEY (id_cliente) REFERENCES Clientes(id);

ALTER TABLE ItensPedido
ADD CONSTRAINT fk_PedidoItensPedido
FOREIGN KEY (id_pedido) REFERENCES Pedidos(id);

ALTER TABLE ItensPedido
ADD CONSTRAINT fk_ProdutoItensPedido
FOREIGN KEY (id_produto) REFERENCES Produtos(id);

INSERT INTO Produtos(nome,valor_brl,unidade)
VALUES('Banana','5.50','kg'),
	  ('Abobrinha', '4.10','kg'),
	  ('Coca-Cola, 350 mL','10.31','und.'),
	  ('Cerveja Spaten, 12x350ml','52.00','cx.'),
	  ('Água de Esgoto', '6.00','L');

INSERT INTO Clientes(nome)
VALUES ('Matheus Rocha da Silva'),
	   ('Ricardo Duarte Taveira'),
       ('Pablo Busatto Figueiredo'),
       ('Cícera Márcia da Fonseca Silva');

INSERT INTO Pedidos(id_cliente)
VALUES(3),
	  (1),
      (2),
      (3),
      (4);

INSERT INTO ItensPedido(id_pedido, id_produto, qtde_produto)
VALUES('1','1','0.5'),
	  ('1','3','1'),
      ('2','4','2'),
      ('3','5','5'),
      ('4','2','0.2'),
      ('5','1','2'),
      ('5','2','1.5'),
      ('5','4','1');
      
CREATE VIEW vw_Clientes 
AS
SELECT *
FROM Clientes;

CREATE VIEW vw_Produtos 
AS
SELECT *
FROM Produtos;

CREATE VIEW vw_Pedidos 
AS
SELECT Pedidos.id, 
	   Pedidos.data, 
       Clientes.nome AS Cliente, 
       Produtos.nome AS Produto, 
       Produtos.valor_brl, 
       ItensPedido.qtde_produto, 
       format((Produtos.valor_brl * ItensPedido.qtde_produto), 2) AS Total_do_item
FROM Pedidos
INNER JOIN Clientes ON Pedidos.id_cliente = Clientes.id
INNER JOIN ItensPedido ON Pedidos.id = ItensPedido.id_pedido
INNER JOIN Produtos ON ItensPedido.id_produto = Produtos.id;
