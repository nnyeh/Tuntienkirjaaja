import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email, dateDone, startTime, endTime, costPool, task, description } = await readBody(event)

  const user = await prisma.user.findUnique({
    where: {
      email
    },
    select: {
      id: true
    }
  })

  const addNewLog = await prisma.logging.create({
    data: {
      userId: user!.id,
      dateDone,
      startTime,
      endTime,
      costPool,
      task,
      description
    }
  })
  return addNewLog
})
