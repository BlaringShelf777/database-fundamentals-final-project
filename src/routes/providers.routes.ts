
import { Router } from 'express'

import { Queries } from '../database/queries'
import client from '../server'

export const providerRouter = Router()

providerRouter.get('/:providerName/products', async (req, res) => {
  const { providerName } = req.params

  const products = await client.query(Queries.AllProductsFromGivenProvider, [providerName])

  return res.json({
    provider: providerName,
    products: products.rows
  })
})

providerRouter.get('/:providerName/categories', async (req, res) => {
  const { providerName } = req.params

  const categories = await client.query(Queries.AllCategoriesFromGivenProvider, [providerName])

  return res.json({
    provider: providerName,
    categories: categories.rows
  })
})
