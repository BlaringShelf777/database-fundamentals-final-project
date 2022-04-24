
export class Queries {
  static Query1 = `
    SELECT pv.numero_filial, p.nome, pv.preco, p.modelo
    FROM produto_vendido_por_filial pv
    JOIN produto p using(codp)
    WHERE pv.nome = '$1'
  `

  static Query2 = `
    SELECT nome, numero_filial, sum(pc.preco)
    FROM filial_lojista fl 
    NATURAL JOIN produto_vendido pv
    JOIN produtos_carrinho pc using(codpv)
    JOIN carrinho c using(codcar, codc)
    WHERE c.finalizado = true AND nome = '$1'
    GROUP BY nome, numero_filial
    HAVING sum(pc.preco) > $2;
  `

  static Query3 = `
    SELECT distinct c.codu as cliente_fiel
    FROM cliente c
    JOIN pedido p using(codc)
    JOIN carrinho c2 using(codcar, codc)
    JOIN produtos_carrinho pc using(codcar, codc)
    JOIN produto_vendido pv using(codpv)
    JOIN filial_lojista using (codfil)
    WHERE c.codu NOT IN (
      SELECT c.codu
      FROM cliente c
      JOIN pedido p using(codc)
      JOIN carrinho c2 using(codcar, codc)
      JOIN produtos_carrinho pc using(codcar, codc)
      JOIN produto_vendido pv using(codpv)
      JOIN filial_lojista fl using (codfil)
      WHERE fl.nome <> '$1'
    )
  `

  static Query4 = `
    SELECT distinct nome as lojista
    FROM filial_lojista
    JOIN endereco e using(code)
    WHERE codfil NOT IN (
      SELECT codfil
      FROM filial f2
      JOIN endereco e2 using(code)
      WHERE uf <> '$1'
    )
  `

  // Revisão
  static Query5 = ''

  static Query6 = `
    SELECT p.nome , p.modelo , p.fornecedor , pc.preco, pc.data_compra
    FROM produtos_comprados pc 
    JOIN produto_vendido pv using(codpv) 
    JOIN produto p using(codp)
    WHERE codc='$1'
  `

  static Query7 = `
    SELECT count(pv.codp) > 0
    FROM produtos_comprados pc
    JOIN produto_vendido pv using(codpv)
    WHERE codc='$1' AND codp = '$2'
  `

  static Query8 = `
    SELECT p.nome, p.modelo 
    FROM produto p
    JOIN fornecedor f ON p.fornecedor = f.nome 
    WHERE fornecedor = '$1'
  `

  static Query9 = `
    SELECT c.nome 
    FROM produto p
    JOIN fornecedor f ON p.fornecedor = f.nome
    JOIN categoria_produto cp using(codp)
    JOIN categoria c using(codcat)
    WHERE fornecedor = '$1'
    GROUP BY c.nome
  `

  static Query10 = `
    SELECT numero_filial 
    FROM filial_lojista
    JOIN endereco e using(code) 
    WHERE nome = '$1' AND e.uf IN (
      SELECT distinct e2.uf  
      FROM usuario u2
      JOIN cliente c using(codu)
      JOIN endereco_cliente ec using(codc)
      JOIN endereco e2 using(code)
    )
  `
}
