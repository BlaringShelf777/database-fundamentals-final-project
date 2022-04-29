
import { Router } from 'express'

import { Queries } from '../database/queries'
import client from '../server'

export const productRouter = Router()

productRouter.get('', async (req, res) => {
  const { category } = req.query
  let categoryName = ''

  if (category) {
    try {
      categoryName = category as string
    } catch {
      categoryName = ''
    }
  }

  const products = await client.query(Queries.ProductsByCategoryAndValuation, [categoryName])

  return res.json({
    category: categoryName,
    products: products.rows
  })
})
