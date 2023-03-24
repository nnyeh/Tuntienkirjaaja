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

  const userLogs = await prisma.logging.findMany({
    where: {
      userId: user!.id
    },
    select: {
      dateAdded: true,
      dateDone: true,
      startTime: true,
      endTime: true,
      costPool: true,
      task: true,
      description: true
    },
    orderBy: {
      dateAdded: "desc"
    }
  })
  return {
    statusCode: 200,
    body: userLogs,
    headers: {
      'Content-Type': 'application/json'
    }
  }
})
