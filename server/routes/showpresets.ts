import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email } = await readBody(event)

  const user = await prisma.user.findUnique({
    where: {
      email
    },
    select: {
      id: true
    }
  })

  const userCostPoolPresets = await prisma.userCostPoolPresets.findMany({
    where: {
      userId: user!.id
    },
    select: {
      costpool: true
    }
  })
  const userTaskPresets = await prisma.userTaskPresets.findMany({
    where: {
      userId: user!.id
    },
    select: {
      task: true
    }
  })
  return {
    statusCode: 200,
    costpools: userCostPoolPresets,
    tasks: userTaskPresets,
    headers: {
      'Content-Type': 'application/json'
    }
  }
})
