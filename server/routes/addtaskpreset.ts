import { prisma } from '../../prisma/db'

export default defineEventHandler(async (event) => {
  const { email, task } = await readBody(event)

  const user = await prisma.user.findUnique({
    where: {
      email
    },
    select: {
      id: true
    }
  })

  const addNewTaskPreset = await prisma.userTaskPresets.create({
    data: {
      userId: user!.id,
      task
    }
  })
  return addNewTaskPreset
})
