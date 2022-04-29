
import express from 'express'

import { clientRouter } from './routes/client.routes'
import { productRouter } from './routes/products.routes'
import { providerRouter } from './routes/providers.routes'
import { sellerRouter } from './routes/sellers.routes'

export const app = express()

app.use(express.json())

app.use('/seller', sellerRouter)

app.use('/provider', providerRouter)

app.use('/product', productRouter)

app.use('/client', clientRouter)
