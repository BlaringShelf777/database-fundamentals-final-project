
import express from 'express'
import { Client } from 'pg'

import { dbSettings } from './database/dbSettings'

export const app = express()

app.use(express.json())

// Just an example (to be removed)
app.get('/', async (req, res) => {
  const client = new Client(dbSettings)

  await client.connect()

  const dbResponse = await client.query('SELECT * from Test')

  res.json(dbResponse)
})
