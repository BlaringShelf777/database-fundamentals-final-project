import { Router } from 'express'
import { Queries } from '../database/queries'
import client from '../server'

export const sellerRouter = Router()

sellerRouter.get('/:sellerName/products', async (req, res) => {
  const { sellerName } = req.params

  const products = await client.query(Queries.AllProdutosFromSeller, [sellerName])

  return res.json({
    seller: sellerName,
    products: products.rows
  })
})

sellerRouter.get('/:sellerName/subsidiaries', async (req, res) => {
  const { sellerName } = req.params
  const { minVal } = req.query
  let cutValue = 0

  if (minVal) {
    try {
      cutValue = parseInt(minVal as string)
    } catch {
      cutValue = 0
    }
  }

  const subsidiaries = await client.query(Queries.SellerSubsidiariesWhoSoldMoreThanGivenValue, [sellerName, cutValue])

  return res.json({
    seller: sellerName,
    cutValue,
    subsidiaries: subsidiaries.rows
  })
})

sellerRouter.get('/:sellerName/faithfullClients', async (req, res) => {
  const { sellerName } = req.params

  const faithfullClients = await client.query(Queries.FaithfullClientsBySellerName, [sellerName])

  return res.json({
    seller: sellerName,
    clients: faithfullClients.rows
  })
})

sellerRouter.get('/stateUnique', async (_req, res) => {
  const sellers = await client.query(Queries.SellersWhoHaveSubsidiariesInUniqueStates)

  return res.json({
    sellers: sellers.rows
  })
})

sellerRouter.get('/subsidiaryUnique', async (req, res) => {
  const { uf } = req.query
  let targetUf = ''

  if (uf) {
    try {
      targetUf = uf as string
    } catch {
      targetUf = ''
    }
  }

  const sellers = await client.query(Queries.SellersWhoHaveSubsidiariesInOnlyGivenState, [targetUf])

  return res.json({
    uf: targetUf,
    sellers: sellers.rows
  })
})
