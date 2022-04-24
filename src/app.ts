
import express from 'express'

import client from './server'

export const app = express()

app.use(express.json())

// Just an example (to be removed)
app.get('/', async (req, res) => {
  const dbResponse1 = await client.query('SELECT * from Test')

  res.json(dbResponse1.rows)
})
