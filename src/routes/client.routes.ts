
import { Router } from 'express'

import { Queries } from '../database/queries'
import client from '../server'

export const clientRouter = Router()

clientRouter.get('/:clientId/cart', async (req, res) => {
  const { clientId } = req.params

  const cart = await client.query(Queries.CartProductsFromGivenClient, [clientId])

  return res.json({
    clientId,
    cart: cart.rows
  })
})

clientRouter.get('/:clientId/purchases', async (req, res) => {
  const { clientId } = req.params

  const purchases = await client.query(Queries.ProductsBoughtByGivenClient, [clientId])

  return res.json({
    clientId,
    purchases: purchases.rows
  })
})

clientRouter.get('/:clientId/:seller/closestSubsidiary', async (req, res) => {
  const { clientId, seller } = req.params

  const subsidiaries = await client.query(Queries.ClosestSubsidiariesFromGivenClient, [seller, clientId])

  return res.json({
    clientId,
    seller,
    subsidiaries: subsidiaries.rows
  })
})
