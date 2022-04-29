
export class Queries {
  static AllProdutosFromSeller = `
    SELECT pv.numero_filial, p.nome, pv.preco, p.modelo
    FROM produto_vendido_por_filial pv
    JOIN produto p using(codp)
    WHERE pv.nome = $1
  `

  static SellerSubsidiariesWhoSoldMoreThanGivenValue = `
    SELECT nome, numero_filial, sum(pc.preco)
    FROM filial_lojista fl 
    NATURAL JOIN produto_vendido pv
    JOIN produtos_carrinho pc using(codpv)
    JOIN carrinho c using(codcar, codc)
    WHERE c.finalizado = true AND nome = $1
    GROUP BY nome, numero_filial
    HAVING sum(pc.preco) > $2;
  `

  static FaithfullClientsBySellerName = `
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
      WHERE fl.nome <> $1
    )
  `

  static SellersWhoHaveSubsidiariesInOnlyGivenState = `
    SELECT distinct nome as lojista
    FROM filial_lojista
    JOIN endereco e using(code)
    WHERE codfil NOT IN (
      SELECT codfil
      FROM filial f2
      JOIN endereco e2 using(code)
      WHERE uf <> $1
    )
  `

  static SellersWhoHaveSubsidiariesInUniqueStates = `
    SELECT distinct fl.nome
    FROM filial_lojista fl
    WHERE NOT EXISTS (
      SELECT *
      FROM filial f
      JOIN endereco e using(code)
      WHERE f.codloj <> fl.codloj and e.uf in (
        SELECT distinct e2.uf
        FROM filial f2
        JOIN endereco e2 using(code)
        WHERE f2.codloj = fl.codloj
      )
    )
  `

  static ProductsBoughtByGivenClient = `
    SELECT p.nome, p.modelo, p.fornecedor, pc.preco, pc.data_compra
    FROM produtos_comprados pc 
    JOIN produto_vendido pv using(codpv) 
    JOIN produto p using(codp)
    WHERE codc = $1
  `

  static ProductsByCategoryAndValuation = `
    SELECT p.nome , p.modelo , avg(nota)
    FROM produto p 
    JOIN avaliacao a using(codp)
    JOIN categoria_produto cp using(codp)
    JOIN categoria c using (codcat)
    WHERE c.nome = $1
    GROUP BY p.codp , p.nome, p.modelo 
    ORDER BY avg(nota) desc
  `

  static AllProductsFromGivenProvider = `
    SELECT p.nome, p.modelo 
    FROM produto p
    JOIN fornecedor f ON p.fornecedor = f.nome 
    WHERE fornecedor = $1
  `

  static AllCategoriesFromGivenProvider = `
    SELECT c.nome 
    FROM produto p
    JOIN fornecedor f ON p.fornecedor = f.nome
    JOIN categoria_produto cp using(codp)
    JOIN categoria c using(codcat)
    WHERE fornecedor = $1
    GROUP BY c.nome
  `

  static ClosestSubsidiariesFromGivenClient = `
    SELECT numero_filial 
    FROM filial_lojista
    JOIN endereco e using(code) 
    WHERE nome = $1 AND e.uf IN (
      SELECT distinct e2.uf  
      FROM usuario u2
      JOIN cliente c using(codu)
      JOIN endereco_cliente ec using(codc)
      JOIN endereco e2 using(code)
      WHERE c.codu = $2
    )
  `

  static CartProductsFromGivenClient = `
    SELECT p.nome, pc.preco, pc.frete 
    FROM cliente c 
    JOIN carrinho c2 using(codc)
    JOIN produtos_carrinho pc using(codcar,codc)
    JOIN produto_vendido pv using(codpv)
    JOIN produto p using(codp)
    WHERE finalizado=false and codc = $1
  `
}
