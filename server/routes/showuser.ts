import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email } = await readBody(event)

  const userInfo = await prisma.user.findUnique({
    where: {
      email
    },
    select: {
      id: true,
      email: true,
      firstName: true,
      lastName: true,
      logs: true,
      costPoolPresets: true,
      taskPresets: true
    }
  })
  return {
    statusCode: 200,
    body: userInfo,
    headers: {
      'Content-Type': 'application/json'
    }
  }
})
