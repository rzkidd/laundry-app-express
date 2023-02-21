import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

const main = async () => {
    const items = await prisma.item.createMany({
        data: [
            {name: 'T-Shirt'},
            {name: 'Shirt'},
            {name: 'Shorts'},
            {name: 'Trousers'},
        ]
    })
}

main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })