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

  const deleteCostPoolPreset = await prisma.userCostPoolPresets.delete({
    where: {
      costpool_userId: {
        userId: user!.id,
        costpool
      }
    }
  })
  return deleteCostPoolPreset
})
