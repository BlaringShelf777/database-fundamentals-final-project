
import 'dotenv/config'
import { Client } from 'pg'

import { app } from './app'
import { dbSettings } from './database/dbSettings'

const client = new Client(dbSettings)

client
  .connect()
  .then(() => {
    const serverPort = process.env.PORT || '3000'

    app.listen(
      serverPort,
      () => console.info(`Server running on port ${serverPort}`)
    )
  })
  .catch(err => console.error(err))

export default client
