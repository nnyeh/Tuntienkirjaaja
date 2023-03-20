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
      date: true,
      startTime: true,
      endTime: true,
      task: true,
      description: true
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
