import express from 'express'
import 'express-group-routes'
import ApiController from './controller/ApiController.js'
import cors from 'cors'
import swaggerJSDoc from 'swagger-jsdoc'
import SwaggerUI from 'swagger-ui-express'

const app = express()
const PORT = process.env.PORT || 3030

app.use(express.json())
app.use(cors())

/**
 * @swagger
 *  /api/v1/items:
 *    get:
 *      description: Get all items available
 *      responses:
 *        200:
 *          description: Returns list of items.
 *          content:
 *            application/json:
 *              
 */

// ... your REST API routes will go here
app.group('/api/v1', (router) => {
  router.get('/items', ApiController.getItems)
  router.post('/items', ApiController.addItems)
  router.get('/histories', ApiController.getHistories)
  router.get('/histories/detail', ApiController.getHistoryDetails)
})

const options = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Laundry App Express API with Swagger",
      version: "0.1.0",
      description:
        "This is a simple CRUD API application made with Express and documented with Swagger",
      license: {
        name: "MIT",
        url: "https://spdx.org/licenses/MIT.html",
      },
      contact: {
        name: "Laundry App",
        url: "https://Laundry App.com",
        email: "info@email.com",
      },
    },
    servers: [
      {
        url: "http://localhost:3030",
      },
    ],
  },
  apis: ["./src/index.js"],
};

const specs = swaggerJSDoc(options);
app.use(
  "/api-docs",
  SwaggerUI.serve,
  SwaggerUI.setup(specs, {explorer: true})
);

app.listen(PORT, () =>
  console.log(`REST API server ready at: http://localhost:${PORT}`),
)