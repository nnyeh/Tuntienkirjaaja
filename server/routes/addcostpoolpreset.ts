import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email, costpool } = await readBody(event)

  const user = await prisma.user.findUnique({
    where: {
      email
    },
    select: {
      id: true
    }
  })

  const addNewCostPoolPreset = await prisma.userCostPoolPresets.create({
    data: {
      userId: user!.id,
      costpool
    }
  })
  return addNewCostPoolPreset
})
